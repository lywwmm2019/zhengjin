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
<title>修改密码_证金贵金属</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/resetpwd.js?v=2"></script>
<script type="text/javascript" src="../js/jquery.watermark.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    $("#oldpwd").watermark("请输入旧密码")
	    $("#newpwd1").watermark("请输入新密码")
	    $("#newpwd2").watermark("请再次输入新密码")
	});
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
        		<p class="personal_right_title">修改密码</p>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_resetpwd_table mt20">
                  <tbody><tr>
                    <td class="tr" height="50" width="100">旧密码：</td>
                    <td width="240"><input id="oldpwd" type="password" class="txt"  maxlength="12"></td>
                  </tr>
                  <tr>
                    <td class="tr" height="50">新密码：</td>
                    <td><input id="newpwd1" onkeyUp="checknewpwd();checkNewPwd12();" type="password" class="txt" maxlength="12"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="20">&nbsp;</td>
                    <td class="pl5"><div id="lv1" class="lv1"></div><div id="lv2"></div><div id="lv3"></div></td>
                    <td id="pwdStrength">差</td>
                  </tr>
                  <tr>
                    <td class="tr" height="50">确认新密码：</td>
                    <td><input id="newpwd2" onkeyUp="checkNewPwd12();" type="password" class="txt"  maxlength="12"></td>
                    <td><div id="hint2" class="alert"></div></td>
                  </tr>
                  <tr>
                    <td height="20">&nbsp;</td>
                  	<td height="50"><div id="hint" style="color:#FF0000"></div></td>
                  </tr>
                  <tr>
                  	<td height="50">&nbsp;</td>
                    <td class="tc"><input id="bt_rest" onclick="respwd()" type="button" class="btn"></td>
                    <td>&nbsp;</td>
                  </tr>
                </tbody></table>
            </div>
      	</div>
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>

