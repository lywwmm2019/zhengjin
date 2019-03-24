<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%!

	private boolean insertJSFWContent(String json, String type){
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), '"+type+"')");
		return QueryRunner.runSql(sb.toString());
	}
	
	private boolean hasSubmit(String json, String mobile, String type){
		String sql = "SELECT count(*) as total FROM ZX_JsonInfo where type='"+type+"' and  jsonInfo like '%"+json + "%'";
		String key = MD5(json);
		Integer total = (Integer)Cache.get(key);
		if(total == null){
			List list = QueryRunner.getListBySql(sql);
			total = 0;
			if(list.size()>0){
				total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
			}
			if(total>0){//提交过设置缓存
				Cache.set(key, total, expire);
			}
		}
		
		if(total > 0)
			return true;
		return false;
	}
	
	private Integer hasDeal(String userId){
		String sql = "SELECT * FROM ZX_JsonInfo where type='jsfw' and  jsonInfo like '%\"userId\" :\""+userId+"\"%' order by createTime desc";
		List list = QueryRunner.getListBySql(sql);
		Integer flag = 0;
		boolean flag1 = false;
		boolean flag2 = false;
		try{
		if(list != null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date now = new Date();
			for(Object obj: list){
				Map mobj = (Map)obj;
				String jsonInfo = (String)mobj.get("jsonInfo");
				Map map = (Map) Json.fromJson(jsonInfo);
				String isvalid = (String)map.get("isvalid");
				String time = (String)map.get("time");
				String fw = (String)map.get("fw");
				Date rtime = sdf.parse(time);
				if("0".equals(isvalid) && rtime.after(now)){
					if("1".equals(fw)){
						flag1 = true;
					}
					if("2".equals(fw)){
						flag2 = true;
					}	
					if(flag1 && flag2){
						break;
					}
				}
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		if(flag1 && flag2){
			flag = 3;
		}
		if(flag1 && !flag2){
			flag = 1;
		}
		if(!flag1 && flag2){
			flag = 2;
		}	
		return flag;
	}
%>
<% 
String act = Utils.getParameterValue(request,"act","");

int state = 0;	
String msg = "提交成功，稍后有贵宾客服与您联系！";
if("0".equals(act)){
try{
	String mobile = getLoginMobile(request);
	if(mobile != null){
		String type = Utils.getParameterValue(request,"type","");
		String code = Utils.getParameterValue(request,"code","");
		String site = Utils.getParameterValue(request,"site","");
		String time = Utils.getParameterValue(request,"time","");
		String name = Utils.getParameterValue(request,"name","");
		String phone = Utils.getParameterValue(request,"phone","");
		String num = Utils.getParameterValue(request,"num","");
		String des = Utils.getParameterValue(request,"des","");
		String fw = Utils.getParameterValue(request,"fw","");
		if(!"".equals(fw)&&!"".equals(type)&&!"".equals(code)&&!"".equals(site)&&!"".equals(time)&&!"".equals(name)&&!"".equals(phone)&&!"".equals(num)&&!"".equals(des)){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			Map<String,String> map = new HashMap<String,String>();
			mobile = encrypt(mobile);
			String crmUserId = "";
			Integer VIPTypeID = 0;
			if(info!=null){ 
				crmUserId = (String)info.get("UserID");
				VIPTypeID = (Integer)info.get("VIPTypeID");
			}
			if(VIPTypeID == 4){
				map.put("type", type);
				map.put("fw", fw);
				map.put("userId", crmUserId);
				map.put("phone", phone);
				map.put("code", code);
				map.put("site", site);
				map.put("time", time);
				map.put("name", name);
				map.put("num", num);
				map.put("des", des);
				map.put("isvalid", "0");
				String json = Json.toJson(map);
				String jsontype = "jsfw";
				Integer ofw = hasDeal(crmUserId);
				if(ofw == 3){
					state = -2;
					msg = "您有未完成的接送服务，请完成后再提交新的申请!";
				}else if(ofw == Integer.valueOf(fw)){//已有接服务
					state = -2;
					msg = "您有未完成的此类型接送服务，请完成后再提交新的申请!";
				}else if(ofw != 3 && ofw != Integer.valueOf(fw)){
					if(!hasSubmit(json, mobile,jsontype)){
						if(!insertJSFWContent(json,jsontype)){
							state = -1;
							msg = "提交失败!";
						}else{
							String key = "JSFW_NUM_"+mobile;
							Cache.delete(key);
						}
					}else{
						state = -2;
						msg = "请不要重复提交相同内容!";
					}
				}else{
					state = -2;
					msg = "您有未完成的接送服务，请完成后再提交新的申请!";
				}
			}else{
				state = -5;
				msg = "非钻石卡客户不能享受此服务，请您升级!";
			}
		}else{
			state = -3;
			msg = "提交内容不能为空!";
		}
    }else{
		state = -4;
		msg = "未登录";
	}

}catch(Exception e){
	e.printStackTrace();
	state = -1;
	msg = "提交失败!";
}
}else if("1".equals(act)){
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
				Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
				Map<String,String> map = new HashMap<String,String>();
				mobile = encrypt(mobile);
				String crmUserId = "";
				Integer VIPTypeID = 0;
				if(info!=null){ 
					crmUserId = (String)info.get("UserID");
					VIPTypeID = (Integer)info.get("VIPTypeID");
				}
				if(VIPTypeID == 4){
					String jsontype = "jsfw_accepted";
					String json = crmUserId+"_jsfw";
					if(!hasSubmit(json, mobile,jsontype)){
						insertJSFWContent(json,jsontype);
					}
				}
		}else{
			state = -1;
			msg = "提交失败!";
		}
	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "提交失败!";
	}			
	
}
response.getWriter().write("{\"state\":\""+state+"\",\"msg\":\""+msg+"\"}");
%>