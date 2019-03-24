<%@page import="com.gti.Utils"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	int menu = 0;
	String url = request.getRequestURI();
	if(url.contains("bonus_jyk.jsp"))
		menu = 1;
	else if(url.contains("bonus_detail_bh.jsp"))
		menu = 2;
	else if(url.contains("xxzx.jsp"))
		menu = 3;
	else if(url.contains("zstq_"))
		menu = 4;
	else if(url.contains("favorite.jsp"))
		menu = 5;
	else if(url.contains("dclb.jsp"))
		menu = 6;
	else if(url.contains("fxpg.jsp"))
		menu = 7;
	else if(url.contains("protocol.jsp"))
		menu = 8;
	else if(url.contains("resetpwd.jsp"))
		menu = 9;
	/* else if(url.contains("bonus_detail_gehk.jsp"))
		menu = 10; */
	pageContext.setAttribute("menu", menu);
%>

<div class="grzx_menu fl">
       <ul class="menu_list">
       	<li <c:if test="${menu==0}">class="click"</c:if>><p><a href=".">个人信息</a></p></li>
        <%-- <li <c:if test="${menu==1}">class="click"</c:if>><p><a href="bonus_jyk.jsp">标杆计划</a></p></li> --%>
        <%-- <li <c:if test="${menu==2}">class="click"</c:if>><p><a href="bonus_detail_bh.jsp">证金礼包</a></p></li> --%>
        <%-- <li <c:if test="${menu==10}">class="click"</c:if>><p><a href="bonus_detail_gehk.jsp">添红计划</a></p></li> --%>
        <li <c:if test="${menu==3}">class="click"</c:if>><p><a href="xxzx.jsp">消息中心<span style="padding:0;color:#f00;" id="xxzx"><c:if test="${nrxxNum>0}">（${nrxxNum}）</c:if></span></a></p></li>
        <li <c:if test="${menu==4}">class="click"</c:if>><p><a href="zstq.jsp">专属特权</a></p></li>
        <li <c:if test="${menu==5}">class="click"</c:if>><p><a href="favorite.jsp">我的收藏</a></p></li>
        <li <c:if test="${menu==6}">class="click"</c:if>><p><a href="dclb.jsp">调查问卷</a></p></li>
        <li <c:if test="${menu==7}">class="click"</c:if>><p><a href="fxpg.jsp">风险评估</a></p></li>
        <li <c:if test="${menu==8}">class="click"</c:if>><p><a href="protocol.jsp">用户协议</a></p></li>
        <li <c:if test="${menu==9}">class="click"</c:if>><p><a href="resetpwd.jsp">修改密码</a></p></li>
    </ul>
</div>
