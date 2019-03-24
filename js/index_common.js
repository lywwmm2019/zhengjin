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
	var cookieArray = document.cookie.split("; "); // �õ��ָ��cookie��ֵ��
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
	document.cookie = cookieVal;
}

function SetCookies(name, value)// ����������һ����cookie�����ӣ�һ����ֵ
{
	var Days = 30; // �� cookie �������� 30 ��
	var exp = new Date(); // new Date("December 31, 9998");
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires="
			+ exp.toGMTString();
}

/*function getCookie(name)// ȡcookies����
{
	var arr = document.cookie
			.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
	if (arr != null)
		return unescape(arr[2]);
	return null;
}*/

function delCookie(name)// ɾ��cookie
{
	/**
	 * var exp = new Date(); exp.setTime(exp.getTime() - 1); var
	 * cval=getCookie(name); if(cval!=null) document.cookie= name +
	 * "="+cval+";expires="+exp.toGMTString();
	 */
	setCookie(name, "", null, "/", ".zhengjin99.com", "");
}

zjgjs.sso.login = function(index) {
	var passport = $("#passport" + index).val();
	var password = $("#password" + index).val();
	if(password != null && password != "")
		password=password.toLowerCase();
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID="
			+ passport + "&Passwd=" + zjgjs.md5(password);
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		userType = userJson.userType;
		regTime = userJson.regTime;
		addCookie("WEBSSO_ZJUSERNAME", userName, 0);
		addCookie("WEBSSO_UID", sso_userID, 0);
		addCookie("WEBSSO_USERTYPE", userType, 0);
		addCookie("WEBSSO_REGTIME", regTime, 0);
		if (sso_userID == 0 || sso_userID == "" || userName == null) {
			alert("�û������������");
			return false;
		} else {
			addCookie("WEBSSO_LID", passport, 0);
			if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(password)){
				openInitpwd();
			}
			zjgjs.sso.loginOk();
			// TODO ���ﻹ��Ҫ��ֱ����ϵͳ��һ����¼������
			/*var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/login.do?mobile="
					+ passport + "&password=" + password + "&userName="
					+ userName + "&isCms=true";
			$("#zhiboIframe").attr("src", zhiboSrc);

			setTimeout(function() {
				location.reload();
			}, 3000);*/
			var url = "http://zhibo.zhengjin99.com/hxzb/otherlogin.do?mobile="+ passport +"&password=" + zjgjs.md5(password) + "&userName=" + userName + "&jsoncallback=?";
			jQuery.getJSON(encodeURI(url), function(json){
				//alert(json["result"]);
			});

		}
	});
};

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
				window
						.open("http://zhibo.zhengjin99.com/hxzb/live/intoRoom.do?roomid="
								+ roomid + "&userid=" + hxzbId2);
			} else {
				/*if (confirm("��û�й�ע��ֱ���ң��޷�����ʵʱֱ�����Ƿ������ʷֱ��������ܰ��ʾ�������Խ�����ʷֱ���˽Ⲣ��ע��ֱ���ҡ���")) {
					$("#testroomid").val(roomid);
					$("#testform").submit();
				}*/
				curRoomId = roomid;
				confirm("��û�й�ע��ֱ���ң��޷�����ʵʱֱ�����Ƿ������ʷֱ��������ܰ��ʾ�������Խ�����ʷֱ���˽Ⲣ��ע��ֱ���ҡ���","http://zhibo.zhengjin99.com/hxzb/hxzb_lishi.jsp?roomid=" + curRoomId);
			}
		} else {// �����˻�Ϊע��3��ģ��2��ʵ��δ����1 �����˻����ܲ鿴��ʷֱ��
			window
					.open("http://zhibo.zhengjin99.com/hxzb/history/liShiDetail.do?roomid="
							+ roomid);
		}
	} else {// δ��¼
		/*alert("������½��鿴");
		$("#popLoginWin").fadeIn();*/
		window.open("http://zhibo.zhengjin99.com/hxzb/history/liShiDetail.do?roomid="
							+ roomid);
	}
};

function submitRoomId(){
	//var nows = new Date().getTime();
	$("#testformDiv").html('<form style="display:none;" action="http://zhibo.zhengjin99.com/hxzb/hxzb_lishi.jsp" method="get" target="_blank"><input type="hidden" id="testroomid" name="roomid" value="' + curRoomId + '"></form><script>setTimeout(function(){$("#testformDiv").find("form").submit();},300);</script>');
	
	//$("#testroomid").val(curRoomId);
	$("#testform").html('<input type="hidden" id="testroomid" name="roomid" value="' + curRoomId + '">');
	$("#testform").submit();	
}

zjgjs.sso.login2 = function(passport, password) {
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID="
			+ passport + "&Passwd=" + zjgjs.md5(password);
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		userType = userJson.userType;
		regTime = userJson.regTime;
		addCookie("WEBSSO_ZJUSERNAME", userName, 0);
		addCookie("WEBSSO_UID", sso_userID, 0);
		addCookie("WEBSSO_USERTYPE", userType, 0);
		addCookie("WEBSSO_REGTIME", regTime, 0);
		if (sso_userID == 0 || sso_userID == "" || userName == null) {
			alert("�û������������");
			return false;
		}
		addCookie("WEBSSO_LID", passport, 0);
		zjgjs.sso.loginOk();
		// TODO ���ﻹ��Ҫ��ֱ����ϵͳ��һ����¼������
		/*var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/login.do?mobile="
				+ passport + "&password=" + password + "&userName=" + userName
				+ "&isCms=true";
		$("#zhiboIframe").attr("src", zhiboSrc);


		setTimeout(function() {
			location.reload();
		}, 3000);*/
		var url = "http://zhibo.zhengjin99.com/hxzb/otherlogin.do?mobile="+ passport +"&password=" + zjgjs.md5(password) + "&userName=" + userName + "&jsoncallback=?";
		jQuery.getJSON(encodeURI(url), function(json){
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
zjgjs.sso.loginOk = function() {
	$("#loginInfos").html(zjgjs.sso.afterLoginHtml());
	if($('#zhibo_lists').hasClass('bx_container')){changeLoopInfo();}
	$("#popLoginWin").hide();
	if (zjgjs.sso.afterLoginOk) {
		zjgjs.sso.afterLoginOk();
	}
};
zjgjs.sso.beforeLoginHtml = function() {
	//var html = '<div style="*width:585px;" class="fr"><div class="fr">�ֻ���<input id="passport" name="" type="text" maxlength="11" class="input_txt" />����<input id="password" onkeypress="BindEnter(event)" name="" type="password" class="input_txt" /><input name="" type="button" class="input_zcbtn" value="��¼"  onclick="zjgjs.sso.login(\'\')" /><input type="button" class="input_loginbtn" value="ע��" onclick="window.open(\'http://tg.zhengjin99.com/zhengjin/sign_up.jsp\')" /><input name="" type="button" class="input_grzx" value="��������"  onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/\'" /><input name="" type="button" class="input_grzx" value="�����̳�"  onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/mall/\'" /><a href="http://tg.zhengjin99.com/zhengjin/findpwd.jsp" class="find_pwd">�һ�����</a></div><div class="clear"></div></div>';
	var html=''
	//return html;
};
zjgjs.sso.afterLoginHtml = function() {
	userPhone = cookie("WEBSSO_LID");
	var str="";	
	if (userPhone != "" && userPhone != null) {
		userPhone = userPhone.substring(0, 3) + "****" + userPhone.substring(7);
	}
	var html = '<div style="*width:405px;" class="fr"><span class="mr5">'+userPhone+'</span>���ã���ӭ������<input class="input_zcbtn ml5" type="button" value="�˳�" name=""  onclick="zjgjs.sso.loginOut(\'\')"><a href="http://tg.zhengjin99.com/zhengjin/modify_password.jsp" class="find_pwd">�޸�����</a></div>';
	var num_url = "http://tg.zhengjin99.com/zhengjin/user/mail_ajax.jsp";
	$.getScript(num_url, function(){
		if(json.nrnum>0){
			str='<a style="margin-left:5px;" href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp">��Ϣ<span style="float:none;margin:0;font-size:12px;color:#f00;font-weight:bold;">(��)</span></a>';
		}
		else{
			str='<a style="margin-left:5px;margin-right:5px;" href="http://tg.zhengjin99.com/zhengjin/user/xxzx.jsp">��Ϣ</a>';
		}
		html = '<div style="*width:500px;" class="fr"><span class="mr5">'+userPhone+'</span>���ã���ӭ������'+str+'<input class="input_zcbtn ml5" type="button" value="�˳�" name=""  onclick="zjgjs.sso.loginOut(\'\')"><input name="" type="button" class="input_grzx" value="��������"  onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/user/\'" /><input name="" type="button" class="input_grzx" value="�����̳�"  onclick="location.href=\'http://tg.zhengjin99.com/zhengjin/mall/\'" /><a href="http://tg.zhengjin99.com/zhengjin/modify_password.jsp" class="find_pwd">�޸�����</a></div>';
		$("#loginInfos").html('');
		//return html;
	});
};
zjgjs.sso.loginOut = function(index) {
	/*var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?action=logout";
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		delCookie("WEBSSO_ATTENTION_LIVEIDGOURP");
		delCookie("WEBHXZB_USERID");
		delCookie("WEBHXZB_UMOBILE");
		delCookie("WEBHXZB_USERTYPE");
		delCookie("WEBHXZB_USERNAME");
		delCookie("WEBHXZB_UROOMS");
		delCookie("WEBHXZB_USERFLAG");
		delCookie("WEBHXZB_USERBALANCE");
		delCookie("WEBHXZB_USERTRA");
		delCookie("WEBHXZB_LOGINTIME");
		delCookie("WEBHXZB_USERMARKET");
		$("#loginInfos").html(zjgjs.sso.beforeLoginHtml());;*/
		// TODO ���ﻹ��Ҫ��ֱ����ϵͳ��һ���˳�������
		/*var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/out.do?isCms=true";
		$("#zhiboIframe").attr("src", zhiboSrc);

		setTimeout(function() {
			location.reload();
		}, 3000);*/
	/*});*/
	var _userId = getCookie("WEBHXZB_USERID");
		delCookie("OPERATOR_"+_userId);
		delCookie("WEBSSO_ZJUSERNAME");
		delCookie("WEBSSO_UID");
		delCookie("WEBSSO_LID");
		delCookie("WEBHXZB_USERID");
		delCookie("WEBHXZB_UMOBILE");
		delCookie("WEBHXZB_USERTYPE");
		delCookie("WEBHXZB_UROOMS");
		delCookie("WEBHXZB_USERFLAG");
		delCookie("WEBHXZB_USERBALANCE");
		delCookie("WEBHXZB_USERTRA");
		delCookie("WEBHXZB_USERMARKET");
		delCookie("WEBHXZB_LOGINTIME");
		delCookie("VIPTypeID");
		delCookie("WEBSSO_NICKNAME");
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?action=logout";
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		$("#loginInfos").html('');
		if($('#zhibo_lists').hasClass('bx_container')){changeLoopInfo();}
	});
};
zjgjs.sso.init = function() {
	userName = cookie("WEBSSO_ZJUSERNAME");// getCookie("WEBSSO_ZJUSERNAME");
	sso_userID = cookie("WEBSSO_UID");
	if (sso_userID == null || sso_userID == 0 || sso_userID == ""
			|| userName == null || userName == "") {
		// $("#popLoginWin").show();
		$("#loginInfos").html('');
	} else {
		zjgjs.sso.loginOk();
	}
};

zjgjs.sso.login_ydtx = function(index){
	var passport = $("#passport_ydtx" + index).val();
	var passord = $("#password_ydtx" + index).val();
	if(passord != null && passord != "")
		passord=passord.toLowerCase();
	var loginin_url = "http://sso.zhengjin99.com/websso/ajaxlogin?mode=ajax&LoginID="
						+ passport + "&Passwd=" + zjgjs.md5(passord);
	$.getScript(loginin_url, function() {
		sso_userID = userJson.sso_userID;
		userName = userJson.userName;
		userType = userJson.userType;
		regTime2 = userJson.regTime;
		addCookie("WEBSSO_ZJUSERNAME",userName,0);
		addCookie("WEBSSO_UID",sso_userID,0);
		addCookie("WEBSSO_USERTYPE",userType,0);
		addCookie("WEBSSO_REGTIME",regTime2,0);
		if(userJson.state == 0){
			if(userType){
				userTypeInt = userType;
			}
			if(regTime2){
				regTime = 	regTime2.substr(0,4) + "-" + regTime2.substr(4,2) + "-" + regTime2.substr(6,2);
				//alert(regTime);
			}	
		}
		if (sso_userID == 0 || sso_userID == ""
				|| userName == null) {
			$("#passport_ydtx" + index).val("");
			$("#password_ydtx" + index).val("");
			alert("�û������������");
			return false;
		}
		if(userType!=-1){
			$("#passport_ydtx" + index).val("");
			$("#password_ydtx" + index).val("");
			alert("�û������������");
		}else{
			if("dc483e80a7a0bd9ef71d8cf973673924" == zjgjs.md5(passord)){
				openInitpwd();
			}
			//TODO ���ﻹ��Ҫ��ֱ����ϵͳ��һ����¼������
			/*var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/login.do?mobile="+ passport +"&password=" + passord + "&userName=" + userName +"&usertype=" +userType + "&isCms=true";
			$("#zhiboIframe").attr("src",zhiboSrc);*/
			
			/*$("#passport_ydtx" + index).val("");
			$("#password_ydtx" + index).val("");
			var oBox = document.getElementById('ydtx_box');
			var oBtn = document.getElementById('ydtx_btn');
			oBox.style.left = '-171px';
			oBtn.style.backgroundPosition = '0 -92px';*/

			/*var zhiboSrc = "http://zhibo.zhengjin99.com/hxzb/vip/viplogin.do?mobile="+ passport +"&password=" + passord;
			$("#zhiboIframe").attr("src",zhiboSrc);
			window.location = "http://zhibo.zhengjin99.com/hxzb/viplogin.do";*/

			//setTimeout("jumpToZhiBo()",2500);
			else{
				$("#ydtx_mobile").val(passport);
				$("#ydtx_password").val(zjgjs.md5(passord));
	
				$("#ydtx_userType").val(userType);
				$("#ydtx_userName").val(userName);
				$("#zhibo_jump").submit();
			}			
		}
		
		
		//$("#login_win").hide();
		
		//$("#show").click();
		
		
		//$("#zhibo_jump").attr("action","http://www.zhengjin99.com/");
		
		//window.open("http://www.zhengjin99.com/","_blank");
		//window.location = "http://zhibo.zhengjin99.com/hxzb/";
		
		//$("#zhibo_jump").submit();
		
	});
};
function jumpToZhiBo(){
	//window.location.reload();
	//window.open("http://zhibo.zhengjin99.com/hxzb/");
	window.location = "http://zhibo.zhengjin99.com/hxzb/viplogin.do";
}

$(document).ready(function() {
	zjgjs.sso.init();
});

