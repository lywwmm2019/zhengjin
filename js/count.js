var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?5144e5a6b26c127789c43502a4742f90";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
function getCookie(name)//ȡcookies����        
{
	var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
	 if(arr != null) return unescape(arr[2]); return null;
}
	init(2);
	function init(n){
		var _maq = _maq || [];
		var params = {};
		
		//�û�����   1 ��ʱ����  2 ��ʼ��
 		params.sdate = n || 0; 
		
		params.ssoid = getCookie('WEBSSO_UID') || '';
		
		//Document��������
		if(document) {
			params.domain = document.domain || ''; 
			params.url = escape(document.URL) || ''; 
			params.title = escape(document.title) || ''; 
			params.referrer = escape(document.referrer) || ''; 
		}   
		//Window��������
		if(window && window.screen) {
			params.sh = window.screen.height || 0;
			params.sw = window.screen.width || 0;
			params.cd = window.screen.colorDepth || 0;
		}   
		//navigator��������
		if(navigator) {
			params.lang = navigator.language || ''; 
		}  
		
		//ƴ�Ӳ�����
		var args = ''; 
		for(var i in params) {
			if(args != '') {
				args += '&';
			}   
			
			args += i + '=' + encodeURIComponent(params[i]);
		}   
		
		//ͨ��Image���������˽ű�
		var img = new Image(1, 1); 
		img.src = 'http://lga.zhengjin99.com/1.gif?' + args;
	}