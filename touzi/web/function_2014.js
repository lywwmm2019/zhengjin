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
	  jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数
	  jsonpCallback:"success_jsonpCallback",//callback的function名称
	  success : function(data){
		  var state=data.state-0;
		  var msg="";
		  switch(data.state){
			  case "0":
				msg="收藏成功，请到收藏中心查看";
				break;
			  case "-1":
				msg="收藏失败";
				break;
			  case "-2":
				msg="您已收藏，请不要重复收藏";
				break;
			  case "-3":
				msg="提交参数错误";
				break;
			  case "-4":
				msg="未登录";
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
                alert("收藏成功!");
            }else if(data.state==-4){
                alert("请先登录再收藏!");
            }else if(data.state==-2){
                alert("您已收藏，请不要重复收藏!");
            }else {
                alert("收藏失败!");
            }
    });
}

function navSelect(){
	var clname=$('#clname').html();
	if(clname=='媒体报道'||clname=='公司新闻'||clname=='公司公告'){
		var className=$('#nav li').eq(2).attr('class');
		$('#nav li').eq(2).attr('class',className+'_sl');
	}
	else if(clname=='社会责任'){
		var className=$('#nav li').eq(4).attr('class');
		$('#nav li').eq(4).attr('class',className+'_sl');
	}
	else if(clname=='每日评论'){
		var className=$('#nav li').eq(2).attr('class');
		$('#nav li').eq(2).attr('class',className+'_sl');
	}
	else if(clname=='资讯导读'){
		var className=$('#nav li').eq(1).attr('class');
		$('#nav li').eq(1).attr('class',className+'_sl');
	}
	else if(clname=='专业术语'||clname=='基本面分析'||clname=='技术讲解'||clname=='心得分享'){
		var className=$('#nav li').eq(4).attr('class');
		$('#nav li').eq(4).attr('class',className+'_sl');
	}
}

function showDialog(title, content) {
	dialog({
		title: title,
		content: content,
		okValue: '确 定',
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

        