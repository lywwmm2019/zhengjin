// TODO ��״̬�иı䣬��ͬʱ��js��jsp����sign_up_ajax.jsp�Լ�cms�е�js
var errorObj = {};
errorObj[1] = "����ʧ�ܣ���֤������ѹ��ڣ������³��Ի�ȡ��֤�룡";
errorObj[2] = "��֤�������������ȷ����֤�룡";
errorObj[3] = "����ʧ�ܣ������³��Ի�ȡ��֤�룡";
errorObj[4] = "����ʧ�ܣ������³��ԣ�";
errorObj[0] = "ע��ɹ���";
errorObj[-1] = "�û����Ѵ��ڣ�����ʧ�ܣ�";
errorObj[-2] = "�ֻ����Ѵ��ڣ�����ʧ�ܣ�";
errorObj[-3] = "�û����ֻ����Ѵ��ڣ�����ʧ�ܣ�";
errorObj[-10] = "���������Ϣ������������ύ��";

var phoneVerifyCode = "";// �ֻ���֤����·���verifyCode
// �����⺯��,����0/1/2/3�ֱ������Ч/��/һ��/ǿ
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
		$("#pwdStrength").html("&nbsp;��");
	}
	if (id == 2) {
		$("#pwdImg").removeClass("qd").removeClass("qd1").removeClass("qd2")
				.removeClass("qd3").addClass("qd2");
		$("#pwdStrength").html("&nbsp;һ��");
	}
	if (id == 3) {
		$("#pwdImg").removeClass("qd").removeClass("qd1").removeClass("qd2")
				.removeClass("qd3").addClass("qd3");
		$("#pwdStrength").html("&nbsp;ǿ");
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
		$("#pwdold_error").html("6-12λ���֡�Ӣ����ĸ�����").show();
		return false;
	}else{
		$("#pwdold_error").hide();
	}*/
	if (!commonReg.test(pwd1) ) {
		$("#pwd1_error").html("6-12λ���֡�Ӣ����ĸ�����").show();
		return false;
	}else{
		$("#pwd1_error").hide();
	}
	if (pwd1 != pwd2) {
		$("#pwd2_error").html("�����������벻һ��").show();
		return false;
	}else{
		$("#pwd2_error").hide();
	}
	if (!commonReg.test(pwd2) ) {
		$("#pwd2_error").html("6-12λ���֡�Ӣ����ĸ�����").show();
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
		$("#hint").html("��ʾ����������6-12λ���֡�Ӣ����ĸ�����");
		return false;
	}
	if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(pwd1)){
		$("#hint").html("��ʾ�������벻��ʹ��ԭ��ʼ����!");
		return false;
	}
	
	if(pwd1 != pwd2 ){
		$("#hint").html("��ʾ�������������벻һ��!");
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
			  	$("#hint").html("��ʾ�������޸ĳɹ�,���˳����µ�¼!");
				$("#button1").hide();
			  }else{
			  	$("#hint").html("��ʾ��"+json1.errorMsg);
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
		$("#pwdStrength").html("&nbsp;��");
	}
	if (id == 2) {
		$("#pwdImg").removeClass("alert_img_1").removeClass("alert_img_2").removeClass("alert_img_3")
				.addClass("alert_img_1").addClass("alert_img_2");
		$("#pwdStrength").html("&nbsp;һ��");
	}
	if (id >= 3) {
		$("#pwdImg").removeClass("alert_img_1").removeClass("alert_img_2").removeClass("alert_img_3")
				.addClass("alert_img_1").addClass("alert_img_2").addClass("alert_img_3");
		$("#pwdStrength").html("&nbsp;ǿ");
	}
}
