<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_common.jsp"%>
<%
String mobile = getLoginMobile(request);	
if(mobile != null){
	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	Integer viptype = 0;
	if(info!=null && info.get("VIPTypeID") != null){
		viptype = ((Integer)info.get("VIPTypeID"));
	}
	String url = "zstq_"+viptype + ".jsp";
	String localurl = request.getRequestURI();
	if(localurl.indexOf("/zhengjin/user/"+url)==-1){
		response.sendRedirect(url);
	}
}
%>