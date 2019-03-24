
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%@ page import="com.gti.Utils"%>
<%
	int num = 0;
	String type = Utils.getParameterValue(request,"id","0");
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			String phone = mobile;
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				String crmuserId = (String)info.get("UserID");
				String emobile = encrypt(mobile);
				String utyp = getUserMailType(request);
				clearUserCacheByKey(mobile);
				String regTime = (String)info.get("CreateTime");
				if("0".equals(type)){
					Integer zxlxNRNum = countNoReadMailByType(0, "1", utyp, emobile, crmuserId, regTime);
					Integer ggtsNRNum = countNoReadMailByType(0, "3", utyp, emobile, crmuserId, regTime);
	                num = zxlxNRNum + ggtsNRNum + countNoReadHdxx(mobile); 
				}else if("2".equals(type)){
					num = countNoReadHdxx(mobile);
				}else{
					num = countNoReadMailByType(0, type, utyp, emobile, crmuserId, regTime);
				}
				
				/*  if(zxlxNRNum != null)
					num = zxlxNRNum;
				if(ggtsNRNum != null)
					num += ggtsNRNum; */
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	//String callbackFunName = Utils.getParameterValue(request, "callbackparam", "");
	//response.getWriter().write(callbackFunName+ "({\"nr\":\""+num+"\"})");
%>
var json = {"nrnum":<%=num%>}