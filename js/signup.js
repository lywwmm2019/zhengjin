var errorObj = {};
errorObj[1] = "操作失败，验证码可能已过期，请重新尝试获取验证码！";
errorObj[2] = "验证码错误，请输入正确的验证码！";
errorObj[3] = "操作失败，请重新尝试获取验证码！";
errorObj[4] = "操作失败，请重新尝试！";
errorObj[5] = "手机号错误，谢谢！";
errorObj[0] = "注册成功！";
errorObj[-1] = "用户名已存在，操作失败！";
errorObj[-2] = "手机号已存在，操作失败！";
errorObj[-3] = "用户或手机号已存在，操作失败！";
errorObj[-10] = "您输入的信息有误，请检查后再提交！";

var phoneVerifyCode = "";// 手机验证码的下发的verifyCode
// 定义检测函数,返回0/1/2/3分别代表无效/差/一般/强
function getResult(s) {
	if (s.length < 4) {
		return 0;
	}
	var ls = 0;
	if (s.match(/[a-z]/ig)) {
		ls++;
	}
	if (s.match(/[0-9]/ig)) {
		ls++;
	}
	if (s.match(/(.[^a-z0-9])/ig)) {
		ls++;
	}
	if (s.length < 6 && ls > 0) {
		ls--;
	}
	return ls
}

function checkPwd() {
	var pwd1 = $("#pwd1").val();
	var id = getResult(pwd1);
	if (id < 2) {
		$("#pwdImg").removeClass("qd").removeClass("qd1").removeClass("qd2")
				.removeClass("qd3").addClass("qd1");
		$("#pwdStrength").html("&nbsp;差");
	}
	if (id == 2) {
		$("#pwdImg").removeClass("qd").removeClass("qd1").removeClass("qd2")
				.removeClass("qd3").addClass("qd2");
		$("#pwdStrength").html("&nbsp;一般");
	}
	if (id == 3) {
		$("#pwdImg").removeClass("qd").removeClass("qd1").removeClass("qd2")
				.removeClass("qd3").addClass("qd3");
		$("#pwdStrength").html("&nbsp;强");
	}
}

var mobileRES = /^(((1[3,8][0-9]{1})|159|158|151|152|153|154|155|156|157|150)+\d{8})$/;
function sendCode() {
	var mobile = $("#mobile").val();
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		$("#mobile_error").html("手机号码不能为空且为正确的手机格式").show();
		return false;
	}else{
		$("#mobile_error").hide();
	}
	$.post(ctx + "/zhengjin/sendcode_ajax.jsp", {
		mobNo : mobile,
		activityID : activityID
	}, function(data) {
		data = eval("(" + data + ")");
		if (data.state == "ok") {
			// $("#alert_div" + index).show();
			alert("已成功发送短信，请查看后输入验证码！");
		} else {
			alert(data.msg);
		}
	})
}
var commonReg = /^[0-9a-zA-Z_]{6,12}$/;
var emailReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
function submitForm() {
	var userName = $("#userName").val();
	var pwd1 = $("#pwd1").val();
	var pwd2 = $("#pwd2").val();
	var mobile = $("#mobile").val();
	var code = $("#code").val();
	var email = $("#email").val();
	if (!commonReg.test(userName)) {
		$("#userName_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#userName_error").hide();
	}
	if (!commonReg.test(pwd1) ) {
		$("#pwd1_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#pwd1_error").hide();
	}
	if (pwd1 != pwd2) {
		$("#pwd2_error").html("两次密码输入不一致").show();
		return false;
	}else{
		$("#pwd2_error").hide();
	}
	if (!commonReg.test(pwd2) ) {
		$("#pwd2_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#pwd2_error").hide();
	}
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		$("#mobile_error").html("手机号码不能为空且为正确的手机格式").show();
		return false;
	}else{
		$("#mobile_error").hide();
	}
	if (code.length != 4) {
		$("#code_error").html("请输入4位验证码").show();
		return false;
	}else{
		$("#code_error").hide();
	}
	if (email.length != 0 && !emailReg.test(email)) {
		$("#email_error").html("请输入正确的邮箱格式").show();
		return false;
	}
	$("#regForm").submit();
}
var commonReg = /^[0-9a-zA-Z_]{6,12}$/;
function submitReg() {
	var userName = $("#userName").val();
	var pwd1 = $("#pwd1").val();
	var pwd2 = $("#pwd2").val();
	var mobile = $("#mobile").val();
	var code = $("#code").val();
	var email = $("#email").val();
	if (!commonReg.test(userName)) {
		$("#userName_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#userName_error").hide();
	}
	if (!commonReg.test(pwd1) ) {
		$("#pwd1_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#pwd1_error").hide();
	}
	if (pwd1 != pwd2) {
		$("#pwd2_error").html("两次密码输入不一致").show();
		return false;
	}else{
		$("#pwd2_error").hide();
	}
	if (!commonReg.test(pwd2) ) {
		$("#pwd2_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#pwd2_error").hide();
	}
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		$("#mobile_error").html("手机号码不能为空且为正确的手机格式").show();
		return false;
	}else{
		$("#mobile_error").hide();
	}
	if (code.length != 4) {
		$("#code_error").html("请输入4位验证码").show();
		return false;
	}else{
		$("#code_error").hide();
	}
	if (email.length != 0 && !emailReg.test(email)) {
		$("#email_error").html("请输入正确的邮箱格式").show();
		return false;
	}
	$.ajax({
		type : "get",
		async:false,
		url : "http://tg.zhengjin99.com/zhengjin/sign_up_ajax.jsp?isSubmit=true&isFromCms=true&userName=" + userName + "&pwd1=" + pwd1 + "&pwd2=" + pwd2 + "&mobile=" + mobile + "&code=" + code + "&email=" + email,
		dataType : "jsonp",
		jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"success_jsonpCallback",//callback的function名称
		success : function(json){
			var jsonObj = json[0];
			var state = jsonObj.state;
			var msg = jsonObj.msg;
			var md5pwd = zjgjs.md5(pwd1);
			if(state == 0){
				var cookieSrc = "http://www.zhengjin99.com/addCookie.shtml?userName=" + userName;
				$("#cookieIframe").attr("src",cookieSrc);
				zjgjs.sso.login2(mobile,pwd1);
				//var ssoSrc = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID=" + mobile + "&Passwd=" + md5pwd;
				//$("#ssoIframe").attr("src",ssoSrc);
				var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/login.do?mobile="+ mobile +"&password=" + pwd1 + "&isCms=true";
				$("#zhiboIframe").attr("src",zhiboSrc);
				$("#change_win").show();
				setTimeout(function(){location.href="http://tg.zhengjin99.com/zhengjin/zjjnList.jsp"},1000 * 10);
			}else{
				alert(errorObj[state]);
			}			
		},
		error:function(){
			alert('fail');
		}
	});


}