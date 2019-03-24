﻿<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>信息中心_调查问卷</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/xxzx.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.post("dclb_ajax.jsp",function(data){
		$("#dc_list").html(data);
	});
});

function next(num, total){
	if(num>0 && num < total)
		getData(num+1);
}

function up(num, total){
	if(num>1)
		getData(num-1);
}
function getData(num){
	$.post("dclb_ajax.jsp",{num:num}, function(data){
		$("#dc_list").html(data);
	});
}

function openUrl(id, title){
	window.location.href = "dcwj.jsp?id="+id+"&title='"+escape(title)+"'";
}
</script>
</head>

<body>
	<!-- head -->
	<%@ include file="../head_v2.jsp"%>
	<!-- nav -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>
	<div id="personal" class="clear mb20 over bg_left_gray">
    	<%@ include file="left_menu.jsp"%>
    	<div class="fr grzx_right">
        	<div class="personal_right pr">
        		<p class="personal_right_title">调查问卷</p>
        		<div id="dc_list">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_dcwj_table">
                <thead>
                  <tr>
                    <td width="85%" class="pl5">标题</td>
                    <td class="tc">日期</td>
                  </tr>
                </thead>
                <tbody>
	                  <tr>
	                    <td class="bg_gray pl5">暂无调查问卷!</td>
	                  </tr>
	                  
	            </tbody>
	                
	            </table>
                </div>
                
            </div>
      	</div>
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>

