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
//绑定enter提交
function BindEnter(obj){
    //使用document.getElementById获取到按钮对象
    //var button = document.getElementById('test');
    if(obj.keyCode == 13) {
		zjgjs.sso.login('');
		obj.returnValue = false;
        }

}
//绑定enter提交   首页的弹窗提交
function BindEnter2(obj){
    //使用document.getElementById获取到按钮对象
    //var button = document.getElementById('test');
    if(obj.keyCode == 13) {
		zjgjs.sso.login('2');
		obj.returnValue = false;
        }

}

// close layer when click-out
document.onclick = mclose; 
// -->
