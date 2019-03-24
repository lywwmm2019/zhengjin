//  主调用函数是 setday(this,[OutputObject])和setday(this)，[OutputObject]是控件输出的控件名，举两个例子：
//  一、<input name=txt><input type=buEventOutputObjon value=setday onclick="setday(this,document.all.txtDateTime)">
//  二、<input onfocus="setday(this)">
//  三、修改源代码，增加FireFox的功能，已IE和FireFox测试都成功！
//===========================================================================================================
var bMoveable=true;
var strFrame;

document.writeln('<iframe id="endDateLayer" frameborder=0 width=162 height=211 style="position: absolute; top:500px;left:500px;z-index: 9998; display:none "></iframe>');
strFrame='<style>';
strFrame+='INPUT.button{BORDER-RIGHT: #63A3E9 1px solid;BORDER-TOP: #63A3E9 1px solid;BORDER-LEFT: #63A3E9 1px solid;';
strFrame+='BORDER-BOTTOM: #63A3E9 1px solid;BACKGROUND-COLOR: #63A3E9;font-family:宋体;}';
strFrame+='TD{FONT-SIZE: 9pt;font-family:宋体;}';
strFrame+='</style>';

if (CheckBrowser()=='IE')
{
strFrame+='<scr' + 'ipt>';
strFrame+='var datelayerx,datelayery;';
strFrame+='var bDrag;';
strFrame+='function document.onmousemove()';
strFrame+='{';
strFrame+=' if(bDrag && window.event.button==1)';
strFrame+=' {';
strFrame+='     var DateLayer=parent.document.all.endDateLayer.style;';
strFrame+='     DateLayer.posLeft += window.event.clientX-datelayerx;';
strFrame+='     DateLayer.posTop += window.event.clientY-datelayery;';
strFrame+=' }';
strFrame+='}';
strFrame+='function DragStart()';
strFrame+='{';
strFrame+='     DateLayer=parent.document.all.endDateLayer.style;';
strFrame+='     datelayerx=window.event.clientX;';
strFrame+='     datelayery=window.event.clientY;';
strFrame+='     bDrag=true;';
strFrame+='}';
strFrame+='function DragEnd()';
strFrame+='{';
strFrame+='     bDrag=false;';
strFrame+='}';
strFrame+='</scr' + 'ipt>';
}
else    //firefox
{
strFrame+='<scr' + 'ipt>';
strFrame+='var datelayerx,datelayery;';
strFrame+='var bDrag;';
strFrame+='var lastIndexof,x,y;';
strFrame+='var Left=0,Top=0;';
strFrame+='document.onmousemove=omm; function omm(event)';
strFrame+='{';
strFrame+=' if(bDrag && event.button==0)';
strFrame+=' {';
strFrame+='     var DateLayer=parent.document.getElementById("endDateLayer").style;  ';
strFrame+='     lastIndexof=DateLayer.left.lastIndexOf("p"); x=DateLayer.left.substring(0,lastIndexof); ';
strFrame+='     Left=parseInt(x)+event.clientX-datelayerx; DateLayer.left=Left+"px";    ';
strFrame+='     lastIndexof=DateLayer.top.lastIndexOf("p"); y=DateLayer.top.substring(0,lastIndexof); ';
strFrame+='     Top = parseInt(y)+event.clientY-datelayery; DateLayer.Top=y+"px" ; ';
strFrame+=' }';
strFrame+='}';
strFrame+='function DragStart(event)';
strFrame+='{';
strFrame+='     DateLayer=parent.document.getElementById("endDateLayer").style;';
strFrame+='     datelayerx=event.clientX; ';
strFrame+='     datelayery=event.clientY; ';
strFrame+='     bDrag=true;';
strFrame+='}';
strFrame+='function DragEnd()';
strFrame+='{';
strFrame+='     bDrag=false;';
strFrame+='}';
strFrame+='function showmessage()  ';
strFrame+='{ ';
strFrame+='    alert("test message"); ';
strFrame+='} ';
strFrame+='</scr' + 'ipt>';
}


strFrame+='<div style="z-index:9999;position: absolute; left:0; top:0; overflow:hidden;" onselectstart="return false">';
strFrame+='<span id=tmpSelectYearLayer style="z-index: 9999;position: absolute;top: 3; left: 19;display: none"></span>';
strFrame+='<span id=tmpSelectMonthLayer style="z-index: 9999;position: absolute;top: 3; left: 78;display: none"></span>';
strFrame+='<span id=tmpSelectHourLayer style="z-index: 9999;position: absolute;top: 188; left: 35px;display: none"></span>';
strFrame+='<span id=tmpSelectMinuteLayer style="z-index:9999;position:absolute;top: 188; left: 77px;display: none"></span>';
strFrame+='<span id=tmpSelectSecondLayer style="z-index:9999;position:absolute;top: 188; left: 119px;display: none"></span>';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#63A3E9 bgcolor=#63A3E9 >';
strFrame+='    <tr><td width=142 height=23 bgcolor=#FFFFFF>';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=158 height=23>';
strFrame+='            <tr align=center >';
strFrame+='                <td width=16 align=center bgcolor=#63A3E9 style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='        onclick="parent.meizzPrevM()" title="向前翻 1 月" ><b >&lt;</b></td>';
strFrame+='       <td width=60 align="center" bgcolor="#63A3E9" style="font-size:12px;cursor:hand" ';
strFrame+='           onmouseover="style.backgroundColor=\'#aaccf3\'"';
strFrame+='        onmouseout="style.backgroundColor=\'#63A3E9\'" ';
strFrame+='        onclick="parent.tmpSelectYearInnerHTML(this.innerHTML.substring(0,4))" ';
strFrame+='        title="点击这里选择年份"><span id=meizzYearHead></span></td>';
strFrame+='       <td width=48 align="center" style="font-size:12px;font-color: #ffffff;cursor:hand" ';
strFrame+='        bgcolor="#63A3E9" onmouseover="style.backgroundColor=\'#aaccf3\'" ';
strFrame+='        onmouseout="style.backgroundColor=\'#63A3E9\'" ';
strFrame+='        onclick="parent.tmpSelectMonthInnerHTML(this.innerHTML.length==3?this.innerHTML.substring(0,1):this.innerHTML.substring(0,2))"';
strFrame+='        title="点击这里选择月份"><span id=meizzMonthHead ></span></td>';
strFrame+='       <td width=16 bgcolor=#63A3E9 align=center style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='        onclick="parent.meizzNextM()" title="向后翻 1 月" ><b >&gt;</b></td>';
strFrame+='      </tr>';
strFrame+='     </table></td></tr>';
strFrame+='    <tr><td width=142 height=18 >';

if (CheckBrowser()=='IE')
{
strFrame+='   <table border=0 cellspacing=0 cellpadding=2 bgcolor=#63A3E9 ' + (bMoveable? 'onmousedown="DragStart()" onmouseup="DragEnd()"':'');
strFrame+='   BORDERCOLORLIGHT=#63A3E9 BORDERCOLORDARK=#FFFFFF width=140 height=20 style="cursor:' + (bMoveable ? 'move':'default') + '">';
strFrame+='   <tr>';
strFrame+='     <td style="font-size:12px;color:#ffffff" width=20>&nbsp;日</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;一</td><td style="font-size:12px;color:#FFFFFF">&nbsp;二</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;三</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;四</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;五</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;六</td>';
strFrame+='   </tr>';
strFrame+='   </table>';
}
else  //firefox
{
strFrame+='   <table border=0 cellspacing=0 cellpadding=2 bgcolor=#63A3E9 ' + (bMoveable? 'onmousedown="DragStart(event)" onmouseup="DragEnd()"':'');
strFrame+='   BORDERCOLORLIGHT=#63A3E9 BORDERCOLORDARK=#FFFFFF width=140 height=20 style="cursor:' + (bMoveable ? 'move':'default') + '">';
strFrame+='   <tr>';
strFrame+='     <td style="font-size:12px;color:#ffffff" width=20>&nbsp;日</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;一</td><td style="font-size:12px;color:#FFFFFF">&nbsp;二</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;三</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;四</td>';
strFrame+='     <td style="font-size:12px;color:#FFFFFF" >&nbsp;五</td><td style="font-size:12px;color:#FFFFFF" >&nbsp;六</td>';
strFrame+='   </tr>';
strFrame+='   </table>';
}


strFrame+='</td></tr>';
strFrame+=' <tr ><td width=142 height=120 >';
strFrame+='    <table border=1 cellspacing=2 cellpadding=2 BORDERCOLORLIGHT=#63A3E9 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 >';
var n=0; for (j=0;j<5;j++){ strFrame+= ' <tr align=center >'; for (i=0;i<7;i++){
strFrame+='<td width=20 height=20 id=meizzDay'+n+' style="font-size:12px" onclick=parent.meizzDayClick(this.innerHTML,0)></td>';n++;}
strFrame+='</tr>';}
strFrame+='      <tr align=center >';
for (i=35;i<37;i++)strFrame+='<td width=20 height=20 id=meizzDay'+i+' style="font-size:12px" onclick="parent.meizzDayClick(this.innerHTML,0)"></td>';
strFrame+='        <td colspan=5 align=right style="color:#1478eb"><span onclick="parent.setNull()" style="font-size:12px;cursor: hand"';
strFrame+='         onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" title="将日期置空">置空</span>&nbsp;&nbsp;<span onclick="parent.meizzToday()" style="font-size:12px;cursor: hand"';
strFrame+='         onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" title="当前日期时间">当前</span>&nbsp;&nbsp;<span style="cursor:hand" id=evaAllOK onmouseover="style.color=\'#ff0000\'" onmouseout="style.color=\'#1478eb\'" onclick="parent.closeLayer()" title="关闭日历">关闭&nbsp;</span></td></tr>';
strFrame+='    </table></td></tr><tr ><td >';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% bgcolor=#FFFFFF height=22 >';
strFrame+='          <tr bgcolor="#63A3E9"><td id=bUseTimeLayer width=30 style="cursor:hand" title="点击这里启用/禁用时间"';
strFrame+='    onmouseover="style.backgroundColor=\'#aaccf3\'" align=center onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame+='     onclick="parent.UseTime(this)">';
strFrame+=' <span></span></td>';
strFrame+='             <td style="cursor:hand" onclick="parent.tmpSelectHourInnerHTML(this.innerHTML.length==3?this.innerHTML.substring(0,1):this.innerHTML.substring(0,2))"';
strFrame+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame+=' title="点击这里选择时间" align=center width=42>' ;
strFrame+='     <span id=meizzHourHead></span></td>';
strFrame+='             <td style="cursor:hand" onclick="parent.tmpSelectMinuteInnerHTML(this.innerHTML.length==3?this.innerHTML.substring(0,1):this.innerHTML.substring(0,2))"';
strFrame+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame+=' title="点击这里选择时间" align=center width=42>' ;
strFrame+='     <span id=meizzMinuteHead></span></td>';
strFrame+='             <td style="cursor:hand" onclick="parent.tmpSelectSecondInnerHTML(this.innerHTML.length==3?this.innerHTML.substring(0,1):this.innerHTML.substring(0,2))"';
strFrame+=' onmouseover="style.backgroundColor=\'#aaccf3\'" onmouseout="style.backgroundColor=\'#63A3E9\'"';
strFrame+=' title="点击这里选择时间" align=center width=42>' ;
strFrame+='     <span id=meizzSecondHead></span></td>';
strFrame+='    </tr></table></td></tr></table></div>';

document.getElementById("endDateLayer").contentWindow.document.writeln(strFrame);
document.getElementById("endDateLayer").contentWindow.document.close(); 

//====================================================定義變量區======================================================
var outObject;
var outButton; //点击的按钮
var outDate=""; //存放对象的日期
var bUseTime=true; //是否使用时间
var bImg="";//是否啟用時間按鈕的文字
//定义阳历中每个月的最大天数
var MonHead = new Array(12);	
//定義從1月到6月的最大天數
MonHead[0] = 31; MonHead[1] = 28; MonHead[2] = 31; MonHead[3] = 30; MonHead[4]  = 31; MonHead[5]  = 30;
//定義從7月到12月的最大天數
MonHead[6] = 31; MonHead[7] = 31; MonHead[8] = 30; MonHead[9] = 31; MonHead[10] = 30; MonHead[11] = 31;
//定义年的变量的初始值
var meizzTheYear=new Date().getFullYear(); 
//定义月的变量的初始值
var meizzTheMonth=new Date().getMonth()+1; 
//定义日的变量的初始值
var meizzTheDate=new Date().getDate();	
//定义小时变量的初始值	
var meizzTheHour=new Date().getHours();	
//定义分钟变量的初始值
var meizzTheMinute=new Date().getMinutes();
//定义秒变量的初始值
var meizzTheSecond=new Date().getSeconds();
//定义写日期的数组	
var meizzWDay=new Array(37);
//存放日历对象
var odatelayer=document.getElementById("endDateLayer").contentWindow;
//alert(odatelayer);
var bUseTimeLayer=odatelayer.document.getElementById("bUseTimeLayer");
//alert(bUseTimeLayer);
bImgSwitch();
bUseTimeLayer.innerHTML=bImg;
//====================================================//主调函数======================================================
function setday(tt,obj) //主调函数
{
    if (arguments.length > 2){alert("对不起！傳入本控件的参数太多！");return;}
    if (arguments.length == 0){alert("对不起！您沒有傳回本控件任何参数");return;}
    
    var dads = document.getElementById("endDateLayer").style;
    var th = tt;
    var ttop = tt.offsetTop; //TT控件的定位点高


    var thei = tt.clientHeight; //TT控件本身的高
    var tleft = tt.offsetLeft; //TT控件的定位点宽
    var ttyp = tt.type; //TT控件的类型

    while (tt = tt.offsetParent)
    {   
        ttop+=tt.offsetTop; 
        tleft+=tt.offsetLeft;
    }
    //決定控件顯示的坐標點
    dads.top = (ttyp=="image") ? ttop+thei+"px" : ttop+thei+6+"px";
    dads.left = tleft+"px";
    
    outObject = (arguments.length == 1) ? th : obj;
    outButton = (arguments.length == 1) ? null : th; //设定外部点击的按钮

    //根据当前输入框的日期显示日历的年月
    var reg = /^(\d+)-(\d{1,2})-(\d{1,2})/; //不含时间
    var r = outObject.value.match(reg);
    if(r!=null)
    {
        r[2]=r[2]-1;
        var d=new Date(r[1],r[2],r[3]);
        if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3])
        {
           outDate=d;
           parent.meizzTheYear = r[1];
           parent.meizzTheMonth = r[2];
           parent.meizzTheDate = r[3];
        }
        else
        {
           outDate="";
        }
        meizzSetDay(r[1],r[2]+1);
    }
    else
    {
        outDate="";
        meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);
    }
    dads.display = '';
    

    //判断初始化时是否使用时间,非严格验证
    //if (outObject.value.length>10)
    if (bUseTime)
    {
        bUseTime=true;
        bImgSwitch();
        //odatelayer.bUseTimeLayer.innerHTML=bImg;
       // odatelayer.getElementById("bUseTimeLayer").innerHTML=bImg;
        meizzWriteHead(meizzTheYear,meizzTheMonth);
        bUseTimeLayer.innerHTML=bImg;
    }
    else
    {
        bUseTime=false;
        bImgSwitch();
        bUseTimeLayer.innerHTML=bImg;
       // odatelayer.getElementById("bUseTimeLayer").innerHTML=bImg;
        meizzWriteHead(meizzTheYear,meizzTheMonth);
        bUseTimeLayer.innerHTML=bImg;
    }

    try
    {
        event.returnValue=false;
    }
    catch (e)
    {
        //此处排除错误，错误原因暂未找到。
        //alert(e);
    }
}
//===================================================控件按鈕事件========================================
//年份的下拉框
function tmpSelectYearInnerHTML(strYearTemp) 
{
    var strYear=GetValueByHTML(strYearTemp).substring(0,4);
	if (strYear.match(/\D/)!=null)
	{
	    alert("年份输入参数不是数字！");
	    return;
	}
	var m = (strYear) ? strYear : new Date().getFullYear();
	if (m < 1000 || m > 9999) {alert("年份值不在 1000 到 9999 之间！");return;}
	var n = m - 50;
	if (n < 1000) n = 1000;
	if (n + 101 > 9999) n = 9974;
	var s = "&nbsp;<select name=tmpSelectYear style='font-size: 12px' "
	s += "onblur='document.getElementById(\"tmpSelectYearLayer\").style.display=\"none\"' "
	s += "onchange='document.getElementById(\"tmpSelectYearLayer\").style.display=\"none\";"
	s += "parent.meizzTheYear = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
	var selectInnerHTML = s;
	for (var i = n; i < n + 101; i++)
	{
		if (i == m) { selectInnerHTML += "<option value='" + i + "' selected>" + i + "年" + "</option>\r\n"; }
		else { selectInnerHTML += "<option value='" + i + "'>" + i + "年" + "</option>\r\n"; }
	}
	selectInnerHTML += "</select>";
	var objSelectYearLayer=odatelayer.document.getElementById("tmpSelectYearLayer");
	objSelectYearLayer.style.display="";
	objSelectYearLayer.innerHTML = selectInnerHTML;
	objSelectYearLayer.focus();
}
//月份的下拉框
function tmpSelectMonthInnerHTML(strMonthTemp) //月份的下拉框
{
    var strMonth=GetValueByHTML(strMonthTemp).substring(0,2);
	if (strMonth.match(/\D/)!=null){alert("月份输入参数不是数字！");return;}
	var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
	var s = "&nbsp;&nbsp;&nbsp;<select name=tmpSelectMonth style='font-size: 12px' "
	s += "onblur='document.getElementById(\"tmpSelectMonthLayer\").style.display=\"none\"' "
	s += "onchange='document.getElementById(\"tmpSelectMonthLayer\").style.display=\"none\";"
	s += "parent.meizzTheMonth = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
	var selectInnerHTML = s;
	for (var i = 1; i < 13; i++)
	{
		if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"月"+"</option>\r\n"; }
		else { selectInnerHTML += "<option value='"+i+"'>"+i+"月"+"</option>\r\n"; }
	}
	selectInnerHTML += "</select>";
	var tmpSelectMonthLayer=odatelayer.document.getElementById("tmpSelectMonthLayer");
	tmpSelectMonthLayer.style.display="";
	tmpSelectMonthLayer.innerHTML = selectInnerHTML;
	odatelayer.document.getElementById("meizzMonthHead").focus();
}
//往前翻 Year
function meizzPrevY() 
{
    if(meizzTheYear > 999 && meizzTheYear <10000)
    {
        meizzTheYear--;
    }
    else
    {
        alert("年份超出范围（1000-9999）！");
    }
    meizzSetDay(meizzTheYear,meizzTheMonth);
}
//往后翻 Year
function meizzNextY() 
{
    if(meizzTheYear > 999 && meizzTheYear <10000)
    {
        meizzTheYear++;
    }
    else
    {
        alert("年份超出范围（1000-9999）！");
    }
    meizzSetDay(meizzTheYear,meizzTheMonth);
}
//往后翻月份
function meizzPrevM() //往前翻月份
{
    if(meizzTheMonth>1)
    {
        meizzTheMonth--
    }
    else
    {
        meizzTheYear--;meizzTheMonth=12;
    }
    meizzSetDay(meizzTheYear,meizzTheMonth);
}
//往后翻月份
function meizzNextM() 
{
    if(meizzTheMonth==12)
    {
        meizzTheYear++;meizzTheMonth=1}
    else
    {
        meizzTheMonth++
    }
    meizzSetDay(meizzTheYear,meizzTheMonth);
}
/***** 增加 小时、分钟 ***/
function tmpSelectHourInnerHTML(strHourTemp) //小时的下拉框
{
    var strHour=GetValueByHTML(strHourTemp).substring(0,2);

    if (!bUseTime){return;}

    if (strHour.match(/\D/)!=null){alert("小时参数不是数字！");return;}
    var m = (strHour) ? strHour : new Date().getHours();
    var s = "<select name=tmpSelectHour style='font-size: 12px' "
    s += "onblur='document.all.tmpSelectHourLayer.style.display=\"none\"' "
    s += "onchange='document.all.tmpSelectHourLayer.style.display=\"none\";"
    s += "parent.meizzTheHour = this.value; parent.evaSetTime(parent.meizzTheHour,parent.meizzTheMinute);'>\r\n";
    var selectInnerHTML = s;
    for (var i = 0; i < 24; i++)
    {
    if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
    else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
    }
    selectInnerHTML += "</select>";
    odatelayer.document.getElementById("tmpSelectHourLayer").style.display="";
    odatelayer.document.getElementById("tmpSelectHourLayer").innerHTML = selectInnerHTML;
    odatelayer.document.getElementById("tmpSelectHour").focus();
}
//分钟的下拉框
function tmpSelectMinuteInnerHTML(strMinuteTemp) 
{
    var strMinute=GetValueByHTML(strMinuteTemp).substring(0,2);

    if (!bUseTime){return;}

    if (strMinute.match(/\D/)!=null){alert("分钟输入数字不是数字！");return;}
    var m = (strMinute) ? strMinute : new Date().getMinutes();
    var s = "<select name=tmpSelectMinute style='font-size: 12px' "
    s += "onblur='document.all.tmpSelectMinuteLayer.style.display=\"none\"' "
    s += "onchange='document.all.tmpSelectMinuteLayer.style.display=\"none\";"
    s += "parent.meizzTheMinute = this.value; parent.evaSetTime(parent.meizzTheHour,parent.meizzTheMinute);'>\r\n";
    var selectInnerHTML = s;
    for (var i = 0; i < 60; i++)
    {
    if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
    else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
    }
    selectInnerHTML += "</select>";
    odatelayer.document.getElementById("tmpSelectMinuteLayer").style.display="";
    odatelayer.document.getElementById("tmpSelectMinuteLayer").innerHTML = selectInnerHTML;
    odatelayer.document.getElementById("tmpSelectMinute").focus();
}
//秒的下拉框
function tmpSelectSecondInnerHTML(strSecondTemp) 
{
    var strSecond=GetValueByHTML(strSecondTemp).substring(0,2);

    if (!bUseTime){return;}

    if (strSecond.match(/\D/)!=null){alert("秒钟输入不是数字！");return;}
    var m = (strSecond) ? strSecond : new Date().getMinutes();
    var s = "<select name=tmpSelectSecond style='font-size: 12px' "
    s += "onblur='document.all.tmpSelectSecondLayer.style.display=\"none\"' "
    s += "onchange='document.all.tmpSelectSecondLayer.style.display=\"none\";"
    s += "parent.meizzTheSecond = this.value; parent.evaSetTime(parent.meizzTheHour,parent.meizzTheMinute,parent.meizzTheSecond);'>\r\n";
    var selectInnerHTML = s;
    for (var i = 0; i < 60; i++)
    {
    if (i == m) { selectInnerHTML += "<option value='"+i+"' selected>"+i+"</option>\r\n"; }
    else { selectInnerHTML += "<option value='"+i+"'>"+i+"</option>\r\n"; }
    }
    selectInnerHTML += "</select>";
    odatelayer.document.getElementById("tmpSelectSecondLayer").style.display="";
    odatelayer.document.getElementById("tmpSelectSecondLayer").innerHTML = selectInnerHTML;
    odatelayer.document.getElementById("tmpSelectSecond").focus();
}
//開啟和關閉時間功能
function UseTime(ctl)
{
    bUseTime=!bUseTime;
    if (bUseTime)
    {
        bImgSwitch();
        ctl.innerHTML=bImg;
        evaSetTime(); //显示时间，用户原来选择的时间
        //evaSetTimeNow(); //显示当前时间
    }
    else
    {
        bImgSwitch();
        ctl.innerHTML=bImg;
        evaSetTimeNothing();
    }
}
//置空按鈕事件
function setNull()
{
    outObject.value = '';
    closeLayer();
}
//    當前日期和時間按鈕 Today Button
function meizzToday() 
{
    parent.meizzTheYear = new Date().getFullYear();
    parent.meizzTheMonth = new Date().getMonth()+1;
    parent.meizzTheDate = new Date().getDate();
    parent.meizzTheHour = new Date().getHours();
    parent.meizzTheMinute = new Date().getMinutes();
    parent.meizzTheSecond = new Date().getSeconds();
    var meizzTheSecond = new Date().getSeconds();

    if (meizzTheMonth<10 && meizzTheMonth.length<2) //格式化成两位数字
    {
        parent.meizzTheMonth="0"+parent.meizzTheMonth;
    }
    if (parent.meizzTheDate<10 && parent.meizzTheDate.length<2) //格式化成两位数字
    {
        parent.meizzTheDate="0"+parent.meizzTheDate;
    }
    //meizzSetDay(meizzTheYear,meizzTheMonth);
    if(outObject)
    {
        if (bUseTime)
        {
           outObject.value= parent.meizzTheYear + "-" + format( parent.meizzTheMonth) + "-" + 
               format(parent.meizzTheDate) + " " + format(parent.meizzTheHour) + ":" + 
               format(parent.meizzTheMinute) + ":" + format(parent.meizzTheSecond); 
               //注：在这里你可以输出改成你想要的格式
        }
        else
        {
           outObject.value= parent.meizzTheYear + "-" + format( parent.meizzTheMonth) + "-" + 
               format(parent.meizzTheDate); //注：在这里你可以输出改成你想要的格式
        }
    }
    closeLayer();
}
//这个层的关闭
function closeLayer() 
{
    var o = document.getElementById("endDateLayer");
    if (o != null)
    {
        o.style.display="none";
    }
}
//点击显示框选取日期，主输入函数*************
function meizzDayClick(nn,ex)
{
    var n=GetValueByHTML(nn);
    parent.meizzTheDate=n;
    var yy=meizzTheYear;
    var mm = parseInt(meizzTheMonth)+ex; //ex表示偏移量，用于选择上个月份和下个月份的日期
    var hh=meizzTheHour;
    var mi=meizzTheMinute;
    var se=meizzTheSecond;
    //判断月份，并进行对应的处理
    if(mm<1)
    {
        yy--;
        mm=12+mm;
    }
    else 
    if(mm>12)
    {
        yy++;
        mm=mm-12;
    }

    if (mm < 10)
    {
        mm = "0" + mm;
    }
    //时
    if (hh<10) 
    {
        hh="0" + hh;
    } 
    //分
    if (mi<10) 
    {
        mi="0" + mi;
    } 
    //秒
    if (se<10)
    {
        se="0" + se;
    } 


    if (outObject)
    {
        if (!n) 
        { //outObject.value=""; 
           return;
        }
        if ( n < 10)
        {
            n = "0" + n;
        }

        WriteDateTo(yy,mm,n,hh,mi,se);

        closeLayer(); 
        if (bUseTime)
        {
           try
           {
                outButton.click();
           }
           catch (e)
           {
                setday(outObject);
           }
        }
    }
    else 
    {
        closeLayer(); 
        alert("您所要输出的控件对象并不存在！");
    }
    closeLayer();
}
//任意点击时关闭该控件 //ie6的情况可以由下面的切换焦点处理代替
//parent.document.addEventListener("onclick ",oc,true) 
document.onclick=oc;
//function document.onclick() 
function oc(event) 
{
    event = (event == null)?window.event:event;
    with(event)
    {
        var srcObj= event.target?event.target:event.srcElement; 
        if (srcObj != outObject && srcObj != outButton)
        {
            closeLayer();
        }
    }
}
//按Esc键关闭，切换焦点关闭
document.onkeyup=oku;
////function document.onkeyup() 
function oku(event)
{
    event=window.event || event;
    
    if (event.keyCode==27)
    {
        if(outObject)outObject.blur();
        closeLayer();
    }
    else if(document.activeElement)
    {
        if(document.activeElement != outObject && document.activeElement != outButton)
        {
           closeLayer();
        }
    } 
}
//==================================tools function  area ==================================================
//是否啟用時間按鈕說明
function bImgSwitch()
{
    if (bUseTime)
    {
        bImg="关闭";
    }
    else
    {
        bImg="开启";
    }
}
//这个层的顯示
function showLayer() //这个层的关闭
{
    odatelayer.document.all["endDateLayer"].style.display="";
}
//格式化数字为两位字符表示
function format(n) 
{
    var m=new String();
    var tmp=new String(n);
    if (n<10 && tmp.length<2)
    {
        m="0"+n;
    }
    else
    {
        m=n;
    }
    return m;
}
// TODO: 整理代码 設定日期
function meizzSetDay(yy,mm)	//主要的写程序**********
{
	meizzWriteHead(yy,mm);
	//设置当前年月的公共变量为传入值
	meizzTheYear=yy;
	meizzTheMonth=mm;
    //将显示框的内容全部清空
	for (var i = 0; i < 37; i++)
	{
	    meizzWDay[i]=""
	};	

	var day1 = 1;
	var day2=1;
	//上个月的最后几天(上月最後一周的日期) 某月第一天的星期几,返回值為[0-6]
	var firstday = new Date(yy,mm-1,1).getDay();	
    //alert(firstday);
	for (i=0;i<firstday;i++)
	{
	    meizzWDay[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1	//上个月的最后几天
	}

	for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++) 
	{ 
	    meizzWDay[i]=day1;
	    day1++; 
	}
	for (i=firstday+GetMonthCount(yy,mm);i<37;i++) 
	{ 
	    meizzWDay[i]=day2;
	    day2++; 
	}
	for (i = 0; i < 37; i++)
	{
		//书写新的一个月的日期星期排列
		var da =odatelayer.document.getElementById("meizzDay"+i);
	    if (meizzWDay[i]!="")
	    {
		    //初始化边框
		    da.borderColorLight="#63A3E9";
		    da.borderColorDark="#63A3E9";
		    da.style.color="#1478eb";
		    if(i<firstday)		//上个月的部分
		    {
			    da.innerHTML="<b><font color=#BCBABC>" + meizzWDay[i] + "</font></b>";
			    da.title=(mm==1?12:mm-1) +"月" + meizzWDay[i] + "日";
			    da.onclick=Function("meizzDayClick(this.innerHTML,-1)");

			    if(!outDate)
				    da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() && 
					    (mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					     "#5CEFA0":"#f5f5f5";
			    else
			    {
				    da.style.backgroundColor =((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && 
				    meizzWDay[i]==outDate.getDate())? "#84C1FF" :
				    (((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && 
				    meizzWDay[i] == new Date().getDate()) ? "#5CEFA0":"#f5f5f5");
				    //将选中的日期显示为凹下去

				    if((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && 
				    meizzWDay[i]==outDate.getDate())
				    {
					    da.borderColorLight="#FFFFFF";
					    da.borderColorDark="#63A3E9";
				    }
			    }
		    }
		    else if (i>=firstday+GetMonthCount(yy,mm))		//下个月的部分
		    {
			    da.innerHTML="<b><font color=#BCBABC>" + meizzWDay[i] + "</font></b>";
			    da.title=(mm==12?1:mm+1) +"月" + meizzWDay[i] + "日";
			    da.onclick=Function("meizzDayClick(this.innerHTML,1)");
			    if(!outDate)
				    da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() && 
					    (mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					     "#5CEFA0":"#f5f5f5";
			    else
			    {
				    da.style.backgroundColor =((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && 
				    meizzWDay[i]==outDate.getDate())? "#84C1FF" :
				    (((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && 
				    meizzWDay[i] == new Date().getDate()) ? "#5CEFA0":"#f5f5f5");
				    //将选中的日期显示为凹下去

				    if((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && 
				    meizzWDay[i]==outDate.getDate())
				    {
					    da.borderColorLight="#FFFFFF";
					    da.borderColorDark="#63A3E9";
				    }
			    }
		    }
		    else		//本月的部分
		    {
			    da.innerHTML="<b>" + meizzWDay[i] + "</b>";
			    da.title=mm +"月" + meizzWDay[i] + "日";
			    da.onclick=Function("meizzDayClick(this.innerHTML,0)");		//给td赋予onclick事件的处理

			    //如果是当前选择的日期，则显示亮蓝色的背景；如果是当前日期，则显示暗黄色背景
			    if(!outDate)
				    da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					    "#5CEFA0":"#f5f5f5";
			    else
			    {
				    da.style.backgroundColor =(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())?
					    "#84C1FF":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					    "#5CEFA0":"#f5f5f5");
				    //将选中的日期显示为凹下去

				    if(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				    {
					    da.borderColorLight="#FFFFFF";
					    da.borderColorDark="#63A3E9";
				    }
			    }
		    }
			    da.style.cursor="hand"
		    }
		    else
		    {
		      da.innerHTML="";da.style.backgroundColor="";da.style.cursor="default"; 
		    }
	}	
}
//往 head 中写入当前的年与月
function meizzWriteHead(yy,mm,ss)	
{
	odatelayer.document.getElementById("meizzYearHead").innerHTML=yy+"年";
	odatelayer.document.getElementById("meizzMonthHead").innerHTML=format(mm) + " 月";
	//插入当前小时、分
	odatelayer.document.getElementById("meizzHourHead").innerHTML=bUseTime?(meizzTheHour+" 时"):"";
	odatelayer.document.getElementById("meizzMinuteHead").innerHTML=bUseTime?(meizzTheMinute+" 分"):"";
	odatelayer.document.getElementById("meizzSecondHead").innerHTML=bUseTime?(meizzTheSecond+" 秒"):"";
}
//格式化数字为两位字符表示
function format(n)	
{
	var m=new String();
	var tmp=new String(n);
	if (n<10 && tmp.length<2)
	{
		m="0"+n;
	}
	else
	{
		m=n;
	}
	return m;
}
//根據年月，得到本月的最大天數
function GetMonthCount(year,month)	//闰年二月为29天
{
	var c=MonHead[month-1];
	if((month==2)&&IsPinYear(year)) 
	c++;
	return c;
}
//判断是否闰平年
function IsPinYear(year)	
{
	if (0==year%4&&((year%100!=0)||(year%400==0))) 
	    return true;
	else 
	    return false;
}
//设置用户选择的小时、分钟
function evaSetTime()  
{
    var meizzHourHead=odatelayer.document.getElementById("meizzHourHead");
    var meizzMinuteHead=odatelayer.document.getElementById("meizzMinuteHead");
    var meizzSecondHead=odatelayer.document.getElementById("meizzSecondHead");
	meizzHourHead.innerHTML=meizzTheHour+" 时";
	meizzMinuteHead.innerHTML=meizzTheMinute+" 分";
	meizzSecondHead.innerHTML=meizzTheSecond+" 秒";
	WriteDateTo(meizzTheYear,meizzTheMonth,meizzTheDate,meizzTheHour,meizzTheMinute,meizzTheSecond)
}
//返回日期和時間
function WriteDateTo(yy,mm,n,hh,mi,se)
{
	if (bUseTime)
	{
		outObject.value= yy + "-" + format(mm) + "-" + format(n) + " " + format(hh) + ":" + format(mi) + ":" + format(se); //注：在这里你可以输出改成你想要的格式
	}
	else
	{
		outObject.value= yy + "-" + format(mm) + "-" + format(n); //注：在这里你可以输出改成你想要的格式
	}
}
//设置时间控件为空
function evaSetTimeNothing() //设置时间控件为空
{
    odatelayer.document.getElementById("meizzHourHead").innerHTML="";
    odatelayer.document.getElementById("meizzMinuteHead").innerHTML="";
    odatelayer.document.getElementById("meizzSecondHead").innerHTML="";
    WriteDateTo(meizzTheYear,meizzTheMonth,meizzTheDate,meizzTheHour,meizzTheMinute,meizzTheSecond)
}
//get vaule  by html content
function  GetValueByHTML(strContent)
{
    var strResult="";
    var strTemp=strContent.split('>');
    var i=(strTemp.length-1)/2;
    strResult=strTemp[i];
    var lastIndexOf=strResult.lastIndexOf('</') 
    strResult=strResult.substring(0,lastIndexOf);
    //alert(strResult);
    return strResult;   
}
//檢測瀏覽器
function CheckBrowser() 
{ 
    var app=navigator.appName; 
    var verStr=navigator.appVersion;
    var strResult=""; 
    //火狐浏览器 
    if (app.indexOf('Netscape') != -1) 
    { 
        strResult="FF";
    } 
    else
    {
        if (app.indexOf('Microsoft') != -1) 
        {
            strResult="IE";
        } 
        else 
        { 
            strResult="OTHER";
        } 
    }
    return strResult; 
}
//return datetime  of html content
function  GetContent()
{
    var txtObj=document.getElementById("txtContent").value=strFrame;
    var divObj=document.getElementById("divContent").innerHTML=strFrame;
}