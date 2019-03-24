// JavaScript Document
	
window.onload=function()
{
for(var ii=0; ii<document.links.length; ii++)
document.links[ii].onfocus=function(){this.blur()}
}
var beitouInterval;
$(document).ready(function(){
	//更新视频和直播室信息
	//beitouInterval = setInterval(function(){changeBeitou();}, 10);
	var market=cookie('WEBHXZB_USERMARKET');
	var price=new Price();
	if(market==""){
		market=2;
	}
	//changeLoopInfo(market);
	getInfo();
	getXB();
	price.MinuteChart('1998263',1);
	price.getTable('1998263');
	//KChart();
	//setInterval(function(){changeLoopInfo();} , 1000 * 60);
	// 背投开始
});
$(document).ready(function(){
		var scrolltop;
		var hei=$(window).height();
		var h=$(document).height();
		var half_h=hei/2;
		if($.browser.msie&&$.browser.version=='6.0'){

		}
		
		//
		
		$('#zhibo_lists li').live('mouseenter',function(){
			$(this).find('.input').show();
			$(this).find('.txt').hide();
		})
		$('#zhibo_lists li').live('mouseleave',function(){
			$(this).find('.input').hide();
			$(this).find('.txt').show();
		})
		$('.propaganda_hide_btn').bind('click',function(){
			$(this).parent().hide();
			$('.propaganda_show').show();
		})
		$('.propaganda_show_btn').bind('click',function(){
			$(this).parent().hide();
			$('.propaganda_hide').show();
		})
		
		$('#nav li').bind({'mouseenter':function(){
			var navLiClass=$(this).attr('class').substring(3,4);
			if(navLiClass=='1'){
				$('.nav_second').hide();
			}
			else{
				$('.nav_second').show();
			}
			
			$('.nav_second p').hide();
			$('.nav_second p.nav_s'+navLiClass).show();
			//alert(navLiClass);
		}})
		
		
		$('#nav_second').bind({'mouseleave':function(e){
			$('.nav_second').hide();
			$('.nav_second p').hide();
		}})
		$('#nav').bind({'mouseleave':function(e){
			$('.nav_second').hide();
			$('.nav_second p').hide();
		}})
		
		quotationSlide();
	
	})

$(document).ready(function(){
	var url=window.location.href;
	var parameter=url.split('?');
	var type=parameter[1]?parameter[1].split('=')[1]:0;
	if(type==1){
		showDialog('提示','尊敬的客户，您的交易余额不足，已被暂停服务。为了方便您继续交易，请及时拨打010-58309199申请再次开通。祝您投资愉快!');
		window.location.href="http://www.zhengjin99.com";
	}
})

//贵金属行情图
function quotationSlide(){
	var price=new Price();
	var quotationNum=0;
	var quotationWidth=$('.index_quotation_num p span:first').width()+17;
	var quotationWidths=0;
	var quotationLength=$('.index_quotation_num p span').length;
	var dataQuotation='1998263';
	for(var i=0;i<quotationLength;i++){
		quotationWidths=quotationWidths+$('.index_quotation_num p span').eq(i).width()+17;
	}
	$('.index_quotation_num p').css('width',quotationWidths);
	//左箭头点击效果
	$('.prev').bind('click',function(){
		quotationNum--;
		if(quotationNum<0){
			quotationNum=0;
		}
		else{
			$('.index_quotation_num p').animate({left:-quotationNum*quotationWidth},500);
		}
	})
	//右箭头点击效果
	$('.next').bind('click',function(){
		quotationNum++;
		if(quotationNum>quotationLength-2){
			quotationNum=quotationLength-2;
		}
		else{
			$('.index_quotation_num p').animate({left:-quotationNum*quotationWidth},500);
		}
	})
	
	//贵金属标签点击
	$('.index_quotation_num p span').bind('click',function(){
		$('.index_quotation_num p span').removeClass('sl');
		$(this).addClass('sl');
		dataQuotation=$(this).attr('data-quotation');
		var dataChartSl=$('.index_quotation_chartsl p.sl').attr('data-chart');
		if(dataChartSl=='minute'){
			price.MinuteChart(dataQuotation,1);
		}
		else if(dataChartSl=='k'){
			price.KChart(dataQuotation,1);
		}
		price.getTable(dataQuotation);
	})
	
	//分时图及日K线切换
	$('.index_quotation_chartsl p').bind('click',function(){
		$('.index_quotation_chartsl p').removeClass('sl');
		$(this).addClass('sl');
		var dataChart=$(this).attr('data-chart');
		$('.index_quotation_chart').hide();
		$('[data-show='+dataChart+']').show();
		if(dataChart=='minute'){
			price.MinuteChart(dataQuotation,1);
		}
		else if(dataChart=='k'){
			price.KChart(dataQuotation,1);
		}
	})
	
	//3S刷新
	var tChart=setInterval(function(){
		price.MinuteChart(dataQuotation,1);
		//price.KChart(dataQuotation,1);
		price.getTable(dataQuotation);
	}, 10000);
}	
	
	
var commonPhoneInfo = "提交手机号获取最新行情预判";
var mobileRES = /^(((1[0-9]{1}[0-9]{1}))+\d{8})$/;
function focusPhone(){
	if($("#mobile").val() == commonPhoneInfo){
		$("#mobile").val("");
	}
}

function blurPhone(){
	if($("#btn").val() == ""){
		$("#btn").val(commonPhoneInfo);
	}
}
var mobile = '';
function isMobile(val) {
	var reg = /^1[34578]\d{9}$/;
	return reg.test(val);
}

$(function () {
	$("#mobile").watermark("请输入您的手机号码");

	$("#btn").click(function () {
	   	 mobile = $.trim($("#mobile").val());
		if (!isMobile(mobile)) {
			showDialog('提示','请输入正确的手机号码！');
			return false;
		}
        var url = "http://tg.zhengjin99.com/zhengjin/ws/put_resource_desc.jsp?callbackparam=?";
        $.getJSON(url, {mobile: mobile, activityId: 'tqbjsy_gjs_20141029', desc: '', isSms: 0}, function(data) {
        	console.log(data);
        });
		showDialog("提示","预约成功！\n稍后会有工作人员与您联系，\n请保持手机畅通。");
        $("#mobile").val('');
	});
});


function setTab(name,cursel,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  menu.className=i==cursel?"hover":"";
  con.style.display=i==cursel?"block":"none";
 }
}

//直播室轮播
/*function changeLoopInfo(zhiboType){
	//$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/gender_zhibolist_html_script_cache_new.jsp", function() {
	var tempZhibo=1;
	if(zhiboType==2){
		tempZhibo=1;
	}
	else if(zhiboType==1){
		tempZhibo=0;
	}
	$.getJSON("http://tg.zhengjin99.com/zhengjin/cmscall/zhibolist.jsp?callback=?", function(zhiboData) {
		//$("#zhibo_lists").html(zhiboLoopList);
		var zhiboLength=zhiboData.listLiveEx.length;
		var zhiboStr='';
		for(var i=0;i<zhiboLength;i++){
			if(zhiboData.listLiveEx[i].type!=2&&zhiboData.listLiveEx[i].m_live_id!=67&&zhiboData.listLiveEx[i].m_live_id!=69){
				zhiboStr=zhiboStr+'<li data-id="'+zhiboData.listLiveEx[i].m_live_id+'"><a href="javascript:zjgjs.sso.visitLiveHome('+zhiboData.listLiveEx[i].m_live_id+')"><img src="/images2014/'+zhiboData.listLiveEx[i].image+'" width="154" height="104" /></a><p class="tc"><a href="javascript:zjgjs.sso.visitLiveHome('+zhiboData.listLiveEx[i].m_live_id+')">'+zhiboData.listLiveEx[i].m_live_name+'</a></p><div class="tc hide input"><input name="" type="button" class="add" /><input name="" type="button" class="getin" onclick="zjgjs.sso.visitLiveHome('+zhiboData.listLiveEx[i].m_live_id+')" /></div><div class="tc txt">'+zhiboData.listLiveEx[i].style+'</div></li>';
			}
		}
		
		$('#zhibo_lists').html('<ul id="" class="lh200 example1">'+zhiboStr+zhiboStr+zhiboStr+'</ul>');
		var uRoom=cookie('WEBHXZB_UROOMS');
		var uRoomStr='';
		var uRoomNum;
		
		
		uRoomStr=uRoom.replace('\"','');
		uRoomStr=uRoomStr.replace('\"','');
		uRoomNum=uRoomStr.split(',')?uRoomStr.split(','):'';
		for(var i=0;i<$('#zhibo_lists ul li').length;i++){
			var dataId=$('#zhibo_lists ul li').eq(i).attr('data-id');
			if(uRoomNum.length>0){
				for(var j=0;j<uRoomNum.length;j++){
					if(uRoomNum[j]==dataId){
						var uRoomNumLi=$('#zhibo_lists ul li').eq(i);
						uRoomNumLi.find('input.add').addClass('added').removeClass('add');
					}
				}
			}
		}
		if($('#zhibo_lists ul li').length>=4){
			$('#zhibo_lists ul').bxCarousel({
				display_num: 5, 
				move: 1, 
				prev_image: '/images2014/icon_arrow_left.gif',
				next_image: '/images2014/icon_arrow_right.gif',
				margin: 0, 
				auto: true,
				auto_interval: 5000,
				auto_hover:true
			});
		}

	});
}*/

function getVedio(){
	$.ajax({
		type : "get",
		async:false,
		url:"http://vd.jrj.com/front/out/index_sp_list.jsp?columnId=Colu1462773451256121,Colu1462773544316127,Colu1462777437095130",
		dataType : "jsonp",
		jsonp: "callback",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"callback",//callback的function名称
		success:function(jsons){			
			var json=jsons.rows;
			var li='';
			for(var i=0;i<3;i++){
				if(json[i]){
					li=li+'<li class="mb10"><div class="pr over"><a target="_blank" href="'+json[i].url+'"><img width="203" height="126" src="'+json[i].videoImage+'"></a></div><p class="title pr" style="height:42px;"><a href="'+json[i].url+'" target="_blank" style="white-space: normal; width: 80%; font-size: 15px;">'+json[i].videoName+'</a><span style="right:0;top:0;" class="pa">'+json[i].createTimeStr.substring(5,10)+'</span></p><p>'+json[i].videoBrief.substring(0,35)+'...<a target="_blank" href="'+json[i].url+'">详情》</a></p><div class="index_vedio_tab pa"><div class="index_vedio_tabl pa"></div><div class="index_vedio_tabr pa"></div>'+json[i].columnName+'</div></li>';
				}
			}
			
			$('#spjj_lists_new').html(li);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			XMLHttpRequest;
			textStatus;
			errorThrown;
		}
	})
	
	
}

function isLogin(url){
	var uName = cookie("WEBSSO_ZJUSERNAME");
	var usso_userID = cookie("WEBSSO_UID");
	if (usso_userID == null || usso_userID == 0 || usso_userID == "" || uName == null || uName == "") {
		showDialog('提示','抱歉，您需要登录后才能进入小班');
		return;
	}else{
		window.open('http://vd.jrj.com/front/out/zbxb.jsp?id='+url);
	}
}


function getXB(){
	$.ajax({
		type : "get",
		async:false,
		url:"http://v.zhengjin99.com/front/out/xbList.jsp",
		dataType : "jsonp",
		jsonp: "callback",//服务端用于接收callback调用的function名的参数
		jsonpCallback:"callbackIA",//callback的function名称
		success:function(jsons){
			var json=jsons.rows;
			var li='';
			for(var i=0;i<1;i++){
				if(json[i]){
					li=li+'<li><a href="javascript:void(0)" onclick="isLogin(\''+json[i].classId+'\');"><img src="'+json[i].image+'" class="fl" width="68" /></a>'+
                    	'<div class="fl right">'+
                        	'<p class="f16 fb"><a style="color:#585757;" href="javascript:void(0)" onclick="isLogin(\''+json[i].classId+'\');">'+json[i].name+'</a></p>'+
                            '<p class="f14">'+json[i].brief+'</p>'+
                            '<p><a href="javascript:void(0)" onclick="isLogin(\''+json[i].classId+'\');">'+json[i].statusText+'</a></p>'+
                        '</div>'+
                    '</li>';
				}
			}
			
			$('#index_xb').html(li);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			XMLHttpRequest;
			textStatus;
			errorThrown;
		}
	})
	
	
}


function getInfo(){
	/*$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/recent_video_html.jsp", function() {
		
		$("#spjj_lists").html(videoList);
	});*/
	getVedio();
	$.getScript("http://tg.zhengjin99.com/zhengjin/cmscall/gender_yjbg_index_html_new2.jsp", function() {
		$("#yjbg_lists").html(yjbgList);
	});
}

function setCookie (name,value,expires,path,domain,secure) {
	var cookieVal = name + "=" + escape (value) +
	 ((expires) ? "; expires=" + expires.toGMTString() : "") +
	 ((path) ? "; path=" + path : "") +
	 ((domain) ? "; domain=" + domain : "") +
	 ((secure) ? "; secure" : "");
	 document.cookie = cookieVal;
}
function addCookie(objName,objValue,objHours){      //添加cookie
   setCookie(objName,objValue,null,"/",".zhengjin99.com","");
}
function getCookie(name)//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

//changeLoopInfo();



function hideDoyooBorder(){
	$("#doyoo_panel").css("width","0px");	
	$("#doyoo_monitor").css("width","0px");	
}
//setInterval(function(){hideDoyooBorder()} , 1 * 1000);
	
	
function showEvm(){
	$('.index_phone_erv').show();
}
function hideEvm(){
	$('.index_phone_erv').hide();
}

	
/*function confirm(str,okHref,okFunc,cancelFunc) {
	$(".confirm").show();
	$("#confirm_info").html(str);
	$("#confrim_btn_ok").attr("href",okHref);
	//$(".confirm").modal();
	if(!okFunc){
		$("#confrim_btn_ok").click(function(){			
			$(".confirm").hide();
			$.modal.close();
		});
	}else{
		$("#confrim_btn_ok").click(function(){
			$(".confirm").hide();
			$.modal.close();
			okFunc();
		});
	}
	if(!cancelFunc){
		$("#confrim_btn_cancel").click(function(){			
			$(".confirm").hide();
			$.modal.close();
		});
	}else{
		$("#confrim_btn_ok").click(function(){			
			$(".confirm").hide();
			$.modal.close();
			cancelFunc();
		});
	}
	return false;
}*/


