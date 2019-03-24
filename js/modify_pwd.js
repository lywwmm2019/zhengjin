// TODO 如状态有改变，需同时改js和jsp，如sign_up_ajax.jsp以及cms中的js
var errorObj = {};
errorObj[1] = "操作失败，验证码可能已过期，请重新尝试获取验证码！";
errorObj[2] = "验证码错误，请输入正确的验证码！";
errorObj[3] = "操作失败，请重新尝试获取验证码！";
errorObj[4] = "操作失败，请重新尝试！";
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

var commonReg = /^[0-9a-zA-Z_]{6,12}$/;
function submitForm() {
	var pwdold = $("#pwdold").val();
	var pwd1 = $("#pwd1").val();
	var pwd2 = $("#pwd2").val();
	var mobile = $("#mobile").val();
	var code = $("#code").val();
	/**if (!commonReg.test(pwdold)) {
		$("#pwdold_error").html("6-12位数字、英文字母或组合").show();
		return false;
	}else{
		$("#pwdold_error").hide();
	}*/
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
	$("#regForm").submit();
}


function openInitpwd(){
	var width=$(window).width();
	var height=$(window).height();
	var dheight=$(document).height();
	$('.gray').css({'width':width,'height':dheight,'display':'block'});
	$('#alert').css({'left':width/2-306});
	$('#alert').css({'top':height/2-207});
	$('#alert').css({'display':'block'});
	
	var sso_userID = cookie("WEBSSO_UID");
	$('#sso_userID').val(sso_userID);
	var sso_userName = cookie("WEBSSO_ZJUSERNAME");
	$('#sso_userName').val(sso_userName);
	var sso_LID = getCookie("WEBSSO_LID");
	$('#sso_LID').val(sso_LID);
	$("#hint").html("");
	$('#pwd1').val("");
	$('#pwd2').val("");
	$("#button1").show();
	zjgjs.sso.loginOut();
}

function closeInitpwd(){
	zjgjs.sso.loginOut();
	$('.gray').css({'display':'none'});
	$('#alert').css({'display':'none'});
}

function modify(){
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();
	if (!commonReg.test(pwd1) ) {
		$("#hint").html("提示：新密码由6-12位数字、英文字母或组合");
		return false;
	}
	if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(pwd1)){
		$("#hint").html("提示：新密码不能使用原初始密码!");
		return false;
	}
	
	if(pwd1 != pwd2 ){
		$("#hint").html("提示：两次密码输入不一致!");
		return false;
	}
	var sso_userID =  $('#sso_userID').val();
	var sso_userName = $('#sso_userName').val();
	var sso_LID = $('#sso_LID').val();
	$.ajax({
		  type : "get",
		  async:false,
		  url : "http://tg.zhengjin99.com/zhengjin/modify_pwd_java.jsp?pwd1=" + pwd1 + "&pwd2=" + pwd2+"&sso_userID="+sso_userID+"&sso_userName="+sso_userName+"&sso_LID="+sso_LID,
		  dataType : "jsonp",
		  timeout: 2000,
		  jsonp: "callbackparam",
		  jsonpCallback: "success_jsonpCallback",
		  success : function(json){
			  var json1 = json;
			  if(json1.state == "0"){
			  	$("#hint").html("提示：密码修改成功,请退出重新登录!");
				$("#button1").hide();
			  }else{
			  	$("#hint").html("提示："+json1.errorMsg);
			  }
		}
	
	});
}

function checkinput(){
	var pwd1 = $('#pwd1').val();
	var pwd2 = $('#pwd2').val();
	if(pwd1 != "" &&  pwd2 != "" && pwd1 == pwd2){
		//$('#input_hint').css({'display':'block'});
		$('#input_hint').show();
	}else{
		$('#input_hint').hide();
		//$('#input_hint').css({'display':'none'});
	}
}

function checkPwd2() {
	var pwd1 = $("#pwd1").val();
	var id = getResult(pwd1);
	if (id < 2) {
		$("#pwdImg").removeClass("alert_img_1").removeClass("alert_img_2").removeClass("alert_img_3")
				.addClass("alert_img_1");
		$("#pwdStrength").html("&nbsp;弱");
	}
	if (id == 2) {
		$("#pwdImg").removeClass("alert_img_1").removeClass("alert_img_2").removeClass("alert_img_3")
				.addClass("alert_img_1").addClass("alert_img_2");
		$("#pwdStrength").html("&nbsp;一般");
	}
	if (id >= 3) {
		$("#pwdImg").removeClass("alert_img_1").removeClass("alert_img_2").removeClass("alert_img_3")
				.addClass("alert_img_1").addClass("alert_img_2").addClass("alert_img_3");
		$("#pwdStrength").html("&nbsp;强");
	}
}
