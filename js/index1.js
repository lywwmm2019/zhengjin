// JavaScript Document
	
window.onload=function()
{
for(var ii=0; ii<document.links.length; ii++)
document.links[ii].onfocus=function(){this.blur()}
}
var beitouInterval;
$(document).ready(function(){
	//更新视频和直播室信息
	//beitouInterval = setInterval(function(){changeBeitou();}, 10);
	changeLoopInfo();
	getInfo();
	setInterval(function(){changeLoopInfo();} , 1000 * 60);
	// 背投开始
});
$(document).ready(function(){
		var scrolltop;
		var hei=$(window).height();
		var h=$(document).height();
		var half_h=hei/2;
		if($.browser.msie&&$.browser.version=='6.0'){
			$('#vip_service').css({'position':'absolute','top':half_h+scrolltop+110,'left':'2%'})
			$('#weixin_s').css({'position':'absolute','top':half_h+scrolltop+60,'right':'2%'})
			$('#foot_banner').css({position:'absolute',top:0,left:"0"});
			$(window).scroll(function(){
				scrolltop=$(document).scrollTop();
				$('#vip_service').css({'position':'absolute','top':half_h+scrolltop+110,'left':'2%'})
				$('#foot_banner').css({position:'absolute',top:scrolltop+hei-31,left:"0"});
				$('#weixin_s').css({'position':'absolute','top':half_h+scrolltop+60,'right':'2%'})
			})
		}
		$('#weixin_s').css({'position':'fixed','bottom':15,'right':'2%'})
	
	})
$(document).ready(function(){
		$('p.weixin_title').live('mouseover',function(){
			$('p.f14').addClass('weixin_title');
			$('p.f14').next().slideUp(300);
			$(this).removeClass('weixin_title');			
			$(this).next().slideDown(300);			
		})
		$('#weixin_close').bind('click',function(){
			$('#weixin').fadeOut(500);
		})
	});
$(document).ready(function(){
	var scrolltop;
	$(window).scroll(function(){
		if($(window).scrollTop()>165){
			scrolltop=$(document).scrollTop();
			$('#nav_main').css({'position':'fixed','top':'0','left':'0'});
			$('#about_main').css('margin-top','50px');
			if($.browser.msie&&$.browser.version=='6.0'){
				$('#nav_main').css({'position':'absolute','top':scrolltop,'left':'0'});
				$('#about_main').css('margin-top','50px');
			}
		}
		else{
			$('#nav_main').css({'position':'static'});
			$('#about_main').css('margin-top','0');
			if($.browser.msie&&$.browser.version=='6.0'){
				$('#nav_main').css({'position':'static'});
				$('#about_main').css('margin-top','50px');
			}
		}
	})
})
	
	
	
	var commonPhone = "请输入您的手机号";
	var commonCode = "请输入验证码";
	/**
	 * 换一张验证码
	 */
	function changeCertPic(ele) {
		var random = new Date().getTime();
		ele.src = "http://tg.zhengjin99.com/zhengjin/makeCertPicCms.jsp?" + random;
	}

	function removeCommonPhone(index) {
		var mobile = $("#phone" + index).val();
		if (mobile == commonPhone) {
			$("#phone" + index).val("");
		}
	}

	function addCommonPhone(index) {
		var mobile = $("#phone" + index).val();
		if (mobile == "") {
			$("#phone" + index).val(commonPhone);
		}
	}

	function sendCodeIndex() {
		var mobile = $("#phoneindex").val();
		var code = $("#codeindex").val();
		var activityID = "ktmn_gjs_20130719";
		if (mobile.replace(/ /gim, "").length == 0 || !mobileRES.test(mobile)) {
			alert("手机号码不能为空且为正确的手机格式");
			return false;
		}
		$.ajax({
		  type : "get",
		  async:false,
		  url : "http://tg.zhengjin99.com/zhengjin/cmscall/cms_index_ajax.jsp?mobNo=" + mobile + "&activityID=" + activityID + "&code=" + code,
		  dataType : "jsonp",
		  timeout: 2000,
		  jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数
		  jsonpCallback:"success_jsonpCallback",//callback的function名称
		  success : function(json){
		   var json1 = json;//{state:1,msg:"sdfa"}
		   if(json1.state == "ok"){
			alert("您的信息已提交！稍后客服代表联系您，认准专线010-58309199纳斯达克上市金融界旗下www.zhengjin99.com【证金贵金属】");
			window.location.href='http://tg.zhengjin99.com/zhengjin/regUser.jsp?phone='+mobile;
		   }else{
			alert(json1.msg);
		   }
		  },
		  error:function(){
		  alert('发送失败!');
		  }
		 }); 
	}
	
	
	
	/**
 * 数值转换成星级符
 * @param grade
 * @returns {String}
 */
function chang2Grade(grade){
	if(grade == null || grade == "")
		return "暂无星级";
	
	var gradeV = parseFloat(grade);
	
	var result = "";
	var v = gradeV/1;
	for(var i = 1; i<= v; i++){
		result += "★";
	}
	if((gradeV/0.5)%2 != 0){
		result += "☆";
	}
		
	return result;
	
}

function GetRequest(){
	var url = location.search; //获取url中"?"符后的字串
	var theRequest = new Object();
	if(url.indexOf("?") != -1)
	{
	  var str = url.substr(1);
		strs = str.split("&");
	  for(var i = 0; i < strs.length; i ++)
		{
		 theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
		}
	}
	return theRequest;
}
var commonPhoneInfo = "请输入您的手机号";
var mobileRES = /^(((1[0-9]{1}[0-9]{1}))+\d{8})$/;
var activityID = GetRequest()["activityID"];
if(!activityID || activityID == "undefined"){
	activityID = "";
}
function focusPhone(){
	if($("#phone").val() == commonPhoneInfo){
		$("#phone").val("");
	}
}

function blurPhone(){
	if($("#phone").val() == ""){
		$("#phone").val(commonPhoneInfo);
	}
}

function submitTel(){
	var mobile = $("#phone").val();
	if(mobile.replace(/ /gim, "").length == 0 || mobile == commonPhoneInfo || !mobileRES.test(mobile)){
		alert("手机号码不能为空且为正确的手机格式");
		return false;
	}

	$.ajax({
		type : "get",
		async:false,
		url : "http://tg.zhengjin99.com/zhengjin/cmscall/reserve_phone.jsp?phone=" + mobile + "&activityID=" + activityID,
		dataType : "jsonp",
		jsonp: "callbackparam",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"success_jsonpCallback",//callback的function名称
		success : function(json){
			var json1 = json[0];
			if(json1.state == 0){
				alert("预约成功！");
			}else{
				alert("预约失败，可能已进行预约，如未进行预约，请核实手机号后重新预约！");
			}
		},
		error:function(){
			alert('预约失败!');
		}
	});
}


function setTab(name,cursel,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  menu.className=i==cursel?"hover":"";
  con.style.display=i==cursel?"block":"none";
 }
}

function changeLoopInfo(){
	$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/gender_zhibolist_html_script_cache_new.jsp", function() {
		$("#zhibo_lists").html(zhiboLoopList);
		$('#zhibo_lists ul').bxCarousel({
			display_num: 4, // ?帵揑撪梕悢検
			move: 1, // 堦師堏?檣槩撪梕
			prev_image: '/images/icon_arrow_left.gif',
			next_image: '/images/icon_arrow_right.gif',
			margin: 10, // ?槩li尦慺擵?嫍?
			auto: true,
			auto_interval: 5000,
			auto_hover:true
		});
	});
}
function getInfo(){
	$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/recent_video_script.jsp", function() {
		if(videoLoopList!=''&videoLoopList.indexOf('src="http://tg.zhengjin99.com"==-1')){
		$("#spjj_lists").html(videoLoopList);}
	});
	$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/gender_yjbg_index_html_new2.jsp", function() {
		$("#yjbg_lists").html(yjbgList);
	});
}

function setCookie (name,value,expires,path,domain,secure) {
	var cookieVal = name + "=" + escape (value) +
	 ((expires) ? "; expires=" + expires.toGMTString() : "") +
	 ((path) ? "; path=" + path : "") +
	 ((domain) ? "; domain=" + domain : "") +
	 ((secure) ? "; secure" : "");
	 document.cookie = cookieVal;
}
function addCookie(objName,objValue,objHours){      //添加cookie
   setCookie(objName,objValue,null,"/",".zhengjin99.com","");
}
function getCookie(name)//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

changeLoopInfo();



function hideDoyooBorder(){
	$("#doyoo_panel").css("width","0px");	
	$("#doyoo_monitor").css("width","0px");	
}
setInterval(function(){hideDoyooBorder()} , 1 * 1000);
	
/*var leftAdv = document.getElementById('left_adv1');
var leftAdvHeight = 280;
function heartBeat_leftAdv(){
		var scrollTop = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
		var baseTop = 0;	
		var ele1 = document.getElementById("left_adv1");

		var windowWidth, windowHeight,windowScrollTop; 
		if (self.innerHeight) { // all except Explorer 
		windowWidth = self.innerWidth; 
		windowHeight = self.innerHeight; 
		windowScrollTop = self.scrollTop; 
		} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode 
		windowWidth = document.documentElement.clientWidth; 
		windowHeight = document.documentElement.clientHeight; 
		windowScrollTop = document.documentElement.scrollTop; 
		} else if (document.body) { // other Explorers 
		windowWidth = document.body.clientWidth; 
		windowHeight = document.body.clientHeight; 
		windowScrollTop = document.body.scrollTop; 
		}

		var totalHeight = windowHeight;
		var menuHeight = leftAdvHeight;
		if(menuHeight > totalHeight){
			baseTop = 0;
		}else{
			baseTop = totalHeight - menuHeight;
		}
		if(ele1 && ele1.style.display != "none"){
			ele1.style.top = (scrollTop + baseTop) + "px";
		}
	}

	window.setInterval("heartBeat_leftAdv()",300);
	
	var startTop = leftAdvHeight;
	var endTop = 0;
	var step = 40;
	var lastTop = leftAdvHeight;
	var stepSecLeft = 20;
	function showLeftAdv(){
		lastTop -= step;
		if(lastTop < endTop){
			lastTop = endTop;
		}
		$("#left_adv1_inner").css("top" , lastTop + "px");
		if(lastTop > endTop){
			setTimeout(function(){showLeftAdv()} , stepSecLeft);
		}
	}
	setTimeout(function(){showLeftAdv()} , stepSecLeft);


var width = 155;
	var curWidth = 155;
	var changeInterval;
	var perWidth = 15;
	var perSec = 50;
	var isToBig = true;
	
	function changeClick(){
		clearInterval(changeInterval);
		var btnEle = $("#obbtn");
		if(isToBig){
			isToBig = false;
			//btnEle.style.backgroundPostion = "0 0px";
			btnEle.css("background-position","0 -88px");
			toSmall();
		}else{
			isToBig = true;
			//btnEle.style.backgroundPostion = "0 -89px";
			btnEle.css("background-position","0 0px");
			toBig();
		}
	}

	function toSmall(){
		changeInterval = setInterval(function(){changePos(curWidth , 0 , false)} , perSec);
	}

	function toBig(){
		changeInterval = setInterval(function(){changePos(curWidth , width , true)} , perSec); 
	}
		
			
	function changePos(start,end,isAdd){
		if(isAdd){
			curWidth += perWidth;
		}else{
			curWidth -= perWidth;
		}
		if(curWidth < 0){
			curWidth = 0;
		}
		if(curWidth > width){
			curWidth = width;
		}
		document.getElementById("xixitable").style.width = curWidth + "px";
		if((start <= 0 && start >= end) || (curWidth >= end && start <= end) || (start == end)){
		//if((start == 0 && end == 0) || (start == width && end == width)){
			clearInterval(changeInterval);
		}
	}

	function heartBeat(){
		var scrollTop = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
		var baseTop = 150;	
		var baseTop2 = 100;	
		var ele1 = document.getElementById("xixi");
		var ele2 = document.getElementById("popLoginWin");
		var ele3 = document.getElementById("change_win");

		var windowWidth, windowHeight,windowScrollTop; 
		if (self.innerHeight) { // all except Explorer 
		windowWidth = self.innerWidth; 
		windowHeight = self.innerHeight; 
		windowScrollTop = self.scrollTop; 
		} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode 
		windowWidth = document.documentElement.clientWidth; 
		windowHeight = document.documentElement.clientHeight; 
		windowScrollTop = document.documentElement.scrollTop; 
		} else if (document.body) { // other Explorers 
		windowWidth = document.body.clientWidth; 
		windowHeight = document.body.clientHeight; 
		windowScrollTop = document.body.scrollTop; 
		}

		var totalHeight = windowHeight;
		var menuHeight = 450;
		if(menuHeight > totalHeight){
			baseTop = 0;
		}else{
			baseTop = (totalHeight - menuHeight) / 2;
		}
		if(ele1 && ele1.style.display != "none"){
			ele1.style.top = (scrollTop + baseTop + 80) + "px";
		}
		if(ele2 && ele2.style.display != "none"){
			ele2.style.top = (scrollTop + baseTop2) + "px";
		}
		if(ele3 && ele3.style.display != "none"){
			ele2.style.top = (scrollTop + 428) + "px";
		}
	}

	window.setInterval("heartBeat()",300);*/
	
function confirm(str,okHref,okFunc,cancelFunc) {
	$(".confirm").show();
	$("#confirm_info").html(str);
	$("#confrim_btn_ok").attr("href",okHref);
	//$(".confirm").modal();
	if(!okFunc){
		$("#confrim_btn_ok").click(function(){			
			$(".confirm").hide();
			$.modal.close();
		});
	}else{
		$("#confrim_btn_ok").click(function(){
			$(".confirm").hide();
			$.modal.close();
			okFunc();
		});
	}
	if(!cancelFunc){
		$("#confrim_btn_cancel").click(function(){			
			$(".confirm").hide();
			$.modal.close();
		});
	}else{
		$("#confrim_btn_ok").click(function(){			
			$(".confirm").hide();
			$.modal.close();
			cancelFunc();
		});
	}
	return false;
}


