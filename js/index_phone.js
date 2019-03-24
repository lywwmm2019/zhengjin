// JavaScript Document

var commonPhone2 = "请输入手机号";
var mobileRES = /^(((1[3,8][0-9]{1})|159|158|151|152|153|154|155|156|157|150)+\d{8})$/;
function sendCode2(index) {
	var mobile = $("#phone" + index).val();
	var activityID = "";
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		alert("手机号码不能为空且为正确的手机格式");
		return false;
	}
	$.ajax({
	  type : "get",
	  async:false,
	  url : "http://tg.zhengjin99.com/zhengjin/cmscall/ggwyc_phone_ajax.jsp?mobNo=" + mobile + "&activityID=" + activityID,
	  dataType : "jsonp",
	  timeout: 2000,
	  jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数
	  jsonpCallback:"success_jsonpCallback",//callback的function名称
	  success : function(json){
	   var json1 = json;//{state:1,msg:"sdfa"}
	   if(json1.state == "ok"){
		alert("您已经成功提交，稍后我们会有专业客服人员与您联系，祝您投资愉快。");
	   }else{
		alert(json1.msg);
	   }
	  },
	  error:function(){
	  alert('发送失败!');
	  //TODO 紧急解决方案，等明天crm那边来人解决后要去掉
	  //	alert('您已经成功提交，稍后我们会有专业客服人员与您联系，祝您投资愉快 。');
	  }
	 }); 
}

function removeCommonPhone2(index) {
	var mobile = $("#phone" + index).val();
	if (mobile == commonPhone2) {
		$("#phone" + index).val("");
	}
}

function addCommonPhone2(index) {
	var mobile = $("#phone" + index).val();
	if (mobile == "") {
		$("#phone" + index).val(commonPhone2);
	}
}

function removeCommonCode(index) {
	var code = $("#code" + index).val();
	if (code == commonCode) {
		$("#code" + index).val("");
	}
}

function addCommonCode(index) {
	var code = $("#code" + index).val();
	if (code == "") {
		$("#code" + index).val(commonCode);
	}
}