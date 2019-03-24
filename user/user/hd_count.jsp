<%@page import="com.gti.cache.Cache"%>
<%@page import="com.gti.Utils"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
private boolean hasSubmit(String mobile, String type){
	
	String sql = "SELECT count(*) as total FROM ZX_Phone where phone = '"+ mobile + "' and activity_id = 'hd_" + type+"'";
	String key = Utils.MD5(sql);
	Integer total = (Integer)Cache.get(key);
	System.out.println(total);
	if(total == null){
		total = 0;
		List list = QueryRunner.getListBySql(sql);
		System.out.println(sql);
		if(list.size()>0){
			total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
			if(total > 0)
				Cache.set(key, total, "30mn");
		}
	}
	
	if(total > 0){
		return true;
	}
	return false;
}

private boolean insertSubmit(String mobile, String type){
	String sql = "insert into ZX_Phone(phone, create_time, states, update_time, activity_id) values('"+ mobile + "', GETDATE(), 5, GETDATE(),'hd_"+ type + "')";
	return QueryRunner.runSql(sql);
}

public static String getCookie(HttpServletRequest request,
		String cookieKey) {
	Cookie[] cookies = request.getCookies();
	String cookieValue = "";
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie temp = cookies[i];
			if (temp.getName().equals(cookieKey)) {
				cookieValue = temp.getValue();
				break;
			}
		}
	}
	return cookieValue;
}
//获取登录用户的手机号
private String getLoginMobile(HttpServletRequest request){
	String mobile = getCookie(request, "WEBSSO_LID");
	String userId = getCookie(request, "WEBSSO_UID");
	String userType = getCookie(request, "WEBSSO_USERTYPE");
	if(mobile == null || "".equals(mobile) || userId==null || "".equals(userId) || userType == null || "".equals(userType)){
		mobile = null;
	}
	return mobile;
}
%>
<%
	String url = "";
	try{
		url = Utils.getParameterValue(request, "r", ".");
		String mobile = getLoginMobile(request);
		if(mobile != null){
			String type = Utils.MD5(url);
			mobile = Utils.MD5(mobile);
			boolean flag = hasSubmit(mobile, type);
			System.out.println(flag);
			if(!flag){
				insertSubmit(mobile, type);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect(url);
%>