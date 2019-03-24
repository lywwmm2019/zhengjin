<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="user_common.jsp"%> 
<%
String mobile = getLoginMobile(request);
List<Map<String,String>> protocols = new ArrayList<Map<String,String>>();
if(mobile != null){
	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	String crmuserId = (String)info.get("UserID");
	List<Map> openAccountList = (List<Map>)info.get("OpenAccountList");
	if(openAccountList != null && openAccountList.size()>0){
		boolean tianjiao = false;
		boolean dayuan = false;
		for(Map acount: openAccountList){
			Integer ExchangeID = (Integer)acount.get("ExchangeID");
			Integer AccountTypeID = (Integer)acount.get("AccountTypeID");
			String AccountID = (String)acount.get("AccountID");
			String path = "";
			if(AccountTypeID==1||AccountTypeID==0){
				Map<String,String> obj = new HashMap<String,String>();
				if(!tianjiao && AccountID.startsWith("212")){
					path = "http://pic.zhengjin99.com/pdf/tianjiao/";
					obj.put("Exchange", "天交所");
					obj.put("pdf", path+crmuserId+".pdf");
					tianjiao = true;
					protocols.add(obj);
				}else if(!dayuan && AccountID.startsWith("1099090")){
					path = "http://pic.zhengjin99.com/pdf/dayuan/";
					obj.put("Exchange", "大圆银泰");
					obj.put("pdf", path+crmuserId+".pdf");
					dayuan = true;
					protocols.add(obj);
				}
			}
		}
		
	}
}
pageContext.setAttribute("protocols", protocols);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
<title>个人中心_证金贵金属</title>
</head>

<body>
	<!-- head -->
	<%@ include file="../head_v2.jsp"%>
	<!-- nav -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>
    
	<div id="personal" class="clear mb20 bg_left_gray"> 
        
        <!-- main-left-menu -->
        <%@ include file="left_menu.jsp"%>
        
    	<div class="fr grzx_right">
        	<div class="personal_right pr">
                <p class="personal_right_title mt30">用户协议 </p>
                <table width="80%" border="0" cellspacing="0" cellpadding="0" class="personal_index_sp tc">
                  <tr>
                    <td class="fb" width="33%">交易所</td>
                    <td class="fb">协议</td>
                  </tr>
                  <c:forEach items="${protocols}" var="r">
                  <tr>
	                  <td class="fb">${r.Exchange }</td>
		              <td><a target="_blank" href="${r.pdf }">下载开户协议>></a></td>
		          </tr>
                  </c:forEach>
                  <c:if test="${fn:length(protocols)==0}">
                  <tr>
		              <td colspan="2"> 无相关内容 </td>
		          </tr>
                  </c:if>
                  
                </table>
            </div>
      	</div>
      
      	<div class="clear"></div>
    </div>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>
