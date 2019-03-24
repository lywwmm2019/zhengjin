<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@ include file="../util.jsp"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
	private boolean insertMail(Integer type, Integer stype, String fromName, String userId, String mobile, String title, String content){
		StringBuilder sb = new StringBuilder(); 
		sb.append("INSERT into ZX_Mail(title, content, type, s_type, fromwId, fromwName, toId, toName, createTime, updateTime, isvalid) " +  
		"VALUES ('"+title+"','"+content+"', '"+type+"', '"+stype+"', '0', '"+fromName+"','"+userId+"','"+mobile+"', GETDATE(), GETDATE(), 1)");
		return QueryRunner.runSql(sb.toString());
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
%>

<%
	String fromName = Utils.getParameterValue(request, "fromName", "");
	String userId = Utils.getParameterValue(request, "userId", "");
	String mobile = Utils.getParameterValue(request, "mobile", "");
	String title = Utils.getParameterValue(request, "title", "");
	String content = Utils.getParameterValue(request, "content", "");
	String ip = getIpAddress(request);
	int state = 0;	
	String msg = "发送成功";
	
	if("114.251.137.130".equals(ip) 
			|| "117.121.12.128".equals(ip) 
			|| "117.121.12.2".equals(ip) 
			||"211.157.28.196".equals(ip)
			||"172.16.162.126".equals(ip)
			||"172.16.132.126".equals(ip)
			||"172.16.162.125".equals(ip)
			||"172.16.132.125".equals(ip)
			||"192.168.1.3".equals(ip)
			||"192.168.1.2".equals(ip)
			||"192.168.70.42".equals(ip)
			||"140.210.2.132".equals(ip)
			||"10.99.12.112".equals(ip)
			||"10.99.12.114".equals(ip)
			||"192.168.70.41".equals(ip)
			||"117.121.12.44".equals(ip)){
		try{
			if("".equals(fromName) || "".equals(userId) || "".equals(mobile)|| "".equals(title)|| "".equals(content)){
				state = -2;
				msg = "提交参数错误";
			}else{
				mobile = encrypt(mobile);
				if(!insertMail(1, 0, fromName, userId, mobile, title, content)){
					state = -1;
					msg = "系统错误";
				}
		    }
	
		}catch(Exception e){
			e.printStackTrace();
			state = -4;
			msg = "系统错误";
		}
	}else{
		state = -3;
		msg = "ip限制";
	}
	System.out.println(new Date().toLocaleString() + "   crm send mail ip:"+ip + ",fromName:" + fromName +",title:" + title + ", userId:"+userId + ", state:"+state);
	response.setContentType("utf-8");
	response.getWriter().write("{\"state\":\""+state+"\",\"msg\":\""+msg+"\"}");
%>
