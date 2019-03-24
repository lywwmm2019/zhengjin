<%@page import="jspdata.shiwei.ZjJrjSms5Util"%>
<%@page import="jspdata.glt.DateUtils"%>
<%@page import="org.nutz.json.Json"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%!String COOKIE_DOMAIN_KEY = ".zhengjin99.com";

	String getValueFromCookie(HttpServletRequest request, String cookieKey) {
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
	}%>
<%
	String activityID = ZjJrjSms5Util.indexActivityID;
	pageContext.setAttribute("activityID", activityID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="证金贵金属,白银,白银分析,白银投资,白银价格,白银交易,炒白银,白银走势,白银软件,模拟炒银,美联储,白银在线分析" />
<meta name="description" content="证金贵金属，首家赴美纳斯达克上市公司中国最大最专业的白银投资服务平台，致力于白银投资、白银交易、现货白银、白银价格、炒白银、现货白银走势、白银行情、模拟炒银、现货白银开户、投资资讯、分析评论、贵金属投资等贵金属综合性投资服务" />
<title>找回密码_证金贵金属</title>
<link href="../css/style_v2.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.watermark.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<!-- 增加图形验证码 -->
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript" src="../../js/dialog-min.js"></script>
<link href="../../css/ui-dialog.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
var activityID = "SSO_GJS_20130409";

$(document).ready(function(){
    $("#mobile").watermark("请输入您的手机号码");
    $("#code").watermark("输入验证码");
});

function sendCode() {
	var mobile = $("#mobile").val();
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		alert("手机号码为空或者格式错误！");
		return false;
	}
	/*$.post("../sendcode_findpwd_ajax2.jsp", {
		mobNo : mobile,
		activityID : activityID
	}, function(data) {
		console.log(data);
		data = eval("(" + data + ")");
		if (data.state == "ok") {
			countTime();
			$('#wait_send').hide();
			$('#send_success').show();
			$("#hint").show();
		} else {
			$("#send_code").show();
			$("#noget").hide();
			alert(data.msg);
		}
	});*/
	
	
	
	$.post("../ws/sendcode_common.jsp", {
		mobile : mobile,
		uuid:uuid,
        code:$("#cde").val(),
        type:'1',
        cacheNameHeader:'gjsfindpwd'
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
	$.post("../ws/sendcode_common.jsp", {type : 3, mobile : $("#mobile").val(),cacheNameHeader:'gjsfindpwd'}, function(data) {
		console.log(data);
	});
}


function findBack() 
{
	var mobile = $("#mobile").val();
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		alert("手机号码为空或者格式错误！");
		return false;
	}
	
	var code = $("#code").val();
	if (code.length != 4) {
		alert("请输入4位验证码！");
		return false;
	}
	
	$.post("../find_password_ajax2.jsp", {
		mobile : mobile,
		code : code,
		cacheNameHeader:'gjsfindpwd'
	}, function(data) {
		data = eval("(" + data + ")");
		if (data.state == 0) {
			$("#noget").hide();
			$("#hint").html("您的密码为["+data.pwd+"]").parent().show();
			$("#hint").show();
			alert("操作成功，密码为 " + data.pwd +" , 请查看“您的密码项”");
		} else {
			if(data.state == '-104')
				alert("您输入验证码错误次数过多，请稍后再试！");
			else
				alert(data.msg);
		}
	});
}

var flag = true;
var interval;
function countTime(){
	$("#time").attr("disabled",true); 
	interval = setInterval(excuFun,1000);
}
var time = 300;
function excuFun(){
	if(flag && time>=1&& time<=300){
		time -= 1;
		$("#time").val(time+"秒后重新获取校验码");
	}else{
		clearInterval(interval); 
		time = 300;
		$("#time").attr("disabled",false); 
		$("#time").val("重新获取校验码");
	}
}
</script>
 
</head>

<body>
	<!-- head -->
    <%@ include file="../head_v2.jsp"%>
	<!--  -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>
    
    <!--  -->
    <div id="findpwd" class="pr">
    	<p class="findpwd_title">手机找回密码</p>
    	<p class="red lh200">您正在使用"手机校验码"验证身份找回密码！</p>
        <ul class="findpwd_list">
        	<li><label><span class="red">*</span>手机号码：</label><input id="mobile" type="text" class="txt" maxlength="11"/><div class="clear"></div></li>
            <li style="margin-bottom:5px;"><label><span class="red">*</span>输入验证码：</label>
            <input id="code" type="text" class="txt" style="width:100px;"  maxlength="4"/>
            <input id="getImgCode"  onclick="sendImgCode('gjsfindpwd')" type="button" class="yzm" value="点击获取验证码"  />
            <div id="voice1" class="hide mt10"><b>若未收到短信，请您<a href="javascript:sendVoice();">获取语音验证码</a></b></div>
            <div id="voice2" class="hide mt10"><b>您将收到语音来电 ，请注意接听</b></div>
            <!-- <div class="fl pr" >
            	<a id="noget" href="javascript:void(0)"  style="display: none;" class="click" onclick="$('#send_success').hide();$('#wait_send').show();">没有收到短信验证码</a>
        		<div id="wait_send" class="pa box" style="display: none;">
                	<a href="javascript:void(0)" class="pa close" onclick="$('#wait_send').hide();"><img src="../images/findpwd_close.png" width="14" height="15" /></a>
                	<p class="title">手机卫士拦截可能造成短信屏蔽，请仔细查看或重新获取。</p>
                    <p class="clear over">
                    <input id="voice1" type="button" class="reget" value="尝试获取语音校验码" onclick="sendVoice();"/></p>
                	<div id="voice2" class="hide mt10">　　　　您将收到语音来电，请留意接听。</div>
                    <p class="mt20">·请核实手机是否已欠费停机，或者屏蔽了系统短信。</p>
                    <p>·如果 手机已丢失或停用，请联系客服人员修改绑定手机号。</p>
                </div>
            </div> -->
            <div class="clear"></div>
            </li>
            <!-- <li><div style="margin-left:135px;display: none;" id="hint">校验码已发送至您手机上，请注意查收，10分钟内输入有效，请勿泄漏。</div></li> -->
            <li><input name="" type="button" class="getpwd" onclick="findBack();"/><div class="clear"></div></li>
        </ul>
    </div>
    <!-- foot -->
    <%@ include file="../foot_v2.jsp"%>
</body>
</html>
