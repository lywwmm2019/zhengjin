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

<%
	String callback = Utils.getParameterValue(request, "callback", "");
	Map result = new HashMap();
	int state = 0;	
	String msg = "success";	
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			String userId = (String)info.get("UserID");
			String act = Utils.getParameterValue(request, "act", "");
			String name = Utils.getParameterValue(request, "name", "");
			String carNo = Utils.getParameterValue(request, "carNo", "");
			if("partybgjh".equals(act)){
				Map obj = partyBGJH(mobile, name, carNo);
				Integer code = (Integer)obj.get("code");
				if(code != null){
					result.putAll(obj);
					if(code == 0){
						Map actu = queryAction(userId, "act_bgjh");
						if(actu == null)
						    addAction(userId, "act_bgjh", 1);
					}
						
				}else{
					state = -9;
				}
			}
			if("updatebgjh".equals(act)){
				Map obj = updateBGJHDetail(mobile, name, carNo);
				Integer code = (Integer)obj.get("code");
				if(code != null){
					result.putAll(obj);
				}else{
					state = -9;
				}
			}
		}else{
			result.put("msg", "unlogin");
		}

	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "syserror";
	}
	result.put("state", state);
	String str = Json.toJson(result);
	if("".equals(callback))
		out.print(str);
	else
		out.print(callback+"("+str+")");
%>
