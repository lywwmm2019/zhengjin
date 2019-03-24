// JavaScript Document

var left_link;

$(document).ready(function(){
	
	var length=$('#gsxw li').length;
	var len=length/5;
	var gsxw_str='<span class="pr gswx_fgx block"><span class="about_gswx_fgx block pa"></span></span>';
	var temp;
	var left_top;
	gettime();
	
	
	for(var i=1;i<len;i++){
		temp=i*5;
		$('#gsxw li').eq(temp-1).after(gsxw_str);		
	}
	
	$('.nav li').bind('mouseover',function(){
		$(this).siblings().removeClass('nav_hover');
		$(this).addClass('nav_hover');
		//$('.nav_s').hide();
	})
	$('.nav li').bind('mouseout',function(){
		$('.nav li').removeClass('nav_hover');
	})
	$('.nav_none').hover(function(){
		$('.nav_s').hide();
	})
	$('#nav').mouseleave(function(){
		$('.nav_s').hide();
	})
	
	$('#page span').bind('mouseover',function(){
		if(!$(this).hasClass('page_hover')){
			$('#page span').removeClass('page_hover');
			$(this).addClass('page_hover');			
		}
	})
	$('.hxjy_about_sm').one('click',function(){
		$('.hxjy_about_ultxt').show();
		$('.hxjy_about_sm').animate({height:'10px'});					
	})
	$('#sun').click(function(){
		$('#moon_bn').hide();
		$('#sun_bn').show();
	})
	$('#moon').click(function(){
		$('#sun_bn').hide();
		$('#moon_bn').show();
	})
	
	$('.khzn').one('click',function(){
		$('.khzn_txt').css('height',0);
		$('.khzn_txt').show();
		$('.khzn').animate({height:'0'});
		$('.khzn_txt').animate({height:'102px'});			
	})
	$('.jygz').one('click',function(){
		$('.jygz_txt').css('height',0);
		$('.jygz_txt').show();
		$('.jygz_txt').animate({height:'106px'});
		$('.jygz').animate({height:'0'});					
	})
	$('.download').one('click',function(){
		$('.download_txt').css('width',0);		
		$('.download').animate({width:'0'});
		$('.download_txt').animate({width:'146px'});	
		$('.download_txt').show();		
	})
	$('.bq_right').one('click',function(){
		$(".download").trigger("click");
	})
	$('.bq_top').one('click',function(){
		$(".jygz").trigger("click");
	})
	$('.bq_bottom').one('click',function(){
		$(".khzn").trigger("click");
	})
	
	$('#read_more').bind('click',function(){
		$('#read').fadeIn();
	})
	$('#return').bind('click',function(){
		$('#read').fadeOut();
	})
	
	var adv1='<a href="http://tg.zhengjin99.com/zhengjin/wxgb/"><img width="780" height="160" src="http://www.zhengjin99.com/images/htmladv1.jpg" alt="证金微信" title="证金微信" /></a>';
	var adv2='<a href="http://tg.zhengjin99.com/zhengjin/zjjnList.jsp"><img width="780" height="160" src="http://www.zhengjin99.com/images/htmladv2.jpg" alt="证金锦囊" title="证金锦囊" /></a>';
	var adv3='<img width="780" height="160" src="http://www.zhengjin99.com/images/htmladv3.jpg" alt="火线交易" title="火线交易" />';
	$('#yscl .advertise').append(adv2);
	$('#xwy .advertise').append(adv1);
	$('#zjxy .advertise').append(adv3);
	$('#gywm .advertise').append(adv3);
	$('#cjrl .advertise').append(adv1);
	
	var left_h=$('.about_left').height();
	var right_h=$('.about_right').height();
	left_link=$('.about_link').height();
	var jn_h=$('.about_zjjn2').height()+15;
	var left_temp=left_link+210+jn_h;
	if(right_h>left_temp){
		$('.about_left').css('height',right_h);
	}
	else{
		$('.about_left').css('height',left_temp);
		$('.khsp').css('height','568px');
	};
	
	
	$('#pager').bind('mouseout',function(){
		$('#page span').removeClass('page_hover');
	})
	
	$(window).scroll(function(){
		left_link=$('.about_link').height();
		left_temp=left_link+210+jn_h;
		var left=$('.about_left').height();
		var block_h=left-left_temp;
		if($(window).scrollTop()>212){
			left_top=$(window).scrollTop();
			left_top=left_top-212;
			$('#about_left').css('top',left_top);
		}
		else{
			$('#about_left').css('top','0');
		};
		if(block_h<left_top+15){
			$('#about_left').css({'top':block_h});

		}
		
		
	})
	
	if(!$('body #foot_banner').hasClass('index_foot')){
		var foot_str='<div class="index_foot f14"><div class="index_foot_main clear over"><a href="javascript:void(0)" class="index_foot_phone block fl"></a></div></div>';
		$('body').append(foot_str);
	}
	if($.browser.msie&&$.browser.version=='6.0'){
		var scrolltop;
		var hei=$(window).height();
		$('.index_foot').css({position:'absolute',top:0,left:"0"});
		$(window).scroll(function(){
			scrolltop=$(document).scrollTop();
			$('.index_foot').css({position:'absolute',top:scrolltop+hei-31,left:"0"});
		})
	}
	
})


function gettime(){
	var time=new Date();
	//北京时间
	var hour=time.getUTCHours()+8;
	var minute=time.getUTCMinutes();
	var second=time.getUTCSeconds();
	
	//东京时间
	var dj_hour=hour+1;
	var dj_minute=minute;
	var dj_second=second;
	
	//美国时间
	var mg_hour=hour-13;
	var mg_minute=minute;
	var mg_second=second;
	
	//瑞士时间
	var rs_hour=hour-6;
	var rs_minute=minute;
	var rs_second=second;
	
	hour=hour>9?hour:"0"+hour;
	minute=minute>9?minute:"0"+minute;
	second=second>9?second:"0"+second;
	
	dj_hour=dj_hour>9?dj_hour:"0"+dj_hour;
	dj_minute=dj_minute>9?dj_minute:"0"+dj_minute;
	dj_second=dj_second>9?dj_second:"0"+dj_second;
	
	rs_hour=rs_hour>9?rs_hour:"0"+rs_hour;
	rs_minute=rs_minute>9?rs_minute:"0"+rs_minute;
	rs_second=rs_second>9?rs_second:"0"+rs_second;
	
	mg_hour=mg_hour<0?mg_hour+24:mg_hour;
	mg_hour=mg_hour>9?mg_hour:"0"+mg_hour;	
	mg_minute=mg_minute>9?mg_minute:"0"+mg_minute;
	mg_second=mg_second>9?mg_second:"0"+mg_second;
	
	var time_bj=document.getElementById("flag_hongkong");
	var time_dj=document.getElementById("flag_japan");
	var time_mg=document.getElementById("flag_america");
	var time_rs=document.getElementById("flag_reishi");
	if(!time_bj||!time_dj||!time_mg||!time_rs){
		return;
	}
	//time_bj.innerHTML(hour+':'+minute+':'+second);
	time_bj.innerHTML=hour+':'+minute+':'+second;
	time_dj.innerHTML=dj_hour+':'+dj_minute+':'+dj_second;
	time_mg.innerHTML=mg_hour+':'+mg_minute+':'+mg_second;
	time_rs.innerHTML=rs_hour+':'+rs_minute+':'+rs_second;
	setTimeout('gettime()',500);
}
function AddFavorite(sURL, sTitle)
{
    try
    {
        window.external.addFavorite(sURL,sTitle)
    }
    catch (e)
    {
        try
        {
            window.sidebar.addPanel(sTitle, sURL, "");
        }
        catch (e)
        {
            alert("加入收藏失败，请使用Ctrl+D进行添加");
        }
    }
}
function SetHome(obj,vrl){
        try{
                obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
				//alert("设置成功！");
        }
        catch(e){
                if(window.netscape) {
                        try {
                                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
								alert("设置成功！");
                        }
                        catch (e) {
                                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                        }
                 }
        }
}
function toDesktop(sUrl,sName){
	try  
	{
		var WshShell = new ActiveXObject("WScript.Shell");
		var oUrlLink = WshShell.CreateShortcut(WshShell.SpecialFolders("Desktop") + "\\" + sName + ".url");
		oUrlLink.TargetPath = sUrl;
		oUrlLink.Save();
	}  
	catch(e)  
	{  
		alert("当前浏览器安全级别不允许操作！");  
	}
} 
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
function nav_over(id){
	$('.nav_s').hide();
	$('#'+id+'_second').show();
}
function nav_out(){
	$('.nav_s').hide();
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