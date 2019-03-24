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
    String act = Utils.getParameterValue(request, "act", "");
    String fw = Utils.getParameterValue(request, "fw", "");
    
    String ip = Utils.getIpAddress(request);
    System.out.println("####################### ip:"+ip);
	int state = 0;	
	String msg = "success";
	String crmUserId = "";
	String result = "";
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				crmUserId = (String)info.get("UserID");
				int maxAge = getMaxAge();
				if("add".equals(act) && !"".equals(fw)){
	                result = addUserFW(crmUserId, fw.replace(" ", "").split(","));
	                if(result != null){
	                	addCookie(request, response, "fw", result, maxAge, "/");
	                }else{
	                	state = -1;
	                    msg = "update error";
	                }
				}else if("del".equals(act) && !"".equals(fw)){
					result = deleteUserFW(crmUserId, fw.replace(" ", "").split(","));
					if(result != null){
                        addCookie(request, response, "fw", result, maxAge, "/");
                    }else{
                        state = -1;
                        msg = "update error";
                    }
				}else if("update".equals(act) && !"".equals(fw)){
                    result = updateUserFW(crmUserId, fw.replace(" ", "").split(","));
                    if(result != null){
                        addCookie(request, response, "fw", result, maxAge, "/");
                    }else{
                        state = -1;
                        msg = "update error";
                    }
                }else{
					state = -1;
	                msg = "params error";
				}
				
			}else{
				state = -1;
				msg = "user info error";
			}
	    }else{
			state = -1;
			msg = "no login";
		}
	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "system error";
	}
	response.setContentType("gbk");
	msg = URLEncoder.encode(msg, "gbk");
	if(state == 0)
		result =  "{\"state\":\""+state+"\",\"msg\":\""+msg+"\",\"fw\":\""+result+"\"}";
	else 
		result =  "{\"state\":\""+state+"\",\"msg\":\""+msg+"\"}";
	
	if (callback.equals("")) {
        out.print(result);
    } else {
        out.print(callback + "(" + result + ")");
    }
	
%>
