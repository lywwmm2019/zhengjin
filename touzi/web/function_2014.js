// JavaScript Document


$(document).ready(function(){
	var detailLength=$('#gjs_detail').length;
	if(detailLength>0){
		navSelect();
	}
	else{
		return;
	}
	
})


function setTab(id,n,t){
	for(var i=1;i<=t;i++){
		$('#'+id+'_content_'+i).hide();
	}
	$('#'+id+'_content_'+n).show();
}
function setTab2(id,n,t){
	for(var i=1;i<=t;i++){
		$('#'+id+'_content_'+i).hide();
	}
	$('#'+id+n).addClass('index_news_sl');
	$('#'+id+n).siblings().removeClass('index_news_sl');
	$('#'+id+'_content_'+n).show();
}

function hideDoyooBorder(){
	$("#doyoo_panel").css("width","0px");	
	$("#doyoo_monitor").css("width","0px");	
}
setInterval(function(){hideDoyooBorder()} , 1 * 1000);

function second_linkshow(e){
	$('.about_link_sec').slideUp();
	$(e).parent().siblings('.about_link_sec').slideDown();
	left_link=left_link+90;
}

//index_phone.js
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

function addFavorite(){
	var url = window.location.href;
	var title = $('#titlename').html();
	var title2=encodeURIComponent(title);
	var model =$('#clname').html();
	var model2=encodeURIComponent(model);
	$.ajax({
	  type : "post",
	  async:false,
	  url : "http://tg.zhengjin99.com/zhengjin/user/favorite_sub_ajax.jsp?model=" + model2 + "&title=" + title2 + "&url=" + url,
	  dataType : "jsonp",
	  jsonp: "callbackparam",//��������ڽ���callback���õ�function���Ĳ���
	  jsonpCallback:"success_jsonpCallback",//callback��function����
	  success : function(data){
		  var state=data.state-0;
		  var msg="";
		  switch(data.state){
			  case "0":
				msg="�ղسɹ����뵽�ղ����Ĳ鿴";
				break;
			  case "-1":
				msg="�ղ�ʧ��";
				break;
			  case "-2":
				msg="�����ղأ��벻Ҫ�ظ��ղ�";
				break;
			  case "-3":
				msg="�ύ��������";
				break;
			  case "-4":
				msg="δ��¼";
				break;
			  }
		  alert(msg);		   
	  }
	 }); 
}

function addFavorList(model, title, url) {
    $.getJSON("http://tg.zhengjin99.com/zhengjin/user/favorite_sub_ajax.jsp?callbackparam=?",
    		{url:url, title:title, model:model}, function(data) {
            if(data.state==0){
                alert("�ղسɹ�!");
            }else if(data.state==-4){
                alert("���ȵ�¼���ղ�!");
            }else if(data.state==-2){
                alert("�����ղأ��벻Ҫ�ظ��ղ�!");
            }else {
                alert("�ղ�ʧ��!");
            }
    });
}

function navSelect(){
	var clname=$('#clname').html();
	if(clname=='ý�屨��'||clname=='��˾����'||clname=='��˾����'){
		var className=$('#nav li').eq(2).attr('class');
		$('#nav li').eq(2).attr('class',className+'_sl');
	}
	else if(clname=='�������'){
		var className=$('#nav li').eq(4).attr('class');
		$('#nav li').eq(4).attr('class',className+'_sl');
	}
	else if(clname=='ÿ������'){
		var className=$('#nav li').eq(2).attr('class');
		$('#nav li').eq(2).attr('class',className+'_sl');
	}
	else if(clname=='��Ѷ����'){
		var className=$('#nav li').eq(1).attr('class');
		$('#nav li').eq(1).attr('class',className+'_sl');
	}
	else if(clname=='רҵ����'||clname=='���������'||clname=='��������'||clname=='�ĵ÷���'){
		var className=$('#nav li').eq(4).attr('class');
		$('#nav li').eq(4).attr('class',className+'_sl');
	}
}

function showDialog(title, content) {
	dialog({
		title: title,
		content: content,
		okValue: 'ȷ ��',
		ok: function () {},
		quickClose: true
	}).show();
}
       
        	$(document).ready(function(){
		var liWidth=233;//li+margin=liwidth		
		var liLength=6;
		var dheight=$(document).height();
		var wwidth=$(window).width();
		var photoN=0;
			$('.photos ul').css('width',2000);
		    $('#left_arrow').bind('click',function(){
			if(photoN<=0){
				return;
			}
			else{
				photoN--;
				$('.photos ul').animate({left:-liWidth*photoN},1000);
				
			}
		})
		$('#right_arrow').bind('click',function(){
			if(photoN>=liLength-3){
				return;
			}
			else{
				photoN++;
				$('.photos ul').animate({left:-liWidth*photoN},1000);
				
			}
		})
		})

$(document).ready(function(){
	$("#photo7").click(function(){
		$("#tc_ybw01").show();
		 $("#bg").show();		
		});	
	$("#error01").click(function(){
		$("#tc_ybw01").hide();
		$("#bg").hide()		
		});
	$("#photo8").click(function(){
		$("#tc_ybw02").show();
		 $("#bg").show();		
		});	
	$("#error02").click(function(){
		$("#tc_ybw02").hide();
		$("#bg").hide()		
		});	
	
	$("#photo9").click(function(){
		$("#tc_ybw04").show();
		$("#bg").show();		
		});
	
	$("#error04").click(function(){
		$("#tc_ybw04").hide();
		$("#bg").hide()		
		});	
	$("#photo10").click(function(){
		$("#tc_ybw05").show();
		$("#bg").show();		
		});
	
	$("#error05").click(function(){
		$("#tc_ybw05").hide();
		$("#bg").hide()		
		});	
	$("#photo11").click(function(){
		$("#tc_ybw03").show();
		$("#bg").show();		
		});
	
	$("#error03").click(function(){
		$("#tc_ybw03").hide();
		$("#bg").hide()		
		});	
	$("#photo12").click(function(){
		$("#tc_ybw06").show();
		$("#bg").show();		
		});
	
	$("#error06").click(function(){
		$("#tc_ybw06").hide();
		$("#bg").hide()		
		});	
});

        