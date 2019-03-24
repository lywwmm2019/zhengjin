<%@page import="java.net.URLEncoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="org.zjtempuri.GJSUserService"%>
<%@page import="org.zjtempuri.IGJSUserService"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%!
	private Map userUpdate2Crm(String mobile, Integer nowgrade, Integer upgrade){
		Map obj = null;
		try{
			String url = "http://crm.zhengjin99.com/External/VIPUserRequestAdvance?Mobile=" + mobile+"&AdvanceInc=" + nowgrade+ "," + upgrade;
			Map parmas = new HashMap();
			parmas.put("mobile", mobile);
			String data = Utils.url2StringUnsafe(url, "UTF-8");
			obj = (Map) Json.fromJson(data);
		}catch(Exception e){
			e.printStackTrace();
		}
		return obj;
	}

	private boolean isUpdateGrade(String mobile,  Integer now, Integer grade){
		String type = "update_"+now+"_"+grade;
		String key = type+"_"+mobile;
		Integer total = (Integer)Cache.get(key);
		if(total == null){
			String select = "select count(*) as total from ZX_JsonInfo where jsonInfo like '"+mobile+"' and type = '"+type+"'";
			List list = QueryRunner.getListBySql(select);
			if (list.size() > 0) {
				total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
			}
			if(total > 0){
				Cache.set(key, total, expire);
				return true;
			}
		}
		
		if(total <= 0){
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+mobile+"', GETDATE(), GETDATE(), '"+type+"')");
			QueryRunner.runSql(sb.toString());
			Cache.set(key, Integer.valueOf(1), expire);
			return false;
		}
		
		return true;
	}
	
%>
	
<%
	int state = 0;
	String activityID = "grzxsjyh_gjs_20140403";
	String type = Utils.getParameterValue(request, "type", "0");
	String callback = Utils.getParameterValue(request, "callback", "");
	Map<String, Object> back = new HashMap<String, Object>();
	if("1".equals(type)){//用户升级提示crm
		String mobile = getLoginMobile(request);
	    String vipType = getCookie(request, "VIPTypeID");
	    //String upgrade = Utils.getParameterValue(request, "up", "4");
	    String upval = Utils.getParameterValue(request, "up","");
	    	
		if(mobile!=null && vipType != null && !"".equals(vipType)){
			Integer viptype = Integer.valueOf(vipType);
			Integer upgrade =  viptype>4?viptype:(viptype+1);
		    if(upval != null){
		    	Integer upint = Integer.valueOf(upval);
		    	if(upint > viptype)
		    		upgrade = upint;
		    }
		    
			String emobile = encrypt(mobile);
			String userType = getCookie(request, "WEBSSO_USERTYPE");
			if(userType != null && !"".equals(userType)){
				userType = userType.replace("%20", "");
			}else{
				userType = "3";
			}
			Integer utype = Integer.valueOf(userType);
			if(!isUpdateGrade(emobile, viptype,upgrade)){
				if(utype == 2 || utype == 1 || utype == 0 || utype == -1){//有归属用户
					Map map = userUpdate2Crm(mobile, viptype, upgrade);
					System.out.println("+++++++++++++++ 1 update " + emobile + " : " + viptype + "-" + upgrade);
				}else{//无归属用户均做新资源
					IGJSUserService userService = new GJSUserService().getBasicHttpBindingIGJSUserService();
					int result = userService.insertUserResource(mobile, activityID, viptype+","+upgrade, "");
					System.out.println("+++++++++++++++ 2 update " + emobile + " : " + vipType + "-" + upgrade);
				}
			}else{
				state = 1;//已提交过
			}
			
		}else{
			state = -1;//未登录
		}
	}else if("2".equals(type)){
		state = 1;
		String userId = getCookie(request, "WEBSSO_UID");
		String email = Utils.getParameterValue(request, "email", "");
		if(userId==null || "".equals(userId)){
			state = -1;//未登录
		}else{
			String url = "http://usercenter.zhengjin99.com/usercenter/register/ajaxEditUserEmail.action?userID="
				+ userId
				+"&email=" + email;
			String result = Utils.fetchDataFromUrlOrCacheWithReturn(url,new HashMap(), "0s", "utf-8");
			Map ssoMap = (Map) Json.fromJson(result);
			String rstate = null;
			if ((rstate = ssoMap.get("state") + "") != null && rstate.equals("0")) {
				String key = "USER_SSOINFO_" + userId;
				Cache.delete(key);
				int maxAge = getMaxAge();
				addCookie(request, response, "WEBSSO_EMAIL", email, maxAge, "/");
				state = 0;
			}
		}
		
	}else if("3".equals(type)){
		state = 1;
		String userId = getCookie(request, "WEBSSO_UID");
		String userName = Utils.getParameterValue(request, "userName", "");
		userName = userName.trim().replace(" ", "");
		if(userId==null || "".equals(userId)){
			state = -1;//未登录
		}else{
			userName = URLEncoder.encode(userName, "GBK");
			String url = "http://usercenter.zhengjin99.com/usercenter/register/ajaxEditNickName.action?userID="
				+ userId
				+"&userName=" + userName;
			String result = Utils.fetchDataFromUrlOrCacheWithReturn(url,new HashMap(), "0s", "GBK");
			Map ssoMap = (Map) Json.fromJson(result);
			String rstate = null;
			if ((rstate = ssoMap.get("state") + "") != null && rstate.equals("0")) {
				state = 0;
				int maxAge = getMaxAge();
				String key = "USER_SSOINFO_" + userId;
				Cache.delete(key);
				addCookie(request, response, "WEBSSO_NICKNAME", userName, maxAge, "/");
			}else{
				state = Integer.valueOf(rstate);
			}
		}
	}else if("4".equals(type)){
		state = 1;
		String nickName = Utils.getParameterValue(request, "nickName", "");
		String userId = Utils.getParameterValue(request, "userId", "");
		nickName = nickName==null?null:nickName.trim().replace(" ", "");
		userId = userId==null?null:userId.trim().replace(" ", "");
		if(userId==null || nickName == null){
			state = -1;//
		}else{
			nickName = URLEncoder.encode(nickName, "GBK");
			String url = "http://usercenter.zhengjin99.com/usercenter/register/ajaxEditNickName.action?userID="+ userId+"&userName=" + nickName;
			String result = Utils.fetchDataFromUrlOrCacheWithReturn(url,new HashMap(), "0s", "GBK");
			Map ssoMap = (Map) Json.fromJson(result);
			String rstate = null;
			if ((rstate = ssoMap.get("state") + "") != null && rstate.equals("0")) {
				state = 0;
				String key = "USER_SSOINFO_" + userId;
				Cache.delete(key);
			}else{
				state = Integer.valueOf(rstate);
			}
		}
	}
	back.put("state", state);
	String print = "%s";
	if(!"".equals(callback))
		print = callback +"(%s)";
	print = String.format(print, Json.toJson(back));
	out.print(print);
%>
