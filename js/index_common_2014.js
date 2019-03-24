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
//���coolie ��ֵ
function cookie(name) {
	var cookieArray = document.cookie.split("; "); // �õ��ָ��cookie��ֵ��,��ֵ��ʵ����name=liyan
	var cookie = new Object();
	for ( var i = 0; i < cookieArray.length; i++) {
		var arr = cookieArray[i].split("="); // ������ֵ�ֿ�
		if (arr[0] == name)
			return unescape(arr[1]); // �����ָ����cookie���򷵻�����ֵ
	}
	return "";
}
function delCookie(name)// ɾ��cookie
{
	document.cookie = name + "=;expires=" + (new Date(0)).toGMTString();
}

function getCookie(objName) {// ��ȡָ�����Ƶ�cookie��ֵ
	var arrStr = document.cookie.split("; ");
	for ( var i = 0; i < arrStr.length; i++) {
		var temp = arrStr[i].split("=");
		if (temp[0] == objName)
			return unescape(temp[1]);
	}
}

function addCookie(objName, objValue, objHours) { // ���cookie
	/**
	 * var str = objName + "=" + escape(objValue); if(objHours > 0){
	 * //Ϊʱ���趨����ʱ�䣬������ر�ʱcookie�Զ���ʧ var date = new Date(); var ms =
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

function SetCookies(name, value)// ����������һ����cookie�����ӣ�һ����ֵ
{
	var Days = 30; // �� cookie �������� 30 ��
	var exp = new Date(); // new Date("December 31, 9998");
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires="
			+ exp.toGMTString();
}


function delCookie(name)// ɾ��cookie
{
	/**
	 * var exp = new Date(); exp.setTime(exp.getTime() - 1); var
	 * cval=getCookie(name); if(cval!=null) document.cookie= name +
	 * "="+cval+";expires="+exp.toGMTString();
	 */
	setCookie(name, "", null, "/", ".zhengjin99.com", "");
}




//��¼
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
		//var maidianVal={"ssoid":sso_userID,"mobile":passport};//���
		//$.cookie('count-data',JSON.stringify(maidianVal),{expires:1000,path:'/'});
		
		
		if (sso_userID == 0 || sso_userID == "" || userName == null) {
			alert("�û������������");
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
				url : "http://tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp", //20160707�޸ģ�20160712Ҫ�Ļ���ʽ��ַ
				dataType : "jsonp",
				jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
				jsonpCallback:"success_callback2",//callback��function����
				success : function(json){
					var maidianVal={"ssoid":sso_userID,"mobile":passport};//���
		            $.cookie('count-data',JSON.stringify(maidianVal),{expires:1000,path:'/'});//����cookie
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

//��ҳ��¼ǰ����
zjgjs.sso.indexBeforeLogin=function(){
	var url = window.location.href
	$.ajax({
		type : "get",
		async:false,
		url : "http://tg.zhengjin99.com/zhengjin/cmscall/user_total_ajax.jsp",
		dataType : "jsonp",
		jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
		jsonpCallback:"success_callback3",//callback��function����
		success : function(json){
			var beforeLogin='<div class="login_main0609 pa">'+                   
                    '<div class="login_input_name"><input name="" type="text" id="phone1" class="inputphone"  maxlength="11" /></div>'+                 
                    '<input name="" type="button" class="login_btn block"  value="" />'+
                    '<p>�����˻�</p>'+
				    '<div class="open"><input name="" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/login.jsp?redirect='+url+' \'" type="button" class="mn" value=""/></div>'+   //20160707�޸ģ�20160712Ҫ�Ļ���ʽ��ַ           
			         '<ul class="txt">'+
                       '<li><span id="numPerson"></span>����������֤�����</li>'+  
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
		$(".inputphone").watermark("�����ֻ�����  ��ȡ����ģ���");
	
		$(".login_btn").click(function(){
		   	 mobile = $.trim($(".inputphone").val());
			if (!isMobile(mobile)) {
				showDialog('��ʾ', '��������ȷ���ֻ����룡');
				return false;
			}
	        var url = "http://tg.zhengjin99.com/zhengjin/ws/put_resource_desc.jsp?callbackparam=?";
	        $.getJSON(url, {mobile: mobile, activityId: 'zj99_dlzc_20150609', desc: '', isSms: 0}, function(data) {
	        	console.log(data);
	        });
	        showDialog('��ʾ', "ԤԼ�ɹ���<br>�Ժ���й�����Ա������ϵ���뱣���ֻ���ͨ��");
	        $(".inputphone").val('');
		});
	  });
	}
}


	function gotoUrl(id, type,name) {
		location.href='http://tg.zhengjin99.com/zhengjin/user/login_check_open.jsp?openId=' + id + '&openType=' + type + '&name=&linkUrl=http://tg.zhengjin99.com/zhengjin/user/';
	}
	
//����ҳ��¼ǰ����
zjgjs.sso.beforeLoginNormal=function(){
	var beforeLoginNormal='<div class="fr hxzb_top_right">'+
            	'<img src="../images2014/hxzb_login_title.jpg" width="310" height="62" class="block" />'+
                '<ul class="hxzb_login">'+
                	'<li class="hxzb_person mb20"><input name="" maxlength="11" type="text" class="txt" value="�����������ֻ�����" id="phone2" onblur="addCommonPhone(\'2\');" onfocus="removeCommonPhone(\'2\');" /></li>'+
                    '<li class="hxzb_pwd"><input type="text" class="txt pwd " id="pwd_text2" value="��������������" onfocus="removePwd(\'2\');" /><input type="password" class="txt hide login_pwd" id="code2" onblur="addPwd(\'2\');" /></li>'+
                    '<li class="mt10 tr"><span class=""><a href="http://tg.zhengjin99.com/zhengjin/user/findpwd.jsp">��������</a></span></li>'+
                    '<li class="mt10"><input name="" type="button" class="login_btn2" onclick="zjgjs.sso.login(\'2\')" /></li>'+//zjgjs.sso.login(2),��ʾ����zjgjs.sso.login������ȡ����2.��¼Ҫת����Ը������ĵ�ҳ�棬����Ҫ�ں���zjgjs.sso.login��Ѱ��http://test.tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp������Ե�ַ���������ַ��Ҫ��ɵ������ǣ��ڲ��Ի��������sso�Ĳ��Թ�����
                '</ul></div>'+
            '<input name="" type="button" value="����ע��" class="hxzb_register block pa" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/register.jsp\'" />';
	//$('#login_main').html(beforeLoginNormal);
}

//��ҳ��¼
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
		VIPTypeIDStr='����ͻ�';
		VIPTypeIDNum=8;
		VIPTypeIDNumStart=15;
		star=star+'<img src="/images2014/tiyan_user.png" width="14" height=""/>';
	}
	 if(rank==3){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=12;
		VIPTypeIDNumStart=11;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==4){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=14;
		VIPTypeIDNumStart=9;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==5){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=20;
		VIPTypeIDNumStart=3;
		star=star+'<img src="/images2014/star_user.png" width="14" height=""/><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" /><img src="/images2014/star_user.png" width="14" />'
	}
	else if(rank==6){
		VIPTypeIDStr='��ʯ�ͻ�';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v1_user.png" width="15" height="13"/>';
	}
	else if(rank==7){
		VIPTypeIDStr='����ͻ�';
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
							'<p class="p2 m15" style="width:275px;"><span class="mr10"><span>���֣�</span><span>'+Score+'</span></span><span><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span style="margin:0 0 0 52px">��Ϣ</span><span class="red" id="newMessage1"></span></a></span><img src="../images2014/mn.png" width="17" height="18" class="mr5" alt=""/><img src="../images2014/sp.png" width="17" height="18"  alt=""/></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p><a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;">֤��ֱ��</a></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p class="zbs"><a href="'+uRoomStr+'" style="margin:0;" onclick="getStop(\'1\')">�ҵĹ�����</a></p>'+
						'</div>'+
						'<div class="fwzx_index_bottom pr"><ul><li class="white" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") style=" cursor:pointer;" >��������</li></ul>'+
    
   /* '<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr"  style="z-index:99">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">�༭�ҵ�ר����Ȩ</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">���ĵȼ���<span>'+VIPTypeIDStr+'</span>�㹲��<span>'+VIPTypeIDNum+'</span>��ר����Ȩ</div>'+
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


//����ҳ�ĵ�¼
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
		VIPTypeIDStr='����ͻ�';
		VIPTypeIDNum=8;
		VIPTypeIDNumStart=15;
		star=star+'<img src="/images2014/tiyan_user.png" width="14" height="14"/>';
	}
	 if(rank==3){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=12;
		VIPTypeIDNumStart=11;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==4){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=14;
		VIPTypeIDNumStart=9;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==5){
		VIPTypeIDStr='���ǿͻ�';
		VIPTypeIDNum=20;
		VIPTypeIDNumStart=3;
		star=star+'<img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/><img src="/images2014/star_user.png" width="14" height="14"/>'
	}
	else if(rank==6){
		VIPTypeIDStr='��ʯ�ͻ�';
		VIPTypeIDNum=23;
		VIPTypeIDNumStart=1;
		star=star+'<img src="/images2014/v1_user.png" width="14" height="14"/>';
	}
	else if(rank==7){
		VIPTypeIDStr='����ͻ�';
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
						'<p class="p2 m15" style="width:275px;"><span class="mr20"><span>���֣�</span><span>'+Score+'</span></span><span class="mr20"><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span style="margin:0 0 0 52px">��Ϣ</span><span class="red" id="newMessage1"></span></a></span></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p><a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;">֤��ֱ��</a></p>'+
						'</div>'+
						'<div class="fwzx_index_top_khzl-middle">'+
							'<p class="zbs"><a href="'+uRoomStr+'" style="margin:0;" onclick="getStop(\'1\')">�ҵĹ�����</a></p>'+
						'</div>'+
						'<div class="fwzx_index_bottom pr"><ul><li style=" cursor:pointer;" class="white" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") >��������</li></ul>'+
    
   /* '<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr"  style="z-index:99">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">�༭�ҵ�ר����Ȩ</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">���ĵȼ���<span>'+VIPTypeIDStr+'</span>�㹲��<span>'+VIPTypeIDNum+'</span>��ר����Ȩ</div>'+
            '<ul class="zs"></ul>'+
        '</div>'+
        '<div class="fwzx_more_bottom"></div>'+
    '</div>'+
  '</div>'+*/

  '</div>';
  
  	//$('#login_main2').html(loginOkStr3);
	<!---->
	
  	var loginOkStr9='<div class="fwzx_index_top_khzl"><div class="fwzx_index_top_khzl-top"><div class="fwzx_index_top_khzl-top-img"><a href="http://tg.zhengjin99.com/zhengjin/user/"><img src="http://pic.zhengjin99.com/head/'+headImg+'.jpg" width="82" height="82"></a></div><p><span><a href="http://tg.zhengjin99.com/zhengjin/user/" style="color:#898888;"><span>'+indexUserPhone+'</span><img style="margin-top: 3px;" class="ml5" src="/images2014/bonus_15.png"></a></span><a><img src="../images2014/fwzx-10.jpg" width="18" height="18"  alt=""/></a><a><img src="../images2014/fwzx-11.jpg" width="18" height="18"  alt=""/></a></p><p class="p2"><span>'+VIPTypeIDStr+'</span><a>'+star+'</a></p><p class="p2"><span><span>���֣�</span><span>'+Score+'</span></span><span style="float:right"><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp" style="margin:0;color:#898888;"><span>��Ϣ</span><span class="red" id="newMessage"></span></a></span></p></div><div class="fwzx_index_top_khzl-middle"><p>	<a href="http://vd.jrj.com/front/chat/?room=1&fromUrl=99" style="margin:0;color:#898888;">֤��ֱ��</a></p></div><div class="fwzx_index_top_khzl-middle"><p class="zbs">	<a href="'+uRoomStr+'" style="margin:0;color:#898888;" onclick="getStop(\'1\')">�ҵĹ�����</a></p></div><div class="fwzx_index_bottom pr"><ul><li class="white2" style=" cursor:pointer;" onclick=window.open("http://tg.zhengjin99.com/zhengjin/user/login.jsp") >��������</li></ul>'+
    
    /*'<div class="pa more_tq hide" style="right:-9px;top:98px;z-index:9999">'+
    	'<div class="fwzx_more_top"></div>'+
        '<div class="fwzx_more_mid pr">'+
        	'<a href="javascript:void(0)" class="pa" style="right:13px;top:5px;" onclick="$(this).parents(\'.more_tq\').hide();"><img src="../images2014/fwzx_more_close.png" width="17" height="16" id="fw_close" /></a>'+
        	'<div class="f18">�༭�ҵ�ר����Ȩ</div>'+
            '<ul class="kj"></ul>'+
            '<div class="f16 dj_title clear">���ĵȼ���<span>'+VIPTypeIDStr+'</span>�㹲��<span>'+VIPTypeIDNum+'</span>��ר����Ȩ</div>'+
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

//���ܹۿ���Ƶ
function getStop(type){
	var utype = cookie("WEBSSO_USERTYPE");
	var flag = cookie("WEBHXZB_USERFLAG");
	if(type&&utype == -1 && flag == 5){
		alert("�𾴵Ŀͻ������Ľ������㣬�ѱ���ͣ����Ϊ�˷������������ף��뼰ʱ����010-58309199�����ٴο�ͨ��ף��Ͷ����죡");
	}
	if(utype == -1 && flag == 5){
		//alert("�����ʺ��Ѿ���ͣ�����ܹۿ�VIPֱ���ң�");
		return false;
	}
	else{
		return true;
	}
}


//��ȡ��ݷ���
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


//��ȡ����������Ϣ
function getMessages(){
	var num_url = "http://tg.zhengjin99.com/zhengjin/user/mail_ajax.jsp";
	$.getScript(num_url, function(){
		if(json.nrnum>0){
			$('#Messages').html('���£�');
			$('#newMessage').html('���£�');
			$('#newMessage1').html('���£�');
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
				userType = "1"; // ���ڴ���Ϊ�յ������������4���ո��㵽����1���gender_zhibolist_html_script_cache.jsp
			}
		}
		if (userType && userType == '0') {// 0Ϊʵ���ѿ�ͨ�˻������˻�����Ȩ�޲鿴ʵʱֱ��
			if (canSee) {// �����ֱ����Ϊ�ɲ鿴��ֱ����
				window.open("http://newzb.jrj.com/hxzb/live/intoRoom.do?fromUrl=99&roomid="
								+ roomid + "&userid=" + hxzbId2);
			} else {
				/*if (confirm("��û�й�ע��ֱ���ң��޷�����ʵʱֱ�����Ƿ������ʷֱ��������ܰ��ʾ�������Խ�����ʷֱ���˽Ⲣ��ע��ֱ���ҡ���")) {
					$("#testroomid").val(roomid);
					$("#testform").submit();
				}*/
				curRoomId = roomid;
				//confirm("��û�й�ע��ֱ���ң��޷�����ʵʱֱ�����Ƿ������ʷֱ��������ܰ��ʾ�������Խ�����ʷֱ���˽Ⲣ��ע��ֱ���ҡ���","http://newzb.jrj.com/hxzb/hxzb_lishi.jsp?roomid=" + curRoomId);
				var r=confirm('��û�й�ע��ֱ���ң��޷�����ʵʱֱ�����Ƿ������ʷֱ������������������ϵ��010-58309199��֤��������ӭ�������硣��');
				if(r)
					window.open('http://newzb.jrj.com/hxzb/history/liShiDetail.do?fromUrl=99&roomid='+curRoomId);
			}
		} else {// �����˻�Ϊע��3��ģ��2��ʵ��δ����1 �����˻����ܲ鿴��ʷֱ��
			window.open("http://newzb.jrj.com/hxzb/history/liShiDetail.do?fromUrl=99&roomid="
							+ roomid);
		}
	} else {// δ��¼
		/*alert("������½��鿴");
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
			alert("�û������������");
			return false;
		}
		addCookie("WEBSSO_LID", passport, 0);
		zjgjs.sso.loginOk();
		var url = "http://newzb.jrj.com/hxzb/otherlogin.do?mobile="+ passport +"&password=" + zjgjs.md5(password) + "&userName=" + userName + "&fromUrl=99" + "&jsoncallback=?";
		jQuery.getJSON(encodeURI(url), function(json){//cookieֵ�������Ļ��õ�
			//alert(json["result"]);
		});

	});
};
//��enter�ύ
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

//��¼��֤ͨ��
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
	//important  ajax���������ѵ�¼����
	$.ajax({
				type : "get",
				async:false,
				url : "http://tg.zhengjin99.com/zhengjin/user/userInfo_ajax.jsp",
				dataType : "jsonp",
				jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
				jsonpCallback:"success_callback2",//callback��function����
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

//��վͷ��δ��¼
/*zjgjs.sso.beforeLoginHtml = function() {
	var locationUrl=window.location.href;
	var html = '<input type="button" value="��¼" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/login.jsp?redirect='+locationUrl+'\'" class="login fl" name=""><input type="button" value="ע��" onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/register.jsp\'" class="register fl" name=""><span class="fl">|</span><span class="ml5 fl"><a href="http://tg.zhengjin99.com/zhengjin/user/"><span class="fl">��������</span><img src="/images2014/bonus_15.png" class="fl" style="margin-top: 3px;margin-left:2px;"></a></span>';
	return html;
};*/
zjgjs.sso.beforeLoginHtml=function(){
	var html = '';
	return html;
	}

//��վͷ���ѵ�¼
/*zjgjs.sso.afterLoginHtml = function() {
	userPhone = cookie("WEBSSO_LID");
	var str="";	
	if (userPhone != "" && userPhone != null) {
		userPhone = userPhone.substring(0, 3) + "****" + userPhone.substring(7);
	}
	var html = '<span class="fl mr10"><a href="http://tg.zhengjin99.com/zhengjin/user/">���ã� '+userPhone+'</a></span><a href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp"><span class="fl mr10">��Ϣ<span class="red" id="Messages"></span></span></a><input type="button" value="�˳�" onclick="zjgjs.sso.loginOut(\'\')" class="login fl" name=""><span class="fl">|</span><span class="ml5 fl"><a href="http://tg.zhengjin99.com/zhengjin/user/"><span class="fl">��������</span><img src="/images2014/bonus_15.png" class="fl" style="margin-top: 3px;margin-left:2px;"></a></span>';
	return html;
};*/
zjgjs.sso.afterLoginHtml = function() {
	
	var html = '';
	return html;
};
//�ǳ�
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

//��¼���
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




var commonPhone2 = "�����������ֻ�����";
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
			alert('��ݷ�ʽ���ֻ�ܴ��6����');
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
			jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
			jsonpCallback:"success_callback",//callback��function����
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
			titleName='�ʺ���ֲ�������ͷ���';
			break;
		case 2:
			titleName='�ʺ���ֲ����Ǽ��Ƶ�Ԥ��';
			break;
		case 3:
			titleName='ר�Ҷ���';
			break;
		case 4:
			titleName='VIPר������';
			break;
		case 5:
			titleName='VIPֱ����';
			break;
		case 6:
			titleName='�ͻ��ػ�';
			break;
		case 7:
			titleName='VIPͶ���ڲ�';
			break;
		case 8:
			titleName='�ʺ���ֲ���Ʒ����ɳ��';
			break;
		case 9:
			titleName='��������';
			break;
		case 10:
			titleName='��������';
			break;
		case 11:
			titleName='Ͷ�ʲ��Ա���';
			break;
		case 12:
			titleName='�󿧹�����';
			break;
		case 13:
			titleName='�ͷ�ר��';
			break;
		case 14:
			titleName='�绰ί���µ�';
			break;
		case 15:
			titleName='�����̳�';
			break;
		case 16:
			titleName='��������';
			break;
		/*case 17:
			titleName='���������';
			break;*/
		case 17:
			titleName='����������';
			break;
		case 18:
			titleName='֤������';
			break;
		case 19:
			titleName='���߽���';
			break;
		case 20:
			titleName='������ѯ';
			break;
		case 21:
			titleName='֤��ѧԺ';
			break;
		case 22:
			titleName='�ƾ�����';
			break;
		case 23:
			titleName='�Ƹ��ܿ�';
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
		smallServive=smallServive+'<img src="../images2014/fwzx_small_0'+n+'.jpg">';		//�Ķ�
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
		jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
		jsonpCallback:"callback_msg",//callback��function����
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
function addCookieLong(objName, objValue, objHours) { // ���cookie��ʱ��Ϊ����
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
//�Ҳม��
function getprogram(){
	
	$.ajax({
		type : "get",
		async:false,
		url:"http://vd.jrj.com/front/out/index_zbsy.jsp",
		dataType : "jsonp",
		jsonp: "callback",//��������ڽ���callback���õ�function���Ĳ���
		jsonpCallback:"callback_program",//callback��function����
		success:function(jsons){
			var json=jsons.news;
			var li = "";
			if(json === null){// 2016-9-3 ����ƽ���������ݷ���ʱ�쳣����
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

