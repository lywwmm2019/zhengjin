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
<%@include file="methods.jsp"%>

<%
String type = Utils.getParameterValue(request, "type");
String mobile = getCookie(request, "WEBSSO_LID");
String ssoId = getCookie(request, "WEBSSO_UID");
String userType = getCookie(request, "WEBSSO_USERTYPE");
String oilType = getCookie(request, "WEBSSO_OILTYPE");
activityId = Utils.getParameterValue(request, "activityId");
if(userType != null)
	userType = userType.replace("%20", "").trim();
if(oilType != null && !userType.equals("0") && !userType.equals("-1") && !userType.equals("-10")){
	userType = oilType.replace("%20", "").trim();
}
Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
String userId = (String)info.get("UserID");

String result = "{\"state\":\"-9\"}";
if(mobile != null && !"".equals(mobile.trim()) && ssoId != null && !"".equals(ssoId.trim())){
	if("query".equals(type)){
		Map obj = queryAction(userId, activityId);
		if(obj == null){
			result = "{\"state\":\"-1\"}";
		}else{
			result = "{\"state\":\""+(Integer)obj.get("flag")+"\"}";
		}
	}else if("party".equals(type)){
		if("0".equals(userType) || "-1".equals(userType) || "-10".equals(userType)){
			Map obj = queryAction(userId, activityId);
			System.out.println("-------"+userId);
			if(obj == null){
				Integer state = partyAction(mobile);
				System.out.println("-------"+state);
				if(state == 0)
					addAction(userId, activityId, 1);
				result = "{\"state\":\""+state+"\"}";
			}else{
				result = "{\"state\":\"1\"}";
			}
		}else{
			result = "{\"state\":\"-1\"}";
		}
	}else if("update".equals(type)){
		
	}
}
	
out.print(result);
%>
