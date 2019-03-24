//个人中心-修改密码/^[0-9a-zA-Z_]{6,12}$/
var commonReg = /^[0-9a-zA-Z]{6,12}$/;
function respwd(){
	$('#bt_rest').hide();
	var pwd1 = $('#newpwd1').val();
	var pwd2 = $('#newpwd2').val();
	var opwd = $('#oldpwd').val();
	
	var sso_userID = getCookie("WEBSSO_UID");
	var sso_userName = getCookie("WEBSSO_ZJUSERNAME");
	var sso_LID = getCookie("WEBSSO_LID");
	if(sso_userID == "" || sso_LID == ""){
		$("#hint").html("提示：你还未登录，请先登录!");
		$('#bt_rest').show();
		return false;
	}
	
	if (!commonReg.test(opwd)) {
		$("#hint").html("提示：旧密码错误(由6-12位数字、英文字母或组合)！");
		$('#bt_rest').show();
		return false;
	}
	if (!commonReg.test(pwd1) ) {
		$("#hint").html("提示：新密码由6-12位数字、英文字母或组合！");
		$('#bt_rest').show();
		return false;
	}
	if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(pwd1)){
		$("#hint").html("提示：新密码不能使用原初始密码!");
		$('#bt_rest').show();
		return false;
	}
	
	if(pwd1 != pwd2 ){
		$("#hint").html("提示：两次密码输入不一致!");
		$('#bt_rest').show();
		return false;
	}
	
	$.post("/zhengjin/user/resetpwd_ajax.jsp",{opwd: opwd,pwd1 : pwd1, pwd2:pwd2, sso_userID:sso_userID,sso_userName:sso_userName,sso_LID:sso_LID},
	function(data){
		var obj=eval("("+data+")");
		if(obj.state == '0'){
			$("#hint").html("提示：密码修改成功,请退出重新登录!");
			$('#newpwd1').val("");
			$('#newpwd2').val("");
			$('#oldpwd').val("");
			alert("提示：密码修改成功,请退出重新登录!");
		}else{
			$('#bt_rest').show();
			$("#hint").html("提示："+obj.errorMsg);
		} 
		
	},"text");
}
//定义检测函数,返回0/1/2/3分别代表无效/差/一般/强
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
	if (s.match(/[0-9]{1,12}/g) && s.match(/[a-z]{1,12}/g) && s.match(/[A-Z]/g) && s.length >= 10) {
		ls++;
	}
	if (s.length < 6 && ls > 0) {
		ls--;
	}
	return ls
}
function checknewpwd() {
	var pwd1 = $("#newpwd1").val();
	var id = getResult(pwd1);
	if (id < 2) {
		$("#lv1").addClass("lv1");
		$("#lv2").removeClass("lv2");
		$("#lv3").removeClass("lv3");
		$("#pwdStrength").html("差");
	}
	if (id == 2) {
		$("#lv1").addClass("lv1");
		$("#lv2").addClass("lv2");
		$("#lv3").removeClass("lv3");
		$("#pwdStrength").html("一般");
	}
	if (id >= 3) {
		$("#lv1").addClass("lv1");
		$("#lv2").addClass("lv2");
		$("#lv3").addClass("lv3");
		$("#pwdStrength").html("强");
	}
}

function checkNewPwd12(){
	var pwd1 = $("#newpwd1").val();
	var pwd2 = $("#newpwd2").val();
	if(pwd1!="" && pwd2!=""&&pwd1 == pwd2)
		$("#hint2").removeClass("alert").addClass("ok");
	else
		$("#hint2").removeClass("ok").addClass("alert");
		
}