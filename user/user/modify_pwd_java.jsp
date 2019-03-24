<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../util.jsp"%>
<%!	
	private String getValueFromCookie(HttpServletRequest request, String cookieKey) {
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
	
	private String getIpAddress(HttpServletRequest request) {
		String ip = "";
		String ips = request.getHeader("X-Forwarded-For");
		if (ips == null || ips.equals("")) {
			ip = request.getHeader("X-Real-IP");
			if (ip == null || ip.equals("")) {
				ip = request.getRemoteAddr();
			}
		} else {
			ip = ips.split(",")[0];
		}
		return ip;
	}
	
	private boolean checkHasChance(String mobile){
		Calendar cal = Calendar.getInstance();
		long now = cal.getTimeInMillis();
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		long last = cal.getTimeInMillis();
		long second = (last - now)/1000;
		String expir = second + "s";
		
		String key = "MODIFYPWDCHANCE_" + mobile;
		Integer num = (Integer)Cache.get(key);
		System.out.println(" +++ modify chance : " + num);
		if(num == null)
			num = new Integer(1);
		else
			num += 1;
		/* if(num > 3){
			return false;
		} */
		Cache.set(key, num, expir);
		return true;
	}
%>
<%
	String state = "0";
	String isSubmit = "true";
	String pwdold = Utils.getParameterValue(request, "pwdold", "a123456"); 
	String pwd1 = Utils.getParameterValue(request, "pwd1", "");
	String pwd2 = Utils.getParameterValue(request, "pwd2", "");
	String WEBSSO_UID = Utils.getParameterValue(request, "sso_userID", "");;//userID
	String WEBSSO_ZJUSERNAME = Utils.getParameterValue(request, "sso_userName", "");//UserName
	String WEBSSO_LID = Utils.getParameterValue(request, "sso_LID", "");//mobile
	
	boolean b = isMobile(WEBSSO_LID);
	String errorMsg = "";
	boolean chance = false;
	if(b){
		
		chance = checkHasChance(WEBSSO_LID);
		if(chance){
		Map emptyMap = new HashMap();
	
		if (WEBSSO_UID.trim().length() == 0
			|| WEBSSO_LID.trim().length() == 0
			|| WEBSSO_ZJUSERNAME.trim().length() == 0) {
			state = "-111";
			errorMsg = "抱歉，尚未登录，无法修改密码";
		} else if (pwdold.trim().length() == 0
			|| pwd1.trim().length() == 0) {
			state = "-112";
			errorMsg = "抱歉，参数错误，请重新填写";
		} else {
			try {
			// TODO 调用sso接口
			String pwdUrl = "http://usercenter.zhengjin99.com/usercenter/register/ajaxEditUserPwd.action?userID="
							+ WEBSSO_UID
							+ "&oldPassword="
							+ pwdold
							+ "&password1="
							+ pwd1
							+ "&mobile="
							+ WEBSSO_LID;
			String result = Utils.fetchDataFromUrlOrCacheWithReturn(pwdUrl,emptyMap, "0s", "utf-8");
			Map ssoMap = (Map) Json.fromJson(result);
			if ((state = ssoMap.get("state") + "") != null && state.equals("0")) {
					errorMsg = "修改成功";
				} else {
					state = ((state == null || state.equals("null")) ? "-20"
							: state);
					if (state.equals("-1")) {
						errorMsg = "原始密码错误!";
					}
				}
			} catch (Exception e) {
				state = "-110";
				errorMsg = "密码修改失败!";
				e.printStackTrace();
			}
		}
		}else{
			state = "-114";
			errorMsg = "今天三次修改机会已用完, 请明天再试!";
		}
	}else{
		state = "-113";
		errorMsg = "手机号格式错误!";
	}
	System.out.println("["+getIpAddress(request)+ "] modify pwd: " + pwd1 + ", " + pwd2 + ", " + WEBSSO_ZJUSERNAME+ ", " + Utils.encrypt(WEBSSO_LID, Utils.DES_KEY) + ", chance:" + chance);
	String callbackFunName = Utils.getParameterValue(request, "callbackparam", "");
	out.write(callbackFunName + "({state:'"+state+"',errorMsg:'" + errorMsg + "'})");
%>
