// JavaScript Document

(function(window) {
	if (typeof window.zjgjs === "undefined") {
		window.zjgjs = {};
	}
	if (typeof window.zjgjs.sso === "undefined") {
		window.zjgjs.sso = {};
	}
})(window);
(function(){
	var hexcase=0;
	var b64pad="";
	var chrsz=8;
	function hex_md5(s){return binl2hex(core_md5(str2binl(s),s.length*chrsz));}
	function b64_md5(s){return binl2b64(core_md5(str2binl(s),s.length*chrsz));}
	function str_md5(s){return binl2str(core_md5(str2binl(s),s.length*chrsz));}
	function hex_hmac_md5(key,data){return binl2hex(core_hmac_md5(key,data));}
	function b64_hmac_md5(key,data){return binl2b64(core_hmac_md5(key,data));}
	function str_hmac_md5(key,data){return binl2str(core_hmac_md5(key,data));}
	function md5_vm_test(){return hex_md5("abc")=="900150983cd24fb0d6963f7d28e17f72";}
	function core_md5(x,len){x[len>>5]|=0x80<<((len)%32);x[(((len+64)>>>9)<<4)+14]=len;var a=1732584193;var b=-271733879;var c=-1732584194;var d=271733878;for(var i=0;i<x.length;i+=16)
	{var olda=a;var oldb=b;var oldc=c;var oldd=d;a=md5_ff(a,b,c,d,x[i+0],7,-680876936);d=md5_ff(d,a,b,c,x[i+1],12,-389564586);c=md5_ff(c,d,a,b,x[i+2],17,606105819);b=md5_ff(b,c,d,a,x[i+3],22,-1044525330);a=md5_ff(a,b,c,d,x[i+4],7,-176418897);d=md5_ff(d,a,b,c,x[i+5],12,1200080426);c=md5_ff(c,d,a,b,x[i+6],17,-1473231341);b=md5_ff(b,c,d,a,x[i+7],22,-45705983);a=md5_ff(a,b,c,d,x[i+8],7,1770035416);d=md5_ff(d,a,b,c,x[i+9],12,-1958414417);c=md5_ff(c,d,a,b,x[i+10],17,-42063);b=md5_ff(b,c,d,a,x[i+11],22,-1990404162);a=md5_ff(a,b,c,d,x[i+12],7,1804603682);d=md5_ff(d,a,b,c,x[i+13],12,-40341101);c=md5_ff(c,d,a,b,x[i+14],17,-1502002290);b=md5_ff(b,c,d,a,x[i+15],22,1236535329);a=md5_gg(a,b,c,d,x[i+1],5,-165796510);d=md5_gg(d,a,b,c,x[i+6],9,-1069501632);c=md5_gg(c,d,a,b,x[i+11],14,643717713);b=md5_gg(b,c,d,a,x[i+0],20,-373897302);a=md5_gg(a,b,c,d,x[i+5],5,-701558691);d=md5_gg(d,a,b,c,x[i+10],9,38016083);c=md5_gg(c,d,a,b,x[i+15],14,-660478335);b=md5_gg(b,c,d,a,x[i+4],20,-405537848);a=md5_gg(a,b,c,d,x[i+9],5,568446438);d=md5_gg(d,a,b,c,x[i+14],9,-1019803690);c=md5_gg(c,d,a,b,x[i+3],14,-187363961);b=md5_gg(b,c,d,a,x[i+8],20,1163531501);a=md5_gg(a,b,c,d,x[i+13],5,-1444681467);d=md5_gg(d,a,b,c,x[i+2],9,-51403784);c=md5_gg(c,d,a,b,x[i+7],14,1735328473);b=md5_gg(b,c,d,a,x[i+12],20,-1926607734);a=md5_hh(a,b,c,d,x[i+5],4,-378558);d=md5_hh(d,a,b,c,x[i+8],11,-2022574463);c=md5_hh(c,d,a,b,x[i+11],16,1839030562);b=md5_hh(b,c,d,a,x[i+14],23,-35309556);a=md5_hh(a,b,c,d,x[i+1],4,-1530992060);d=md5_hh(d,a,b,c,x[i+4],11,1272893353);c=md5_hh(c,d,a,b,x[i+7],16,-155497632);b=md5_hh(b,c,d,a,x[i+10],23,-1094730640);a=md5_hh(a,b,c,d,x[i+13],4,681279174);d=md5_hh(d,a,b,c,x[i+0],11,-358537222);c=md5_hh(c,d,a,b,x[i+3],16,-722521979);b=md5_hh(b,c,d,a,x[i+6],23,76029189);a=md5_hh(a,b,c,d,x[i+9],4,-640364487);d=md5_hh(d,a,b,c,x[i+12],11,-421815835);c=md5_hh(c,d,a,b,x[i+15],16,530742520);b=md5_hh(b,c,d,a,x[i+2],23,-995338651);a=md5_ii(a,b,c,d,x[i+0],6,-198630844);d=md5_ii(d,a,b,c,x[i+7],10,1126891415);c=md5_ii(c,d,a,b,x[i+14],15,-1416354905);b=md5_ii(b,c,d,a,x[i+5],21,-57434055);a=md5_ii(a,b,c,d,x[i+12],6,1700485571);d=md5_ii(d,a,b,c,x[i+3],10,-1894986606);c=md5_ii(c,d,a,b,x[i+10],15,-1051523);b=md5_ii(b,c,d,a,x[i+1],21,-2054922799);a=md5_ii(a,b,c,d,x[i+8],6,1873313359);d=md5_ii(d,a,b,c,x[i+15],10,-30611744);c=md5_ii(c,d,a,b,x[i+6],15,-1560198380);b=md5_ii(b,c,d,a,x[i+13],21,1309151649);a=md5_ii(a,b,c,d,x[i+4],6,-145523070);d=md5_ii(d,a,b,c,x[i+11],10,-1120210379);c=md5_ii(c,d,a,b,x[i+2],15,718787259);b=md5_ii(b,c,d,a,x[i+9],21,-343485551);a=safe_add(a,olda);b=safe_add(b,oldb);c=safe_add(c,oldc);d=safe_add(d,oldd);}
	return Array(a,b,c,d);}
	function md5_cmn(q,a,b,x,s,t)
	{return safe_add(bit_rol(safe_add(safe_add(a,q),safe_add(x,t)),s),b);}
	function md5_ff(a,b,c,d,x,s,t)
	{return md5_cmn((b&c)|((~b)&d),a,b,x,s,t);}
	function md5_gg(a,b,c,d,x,s,t)
	{return md5_cmn((b&d)|(c&(~d)),a,b,x,s,t);}
	function md5_hh(a,b,c,d,x,s,t)
	{return md5_cmn(b^c^d,a,b,x,s,t);}
	function md5_ii(a,b,c,d,x,s,t)
	{return md5_cmn(c^(b|(~d)),a,b,x,s,t);}
	function core_hmac_md5(key,data)
	{var bkey=str2binl(key);if(bkey.length>16)bkey=core_md5(bkey,key.length*chrsz);var ipad=Array(16),opad=Array(16);for(var i=0;i<16;i++)
	{ipad[i]=bkey[i]^0x36363636;opad[i]=bkey[i]^0x5C5C5C5C;}
	var hash=core_md5(ipad.concat(str2binl(data)),512+data.length*chrsz);return core_md5(opad.concat(hash),512+128);}
	function safe_add(x,y)
	{var lsw=(x&0xFFFF)+(y&0xFFFF);var msw=(x>>16)+(y>>16)+(lsw>>16);return(msw<<16)|(lsw&0xFFFF);}
	function bit_rol(num,cnt)
	{return(num<<cnt)|(num>>>(32-cnt));}
	function str2binl(str)
	{var bin=Array();var mask=(1<<chrsz)-1;for(var i=0;i<str.length*chrsz;i+=chrsz)
	bin[i>>5]|=(str.charCodeAt(i/chrsz)&mask)<<(i%32);return bin;}
	function binl2str(bin)
	{var str="";var mask=(1<<chrsz)-1;for(var i=0;i<bin.length*32;i+=chrsz)
	str+=String.fromCharCode((bin[i>>5]>>>(i%32))&mask);return str;}
	function binl2hex(binarray)
	{var hex_tab=hexcase?"0123456789ABCDEF":"0123456789abcdef";var str="";for(var i=0;i<binarray.length*4;i++)
	{str+=hex_tab.charAt((binarray[i>>2]>>((i%4)*8+4))&0xF)+
	hex_tab.charAt((binarray[i>>2]>>((i%4)*8))&0xF);}
	return str;}
	function binl2b64(binarray)
	{var tab="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var str="";for(var i=0;i<binarray.length*4;i+=3)
	{var triplet=(((binarray[i>>2]>>8*(i%4))&0xFF)<<16)|(((binarray[i+1>>2]>>8*((i+1)%4))&0xFF)<<8)|((binarray[i+2>>2]>>8*((i+2)%4))&0xFF);for(var j=0;j<4;j++)
	{if(i*8+j*6>binarray.length*32)str+=b64pad;else str+=tab.charAt((triplet>>6*(3-j))&0x3F);}}
	return str;}
	window.zjgjs.md5 = hex_md5;
	})();
//获得coolie 的值
function cookie(name) {
	var cookieArray = document.cookie.split("; "); // 得到分割的cookie名值对,名值对实例：name=liyan
	var cookie = new Object();
	for ( var i = 0; i < cookieArray.length; i++) {
		var arr = cookieArray[i].split("="); // 将名和值分开
		if (arr[0] == name)
			return unescape(arr[1]); // 如果是指定的cookie，则返回它的值
	}
	return "";
}
function delCookie(name)// 删除cookie
{
	document.cookie = name + "=;expires=" + (new Date(0)).toGMTString();
}

function getCookie(objName) {// 获取指定名称的cookie的值
	var arrStr = document.cookie.split("; ");
	for ( var i = 0; i < arrStr.length; i++) {
		var temp = arrStr[i].split("=");
		if (temp[0] == objName)
			return unescape(temp[1]);
	}
}

function addCookie(objName, objValue, objHours) { // 添加cookie
	/**
	 * var str = objName + "=" + escape(objValue); if(objHours > 0){
	 * //为时不设定过期时间，浏览器关闭时cookie自动消失 var date = new Date(); var ms =
	 * objHours*3600*1000; date.setTime(date.getTime() + ms); str += ";
	 * expires=" + date.toGMTString()+"; domain=.zhengjin99.com"; }
	 * document.cookie = str;
	 */
	objHours = 24;
	var date = new Date();
	var ms = objHours*3600*1000;
	date.setTime(date.getTime() + ms);
	setCookie(objName, objValue, date, "/", ".zhengjin99.com", "");
}
function setCookie(name, value, expires, path, domain, secure) {
	var cookieVal = name + "=" + escape(value)
			+ ((expires) ? "; expires=" + expires.toGMTString() : "")
			+ ((path) ? "; path=" + path : "")
			+ ((domain) ? "; domain=" + domain : "")
			+ ((secure) ? "; secure" : "");
			
			
			//alert(cookieVal)
		
	document.cookie = cookieVal;
}
	//alert(document.cookie);

function SetCookies(name, value)// 两个参数，一个是cookie的名子，一个是值
{
	var Days = 30; // 此 cookie 将被保存 30 天
	var exp = new Date(); // new Date("December 31, 9998");
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires="
			+ exp.toGMTString();
}


function delCookie(name)// 删除cookie
{
	/**
	 * var exp = new Date(); exp.setTime(exp.getTime() - 1); var
	 * cval=getCookie(name); if(cval!=null) document.cookie= name +
	 * "="+cval+";expires="+exp.toGMTString();
	 */
	setCookie(name, "", null, "/", ".zhengjin99.com", "");
}




//登录
zjgjs.sso.login = function(index) {
	var passport = $("#phone" + index).val();
	var password = $("#code" + index).val();
	if(password == ''){
		password = $("#pwd_text2").val();
		}
	if(password != null && password != "")
		password=password.toLowerCase();
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID="
			+ passport + "&Passwd=" + zjgjs.md5(password)+ "&yhdj=1"+"&plateform=pc_99";
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		userType = userJson.userType-0;
		oilType = userJson.oilType-0;
		regTime = userJson.regTime;
		rank = userJson.rank;
		token = userJson.token;
		addCookie("WEBSSO_TOKEN",token,0);
		addCookie("WEBSSO_ZJUSERNAME", userName, 0);
		addCookie("WEBSSO_UID", sso_userID, 0);
		addCookie("WEBSSO_USERTYPE", userType, 0);
		addCookie("WEBSSO_OILTYPE", oilType, 0);
		addCookie("WEBSSO_REGTIME", regTime, 0);
		addCookie("WEBSSO_RANK", rank, 0);
		//var maidianVal={"ssoid":sso_userID,"mobile":passport};//埋点
		//$.cookie('count-data',JSON.stringify(maidianVal),{expires:1000,path:'/'});
		
		
		if (sso_userID == 0 || sso_userID == "" || userName == null) {
			alert("用户名或密码错误");
			return false;
		} else {
			addCookie("WEBSSO_LID", passport, 0);
			if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(password)){
				openInitpwd();
			}
			//zjgjs.sso.indexLogin();
			var url = "http://newzb.jrj.com/hxzb/otherlogin.do?mobile="+ passport +"&password=" + zjgjs.md5(password) + "&userName=" + userName + "&fromUrl=99" + "&jsoncallback=?";
			jQuery.getJSON(encodeURI(url), function(json){
				//alert(json["result"]);
				
			});
			$.ajax({
				type : "get",
				async:false,
				url : "http://tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp", //20160707修改，20160712要改回正式地址
				dataType : "jsonp",
				jsonp: "callback",//服务端用于接收callback调用的function名的参数
				jsonpCallback:"success_callback2",//callback的function名称
				success : function(json){
					var maidianVal={"ssoid":sso_userID,"mobile":passport};//埋点
		            $.cookie('count-data',JSON.stringify(maidianVal),{expires:1000,path:'/'});//设置cookie
					statisticsDataOut.extend.login();
					zjgjs.sso.loginOk();
					if($('#zhibo_lists').hasClass('bx_container')){
						zjgjs.sso.indexLogin(json)
					}else{
						zjgjs.sso.loginNormal(json);
					}
				}
			});
		}
	});
};

    function success_callback3(json){
		    $('#numPerson').html(json.total);
	};

//首页登录前窗口
zjgjs.sso.indexBeforeLogin=function(){
	var url = window.location.href
	$.ajax({
		type : "get",
		async:false,
		url : "http://tg.zhengjin99.com/zhengjin/cmscall/user_total_ajax.jsp",
		dataType : "jsonp",
		jsonp: "callback",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"success_callback3",//callback的function名称
		success : function(json){
			var beforeLogin='<div class="login_main0609 pa">'+                   
                    '<div class="login_input_name"><input name="" type="text" id="phone1" class="inputphone"  maxlength="11" /></div>'+                 
                    '<input name="" type="button" class="login_btn block"  value="" />'+
                    '<p>已有账户</p>'+
				    '<div class="open"><input name="" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/login.jsp?redirect='+url+' \'" type="button" class="mn" value=""/></div>'+   //20160707修改，20160712要改回正式地址           
			         '<ul class="txt">'+
                       '<li><span id="numPerson"></span>人正在享受证金服务</li>'+  
                      '</ul>'+
                '</div>'  	
			//$('#login_main1').html(beforeLogin);
			//$('#login_main2').html(beforeLogin);
			
			$('#login_main1').html('');
			$('#login_main2').html('');
			$('#numPerson').html(json.total);
			test();	
		}
	});	
	

	
	test=function(){
	var mobile = '';
	function isMobile(val) {
		var reg = /^1[34578]\d{9}$/;
		return reg.test(val);
	}
	$(function () {
		$(".inputphone").watermark("输入手机号码  领取百万模拟金");
	
		$(".login_btn").click(function(){
		   	 mobile = $.trim($(".inputphone").val());
			if (!isMobile(mobile)) {
				showDialog('提示', '请输入正确的手机号码！');
				return false;
			}
	        var url = "http://tg.zhengjin99.com/zhengjin/ws/put_resource_desc.jsp?callbackparam=?";
	        $.getJSON(url, {mobile: mobile, activityId: 'zj99_dlzc_20150609', desc: '', isSms: 0}, function(data) {
	        	console.log(data);
	        });
	        showDialog('提示', "预约成功！<br>稍后会有工作人员与您联系，请保持手机畅通。");
	        $(".inputphone").val('');
		});
	  });
	}
}


	function gotoUrl(id, type,name) {
		location.href='http://tg.zhengjin99.com/zhengjin/user/login_check_open.jsp?openId=' + id + '&openType=' + type + '&name=&linkUrl=http://tg.zhengjin99.com/zhengjin/user/';
	}
	
//非首页登录前窗口
zjgjs.sso.beforeLoginNormal=function(){
	var beforeLoginNormal='<div class="fr hxzb_top_right">'+
            	'<img src="../images2014/hxzb_login_title.jpg" width="310" height="62" class="block" />'+
                '<ul class="hxzb_login">'+
                	'<li class="hxzb_person mb20"><input name="" maxlength="11" type="text" class="txt" value="请输入您的手机号码" id="phone2" onblur="addCommonPhone(\'2\');" onfocus="removeCommonPhone(\'2\');" /></li>'+
                    '<li class="hxzb_pwd"><input type="text" class="txt pwd " id="pwd_text2" value="请输入您的密码" onfocus="removePwd(\'2\');" /><input type="password" class="txt hide login_pwd" id="code2" onblur="addPwd(\'2\');" /></li>'+
                    '<li class="mt10 tr"><span class=""><a href="http://tg.zhengjin99.com/zhengjin/user/findpwd.jsp">忘记密码</a></span></li>'+
                    '<li class="mt10"><input name="" type="button" class="login_btn2" onclick="zjgjs.sso.login(\'2\')" /></li>'+//zjgjs.sso.login(2),表示函数zjgjs.sso.login，参数取的是2.登录要转向测试个人中心的页面，所以要在函数zjgjs.sso.login中寻找http://test.tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp这个测试地址，在这个地址中要完成的任务是：在测试环境中完成sso的测试工作。
                '</ul></div>'+
            '<input name="" type="button" value="快速注册" class="hxzb_register block pa" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/register.jsp\'" />';
	//$('#login_main').html(beforeLoginNormal);
}

//首页登录
/*function move(){
		$('.orange').addClass('white').removeClass('orange');
		$('.white').addClass('orange')
    };
*/

function success_callback2(){}

$(document).ready(function() {

	$('#login_main2').on('mouseover','.white',function(){
		$('.fwzx_index_bottom .orange').removeClass('orange').addClass('white');
		$(this).addClass('orange');
	});
	$('#login_main1').on('mouseover','.white',function(){
		$('.fwzx_index_bottom .orange').removeClass('orange').addClass('white');
		$(this).addClass('orange');
	});
	$('#login_main').on('mouseover','.white2',function(){
		$('.fwzx_index_bottom .orange').removeClass('orange').addClass('white2');
		$(this).addClass('orange');
	});
		
});
zjgjs.sso.indexLogin=function(json){
	var rank=cookie('WEBSSO_RANK')
	//var VIPTypeID=cookie('VIPTypeID');
	var VIPTypeIDStr='';
	var star='';
	var VIPTypeIDNum=0;
	var VIPTypeIDNumStart=0;
	var uRoom=cookie('WEBHXZB_UROOMS');
	var uRoomStr='';
	var uRoomNum;
	var indexUserPhone = cookie("WEBSSO_LID");
	var newstr='';
	var serwivestr='';
	var Score=json?json.Score:cookie('Score');
	var headImg=cookie('WEBSSO_UID');
	var fastServive=json?json.fw:cookie('fw');
	var fastServiveStr='';
	var tempServive;
	var smallServive='';
	var ssoType=cookie('WEBSSO_USERTYPE');
	
	if(cookie('fw')==''){
		addCookie("fw", fastServive, 0);
	}
	rank=rank-0;
	//headImg='img_17876860';
	
	
	if (indexUserPhone != "" && indexUserPhone != null) {
		indexUserPhone = indexUserPhone.substring(0, 3) + "****" + indexUserPhone.substring(7);
	}
	if(rank==""){
		VIPTypeIDStr='体验客户';
		VIPTypeIDNum=8;
		VIPTypeIDNumStart=15;
		star=star+'<img src="/images2014/tiyan_user.png" width="14" height=""/>';
	}
	 if(rank==3){
		VIPTypeIDStr='三星客户';
		VIPTypeIDNum=12;
		VIPTypeIDNumStart=11;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==4){
		VIPTypeIDStr='四星客户';
		VIPTypeIDNum=14;
		VIPTypeIDNumStart=9;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==5){
		VIPTypeIDStr='五星客户';
		VIPTypeIDNum=20;
		VIPTypeIDNumStart=3;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==6){
		VIPTypeIDStr='钻石客户';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v1_user.png" width="15" height="13"/>';
	}
	else if(rank==7){
		VIPTypeIDStr='至尊客户';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v2_user.png" width="16" height="16"/>';
	}
	/*for(var k=1;k<VIPTypeID-2;k++){
		;
	}*/
	
	if(fastServive!="" && fastServive != 'undefined' && typeof(fastServive) != "undefined"){
		tempServive=fastServive.replace('\"','');
		tempServive=tempServive.replace('\"','');
		tempServive=tempServive.split(',');
		if(tempServive.length>=1){
			for(var a=0;a<tempServive.length;a++){
				if(tempServive[a]!=0){
					/*if(tempServive[a]<10){
						
						smallServive=smallServive+'<li><img src="../images2014/fwzx_small_0'+tempServive[a]+'.jpg"></li>';
					}
					else{
						smallServive=smallServive+'<li><img src="../images2014/fwzx_small_'+tempServive[a]+'.jpg"></li>';
					}*/
					smallServive=setFastUrl(tempServive[a])+smallServive;
				}
			}
			
		}
		
	}
	
  	var loginOkStr2='<div class="fwzx_index_top_khzl pa index_loginok">'+
						'<div class="fwzx_index_top_khzl-top">'+
							'<a href="http://tg.zhengjin99.com/zhengjin/user/"><img src="http://pic.zhengjin99.com/head/'+headImg+'.jpg" width="82" height="82" class="mauto block"></a>'+
							'<p class="p2" style="width:110px;height:25px;float:left;margin:20px 0 3px 10px;"><span><a href="http://tg.zhengjin99.com/zhengjin/user/"><span>'+indexUserPhone+'</span><img style="" class="ml5" src="/images2014/bonus_15.png" /></a></span></p>'+
							'<p class="p2" style="width:150px;height:25px;float:left;margin:20px 0 3px 10px;"><span>'+VIPTypeIDStr+'</span><a>'+star+'</a></p>'+
							'<p class="p2 m15" style="width:275px;"><span class="mr10"><span>积分：</span><span>'+Score+'</span></span><span><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span style="margin:0 0 0 52px">消息</span><span class="red" id="newMessage1"></span></a></span><img src="../images2014/mn.png" width="17" height="18" class="mr5" alt=""/><img src="../images2014/sp.png" width="17" height="18"  alt=""/></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p><a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;">证金直播</a></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p class="zbs"><a href="'+uRoomStr+'" style="margin:0;" onclick="getStop(\'1\')">我的工作室</a></p>'+
						'</div>'+
						'<div class="fwzx_index_bottom pr"><ul><li class="white" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") style=" cursor:pointer;" >个人中心</li></ul>'+
    
   /* '<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr"  style="z-index:99">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">编辑我的专属特权</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">您的等级是<span>'+VIPTypeIDStr+'</span>你共有<span>'+VIPTypeIDNum+'</span>个专属特权</div>'+
            '<ul class="zs"></ul>'+
        '</div>'+
        '<div class="fwzx_more_bottom"></div>'+
    '</div>'+
  '</div>'+*/

  '</div>';
  
  	//$('#login_main1').html(loginOkStr2);

	var zhiboT=setTimeout(function(){
		var market=cookie('WEBHXZB_USERMARKET');
		changeLoopInfo(market);
	},1000);/**/
	
	var zhiboRoomT=setTimeout(function(){
		uRoom=cookie('WEBHXZB_UROOMS');
		uRoomStr=uRoom.replace('\"','');
		uRoomStr=uRoomStr.replace('\"','');
		uRoomNum=uRoomStr.split(',')[0]?uRoomStr.split(',')[0]:'';
		if(uRoomNum==52||uRoomNum==59){
			uRoomStr='http://newzb.jrj.com/hxzb/vip/viploginNew.do';
		}
		else if(uRoomNum==67||ssoType==-10){
			uRoomStr='http://newzb.jrj.com/hxzb/vip/viploginNew.do';
		}
		else if(uRoomNum==''){
			uRoomStr='http://newzb.jrj.com/hxzb/';
		}
		else{
			uRoomStr='http://newzb.jrj.com/hxzb/live/intoRoom.do?roomid='+uRoomNum;
		}
		
		if(!getStop()){
			uRoomStr='javascript:void(0)';
		}
		$('.zbs a').attr('href',uRoomStr);
	},1000);
	
	
    getMessages();
	
	
};


//非首页的登录
zjgjs.sso.loginNormal=function(json){
	//var VIPTypeID=cookie('rank');
	var rank=cookie('rank')
	var VIPTypeIDStr='';
	var star='';
	var VIPTypeIDNum=0;
	var VIPTypeIDNumStart=0;
	var uRoom=cookie('WEBHXZB_UROOMS');
	var uRoomStr='';
	var uRoomNum;
	var indexUserPhone = cookie("WEBSSO_LID");
	var newstr='';
	var serwivestr='';
	var Score=json?json.Score:cookie('Score');
	var headImg=cookie('WEBSSO_UID');
	var fastServive=json?json.fw:cookie('fw');
	var fastServiveStr='';
	var tempServive;
	var smallServive='';
	var ssoType=cookie('WEBSSO_USERTYPE');
	
	if(cookie('fw')==''){
		addCookie("fw", fastServive, 0);
	}
	rank=rank-0;
	//headImg='img_17876860';
	
	if (indexUserPhone != "" && indexUserPhone != null) {
		indexUserPhone = indexUserPhone.substring(0, 3) + "****" + indexUserPhone.substring(7);
	}
	if(rank==""){
		VIPTypeIDStr='体验客户';
		VIPTypeIDNum=8;
		VIPTypeIDNumStart=15;
		star=star+'<img src="/images2014/tiyan_user.png" width="14" height="14"/>';
	}
	 if(rank==3){
		VIPTypeIDStr='三星客户';
		VIPTypeIDNum=12;
		VIPTypeIDNumStart=11;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==4){
		VIPTypeIDStr='四星客户';
		VIPTypeIDNum=14;
		VIPTypeIDNumStart=9;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==5){
		VIPTypeIDStr='五星客户';
		VIPTypeIDNum=20;
		VIPTypeIDNumStart=3;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==6){
		VIPTypeIDStr='钻石客户';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v1_user.png" width="14" height="14"/>';
	}
	else if(rank==7){
		VIPTypeIDStr='至尊客户';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v2_user.png" width="14" height="14"/>';
	}
	/*for(var k=0;k<VIPTypeID+1;k++){
		if(k==0){
		star=star+'<img src="/images2014/star.png" width="14" height="13" style="float:left;display:inline;"/>'
			}
		else{
		star=star+'<img src="/images2014/star.png" width="14" height="13" style="float:left;display:inline;"/>'
		}
	}
	*/
	if(fastServive!="" && fastServive != 'undefined' && typeof(fastServive) != "undefined"){
		tempServive=fastServive.replace('\"','');
		tempServive=tempServive.replace('\"','');
		tempServive=tempServive.split(',');
		if(tempServive.length>=1){
			for(var a=0;a<tempServive.length;a++){
				if(tempServive[a]!=0){
					smallServive=setFastUrl(tempServive[a])+smallServive;
				}
			}
		}
	}
	
  	var loginOkStr3='<div class="fwzx_index_top_khzl pa index_loginok">'+
					 '<div class="fwzx_index_top_khzl-top">'+
						'<a href="http://tg.zhengjin99.com/zhengjin/user/"><img src="http://pic.zhengjin99.com/head/'+headImg+'.jpg" width="82" height="82" class="mauto block"></a>'+
						'<p class="p2" style="width:110px;height:25px;float:left;margin:20px 0 3px 10px;"><span><a href="http://tg.zhengjin99.com/zhengjin/user/"><span>'+indexUserPhone+'</span><img style="" class="ml5" src="/images2014/bonus_15.png" /></a></span></p>'+
						'<p class="p2" style="width:150px;height:25px;float:left;margin:20px 0 3px 10px;"><span>'+VIPTypeIDStr+'</span><a>'+star+'</a></p>'+
						'<p class="p2 m15" style="width:275px;"><span class="mr20"><span>积分：</span><span>'+Score+'</span></span><span class="mr20"><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span style="margin:0 0 0 52px">消息</span><span class="red" id="newMessage1"></span></a></span></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p><a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;">证金直播</a></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p class="zbs"><a href="'+uRoomStr+'" style="margin:0;" onclick="getStop(\'1\')">我的工作室</a></p>'+
						'</div>'+
						'<div class="fwzx_index_bottom pr"><ul><li style=" cursor:pointer;" class="white" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") >个人中心</li></ul>'+
    
   /* '<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr"  style="z-index:99">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">编辑我的专属特权</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">您的等级是<span>'+VIPTypeIDStr+'</span>你共有<span>'+VIPTypeIDNum+'</span>个专属特权</div>'+
            '<ul class="zs"></ul>'+
        '</div>'+
        '<div class="fwzx_more_bottom"></div>'+
    '</div>'+
  '</div>'+*/

  '</div>';
  
  	//$('#login_main2').html(loginOkStr3);
	<!---->
	
  	var loginOkStr9='<div class="fwzx_index_top_khzl"><div class="fwzx_index_top_khzl-top"><div class="fwzx_index_top_khzl-top-img"><a href="http://tg.zhengjin99.com/zhengjin/user/"><img src="http://pic.zhengjin99.com/head/'+headImg+'.jpg" width="82" height="82"></a></div><p><span><a href="http://tg.zhengjin99.com/zhengjin/user/" style="color:#898888;"><span>'+indexUserPhone+'</span><img style="margin-top: 3px;" class="ml5" src="/images2014/bonus_15.png"></a></span><a><img src="../images2014/fwzx-10.jpg" width="18" height="18"  alt=""/></a><a><img src="../images2014/fwzx-11.jpg" width="18" height="18"  alt=""/></a></p><p class="p2"><span>'+VIPTypeIDStr+'</span><a>'+star+'</a></p><p class="p2"><span><span>积分：</span><span>'+Score+'</span></span><span style="float:right"><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp" style="margin:0;color:#898888;"><span>消息</span><span class="red" id="newMessage"></span></a></span></p></div><div class="fwzx_index_top_khzl-middle"><p>	<a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;color:#898888;">证金直播</a></p></div><div class="fwzx_index_top_khzl-middle"><p class="zbs">	<a href="'+uRoomStr+'" style="margin:0;color:#898888;" onclick="getStop(\'1\')">我的工作室</a></p></div><div class="fwzx_index_bottom pr"><ul><li class="white2" style=" cursor:pointer;" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") >个人中心</li></ul>'+
    
    /*'<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:9999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">编辑我的专属特权</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">您的等级是<span>'+VIPTypeIDStr+'</span>你共有<span>'+VIPTypeIDNum+'</span>个专属特权</div>'+
            '<ul class="zs"></ul>'+
        '</div>'+
        '<div class="fwzx_more_bottom"></div>'+
    '</div>'+
*/
  '</div>'+

  '</div>';
  
  	$('#login_main').html(loginOkStr9);
	
	<!---->
	var zhiboRoomT=setTimeout(function(){
		uRoom=cookie('WEBHXZB_UROOMS');
		uRoomStr=uRoom.replace('\"','');
		uRoomStr=uRoomStr.replace('\"','');
		uRoomNum=uRoomStr.split(',')[0]?uRoomStr.split(',')[0]:'';
		if(uRoomNum==52||uRoomNum==59){
			uRoomStr='http://newzb.jrj.com/hxzb/vip/viploginNew.do';
		}
		else if(uRoomNum==67||ssoType==-10){
			uRoomStr='http://newzb.jrj.com/hxzb/vip/viploginNew.do';
		}
		else if(uRoomNum==''){
			uRoomStr='http://newzb.jrj.com/hxzb/';
		}
		else{
			uRoomStr='http://newzb.jrj.com/hxzb/live/intoRoom.do?roomid='+uRoomNum;
		}
		
		if(!getStop()){
			uRoomStr='javascript:void(0)';
		}
		
		$('.zbs a').attr('href',uRoomStr);
	},1000);
	
	
    getMessages();
};

//不能观看视频
function getStop(type){
	var utype = cookie("WEBSSO_USERTYPE");
	var flag = cookie("WEBHXZB_USERFLAG");
	if(type&&utype == -1 && flag == 5){
		alert("尊敬的客户，您的交易余额不足，已被暂停服务。为了方便您继续交易，请及时拨打010-58309199申请再次开通。祝您投资愉快！");
	}
	if(utype == -1 && flag == 5){
		//alert("您的帐号已经暂停，不能观看VIP直播室！");
		return false;
	}
	else{
		return true;
	}
}


//获取快捷服务
function getFastServive(){
	var VIPTypeID=cookie('VIPTypeID');
	var VIPTypeIDNum=0;
	var VIPTypeIDNumStart=0;
	var serwivestr='';
	var fastServive=cookie('fw');
	var fastServiveStr='';
	var tempServive;
	
	if(VIPTypeID==0){
		VIPTypeIDNumStart=16;
	}
	else if(VIPTypeID==1){
		VIPTypeIDNumStart=12;
	}
	else if(VIPTypeID==2){
		VIPTypeIDNumStart=10;
	}
	else if(VIPTypeID==3){
		VIPTypeIDNumStart=4;
	}
	else if(VIPTypeID==4){
		VIPTypeIDNumStart=1;
	}
	
	if(fastServive!=""){
		tempServive=fastServive.replace('\"','');
		tempServive=tempServive.replace('\"','');
		tempServive=tempServive.split(',');
		if(tempServive.length>=1){
			for(var a=0;a<tempServive.length;a++){
				if(tempServive[a]!=0){
					if(tempServive[a]<10){
						fastServiveStr=fastServiveStr+'<li><img data-id="'+tempServive[a]+'" src="../images2014/fwtx-0'+tempServive[a]+'.jpg"></li>';
					
					}
					else{
						fastServiveStr=fastServiveStr+'<li><img data-id="'+tempServive[a]+'" src="../images2014/fwtx-'+tempServive[a]+'.jpg"></li>';
					}
				}
			}
			
		}
		
	}
	
	for(var j=VIPTypeIDNumStart;j<24;j++){
		
		if(j<10){
			serwivestr=serwivestr+'<li><img data-id="'+j+'" src="../images2014/fwtx-0'+j+'.jpg"></li>';
		}
		else{
			serwivestr=serwivestr+'<li><img data-id="'+j+'" src="../images2014/fwtx-'+j+'.jpg"></li>';
			
			/* if (j == 5) {
                    continue;}*/
		}/**/
		

	}	
	
	$('.kj').html(fastServiveStr);
	$('.zs').html(serwivestr);
	if(fastServive!=""){
		for(var k=0;k<tempServive.length;k++){
			$('.zs li').find('img[data-id='+tempServive[k]+']').parent('li').remove();
		}
	}
}


//获取个人中心消息
function getMessages(){
	var num_url = "http://tg.zhengjin99.com/zhengjin/user/mail_ajax.jsp";
	$.getScript(num_url, function(){
		if(json.nrnum>0){
			$('#Messages').html('（新）');
			$('#newMessage').html('（新）');
			$('#newMessage1').html('（新）');
		}
	});
}



zjgjs.sso.isLogin = function() {
	sso_userID = cookie("WEBSSO_UID");
	userName = cookie("WEBSSO_ZJUSERNAME");
	if (sso_userID == 0 || sso_userID == "" || userName == null) {
		return false;
	}
	return true;
};
var curRoomId = 0;
zjgjs.sso.visitLiveHome = function(roomid) {
	if (zjgjs.sso.isLogin()) {
		liveIdGroup = cookie("WEBSSO_ATTENTION_LIVEIDGOURP");
		var hxzbId2 = cookie("WEBHXZB_USERID");
		if (!liveIdGroup) {
			liveIdGroup = "";
		}
		//liveIdGroup=liveIdGroup.split('"')[1];
		liveIdGroup=liveIdGroup.replace('"','');
		var liveIdArr = liveIdGroup.split(",");
		var canSee = false;
		for ( var i = 0; i < liveIdArr.length; i++) {
			if (liveIdArr[i] == roomid) {
				canSee = true;
				break;
			}
		}
		userType = cookie("WEBSSO_USERTYPE");
		if (userType && userType.length > 0) {
			userType = decodeURI(userType);
			userType = userType.substr(0, 1);
			if (userType == " ") {
				userType = "1"; // 现在存在为空的情况，这种是4个空格，算到类型1里，见gender_zhibolist_html_script_cache.jsp
			}
		}
		if (userType && userType == '0') {// 0为实盘已开通账户，此账户才有权限查看实时直播
			if (canSee) {// 如果此直播室为可查看的直播室
				window.open("http://newzb.jrj.com/hxzb/live/intoRoom.do?fromUrl=99&roomid="
								+ roomid + "&userid=" + hxzbId2);
			} else {
				/*if (confirm("您没有关注此直播室，无法进入实时直播，是否进入历史直播？（温馨提示：您可以进入历史直播了解并关注此直播室。）")) {
					$("#testroomid").val(roomid);
					$("#testform").submit();
				}*/
				curRoomId = roomid;
				//confirm("您没有关注此直播室，无法进入实时直播，是否进入历史直播？（温馨提示：您可以进入历史直播了解并关注此直播室。）","http://newzb.jrj.com/hxzb/hxzb_lishi.jsp?roomid=" + curRoomId);
				var r=confirm('您没有关注此直播室，无法进入实时直播，是否进入历史直播？（如有疑问请联系：010-58309199，证金贵金属欢迎您的来电。）');
				if(r)
					window.open('http://newzb.jrj.com/hxzb/history/liShiDetail.do?fromUrl=99&roomid='+curRoomId);
			}
		} else {// 其它账户为注册3、模拟2、实盘未激活1 ，此账户智能查看历史直播
			window.open("http://newzb.jrj.com/hxzb/history/liShiDetail.do?fromUrl=99&roomid="
							+ roomid);
		}
	} else {// 未登录
		/*alert("请您登陆后查看");
		$("#popLoginWin").fadeIn();*/
		window.open("http://newzb.jrj.com/hxzb/history/liShiDetail.do?fromUrl=99&roomid="
							+ roomid);
	}
};

function submitRoomId(){
	//var nows = new Date().getTime();
	$("#testformDiv").html('<form style="display:none;" action="http://newzb.jrj.com/hxzb/hxzb_lishi.jsp?fromUrl=99&" method="get" target="_blank"><input type="hidden" id="testroomid" name="roomid" value="' + curRoomId + '"></form><script>setTimeout(function(){$("#testformDiv").find("form").submit();},300);</script>');
	
	//$("#testroomid").val(curRoomId);
	$("#testform").html('<input type="hidden" id="testroomid" name="roomid" value="' + curRoomId + '">');
	$("#testform").submit();	
}

zjgjs.sso.login2 = function(passport, password) {
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID="
			+ passport + "&Passwd=" + zjgjs.md5(password)+ "&yhdj=1"+"&plateform=pc_99";
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		userType = userJson.userType;
		oilType = userJson.oilType;
		regTime = userJson.regTime;
		rank=userJson.rank;
		token=userJson.token;
		addCookie("WEBSSO_ZJUSERNAME", userName, 0);
		addCookie("WEBSSO_UID", sso_userID, 0);
		addCookie("WEBSSO_USERTYPE", userType, 0);
		addCookie("WEBSSO_OILTYPE", oilType, 0);
		addCookie("WEBSSO_REGTIME", regTime, 0);
		addCookie("WEBSSO_RANK", rank, 0);
		addCookie("WEBSSO_TOKEN",token, 0);
		if (sso_userID == 0 || sso_userID == "" || userName == null) {
			alert("用户名或密码错误");
			return false;
		}
		addCookie("WEBSSO_LID", passport, 0);
		zjgjs.sso.loginOk();
		var url = "http://newzb.jrj.com/hxzb/otherlogin.do?mobile="+ passport +"&password=" + zjgjs.md5(password) + "&userName=" + userName + "&fromUrl=99" + "&jsoncallback=?";
		jQuery.getJSON(encodeURI(url), function(json){//cookie值个人中心会用到
			//alert(json["result"]);
		});

	});
};
//绑定enter提交
function BindEnter(obj){
	if(obj.keyCode == 13) {
		zjgjs.sso.login('');
		obj.returnValue = false;
	}
} 

function removePwd(num){
	$('#pwd_text'+num).hide();
	$('#pwd_text'+num).siblings().show();
	$('#pwd_text'+num).siblings().focus();

}
function addPwd(num){
	var txt=$('#code'+num).val();
	if(!txt||txt==''){
		$('#code'+num).hide();
		$('#code'+num).siblings().show();
	}
}

//登录验证通过
zjgjs.sso.loginOk = function() {
	$("#loginInfos").html(zjgjs.sso.afterLoginHtml());
	if($('#zhibo_lists').hasClass('bx_container')){
		var zhiboT=setTimeout(function(){
			var market=cookie('WEBHXZB_USERMARKET');
			changeLoopInfo(market);
		},1000);
		//changeLoopInfo(2);
	}
	$("#popLoginWin").hide();
	if (zjgjs.sso.afterLoginOk) {
		zjgjs.sso.afterLoginOk();
	}
	//important  ajax函数加入已登录函数
	$.ajax({
				type : "get",
				async:false,
				url : "http://tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp",
				dataType : "jsonp",
				jsonp: "callback",//服务端用于接收callback调用的function名的参数
				jsonpCallback:"success_callback2",//callback的function名称
				success : function(json){
					//zjgjs.sso.loginOk();
					if($('#zhibo_lists').hasClass('bx_container')){
						zjgjs.sso.indexLogin(json)
					}else{
						zjgjs.sso.loginNormal(json)
					}
				}
			});
};

//网站头部未登录
/*zjgjs.sso.beforeLoginHtml = function() {
	var locationUrl=window.location.href;
	var html = '<input type="button" value="登录" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/login.jsp?redirect='+locationUrl+'\'" class="login fl" name=""><input type="button" value="注册" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/register.jsp\'" class="register fl" name=""><span class="fl">|</span><span class="ml5 fl"><a href="http://tg.zhengjin99.com/zhengjin/user/"><span class="fl">个人中心</span><img src="/images2014/bonus_15.png" class="fl" style="margin-top: 3px;margin-left:2px;"></a></span>';
	return html;
};*/
zjgjs.sso.beforeLoginHtml=function(){
	var html = '';
	return html;
	}

//网站头部已登录
/*zjgjs.sso.afterLoginHtml = function() {
	userPhone = cookie("WEBSSO_LID");
	var str="";	
	if (userPhone != "" && userPhone != null) {
		userPhone = userPhone.substring(0, 3) + "****" + userPhone.substring(7);
	}
	var html = '<span class="fl mr10"><a href="http://tg.zhengjin99.com/zhengjin/user/">您好！ '+userPhone+'</a></span><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span class="fl mr10">消息<span class="red" id="Messages"></span></span></a><input type="button" value="退出" onclick="zjgjs.sso.loginOut(\'\')" class="login fl" name=""><span class="fl">|</span><span class="ml5 fl"><a href="http://tg.zhengjin99.com/zhengjin/user/"><span class="fl">个人中心</span><img src="/images2014/bonus_15.png" class="fl" style="margin-top: 3px;margin-left:2px;"></a></span>';
	return html;
};*/
zjgjs.sso.afterLoginHtml = function() {
	
	var html = '';
	return html;
};
//登出
zjgjs.sso.loginOut = function(index) {
	var _userId = getCookie("WEBHXZB_USERID");
		delCookie("WEBSSO_TOKEN");
		delCookie("OPERATOR_"+_userId);
		delCookie("WEBSSO_RANK");
		delCookie("WEBSSO_ZJUSERNAME");
		delCookie("WEBSSO_UID");
		delCookie("WEBSSO_LID");
		delCookie("WEBSSO_ATTENTION_LIVEIDGROUP");
		delCookie("WEBSSO_USERTYPE");
		delCookie("WEBSSO_OILTYPE");
		delCookie("WEBHXZB_USERID");
		delCookie("WEBHXZB_UMOBILE");
		delCookie("WEBHXZB_USERTYPE");
		delCookie("WEBHXZB_UROOMS");
		delCookie("WEBHXZB_USERFLAG");
		delCookie("WEBHXZB_USERBALANCE");
		delCookie("WEBHXZB_USERTRA");
		delCookie("WEBHXZB_USERMARKET");
		delCookie("WEBHXZB_LOGINTIME");
		delCookie("WEBHXZB_MOBILE");
		delCookie("WEBHXZB_LEVEL");
		delCookie("WEBHXZB_USERNAME");
		delCookie("VIPTypeID");
		delCookie("Score");
		delCookie("WEBSSO_NICKNAME");
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?action=logout";
	$.getScript(loginin_url, function() {
		//sso_userID = userJson.sso_userID;
		//userName = userJson.userName;
		$("#loginInfos").html(zjgjs.sso.beforeLoginHtml());
		zjgjs.sso.indexBeforeLogin();
		zjgjs.sso.beforeLoginNormal();
		if($('#zhibo_lists').hasClass('bx_container')){changeLoopInfo(2);}
	});
};

//登录入口
var sso_userID;
var userName;
zjgjs.sso.init = function() {
	userName = cookie("WEBSSO_ZJUSERNAME");
	sso_userID = cookie("WEBSSO_UID");
	if (sso_userID == null || sso_userID == 0 || sso_userID == "" || userName == null || userName == "") {
		// $("#popLoginWin").show();
		$("#loginInfos").html(zjgjs.sso.beforeLoginHtml());
		zjgjs.sso.indexBeforeLogin();
		zjgjs.sso.beforeLoginNormal();
	} else {
		zjgjs.sso.loginOk();
		if($('#zhibo_lists').hasClass('bx_container')){
			zjgjs.sso.indexLogin()
		}else{
			zjgjs.sso.loginNormal();
		}
		
	}
};




var commonPhone2 = "请输入您的手机号码";
function removeCommonPhone(index) {
	var mobile = $("#phone" + index).val();
	if (mobile == commonPhone2) {
		$("#phone" + index).val("");
	}
}

function addCommonPhone(index) {
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
function jumpToZhiBo(){

	window.location = "http://newzb.jrj.com/hxzb/viplogin.do";
}


function kefuImg(){
	$('#index_piao .qq').addClass('qq_hover').removeClass('qq');
	var t=setTimeout(function(){
		$('#index_piao .qq_hover').addClass('qq').removeClass('qq_hover');
	},1000);
}

var cache_id=cookie("VEDIOHINT");
$(document).ready(function() {
	zjgjs.sso.init();
	//getVedioHint();
	//var vediot=setInterval(function(){
	//	getVedioHint();
	//},60*1000);
	var t=0;
	var wheight=$(window).height();
	
	$(window).scroll(function(){
		var scrolltop=$(window).scrollTop();
		if(scrolltop>=wheight){
			$('#index_piao a').show();
		}
		else{
			$('#index_piao a').hide();
		};
		if(scrolltop>128){
			if(t!=1){
				$('#vedioHint').animate({right:'-195px'},500);
				t=1;
			}
			
		}
		else{
			if(t!=2){
				$('#vedioHint').animate({right:'-7px'},500);
				t=2;
			}
		}
	})
	
	 
	
	
	$('#vedioHint').bind('mouseenter',function(){
		var right=$(this).css('right');
		if(right=='-195px'){
			$(this).animate({right:'-7px'},500);
		}
	})
	$('#vedioHint').bind('mouseleave',function(){
		var right2=$(this).css('right');
		if(right2=='-7px'){
			$(this).animate({right:'-195px'},500);
		}
	})
	
	
	var kefuFun=setInterval('kefuImg()',2000);
	
	$('#index_piao div').bind('mouseenter',function(){
		var className=$(this).attr('class');
		$('#index_piao div.'+className).addClass(className+'_hover').removeClass(className);
		if($(this).hasClass('qq_hover')){
			clearInterval(kefuFun);
		}
		else{
			return;
		}
	});
	$('#index_piao div').bind('mouseleave',function(){
		var className2=$(this).attr('class');
		className2=className2.replace('_hover','');
		$('#index_piao div.'+className2+'_hover').addClass(className2).removeClass(className2+'_hover');
		if($(this).hasClass('qq')){
			kefuFun=setInterval('kefuImg()',2000);
		}else{
			return;
		}
	});
	
	
	$('.kj li').live('mouseenter',function(){
		$(this).append('<a id="more_delate" class="pa hand" href="javascript:void(0)" style="background:url(/images2014/more_delate.png) no-repeat;_background:none;_FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'/images2014/more_delate.png\'));left:0;top:0;width:90px;height:90px;"></a>');
	})
	$('.kj li').live('mouseleave',function(){
		$('#more_delate').remove();
	})
	
	$('.zs li').live('mouseenter',function(){
		$(this).append('<a id="more_add" class="pa hand" href="javascript:void(0)" style="background:url(/images2014/more_add.png) no-repeat;_background:none;_FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'/images2014/more_add.png\'));left:0;top:0;width:90px;height:90px;"></a>');
	})
	$('.zs li').live('mouseleave',function(){
		$('#more_add').remove();
	})
	
	$('#more_add').live('click',function(){
		var moreStr=$(this).parent('li').html();
		if($('.kj li').length>=6){
			alert('快捷方式最多只能存放6个！');
			return;
		}
		$(this).parent('li').remove();
		$('.kj').append('<li>'+moreStr+'</li>');
		$('#more_add').remove();
	})
	$('#more_delate').live('click',function(){
		var moreStrDel=$(this).parent('li').html();
		var moreDelData=$(this).siblings('img').attr('data-id');
		$(this).parent('li').remove();
		$('.zs').append('<li>'+moreStrDel+'</li>');
		$('#more_delate').remove();
	})
	
	$('.fwzx_index_bottom_more').live('click',function(){
		getFastServive();
	})
	
	$('#fw_close').live('click',function(){
		var datas=[];
		var smallServive='';
		for(var i=0;i<$('.kj li img').length;i++){
			datas.push($('.kj li img').eq(i).attr('data-id'));
		}
		if(datas.length==0){
			datas.push(0);
		}
		$.ajax({
			type : "get",
			async:false,
			url : "http://tg.zhengjin99.com/zhengjin/user/userfw_ajax.jsp",
			data:'act=update&fw='+datas,
			dataType : "jsonp",
			jsonp: "callback",//服务端用于接收callback调用的function名的参数
			jsonpCallback:"success_callback",//callback的function名称
			success : function(json){
				for(var i=0;i<datas.length;i++){
					var tempdatas=datas[i]-0;
					if(tempdatas!=0){
						smallServive=setFastUrl(tempdatas)+smallServive;
					}
					else{
						smallServive='';
					}
				}				
				$('.tq').html(smallServive);
			}
		});
	});
	
	
	$('.pwd_text').live('focus',function(){
		$(this).hide();
		$(this).siblings().show();
		$(this).siblings().focus();
	});
	$('.login_pwd').live('blur',function(){
		var txt=$(this).val();
		if(!txt||txt==''){
			$(this).hide();
			$(this).siblings().show();
		}
	});
});

function setTitle(num){
	num=parseInt(num);
	var titleName='';
	switch(num){
		case 1:
			titleName='彩虹俱乐部倾情接送服务';
			break;
		case 2:
			titleName='彩虹俱乐部五星级酒店预订';
			break;
		case 3:
			titleName='专家定制';
			break;
		case 4:
			titleName='VIP专属热线';
			break;
		case 5:
			titleName='VIP直播室';
			break;
		case 6:
			titleName='客户关怀';
			break;
		case 7:
			titleName='VIP投资内参';
			break;
		case 8:
			titleName='彩虹俱乐部尚品生活沙龙';
			break;
		case 9:
			titleName='风险评估';
			break;
		case 10:
			titleName='奖励积分';
			break;
		case 11:
			titleName='投资策略报告';
			break;
		case 12:
			titleName='大咖工作室';
			break;
		case 13:
			titleName='客服专线';
			break;
		case 14:
			titleName='电话委托下单';
			break;
		case 15:
			titleName='积分商城';
			break;
		case 16:
			titleName='个人中心';
			break;
		/*case 17:
			titleName='金融面对面';
			break;*/
		case 17:
			titleName='金牌早晚评';
			break;
		case 18:
			titleName='证金银屏';
			break;
		case 19:
			titleName='火线交易';
			break;
		case 20:
			titleName='在线咨询';
			break;
		case 21:
			titleName='证金学院';
			break;
		case 22:
			titleName='财经日历';
			break;
		case 23:
			titleName='财富周刊';
			break;
	}
	return titleName;
}

function setFastUrl(n){
	var smallServive='';
	var titleName=setTitle(n);
	smallServive=smallServive+'<li title="'+titleName+'">';
	if(n<10){
		if(n == 1){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/mall/detail.jsp?itemId=10042" target="_blank">';
		}else if(n == 2){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/mall/detail.jsp?itemId=10041" target="_blank">';
		}else if(n == 7){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/ydtx/index.jsp" target="_blank">';
		}else if(n == 9){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/user/fxpg.jsp" target="_blank">';
		}else{
			smallServive=smallServive+'<a href="javascript:void(0)" style="cursor:default;">';
		}
		smallServive=smallServive+'<img src="../images2014/fwzx_small_0'+n+'.jpg">';		//改动
	}else{
		if(n == 12){
			smallServive=smallServive+'<a href="http://newzb.jrj.com/hxzb/" target="_blank">';
		}else if(n == 15){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/mall/" target="_blank">';
		}else if(n == 16){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/user/" target="_blank">';
		/*}else if(n == 17){
			smallServive=smallServive+'<a href="http://vd.jrj.com/front/out/zbxb.jsp" target="_blank">';*/
		}else if(n == 18){
			smallServive=smallServive+'<a href="http://www.zhengjin99.com/list/list_yanjiu_zaowan.shtml" target="_blank">';
		}else if(n == 19){
			smallServive=smallServive+'<a href="http://vd.jrj.com/" target="_blank">';
		}else if(n == 20){
			smallServive=smallServive+'<a href="http://newzb.jrj.com/hxzb/" target="_blank">';
		}else if(n == 23){
			smallServive=smallServive+'<a href="http://www.zhengjin99.com/research/calendar.shtml" target="_blank">';
		}else if(n == 22){
			smallServive=smallServive+'<a href="http://www.zhengjin99.com/list/list_yanjiu_xueyuan.shtml" target="_blank">';
		}else if(n == 24){
			smallServive=smallServive+'<a href="http://tg.zhengjin99.com/zhengjin/cfzk/" target="_blank">';
		}else{
			smallServive=smallServive+'<a href="javascript:void(0)" style="cursor:default;">';
		}
		smallServive=smallServive+'<img src="../images2014/fwzx_small_'+n+'.jpg">';
	}
	smallServive=smallServive+'</a></li>';
	
	return smallServive;
}


function getVedioHint(){
	cache_id=cookie("VEDIOHINT");
	$.ajax({
		type : "get",
		async:false,
		url:"http://vd.jrj.com/front/out/get_pushmsg.jsp?type=0&pageSize=1",
		dataType : "jsonp",
		jsonp: "callback",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"callback_msg",//callback的function名称
		success:function(datas){
			var data=datas.rows[0];
			if(cache_id==data.id){
				$('#vedioHint').hide();
				return;
			}
			$('#vedioHint').show();
			var txt='<div class="fl vedioHint_img" onclick="vedioHintClose('+data.id+');"><a href="'+data.url+'" target="_blank"><img height="67" width="74" src="'+data.imageUrl+'" /></a></div><div class="vedioHint_txt fl"><p class="vedioHint_title">'+data.title+'</p><p onclick="vedioHintClose('+data.id+');"><a href="'+data.url+'" target="_blank">'+data.content.substring(0,20)+'</a></p></div><div class="vedioHint_close" onclick="vedioHintClose('+data.id+');"></div>';
		
			$('#vedioHint').html(txt);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			XMLHttpRequest;
			textStatus;
			errorThrown;
		}
	})
}

function vedioHintClose(vedioId){
	$('#vedioHint').hide();
	delCookie('VEDIOHINT');
	//setCookie("VEDIOHINT", "", null, "", ".zhengjin99.com", "");
	addCookie("VEDIOHINT",vedioId);
}
function addCookieLong(objName, objValue, objHours) { // 添加cookie，时间为永久
	objHours=24*10;
	var str = objName + "=" + escape(objValue); 
	str += "; domain=.zhengjin99.com"; 
	if(objHours > 0){
		var date = new Date(); 
		var ms = objHours*3600*1000; 
		date.setTime(date.getTime() + ms); 
		str += "; expires=" + date.toGMTString()+"; domain=.zhengjin99.com"; 
	 }
	 document.cookie = str;
}
//右侧浮窗
function getprogram(){
	
	$.ajax({
		type : "get",
		async:false,
		url:"http://vd.jrj.com/front/out/index_zbsy.jsp",
		dataType : "jsonp",
		jsonp: "callback",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"callback_program",//callback的function名称
		success:function(jsons){
			var json=jsons.news;
			var li = "";
			if(json === null){// 2016-9-3 明秀平增加无数据返回时异常处理
			}else{
				li= ''+json.startTime.substring(11,16)+' - '+json.endTime.substring(11,16)+' </br> '+json.content+' ';				        		
			}
		$('p.vedio').html(li);
		},
		
		error:function(XMLHttpRequest, textStatus, errorThrown){
			XMLHttpRequest;
			textStatus;
			errorThrown;
		}
	})
}

$(document).ready(function() {
	zjgjs.sso.init();
	getprogram();
	var vediot=setInterval(function(){
		getprogram();
	},60000);
});

