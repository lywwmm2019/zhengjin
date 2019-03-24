<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@ include file="methods.jsp"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
	private boolean insertZjdzContent(String json){
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), 'zjdz')");
		return QueryRunner.runSql(sb.toString());
	}

	private boolean hasSubmit(String json, String mobile){
		String sql = "SELECT count(*) as total FROM ZX_JsonInfo where type='zjdz' and  jsonInfo like '%"+json + "%'";
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
%>

<%
int state = 0;	
String msg = "提交成功,请注意查收！";
try{
	String mobile = getLoginMobile(request);
	if(mobile != null){
		String content = Utils.getParameterValue(request,"content","");
		if(content != "" && !"".equals(content)){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			Map<String,String> map = new HashMap<String,String>();
			mobile = encrypt(mobile);
			String crmUserId = "";
			if(info!=null){
				crmUserId = (String)info.get("UserID");
			}
			map.put("userId", crmUserId);
			map.put("mobile", mobile);
			map.put("content", content);
			String json = Json.toJson(map);
			if(!hasSubmit(json, mobile)){
				if(!insertZjdzContent(json)){
					state = -1;
					msg = "提交失败!";
				}else{
					String key = "FAVORITE_NUM_"+mobile;
					Cache.delete(key);
				}
			}else{
				state = -2;
				msg = "请不要重复提交相同内容!";
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
response.getWriter().write("{\"state\":\""+state+"\",\"msg\":\""+msg+"\"}");
%>
