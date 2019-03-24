// JavaScript Document
(function(window) {
	var mobileUAKeywords = ["nokia", "sony", "ericsson", "mot", "samsung", "htc", "sgh", "lg", "sharp", "sie-",
				"philips", "panasonic", "alcatel", "lenovo", "iphone", "ipod", "blackberry", "meizu", 
				"android", "netfront", "symbian", "ucweb","UCBrowser", "windowsce", "palm", "operamini", 
				"operamobi", "opera mobi", "openwave", "nexusone", "cldc", "midp", "wap", "mobile"
			];
	var userAgent = navigator.userAgent;
	//alert(userAgent);
	var regExp = new RegExp(mobileUAKeywords.join("|"), "i");
	var browser = {
		mobile: !!userAgent.match(regExp),
		android: /android/i.test(userAgent) || /linux/i.test(userAgent),
		iPad: /iPad/i.test(userAgent),
		iPhone: /iPhone/i.test(userAgent),
		isWechatBrowser: /micromessenger/i.test(userAgent)
	};
	
	window.browser = browser;

   
	
})(window);


//$(function() {
$(document).ready(function(){
	var browser = window.browser;
	var wheight=$(window).height();
	
	
	
	if (!browser.mobile) {
		/*var $scrollDownArrow = $("#scrollDownArrow");
		var $container = $("#container");
		
		$scrollDownArrow.click(function() {
			$("html, body").animate({
				"scrollTop": $container.offset().top
			}, 350);
		});*/
	}
	else{
		window.location.href="http://m.zhengjin99.com";
	}
	//alert(browser.android)
	if (browser.android) {
	   /*$(".download").each(function(){
			$(this).attr("src","images/down.png");
		});
		
		 $(".download_a").each(function(){
			$(this).attr("href","http://soft.zhengjin99.com/hq/hq_2.0.0.apk");
		});*/
	}
	if(browser.iPad || browser.iPhone){
		/*$(".download").each(function(){
			$(this).attr("src","images/down_ios.png");
			//$(this).attr("src","images/down.png");
		});
		$(".share").hide();
		
		
		 $(".download_a").each(function(){
			//$(this).attr("href","itms-services://?action=download-manifest&url=https://dn-twofaces.qbox.me/TwoFaces_010001D.plist");
			$(this).attr("href","javascript:void(0)");
		});*/
		//$('#start').hide();
	}
})