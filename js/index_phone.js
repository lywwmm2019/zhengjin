// JavaScript Document

var commonPhone2 = "�������ֻ���";
var mobileRES = /^(((1[3,8][0-9]{1})|159|158|151|152|153|154|155|156|157|150)+\d{8})$/;
function sendCode2(index) {
	var mobile = $("#phone" + index).val();
	var activityID = "";
	if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
		alert("�ֻ����벻��Ϊ����Ϊ��ȷ���ֻ���ʽ");
		return false;
	}
	$.ajax({
	  type : "get",
	  async:false,
	  url : "http://tg.zhengjin99.com/zhengjin/cmscall/ggwyc_phone_ajax.jsp?mobNo=" + mobile + "&activityID=" + activityID,
	  dataType : "jsonp",
	  timeout: 2000,
	  jsonp: "callbackparam",//��������ڽ���callback���õ�function���Ĳ���
	  jsonpCallback:"success_jsonpCallback",//callback��function����
	  success : function(json){
	   var json1 = json;//{state:1,msg:"sdfa"}
	   if(json1.state == "ok"){
		alert("���Ѿ��ɹ��ύ���Ժ����ǻ���רҵ�ͷ���Ա������ϵ��ף��Ͷ����졣");
	   }else{
		alert(json1.msg);
	   }
	  },
	  error:function(){
	  alert('����ʧ��!');
	  //TODO �������������������crm�Ǳ����˽����Ҫȥ��
	  //	alert('���Ѿ��ɹ��ύ���Ժ����ǻ���רҵ�ͷ���Ա������ϵ��ף��Ͷ����� ��');
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