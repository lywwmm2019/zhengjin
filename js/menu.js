// JavaScript Document
<!--
var timeout         = 500;
var closetimer		= 0;
var ddmenuitem      = 0;

// open hidden layer
function mopen(id)
{	
	// cancel close timer
	mcancelclosetime();

	// close old layer
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

	// get new layer and show it
	ddmenuitem = document.getElementById(id);
	ddmenuitem.style.visibility = 'visible';

}
// close showed layer
function mclose()
{
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}

// go close timer
function mclosetime()
{
	closetimer = window.setTimeout(mclose, timeout);
}

// cancel close timer
function mcancelclosetime()
{
	if(closetimer)
	{
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}
//��enter�ύ
function BindEnter(obj){
    //ʹ��document.getElementById��ȡ����ť����
    //var button = document.getElementById('test');
    if(obj.keyCode == 13) {
		zjgjs.sso.login('');
		obj.returnValue = false;
        }

}
//��enter�ύ   ��ҳ�ĵ����ύ
function BindEnter2(obj){
    //ʹ��document.getElementById��ȡ����ť����
    //var button = document.getElementById('test');
    if(obj.keyCode == 13) {
		zjgjs.sso.login('2');
		obj.returnValue = false;
        }

}

// close layer when click-out
document.onclick = mclose; 
// -->
