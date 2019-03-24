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
<%!
	
	private boolean hasSubmit(Integer vid, String mobile, String userId){
		String sql = "SELECT count(*) as total FROM ZX_Vote_Result where (mobile= '"+ mobile + "' or mobile= '"+ userId + "') and vId="+vid;
		List list = QueryRunner.getListBySql(sql);
		Integer total = 0;
		if(list.size()>0){
			total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
		}
		if(total > 0)	
			return true;
		return false;
	}
%>

<%
	int state = 0;
	String mobile = getLoginMobile(request);	
	if(mobile != null){
		try{
			int pageSize  = 8;
			String vid = Utils.getParameterValue(request,"vid","");
			String vqs = Utils.getParameterValue(request,"vqs","");
			String suggest = Utils.getParameterValue(request,"suggest", "");
			String sugs = Utils.getParameterValue(request,"sugs", "");
			String type = Utils.getParameterValue(request,"type", "");
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				mobile = encrypt(mobile);
				String crmUserId = (String)info.get("UserID");
				if(!hasSubmit(Integer.valueOf(vid), mobile, crmUserId)){
					Map map = (Map) Json.fromJson(vqs);
					Map mapsugs = null;
					if("2".equals(type))
						mapsugs = (Map) Json.fromJson(sugs);
					Set<String> keys = map.keySet();
					StringBuilder sb = new StringBuilder();
					sb.append("INSERT into ZX_Vote_Result(vId, qId, vqId, mobile, suggest, createTime) VALUES ");
					for(String key: keys){
						sb.append("(").append(vid);
						sb.append(", ").append(key);
						sb.append(", ").append(map.get(key));
						sb.append(", '").append(crmUserId).append("'");
						if("2".equals(type))
							sb.append(", '").append(mapsugs.get(key)).append("'");
						else
							sb.append(", null");
						sb.append(",GETDATE())");
						sb.append(",");
					}
					//总建议
					if(!"".equals(suggest)){
						sb.append("(").append(vid);
						sb.append(", ").append(0);
						sb.append(", ").append(0);
						sb.append(", '").append(crmUserId).append("'");
						sb.append(", '").append(suggest).append("'");
						sb.append(",GETDATE())");
						sb.append(",");
					}
					QueryRunner.runSql(sb.substring(0, sb.lastIndexOf(",")));
				}else{
					state = -2;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			state = -1;
		}
	}else{
		state = -3;
	}
%>
{"state": <%=state %>}