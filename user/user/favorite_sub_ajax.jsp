<%@page import="java.net.URLEncoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>
<%@ include file="methods.jsp"%>
<%!
	private boolean hasSubmit(String json, String mobile){
		String sql = "SELECT count(*) as total FROM ZX_JsonInfo where type='favorite' and  jsonInfo like '%"+json + "%'";
		System.out.println(sql);
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
	
	private boolean insertFavorite(String json){
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), 'favorite')");
		String key = MD5(json);
		Cache.set(key, Integer.valueOf(1), expire);
		return QueryRunner.runSql(sb.toString());
	}
%>

<%
	String callbackFunName = Utils.getParameterValue(request, "callbackparam", "");
	int state = 0;	
	String msg = "收藏成功";
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				mobile = encrypt(mobile);
				String crmUserId = (String)info.get("UserID");
				String url = Utils.getParameterValue(request,"url","");
				String title = Utils.getParameterValue(request,"title","");
				String modelName = Utils.getParameterValue(request,"model", "");
				if(url != "" && title != "" && modelName != ""){
					Map<String,String> map = new HashMap<String,String>();
					map.put("mobile", mobile);
					map.put("userId", crmUserId);
					map.put("modelName", modelName);
					map.put("title", title);
					map.put("url", url);
					String json = Json.toJson(map);
					json = json.replaceAll("\\n", "").replaceAll("\\r", "");
					if(!hasSubmit(json, crmUserId)){
						if(!insertFavorite(json)){
							state = -1;
							msg = "收藏失败";
						}else{
							String key = "FAVORITE_NUM_"+crmUserId;
							Cache.delete(key);
						}
					}else{
						state = -2;
						msg = "您已收藏，请不要重复收藏";
					}
					
				}else{
					state = -3;
					msg = "提交参数错误";
				}
			}else{
				state = -1;
				msg = "收藏失败";
			}
	    }else{
			state = -4;
			msg = "未登录";
		}

	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "收藏失败";
	}
	response.setContentType("gbk");
	msg = URLEncoder.encode(msg, "gbk");
	response.getWriter().write(callbackFunName+ "({\"state\":\""+state+"\",\"msg\":\""+msg+"\"})");
%>
