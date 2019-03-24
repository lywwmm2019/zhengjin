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
		//window.location.href="http://zb.zhengjin99.com";
		$("#iframe1").css("display","block");
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
	
	var $popup = $("#popup");
	$popup.find("a.popup-btn").click(function() {
		$popup.hide();
	});
	
	$("a.iphone").click(function(e) {
		e.stopPropagation();
		e.preventDefault();
		
		$popup.show();
	});
	
	if (browser.isWechatBrowser&&!browser.iPhone&&!browser.iPad) {
		$(".download").click(function(e) {
			if (browser.android) {
				e.preventDefault();
			}
			var $browserTips = $("<div></div>")
					.attr("id", "browserTips")
					.addClass("browser-tips")
					/*.html("<div class='browser-tips-content'>"
									+   "<label>微信内无法下载，请点击<span class='font-attention'>右上角</span>按钮</label>"
									+   "<label class='line-with-bg'>选择<span class='font-attention'>「在浏览器中打开」</span>即可正常下载</label>"
									+   "<div class='tips-arrow'></div>"
									+ "</div>"
									+ "<div class='browser-tips-mask'></div>");*/
					.html("<div class='alert_dialog hide'>"
    						+   "<img src='images/alert_01.png' width='80%' class='mauto block' />"
       						+  " <a href='javascript:void(0)' onClick='$(this).parent().hide();'><img src='images/alert_close.png' width='40%' class='mauto block' style='margin-top:10%;' /></a>"
    				 	 +"</div>");
			
			//$("body").append($browserTips);
			$('.alert_dialog').css('height',wheight);
			$('.alert_dialog').show();
			
			$browserTips.find(".browser-tips-mask").click(function() {
				$browserTips.remove();
			});
		});
	
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
			WeixinJSBridge.call('showOptionMenu');
		});
	}
});
//});

/*var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?ef4d09c5121bf0c984565615af9123f7";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();*/
