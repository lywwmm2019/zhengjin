<%@page import="java.net.URLEncoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>
<%@ include file="../util.jsp"%> 
<%!
private boolean copy(String fileFrom, String fileTo) {  
    try {  
        FileInputStream in = new FileInputStream(fileFrom);  
        FileOutputStream out = new FileOutputStream(fileTo);  
        byte[] bt = new byte[1024];  
        int count;  
        while ((count = in.read(bt)) > 0) {  
            out.write(bt, 0, count);  
        }  
        in.close();  
        out.close();  
        return true;  
    } catch (IOException e) {
    	e.printStackTrace();
        return false;  
    }  
}  
private final String path = "/data/web/apollo/spage/user/head/";
%>
<%
	
	
	int state = 0;	
	String msg = "操作成功";
	try{
		String head = Utils.getParameterValue(request, "head", "");
		String ssoId = getCookie(request, "WEBSSO_UID");
		if(!"".equals(head) && ssoId != null && !"".equals(ssoId)){
			head = head.substring(head.lastIndexOf("/"), head.length());
			String from = path+head;
			String to = path+ssoId+".jpg";
			if(copy(from, to)){
				state = 0;
				msg = "操作成功";
			}else{
				state = -3;
				msg = "操作失败";
			}
		}else{
			state = -2;
			msg = "操作失败";
		}

	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "操作失败";
	}
	
%>
{"state":"<%=state%>", "msg": "<%=msg%>"}
