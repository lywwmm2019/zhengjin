<%@page import="java.net.URLDecoder"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@ page import="com.gti.Utils"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%!

//获取用户的email
private String getUserEmail(HttpServletRequest request, HttpServletResponse response, String mobile, String userId){
	
	Map obj = getUserNickNameAndEmail(request, response, mobile, userId);
	String email = (String)obj.get("email");
	int maxAge = getMaxAge();
	addCookie(request, response, "WEBSSO_EMAIL", email, maxAge, "/");
	return email;
}

//获取用户的email
private String getUserNickName(HttpServletRequest request, HttpServletResponse response, String mobile, String userId){
	
	Map obj = getUserNickNameAndEmail(request, response, mobile, userId);
	String nickName = (String)obj.get("nickName");
	try{
		if(nickName!= null && !"".equals(nickName)){
			nickName = URLEncoder.encode(nickName, "UTF-8");
		} 
	}catch(Exception e){
		e.printStackTrace();
	}
	int maxAge = getMaxAge();
	addCookie(request, response, "WEBSSO_NICKNAME", nickName, maxAge, "/");
	
	return nickName;
}

//获取用户的email
private Map getUserNickNameAndEmail(HttpServletRequest request, HttpServletResponse response, String mobile, String userId){
	String key = "USER_SSOINFO_" + userId;
	Map info = (Map)Cache.get(key);
	
	if(info == null){
		try{
			String url = "http://usercenter.zhengjin99.com/usercenter/register/ajaxGetBackInfoByID.action?userID="+userId;
			String data = Utils.url2StringUnsafe(url, "GBK");
			info = (Map) Json.fromJson(data);
			Cache.set(key, info, "5mn");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	return info;
}
%>
<%
	int nrxxNum = 0;
	//加载用户基本信息
	try{ 
		String mobile = getCookie(request, "WEBSSO_LID");
		String userId = getCookie(request, "WEBSSO_UID");
		String userType = getCookie(request, "WEBSSO_USERTYPE");
		//System.out.println("+++++++++" + mobile + ":" + userId + "--" + (mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId)));
		if(mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId) && userType!=null && !"".equals(userType)){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			String email = getUserEmail(request, response, mobile, userId);
			String nick = getUserNickName(request, response, mobile, userId);
			String crmuserId = (String)info.get("UserID");
			if(crmuserId!=null){
				String emobile = encrypt(mobile);
				String utyp = getUserMailType(request);
				String regTime = (String)info.get("CreateTime");
				int zxlxNRNum = countNoReadMailByType(0, "1", utyp, emobile, crmuserId, regTime);
				int ggtsNRNum = countNoReadMailByType(0, "3", utyp, emobile, crmuserId, regTime);
				nrxxNum = zxlxNRNum + ggtsNRNum + countNoReadHdxx(mobile);
				String fw = "";
				Map fwObj = queryUserFW(crmuserId);
                if(fwObj!= null){
                    fw = (String)fwObj.get("fw");
                    if(fw == null){
                        fw = "";
                    }
                }
                int maxAge = getMaxAge();
                addCookie(request, response, "u_fw", fw, maxAge, "/");
                
			}
			pageContext.setAttribute("nrxxNum", nrxxNum);
		}else{
			String url = request.getRequestURI();
			String urlFrom = Utils.getParameterValue(request,"from","");
			if(url.indexOf("zhengjin/user/login.jsp")==-1){
				if("jiaoyibao".equals(urlFrom))
					response.sendRedirect("login.jsp?from=jiaoyibao");
				else
					response.sendRedirect("login.jsp");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
