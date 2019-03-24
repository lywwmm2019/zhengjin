$(document).ready(function() {
	//phoneCookie=getParam('pho');
	$('.speHov').each(function(index){
		$(this).hover(function(){
			$(this).css({'background':'url(../images2014/icon'+(index+1)+'a.png) no-repeat 30px 3px','color':'#e89916'});
			$('.winConSty').eq(index).stop().show();
		},function(){
			$(this).css({'background':'url(../images2014/icon'+(index+1)+'.png) no-repeat 30px 3px','color':'#333'});
			$('.winConSty').eq(index).stop().hide();
		})
	})
	$('.winConSty').each(function(index){
		$(this).hover(function(){
			$('.speHov').eq(index).css({'background':'url(../images2014/icon'+(index+1)+'a.png) no-repeat 30px 3px','color':'#e89916'});
			$(this).stop().show();
		},function(){
			$('.speHov').eq(index).css({'background':'url(../images2014/icon'+(index+1)+'.png) no-repeat 30px 3px','color':'#333'});
			$(this).stop().hide();
		})
	})
	$('.hovCont').each(function(index){
		$(this).hover(function(){
			$(this).css({'color':'#e89916'});
			$('.winConSty2').eq(index).stop().show();
		},function(){
			$(this).css({'color':'#333'});
			$('.winConSty2').eq(index).stop().hide();
		})
	})
	$('.winConSty2').each(function(index){
		$(this).hover(function(){
			$('.hovCont').eq(index).css({'color':'#e89916'});
			$(this).stop().show();
		},function(){
			$('.hovCont').eq(index).css({'color':'#333'});
			$(this).stop().hide();
		})
	})
	$('.close').click(function(){
		$('#mask').hide();
		$(this).parent().hide();
		getInformation();
	})
	/*通过手机号码获取用户信息*/
	//getInformation();
	/*网站用户等级升级提醒请求接口*/
	
})



function getParam(item) {
	var svalue = location.search.match(new RegExp('[\?\&]' + item + '=([^\&]*)(\&?)','i'));
	return svalue?decodeURIComponent(svalue[1]):'';
}