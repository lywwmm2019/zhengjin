<%@page language="java" pageEncoding="utf-8" import="java.util.*" %>
<%@page import="com.gti.Utils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
try {
	String activityID = Utils.getParameterValue(request, "activityID","SSO_GJS_20130409");
	pageContext.setAttribute("activityID", activityID);
	
	String hreferer = request.getHeader("referer");
    String hfrom = Utils.getParameterValue(request,"from", "");
    if(hfrom != null && "jiaoyibao".equals(hfrom)){
        pageContext.setAttribute("head", 0);
        hreferer = "";
    }else if (hreferer != null && hreferer.contains("from=jiaoyibao")){
        pageContext.setAttribute("head", 0);
        hreferer = "from=jiaoyibao";
    }else{
        hreferer = "";
    }
    pageContext.setAttribute("hreferer", hreferer);
} catch (Exception e) {
	e.printStackTrace();
}
%>
<%!
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="keywords" content="证金贵金属,白银,白银分析,白银投资,白银价格,白银交易,炒白银,白银走势,白银软件,模拟炒银,美联储,白银在线分析" />
<meta name="description" content="证金贵金属，首家赴美纳斯达克上市公司中国最大最专业的白银投资服务平台，致力于白银投资、白银交易、现货白银、白银价格、炒白银、现货白银走势、白银行情、模拟炒银、现货白银开户、投资资讯、分析评论、贵金属投资等贵金属综合性投资服务" />
<title>注册_证金贵金属</title>
<link href="http://www.zhengjin99.com/images/logo.ico" rel="shortcut icon">
<link href="../css/style_v2.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="../js/index_common.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.watermark.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>

<!-- 增加图形验证码 -->
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript" src="../../js/dialog-min.js"></script>
<link href="../../css/ui-dialog.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(document).ready(function(){
	    $("#mobile").watermark("请输入您的手机号码");
	    $("#sign_password0").watermark("请输入您的登录密码");
	    $("#sign_password1").watermark("请再次输入您的登录密码");
	    $("#sign_code").watermark("输入验证码");
	});
	
	
	var commonReg = /^[0-9a-zA-Z]{6,12}$/;
	function sendCode() {
		var activityID = $("#activityID").val();
		var mobile = $("#mobile").val();
		if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
			alert("手机号码不能为空且为正确的手机格式");
			return false;
		}
		$.post("../ws/sendcode_common.jsp", {
			mobile : mobile,
			uuid:uuid,
            code:$("#cde").val(),
            type:'1',
            cacheNameHeader:'gjsreg'
		}, function(data) {
			data = eval("(" + data + ")");
			if (data.state == "1") {
                alert("已成功发送短信，请查看后输入验证码！\n若60秒后仍未收到短信，请根据页面提示获取语音验证码。");
			} else {
				alert(data.msg);
			}
			setTimeout("showTip()", 60000);
		});
	}
	
	function showTip() {
		$('#voice2').hide();
		$('#voice1').show();
	}
	
	function sendVoice() {
		$('#voice1').hide();
		$('#voice2').show();
		$.post("../ws/sendcode_common.jsp", {type : 3, mobile : $("#mobile").val(),cacheNameHeader:'gjsreg'}, function(data) {
			console.log(data);
		});
	}
	
	function sign() {
		var activityID = $("#activityID").val();
		$("#bt_sign").attr("disabled",true);
		var mobile = $("#mobile").val();
		if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
			return alert("手机号码不能为空且为正确的手机格式");
		}
		var sign_password0 = $("#sign_password0").val();
		var sign_password1 = $("#sign_password1").val();
		if (!commonReg.test(sign_password0)) {
			return alert("6-12位数字、英文字母或组合");
		}
		
		if (sign_password0 != sign_password1) {
			return alert("两次输入的密码不一致");
		}
		
		var code = $("#sign_code").val();
		if(code.replace(/ /gim, "").length == 0){
			return  alert("请输入正确的验证码");
		}
		$.post("../mall/sign_java.jsp",{
			mobile : mobile,
			pwd1 : sign_password0,
			pwd2 : sign_password1,
			code : code,
			cacheNameHeader:'gjsreg',
			activityID:activityID
		}, function(data) {
			data = eval("(" + data + ")");
			if (data.state == 0) {
				addCookie("WEBSSO_LID",mobile,0)
				if(confirm("注册成功! 要现在登录吗？")){
					window.location.href = "login.jsp";
				}else{
					$("#mobile").val("");
					$("#sign_password0").val("");
					$("#sign_password1").val("");
				}
			} else {
				alert(data.msg);
			}
			$("#bt_sign").attr("disabled",false);
		});
	}
</script>
</head>
<body>
    <c:if test="${head != 0}">
	<!--  -->
	<div id="head">
        <div class="w990 mauto over clear logo">
        	<h1>
            	<a href="http://www.zhengjin99.com"><img src="../images/logo.png" width="199" height="47" alt="证金贵金属" class="block fl" /></a>
                <img src="../images/logo_register.png" width="59" height="35" alt="注册" class="block fl" />
            	<img src="../images/kefu.png" width="294" height="32" alt="客服电话：010-58309199" class="block fr" />
            </h1>
        </div>
    </div>
    </c:if>
    <!--  -->
    <div id="register" class="pr">
    	<div class="banner1 pr">
            <div class="w990 mauto pr login_dialog" style="z-index:9;">            	
            	<div class="login_main pa">
                    
                    <input id="activityID" type="hidden" value="${activityID}"/> 
                    <div class="login_input_phone"><input name="" id="mobile" type="text" maxlength="11"/></div>
                    <div class="login_input_pwd"><input name="" id="sign_password0" type="password" maxlength="12"/></div>
                    <p class="register_hint">6-12位数字、英文字母或组合</p>
                    <div class="login_input_pwd" style="margin-top:0;"><input name="" id="sign_password1"  type="password" maxlength="12"/></div>
                    <div class="mt20">
	                    <input name="" id="sign_code" type="text" class="yzm" maxlength="4"/>
	                    <input name="" type="button" id="getImgCode"  onclick="sendImgCode('gjsreg')" class="getcode ml10"/>
                    </div>
                    <div id="voice1" class="hide mt10"><b>若未收到短信，请您<a href="javascript:sendVoice();">获取语音验证码</a></b></div>
                    <div id="voice2" class="hide mt10"><b>您将收到语音来电 ，请注意接听</b></div>
                    <input name="" type="button" class="register_btn block" onclick="sign();" />
                </div>
            </div>
            <div class="login_bg"></div>
        </div>
    </div>
    <!-- foot -->
    <%@ include file="../foot_v2.jsp"%>
</body>
</html>


