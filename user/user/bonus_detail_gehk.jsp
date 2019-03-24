<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	List prizes = null;
	List prizesDetailTJ = null;
	List prizesDetailDY = null;
	List prizesDetailQL = null;
	try{
	String mobile = getCookie(request, "WEBSSO_LID");
	String userId = getCookie(request, "WEBSSO_UID");
	String userType = getCookie(request, "WEBSSO_USERTYPE");
	if(mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId)  && userType != null && !"".equals(userType)){
		Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
		String email = getUserEmail(request, response, mobile, userId);
		String nick = getUserNickName(request, response, mobile, userId);
		pageContext.setAttribute("info", info);
		pageContext.setAttribute("mobile", mobile.substring(0,3)+"****"+mobile.substring(7,11));
		pageContext.setAttribute("email", email);
		pageContext.setAttribute("nick", nick!=null?URLDecoder.decode(nick, "UTF-8"):"");
		pageContext.setAttribute("userType", userType.replace("%20",""));
		String Market = getCookie(request, "Market");
		pageContext.setAttribute("Market", Market);
		
		
		//是否可以参加活动
		Integer isHaixi=0;
		List<Map> accounts = (List<Map>)info.get("OpenAccountList");
		for(Map account: accounts){
			Integer accountType = (Integer)account.get("AccountTypeID");
			Integer exchange = (Integer)account.get("ExchangeID");
			if(accountType==1&&(exchange==3||exchange==4||exchange==2)){
				pageContext.setAttribute("isHaixi", "1");
			}
		}	
		//参加红包活动状态 hbFlag: 0 未参加， 1参加 
		Integer hbFlag = 0;
		boolean hasTrade = false;
		Integer exPer=8;
		activityId = "zjsy_thjh_20151023";
		Map obj = queryAction((String)info.get("UserID"), activityId);
		Double fund = 0D;
		Double yestodayMoney = 0D;
		Double allMoney = 0D;
		Map newFund = null;
		Integer quantity = 0;
		//红包详情
		prizes = getUserPrizeListSum(mobile, 6);
		if(obj != null){
			hbFlag = 1;
			if(prizes != null){
				for(int i=0;i<prizes.size();i++){
					Map map = (Map)prizes.get(i);
					System.out.println("Quantity:"+map.get("Quantity")+";Fund:"+map.get("Fund")+";_ChangeAmount:"+map.get("_ChangeAmount"));
					System.out.println(map.get("Fund"));
					fund += Double.valueOf(""+map.get("Fund"));
					yestodayMoney += Double.valueOf(""+map.get("ChangeAmount"));
					int tmp = Integer.parseInt(""+map.get("Quantity"));
					if(tmp != 0){
						allMoney += Double.valueOf(""+map.get("_ChangeAmount"));
					}
					quantity += Integer.parseInt(""+map.get("Quantity"));
				}
				hasTrade = hasTradeThjh(mobile);
				allMoney = new BigDecimal(allMoney).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
				yestodayMoney = new BigDecimal(yestodayMoney).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
				
			}
		}
		//如果未参加或者获取最新计算基数为null, 最新存量金为计算基数
		if(fund == null || fund == 0D)
			fund = getUserFirstFund(mobile);
		pageContext.setAttribute("hbFlag", hbFlag);
		pageContext.setAttribute("fund", fund);
		pageContext.setAttribute("lucre", newFund==null?"0.00":newFund.get("ChangeAmount"));
		pageContext.setAttribute("allLucre", newFund==null?"0.00":newFund.get("totalChangeAmount"));
		pageContext.setAttribute("hasTrade", hasTrade?1:0);
		pageContext.setAttribute("yestodayMoney", yestodayMoney);
		if(quantity > 0){
			pageContext.setAttribute("allMoney", allMoney);
		}else{
			pageContext.setAttribute("allMoney", 0.00);
		}
		
		pageContext.setAttribute("quantity", quantity);
		//收益率变动
		if(fund<300000&&fund>=50000){
			exPer=8;
		}else if(fund<1000000&&fund>=300000){
			exPer=10;
		}else if(fund<3000000&&fund>=1000000){
			exPer=12;
		}else if(fund<5000000&&fund>=3000000){
			exPer=14;
		}else if(fund>=5000000){
			exPer=17;
			fund=Double.valueOf(5000000);
		}
		pageContext.setAttribute("fund", fund);
		pageContext.setAttribute("exPer", exPer);
		
		//红包详情
		if(null != prizes && prizes.size()>0){
			pageContext.setAttribute("prizes", prizes);
			for(int i=0;i<prizes.size();i++){
				Map map = (Map)prizes.get(i);
				if(map.get("ExchangeID").equals("2")){
					prizesDetailTJ = getUserPrizeListDetail(mobile, 6,2);
					pageContext.setAttribute("prizesDetailTJ", prizesDetailTJ);
				}else if(map.get("ExchangeID").equals("3")){
						prizesDetailDY = getUserPrizeListDetail(mobile, 6,3);
						pageContext.setAttribute("prizesDetailDY", prizesDetailDY);
				}else if(map.get("ExchangeID").equals("4")){
					prizesDetailQL = getUserPrizeListDetail(mobile, 6,4);
					pageContext.setAttribute("prizesDetailQL", prizesDetailQL);
				}
			}
		}
	}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心_证金贵金属</title>
<link href="css/style_v2.css?v=20150107" rel="stylesheet" type="text/css" />
<link href="css/main.css?v=20150107" rel="stylesheet" type="text/css" />
<!-- <link rel="stylesheet" type="text/css" href="/zhengjin/sphy/css/style2.css"  /> -->
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript">
function update(){
	$.post("user_update.jsp",{type:1},function(data){
		if(data.state == 0)
			alert("已成功提交，请耐心等待，稍后有专员联系您!");
		if(data.state == 1)
			alert("已成功提交，无需重复!");
		if(data.state == -1)
			alert("你未登录，请先登录!");
		
	},"json");
}
var reg = /^[a-zA-Z\u4e00-\u9fa5_]{1,5}$/;
var regEmail =  /^[.a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
function edit(type, obj){
	var val = $("#"+obj+"_button").val();
	if(val=="编辑"){
		var value = $("#"+obj+"_val").text();
		$("#"+obj+"_val").html("<input id='"+obj+"' type='text' value='"+value+"'>");
		$("#"+obj+"_button").val("保存");
	}else if(val=="保存"){
		var value = $("#"+obj+"").val();
		if(value == ""){
			return alert("内容不能为空, 请输入!");
		}
		if(type == 3){
			if (!reg.test(value)) {
				return alert("昵称由1-5位简体中文、英文字母或组合");
			}
		}
		if(type == 2){
			if (!regEmail.test(value)) {
				return alert("邮箱格式错误");
			}
		}
		$.post("user_update.jsp",{type:type, email:value, userName: value},function(data){
			if(type == 3){
				if(data.state == 0){
					$("#"+obj+"_val").text(decodeURIComponent(value));
					$("#"+obj+"_button").val("编辑");
				    addCookie("WEBSSO_EMAIL",encodeURIComponent(value),0);
					alert("修改成功!");
				}
				if(data.state == 1)
					alert("修改失败!");
				if(data.state == -4)
					alert("此昵称已存在!");
				if(data.state == -1)
					alert("你未登录，请先登录!");
				
			}
			
			if(type == 2){
				if(data.state == 0){
					$("#"+obj+"_val").text(decodeURIComponent(value));
					$("#"+obj+"_button").val("编辑");
				    addCookie("WEBSSO_EMAIL",encodeURIComponent(value),0);
					alert("修改成功!");
				}
				if(data.state == 1)
					alert("修改失败!");
				if(data.state == -1)
					alert("你未登录，请先登录!");
				
			}
		},"json");
	}
	
}

function changeHead(){
	var head = $("#head_big").attr("src");
	$('#confirm_bt').attr('disabled', true);
	$.post("headimage_ajax.jsp",{head:head},function(data){
		//alert(data.msg);
		if(data.state == "0"){
			$('.personal_index_head').hide();
			$('#headImage').attr('src',head);
		}
		$('#confirm_bt').attr('disabled', false);
			
	},"json");
}
var url = "../ws/put_resource_desc.jsp?callbackparam=?";
function party(){
	var isHaixi = ${isHaixi};
	if(isHaixi=="1"){
	$.post("hbhd_ajax_gehk.jsp",{type:'party',activityId:'zjsy_thjh_20151023'},function(data){
		if(data.state == "0" ){
			$("#cjcg").show();
			$("#bomb-mask").show();
			
			$("#bonus_before").hide();
			$("#bonus_close").show();
			$("#bonus_detail").hide();
			
	        $.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zjsy_thjh_20151023', desc: '', isSms: 0}, function(data) {
	        });
		}else if(data.state == "1"){
			$("#xyjh").show();
			$("#bomb-mask").show();
		}else{
			$("#xyjh").show();
			$("#bomb-mask").show();
		}
		
		$('#bomb-box-2').hide();
	},"json");
	}else{
		$('#bomb-box-2').hide();
		$("#dyql").show();
		$("#bomb-mask").show();
	}
}

function showAgreement(){
	//return alert("抱歉，活动已结束！");
	$("body").css("overflow-y","hidden"); //显示滚动条设置
	var usertype = $.trim($.cookie('WEBSSO_USERTYPE'));
	var oiltype = $.trim($.cookie('WEBSSO_OILTYPE'));
	//oiltype = '0';
	if(usertype == '0' || usertype == '-1' || usertype == '-10' || oiltype == '0' || oiltype == '-1'){
		$('#bomb-box-2').show();
	}else{
		$.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zjsy_thjh_20151023', desc: '', isSms: 0}, function(data) {
        });
		$("#tjsq").show();
		$("#bomb-mask").show();
	}
}

$(document).ready(function(){
	$('.question').bind('mouseenter',function(){
		$(this).find('.hint_txt').show();
	})
	$('.question').bind('mouseleave',function(){
		$(this).find('.hint_txt').hide();
	});
	$(".select p").click(function(){
		var index = $(".select p").index($(this));
		if(index == 0){
			$(".content-box .content1").show();	
			$(".content-box .content2").hide();	
		} else {
			$(".content-box .content2").show();	
			$(".content-box .content1").hide();	
			
		}
		$(".select p").attr("class","");
		$(this).attr("class","p1");
		$('.tc-zsfx-close').bind('click',function(){		
			$("#tc_zsfx_dy").hide();
			$("#tc_zsfx_ql").hide();
			$("#tc_zsfx_hx").hide();
			$('#bgzsfxmb').hide();
		})
	})
});
/**
 * 显示红包详情
 */
function showDetail(market){
	$('#bgzsfxmb').show();
	if(market == 2){
		$("#tc_zsfx_dy").hide();
		$("#tc_zsfx_ql").hide();
		$("#tc_zsfx_hx").show();
	}else if(market == 4){
		$("#tc_zsfx_hx").hide();
		$("#tc_zsfx_dy").hide();
		$("#tc_zsfx_ql").show();
	}else if(market == 3){
		$("#tc_zsfx_hx").hide();
		$("#tc_zsfx_ql").hide();
		$("#tc_zsfx_dy").show();
	}
}
</script>

</head>

<body>
	<!-- head -->
	<%@ include file="../head_v2.jsp"%>

	<!--  -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>

<style type="text/css">
    	 .prompt-box-style{width:146px;height:90px; position:absolute;top:135px;left:629px;font-size:12px;display:none;}
		 .prompt-box-style p{width:134px;padding:4px 6px;height:47px; position:absolute;top:0;left:0;z-index:222;line-height: 16px;}
		 .prompt-box-style .prompt-mask{position:absolute;background:#ffe119;opacity:0.7;width:100%;height:100%;top:0;left:0;z-index:1;}
		 .lv-8{width:21px;height:21px;position:absolute;top:184px;left:294px; cursor:pointer;}
		 .je-num{width:21px;height:21px;position:absolute;top:238px;left:294px;cursor:pointer;}
		
		 .box-red #prompt-box{width:146px;height:63px; position:absolute;top:112px;left:634px;font-size:12px;display:none;}
	     .box-red #prompt-box p{width:134px;padding:4px 6px;height:47px; position:absolute;top:0;left:0;z-index:222}
	     .box-red #prompt-box .prompt-mask{position:absolute;background:#ffe119;opacity:0.7;width:100%;height:59px;top:0;left:0;z-index:1;}
		 .box-red #open-red-btn{width:21px;height:21px;position:absolute;top:75px;left:238px; cursor:pointer;}
    </style>
    	<script type="text/javascript">
			$(function(){
					$(".box-red2 #open-red-btn").mouseover(function(){
						$(".box-red2 #prompt-box").show();	
					}).mouseout(function(){
						$(".box-red2 #prompt-box").hide();	
					})	
					
					$(".box-red #open-red-btn").mouseover(function(){
						$(".box-red #prompt-box").show();	
					}).mouseout(function(){
						$(".box-red #prompt-box").hide();	
					})	
					
					
					$(".box-red2 .lv-8").mouseover(function(){
						$(".box-red2 .prompt-box-style").css({"top":"150px"}).show();	
					}).mouseout(function(){
						$(".box-red2 .prompt-box-style").hide();	
					})
					
					$(".box-red2 .je-num").mouseover(function(){
						$(".box-red2 .prompt-box-style").css({"top":"208px"}).show();	
					}).mouseout(function(){
						$(".box-red2 .prompt-box-style").hide();	
					})
					
					
					
					$(".box-red1 .lv-8").mouseover(function(){
						$(".box-red1 .prompt-box-style").css({"top":"145px"}).show();	
					}).mouseout(function(){
						$(".box-red1 .prompt-box-style").hide();	
					})
					
					$(".box-red1 .je-num").mouseover(function(){
						$(".box-red1 .prompt-box-style").css({"top":"200px"}).show();	
					}).mouseout(function(){
						$(".box-red1 .prompt-box-style").hide();	
					})
					
					
					$(".box-red .lv-8").mouseover(function(){
						$(".box-red .prompt-box-style").css({"top":"145px"}).show();	
					}).mouseout(function(){
						$(".box-red .prompt-box-style").hide();	
					})
					
					$(".box-red .je-num").mouseover(function(){
						$(".box-red .prompt-box-style").css({"top":"200px"}).show();	
					}).mouseout(function(){
						$(".box-red .prompt-box-style").hide();	
					})
					$("#hongbaojiesuan").mouseover(function(){
						$("#prompt-box-hbje").css({"left":"130px"}).show();	
					}).mouseout(function(){
						$("#prompt-box-hbje").hide();	
					})	

                   $("#hongbaojiesuan02").mouseover(function(){
						$("#prompt-box-hbje2").css({"left":"130px"}).show();	
					}).mouseout(function(){
						$("#prompt-box-hbje2").hide();	
					})
				  $("#hongbaojiesuan03").mouseover(function(){
						$("#prompt-box-hbje3").css({"left":"130px"}).show();	
					}).mouseout(function(){
						$("#prompt-box-hbje3").hide();	
					})
				$("#hongbaojiesuan04").mouseover(function(){
						$("#prompt-box-hbje4").css({"left":"130px"}).show();	
					}).mouseout(function(){
						$("#prompt-box-hbje4").hide();	
					})
			})
        </script>

	<div id="personal" class="clear mb20 bg_left_gray">
    	<%@ include file="left_menu.jsp"%>
    	<div class="fr grzx_right">
        	<!--未参加活动界面-->
								<%-- <div class="box-red" id="bonus_before" style="display:<c:if test="${hbFlag == 0}">block</c:if><c:if test="${hbFlag != 0}">none</c:if>;">
								<div style="position: absolute; font-size: 106px; color: rgb(255, 255, 255); top: 65px; width: 160px; text-align: right; left: 50px;">${exPer}</div>
										<p class="text1">我的红包计算基数<span id="base">0</span><small>元</small></p>
   										 <div class="red">
    										<span class="red-money">0.00<small style="font-size:14px;">元</small></span>
        									<div class="ln-activity-btn" onclick="showAgreement();"></div>
                                    		<div id="open-red-btn"></div>
    									</div>
    								
                                    <div id="prompt-box">
                                        <p>活动期间，如资金出现出金操作，待兑红包金额将会清零。</p>
                                        <div class="prompt-mask"></div>
                                    </div>
                                    
                                    <div class="see-details-btn" onclick="location.href='bonus_detail_gehk.jsp'"></div>
                                    
                                     <div class="prompt-box-style" style="left:317px;top:150px;">
                                        <p>新客户:活动期内净入金;老客户:活动期内净入金+申请日开盘前存量,活动期内有任意出金操作，礼包总金额全部清零
                                        </p>
                                        <div class="prompt-mask"></div>
                                    </div>
                                    <div class="lv-8" style="top:180px;"></div>
    								<div class="je-num"></div>
                                                                    
								</div>
								
								
								
								
								<!--已参加活动界面-->
								<div class="box-red1" id="bonus_close" style="display:<c:if test="${hbFlag == 1 && fund<50000}">block</c:if><c:if test="${!(hbFlag == 1 && fund<50000)}">none</c:if>;">
								<div style="position: absolute; font-size: 106px; color: rgb(255, 255, 255); top: 65px; width: 160px; text-align: right; left: 50px;">${exPer}</div>
										<p class="text1">我的红包计算基数<span id="base">${fund }</span><small>元</small></p>
    									<div class="red" style="background-image:url(<c:if test="${fund<50000}">images/hongbao-2_1.png</c:if><c:if test="${fund>=50000}">images/hongbao-2.png</c:if>)">
                                            <!--新增代码开始-->
                                            <style type="text/css">
												.box-red1 .yes-meet{position:absolute;left:19px;top:135px;}
												.box-red1 .no-meet{position:absolute;left:19px;top:163px;}
												.box-red1 .yellow-text{width:228px;color:#fff;font-size:13px;position:absolute;top:137px;line-height:14px;left:72px;font-family: "Microsoft YaHei";}
												.box-red1 .white-text{width:228px;color:#fff;font-size:12px;position:absolute;top:155px;line-height:14px;left:72px;font-family: "Microsoft YaHei";}
											</style>
                                            <img src="<c:if test="${!(quantity>0&&fund>=50000)}">images/white-bg.png</c:if><c:if test="${(quantity>0&&fund>=50000)}">images/yellow-bg.png</c:if>"  class="no-meet"/>
                                            <img src="<c:if test="${fund<50000}">images/white-bg.png</c:if><c:if test="${fund>=50000}">images/yellow-bg.png</c:if>"  class="yes-meet"/>
                                            <p class="white-text">活动期内，账户只需操作1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg）即可</p>
                                            <p class="yellow-text">红包基数大于等于5万元。</p>
                                             <!--新增代码结束-->
        									<div class="ln-activity-btn" style="cursor: default;"></div>
    							</div>
    							<div class="see-details-btn" onclick="location.href='bonus_detail_gehk.jsp'"></div>
                                 <div class="prompt-box-style" style="left:317px;top:150px;">
                                    <p>新客户:活动期内净入金;老客户:活动期内净入金+申请日开盘前存量,活动期内有任意出金操作，礼包总金额全部清零
                                    </p>
                                    <div class="prompt-mask"></div>
                                </div>
                                <div class="lv-8"></div>
                                <div class="je-num"></div>
								</div>
								<div class="box-red1" id="bonus_close" style="display:<c:if test="${hbFlag == 1 && hasTrade == 0}">block</c:if><c:if test="${!(hbFlag == 1 && hasTrade == 0)}">none</c:if>;">
										<!-- <p class="text1">我的红包计算基数<span id="base">等待活动开启</span><small></small></p> -->
										<p class="text1"><span id="base">等待活动开启</span><small></small></p>
    									<div class="red">

        							<div class="ln-activity-btn" style="cursor: default;"></div>
    							</div>
    							<div class="see-details-btn" onclick="location.href='bonus_detail_gehk.jsp'"></div>
                                 <div class="prompt-box-style" style="left:317px;top:150px;">
                                    <p>新客户:活动期内净入金;老客户:活动期内净入金+申请日开盘前存量,活动期内有任意出金操作，礼包总金额全部清零
                                    </p>
                                    <div class="prompt-mask"></div>
                                </div>
                                
                                <div class="lv-8"></div>
                                <div class="je-num"></div>
                                
								</div>

																<!--已开启活动界面-->
								<div class="box-red2" id="bonus_detail" style="display:<c:if test="${hbFlag == 1 && fund>=50000}">block</c:if><c:if test="${!(hbFlag == 1 && fund>=50000)}">none</c:if>;">
								<div style="position: absolute; font-size: 106px; color: rgb(255, 255, 255); top: 65px; width: 160px; text-align: right; left: 50px;">${exPer}</div>
									<p class="text1">我的红包计算基数<span id="base">${fund }</span><small>元</small></p>
								    <div class="red">
										<span class="red-money" style="top:98px">${allMoney }<small style="font-size:14px;">元</small></span>
								        <div  style="top:198px;" class="yu-jine" >昨日待兑金额:<span>${yestodayMoney}</span> 元</div>
								          <div id="open-red-btn"></div>
								           <div style="position:absolute;color:#fffb14;line-height:13px;top:156px;font-size:12px;width:300px;left:6px;display:<c:if test="${!(quantity>0)}">block</c:if><c:if test="${(quantity>0)}">none</c:if>;">&nbsp;&nbsp;&nbsp;&nbsp;待兑红包金额，需在活动期内操作1手现货重油（50或200T）
或1手大圆银（50kg或100kg）或1手大圆沥青（50或200T）或天通银 （15kg或30kg）方可领取</div>
								    </div>
								    <div class="see-details-btn" onclick="location.href='bonus_detail_gehk.jsp'" style="cursor: pointer;width: 100px;margin-top:20px;">&nbsp;&nbsp;</div>
									<div id="prompt-box">
								    	<p style="line-height: 18px;">活动期间，如资金出现出金操作，待兑红包金额将会清零。</p>
								    	<div class="prompt-mask"></div>
								    </div>
								    <div class="prompt-box-style" style="left:317px;top:150px;">
								    	<p>新客户:活动期内净入金;
								        老客户:活动期内净入金+申请日开盘前存量,活动期内有任意出金操作，礼包总金额全部清零
								        </p>
								    	<div class="prompt-mask"></div>
								    </div>
									<div class="lv-8"></div>
								  	<div class="je-num"></div>
								</div> --%>
<style type="text/css">
html,body,div,p,span{padding:0;margin:0;}
li{list-style:none;}
.activity-end{ background:url(images/bg.jpg) no-repeat;width:743px;height:329px;position:relative;font-family:'Microsoft YaHei'; }
.activity-end p{width:290px;height:100px;text-align:center;left:388px;top:122px;position:absolute;}
.activity-end .je{font-size:48px; text-align:center;color:#fff;}
.activity-end .dw{font-size:14px;color:#fff;}
</style>
<div class="activity-end">
	<p><span class="je">${allMoney }</span><span class="dw">元</span></p>
</div>
<!--title为"提示"弹窗元素-->
<div class="bomb-box" id="tjsq" style="display:none;left: 44%;">
	<div class="bomb-top">
    	<img src="images/j01.png"  width="10"/>
        <p></p>
        <img src="images/j02.png"  width="10"/>
    </div>
    <div class="bomb-content">
    	<p class="bomb-text1">提示</p>
        <p class="bomb-text2">您的申请已提交，稍后客服代表联系您，请保持电话畅通。详情请联系010-58309199</p>
    </div>
    <div class="bomb-top">
    	<img src="images/j03.png"  width="10"/>
        <p style="background:#fff;"></p>
        <img src="images/j04.png"  width="10"/>
    </div>
    <img src="images/close.png"  id="closetjsq"/>
</div>

<!--半透明底图-->
<div id="bomb-mask"></div>


<!--title为"亲，您需要激活账户"弹窗元素-->

<div class="bomb-box" id=xyjh style="display:none;left: 44%;">
	<div class="bomb-top">
    	<img src="images/j01.png"  width="10"/>
        <p></p>
        <img src="images/j02.png"  width="10"/>
    </div>
    <div class="bomb-content" style="height:130px;">
    	<p class="bomb-text1">亲，您需要激活账户</p>
        <p class="bomb-text2" style="font-size:24px;">详情请联系：010-58309199</p>
    </div>
    <div class="bomb-top">
    	<img src="images/j03.png"  width="10"/>
        <p style="background:#fff;"></p>
        <img src="images/j04.png"  width="10"/>
    </div>
    <img src="images/close.png"  id="closexyjh"/>
</div>

<!--title为"大圆，齐鲁"弹窗元素-->

<div class="bomb-box" id=dyql style="display:none;">
	<div class="bomb-top">
    	<img src="images/j01.png"  width="10"/>
        <p></p>
        <img src="images/j02.png"  width="10"/>
    </div>
    <div class="bomb-content" style="height:130px;">
    <p class="bomb-text1">提示</p>
    <p class="bomb-text2" style="width:380px">亲爱的客户您好，想要参加该活动请咨询您的客服人员，也可拨打010-58309199了解详情。</p>
    </div>
    <div class="bomb-top">
    	<img src="images/j03.png"  width="10"/>
        <p style="background:#fff;"></p>
        <img src="images/j04.png"  width="10"/>
    </div>
    <img src="images/close.png"  id="closedyql" class="closedyql" style="position:absolute;right:0;top:14px; cursor:pointer;"/>
</div>


<!--title为"恭喜您"弹窗元素-->
<div class="bomb-box" style="height:232px;display:none;left: 44%;" id="cjcg">
	<div class="bomb-top">
    	<img src="images/j01.png"  width="10"/>
        <p></p>
        <img src="images/j02.png"  width="10"/>
    </div>
    <div class="bomb-content" style="height:210px;">
    	<p class="bomb-text1">恭喜您</p>
        <p class="bomb-text2" style="font-size:21px;width:390px;">获得红包参与资格</p>
         <img src="images/qrbtn.png" id="qrcjcg"  style="margin:0 auto;margin-top:27px; cursor:pointer;"/>
    </div>
    <div class="bomb-top">
    	<img src="images/j03.png"  width="10"/>
        <p style="background:#fff;"></p>
        <img src="images/j04.png"  width="10"/>
    </div>
    <img src="images/close.png"  id="closecjcg"/>
</div>




   <script type="text/javascript">
                   	
                    	$(function(){
                    		
                    		$('#close02,#no-btn').click(function(){
                    			$('#bomb-box-2').hide();	
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    		
                    		$('#yes-btn').click(function(){
                    			party();
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    		$('#closecjcg,#qrcjcg').click(function(){
                    			$('#cjcg').hide();
                    			$('#bomb-mask').hide();
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    		$('#closexyjh').click(function(){
                    			$('#xyjh').hide();
                    			$('#bomb-mask').hide();
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    		$('#closedyql').click(function(){
                    			$('#dyql').hide();
                    			$('#bomb-mask').hide();
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    		$('#closetjsq').click(function(){
                    			$('#tjsq').hide();
                    			$('#bomb-mask').hide();
                    			$("body").css("overflow-y","");//隐藏滚动条设置
                    		});
                    	})
                    </script>
<!--证金礼包活动协议弹窗-->
<div  id="bomb-box-2" style="display:none;">
	<img src="images/j05.png" />
    <div class="content">
        <div class="top">
            <p>请您阅读并同意《证金礼包活动协议》，以完成参加这次活动！</p>
            <img src="images/close02.png"  id="close02"/>
        </div>
        <div class="content-box">

<p>《证金红包活动参与协议》是您与证金财富之间有关参与证金红包活动的法律协议。我公司在此特别提示用户认真阅读、充分理解本协议内容，并审慎选择接受或不接受本协议。用户一旦点击同意，即表示完全接受协议内容并同意接受本协议各项条款的约束。</p>
<p><strong>证金红包活动规则</strong></p>
<p>1、参与资格：</p>
<p>2015年11月11日-2016年1月29日（自然日，包含周六日）只要满足下列两个条件即可参与证金红包活动</p>
<p><strong>A、活动期内申请成功且资金基数大于等于5万元</strong></p>
<p>红包基数：申请日取存量资金（面向老客户）+净入金为基数</p>
<p>注：老客户以申请日开盘前的存量资金加活动期净入金计算，新客户按照当天净入金量计算</p>
<p>开启红包即可每天计算5万元以上红包基数所能产生的账面收益，但是需要满足获取红包条件，才能在活动结束后获取红包收益；</p>
<p>B、获取红包条件：</p>
<p>活动期内，账户需要操作1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg）即可，活动期间建仓并平仓一次算1手；</p>
<p>2、红包计算规则：</p>
<p>12月12日之前（不含12日当天）：</p>
<p>每日红包金额=每日红包基数×8%×1/365（收益相当于年化收益率8%）</p>
<p>12月12日之后（含12日当天）：</p>
<p>5万≤基数＜30万：红包金额=红包基数×8%×1/365，相当于年化收益率8%；</p>
<p>30万≤基数＜100万：红包金额=红包基数×10%×1/365，相当于年化收益率10%；</p>
<p>100万≤基数＜300万：红包金额=红包基数×12%×1/365，相当于年化收益率12%；</p>
<p>300万≤基数＜500万：红包金额=红包基数×14%×1/365，相当于年化收益率14%；</p>
<p>基数=500万：红包金额=红包基数×17%×1/365，相当于年化收益率17%；</p>
<p>礼包基数500万封顶，500万以上超出部分不享受本次活动；</p>
<p>3、注意事项：</p>
<p><strong>A 活动期间如有出金，此前的红包将会清零</strong></p>
<p>例1：11月30日账户出金，剩余红包基数在5万以下，那么11月11日至11月30日红包清零，后期需要重新加金至5万以上且平仓1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg），方可自满足条件之日起重新享受红包</p>
<p>例2：11月30日账户出金，剩余红包基数在5万以上，那么11月11日至11月30日红包清零，如在11月30日当日平仓1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg），自11月30日起开始以新的红包基数享受红包</p>
<p><strong>B 必须点击报名参加并同意本协议之后，交易1手现货重油或大圆银或大圆沥青或天通银才有效</strong></p>
<p>例1、 11月11日客户净入金就达到5万元，但是始终没有报名参加并点击同意本协议，在此之前的交易和净入金无效，如11月30日，该客户在未出金的情况下，点击报名参加并同意本协议，待兑红包收益开始计算，并且在活动期间内，该客户满足1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或天通银（15kg或30kg）或大圆沥青（50T或150T）交易要求，即可在活动结束后领取红包收益。</p>
<p><strong>C 活动期间每天中午12点以后，可以登录个人中心查看昨日红包收益情况及明细；</strong></p>
<p><strong>D 活动结束后二十个交易日内，公司统一为符合条件的客户发放红包；</strong></p>
<p><strong>E 活动结束后一个月以内，公司统一为符合条件的客户发放红包，红包会发放至客户开户时绑定的主银行卡上</strong></p>
<p><strong>F 每个交易账户单独参与本次活动，不合并计算</strong></p>
<p><strong>风险提示</strong></p>
<p>1、认识风险</p>
<p>用户需认识到贵金属投资的风险性，用户需结合自身的知识储备、投资经验、投资需求、风险偏好及自身的收入状况、资金量级等决定是否参与本活动，并独立做出投资决策，用户贸然投资可能产生潜在投资风险；</p>
<p>2、经营风险</p>
<p>因国家行业政策调整、法律法规修订等外部经营环境发生变化，我公司有权调整活动内容或暂停、中断本活动，但有义务告知用户，用户应知悉上述风险；</p>
<p>3、第三方风险</p>
<p>因网络接入单位、电信平台支持单位等第三方的网络故障、设备故障、系统故障，造成活动详情在网站显示错误、迟延、异常，或因数据原因导致的客户红包金额统计错误、显示错误等，在此提示客户注意此类风险；</p>
<p>4、不可抗力风险</p>
<p>因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其它重大疫情、火灾等不可抗力或网络受到黑客攻击、网络病毒侵入或发作可能本活动信息显示异常或本活动提前终止；</p>
<p>上述风险提示并不保证完全揭示或充分说明用户参与本活动过程中的全部风险，建议用户仔细阅读上述提示，并认识到贵金属投资蕴含的较高风险。用户如同意本协议并参与本活动视为已对风险有足够清醒客观的认知，能够自主做出投资决策并独立承担投资风险。</p>

<p><strong>免责条款</strong></p>
	<p>因下列情形导致本活动信息传递延迟、或本活动中断、终止，我公司不承担法律责任：</p>
<p>1、因互联网接入单位、短信发送商、移动运营商等第三方的线路故障、通讯故障造成的信息传递异常；</p>
<p>2、我公司对网站进行停机维护或公司经营方针调整；</p>
<p>3、因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其它重大疫情、火灾造成的及其它不可抗力造成的网络服务异常；</p>
<p>4、因黑客攻击、网络病毒侵入或发作、网络管制导致活动信息显示异常；</p>
<p>5、我公司有权根据公司经营情况、突发性的政治或经济等因素决定随时终止本活动。本活动一经终止，所有红包不再发放，不得兑现，且本公司不承担任何法律责任。</p>
<p><strong>协议效力</strong></p>
<p>1、本协议为用户与我公司就证金红包活动达成的最终和唯一的正式文本，取代和撤消双方之间先前所有的书面或口头保证、承诺、声明及其它一切书面文件。</p>
<p>2、如本协议的任何条款违法、无效，或因某种原因不可执行，那么该条款被认为与本协议分离，不影响本协议其它条款的效力。</p>
<p>3、我公司保留不定时修改活动内容及活动规则的权利，更新后的活动规则一旦公布即替代原来的活动规则，恕不再另行通知。</p>

<p><strong>争议解决</strong></p>
<p>1、本协议的解释、效力及纠纷的解决，适用中华人民共和国法律。若用户和我公司发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此同意将纠纷或争议提交我公司所在地人民法院管辖。</p>
<p>2、本协议的解释权在法律允许的范围内归我公司所有。我公司有权不时修改、补充、完善本协议。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。</p>

          <div class="footer-btn-box">
                <div>
                    <img src="images/btn-01.png" id="no-btn"/>
                    <img src="images/btn-02.png" id="yes-btn" style="margin-left:15px;"/>
                </div>
            </div>
            
       </div>
    </div>
    
    <img src="images/j06.png" />
</div>



<div class="content-box"  >
    <div class="select"><span class="action"><p class="p1"  style="cursor: pointer;">活动详情</p></span><span class="redmoney" style="cursor: pointer;"><p>红包详情</p></span></div>
    <div class="content1">
    <div class="wenzi">
    <p>证金红包活动规则</p>
    <p>1、参与资格：</p>
    <p>2015年11月11日-2016年1月29日（自然日，包含周六日）只要满足下列两个条件即可参与证金红包活动</p>
    <p>A、活动期内申请成功且资金基数大于等于5万元</p>
    <p>红包基数：申请日取存量资金（面向老客户）+净入金为基数</p>
    <p>注：老客户以申请日开盘前的存量资金加活动期净入金计算，新客户按照当天净入金量计算</p>
    <p>开启红包即可每天计算5万元以上红包基数所能产生的账面收益，但是需要满足获取红包条件，才能在活动结束后获取红包收益；</p>
    <p>B、获取红包条件：</p>
    <p>活动期内，符合申请成功且资金基数大于等于5万元后，账户需要操作1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或1手天通银（15kg或30kg）即可，活动期间建仓并平仓一次算1手</p>
    <div class="bk40"></div>
    <p>2、红包计算规则：</p>
	<p>12月12日之前（不含12日当天）：</p>
	<p>每日红包金额=每日红包基数×8%×1/365（收益相当于年化收益率8%）</p>
	<p>12月12日之后（含12日当天）：</p>
	<p>5万≤基数＜30万：红包金额=红包基数×8%×1/365，相当于年化收益率8%；</p>
	<p>30万≤基数＜100万：红包金额=红包基数×10%×1/365，相当于年化收益率10%；</p>
	<p>100万≤基数＜300万：红包金额=红包基数×12%×1/365，相当于年化收益率12%；</p>
	<p>300万≤基数＜500万：红包金额=红包基数×14%×1/365，相当于年化收益率14%；</p>
	<p>基数=500万：红包金额=红包基数×17%×1/365，相当于年化收益率17%；</p>
	<p>礼包基数500万封顶，500万以上超出部分不享受本次活动；</p>
    <div class="bk40"></div>
    <p>3、注意事项：</p>
    <p>A 活动期间如有出金，此前的红包将会清零</p>
    <p>例1：11月30日账户出金，剩余红包基数在5万以下，那么11月11日至11月30日红包清零，后期需要重新加金至5万以上，在以后活动期内重新建仓并平仓1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg），方可领取红包；</p>
    <p>例2：11月30日账户出金，剩余红包基数在5万以上，那么11月11日至11月30日红包清零，自11月30日起开始以新的红包基数享受红包；在之后活动期内重新建仓并平仓1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或1手大圆沥青（50T或150T）或天通银 （15kg或30kg），方可领取红包。</p>
    <p>B 必须点击报名参加并同意本协议之后，存量资金或净入金才有效，同意协议和净入金符合要求，交易1手现货重油或大圆银或大圆沥青或天通银才有效；</p>
    <p>例1、 11月11日客户净入金就达到5万元，但是始终没有报名参加并点击同意本协议，在此之前的交易和净入金无效，如11月30日，该客户在未出金的情况下，点击报名参加并同意本协议，待兑红包收益开始计算，并且在活动期间内，该客户满足1手现货重油（50T或200T）或1手大圆银（50kg或100kg）或天通银（15kg或30kg）或大圆沥青（50T或150T）交易要求，即可在活动结束后领取红包收益。</p>
    <p>C 红包基数受活动期净入金影响，而交易盈亏不影响红包基数；</p>
    <p>D 活动期间每天中午12点以后，可以登录个人中心查看昨日红包收益情况及明细；</p>
    <p>E 活动结束后二十个交易日内，公司统一为符合条件的客户发放红包；</p>
    <p>F 每个交易账户单独参与本次活动，不合并计算。</p>
    </div>
    </div>
    
   <div class="content2">
    	 <table width="100%" border="0" cellspacing=0 cellpadding=0>
        	<tr bgcolor="#f03333" height="36" align="center" class="table-title">
            	<td style="background:none;">交易所</td>
	                <td style="background:none;">红包结算时间</td>
	                <td style="position:relative"><p style="float:left;">当日红包金额</p><img id="hongbaojiesuan" src="images/006_03.png" style="cursor:pointer" /> 
                    <div id="prompt-box-hbje">
                                        <p>当日红包产生的收益数额</p>
                                        <div class="prompt-mask"></div>
                                    </div></td>
	               
                    <td style="position:relative"><p style="float:left;">红包总金额</p> <img id="hongbaojiesuan02" src="images/006_03.png"  style="cursor:pointer"/>
                    <div id="prompt-box-hbje2">
                                        <p>启动红包至今获得的收益数额之和</p>
                                        <div class="prompt-mask"></div>
                                    </div>
                    </td>
	                <td style="position:relative"><p style="float:left;">红包收益率</p> <img id="hongbaojiesuan03" src="images/006_03.png"  style="cursor:pointer"/>
                    <div id="prompt-box-hbje3">
                                        <p>相当于年化收益率</p>
                                        <div class="prompt-mask"></div>
                                    </div>
                    </td>
	                <td style="position:relative"><p style="float:left;">结算基数</p> <img id="hongbaojiesuan04" src="images/006_03.png"  style="cursor:pointer"/>
                    <div id="prompt-box-hbje4">
                                        <p>新客户:活动期内净入金;老客户:活动期内净入金+申请日开盘前存量,活动期内有任意出金操作,礼包总金额全部清零</p>
                                        <div class="prompt-mask"></div>
                                    </div>
                    </td>
	                <td>详情</td>
            </tr>
             <%
                          	 if(prizes != null){
                          		 for(int i = prizes.size()-1; i >= 0; i--){
                          			Map map = (Map)prizes.get(i);
                          			 out.print("<tr style='color: red;'>");
                          			 if(map.get("ExchangeID").equals("2")){
	                          			 out.print("<td>天通银</td>");
                          			 }else if(map.get("ExchangeID").equals("3")){
                          				out.print("<td>大圆沥青</td>");
                          			 }else if(map.get("ExchangeID").equals("4")){
                          				out.print("<td>现货重油</td>");
                          			 }else{
                          				out.print("<td>暂无对应类型</td>");
                          			 }
                          			out.print("<td>"+map.get("ChangeTime")+"</td>");
                          			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>");
                          			out.print("<td>"+ new BigDecimal(Double.valueOf(""+map.get("_ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>"); 
                          			out.print("<td>"+Double.valueOf((String)map.get("Rate"))*100+"%</td>");
                          			if(Double.valueOf(""+map.get("Fund"))>=5000000){
                          				out.print("<td>"+5000000.00+"</td>");
                          			}else{
                          				out.print("<td>"+map.get("Fund")+"</td>");
                          			}
                          			
                          			if(Double.valueOf(""+map.get("ChangeAmount"))>0){
                          				out.print("<td><input type='button' value='详情' onclick='showDetail("+map.get("ExchangeID")+")' /></td>");
                          			}else{
	                          			out.print("<td></td>");
                          			}
                          			out.print("</tr>");
                          		 }
                          		
                          	 }
                          %>
                            <c:if test="${fn:length(prizes) <= 0}">
                            <tr> <td colspan="7">暂无记录</td> </tr>
                            </c:if>
        </table> 
    </div>
</div>

                <!-- 红包end -->
            </div>
      	</div>
      	<div class="clear"></div>
      	<div class="tc-zsfxwhole" id="tc_zsfx_hx" style="display: none">
        <div class="tc-zsfxzyk">
            <div class="tc_zsfx">
				<table width="456" border="0" cellspacing="0" cellpadding="0" style="color:#FFF; text-align:center;margin:20px 0 0 20px;" >
				  <tr>
				    <td width="130" height="36" bgcolor="#f03333">红包结算时间</td>
				    <td width="121" height="36" bgcolor="#f03333">当日红包金额</td>
				    <td width="117" height="36" bgcolor="#f03333">红包总金额</td>
				    <td width="88" height="36" bgcolor="#f03333">结算基数</td>
				  </tr>
				</table>
				<div class="tc_zsfx2" style="overflow-x:hidden;overflow-y:auto; height:250px;" >
				<table width="456"  border="0" cellspacing="0" cellpadding="0"  >
				  <tr >
				    <td width="130">红包结算时间</td>
				    <td width="120">当日红包金额</td>
				    <td width="118">红包总金额</td>
				    <td width="88">结算基数</td>
				  </tr>
				  <%
                  	 if(prizesDetailTJ != null){
                  		 for(int i = prizesDetailTJ.size()-1; i >= 0; i--){
                  			Map map = (Map)prizesDetailTJ.get(i);
                  			out.print("<tr>");
                  			out.print("<td>"+map.get("ChangeTime")+"</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("_ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>"); 
                  			
                  			if(Double.valueOf(""+map.get("Fund"))>=5000000){
                  				out.print("<td>"+new BigDecimal(5000000).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}else{
                  				out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("Fund"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}
                  			
                  			out.print("</tr>");
                  		 }
                  		
                  	 }
                  %>
                 <c:if test="${fn:length(prizes) <= 0}">
                 <tr> <td colspan="7">暂无记录</td> </tr>
                 </c:if>
				  
				</table>
				</div>
                <div class="tc-zsfx-close"></div>
          </div>
        </div>
      	</div>
      	<div class="tc-zsfxwhole" id="tc_zsfx_dy" style="display: none">
        <div class="tc-zsfxzyk">
            <div class="tc_zsfx">
				<table width="456" border="0" cellspacing="0" cellpadding="0" style="color:#FFF; text-align:center;margin:20px 0 0 20px;" >
				  <tr>
				    <td width="130" height="36" bgcolor="#f03333">红包结算时间</td>
				    <td width="121" height="36" bgcolor="#f03333">当日红包金额</td>
				    <td width="117" height="36" bgcolor="#f03333">红包总金额</td>
				    <td width="88" height="36" bgcolor="#f03333">结算基数</td>
				  </tr>
				</table>
				<div class="tc_zsfx2" style="overflow-x:hidden;overflow-y:auto; height:250px;" >
				<table width="456"  border="0" cellspacing="0" cellpadding="0"  >
				  <tr >
				    <td width="130">红包结算时间</td>
				    <td width="120">当日红包金额</td>
				    <td width="118">红包总金额</td>
				    <td width="88">结算基数</td>
				  </tr>
				  <%
                  	 if(prizesDetailDY != null){
                  		 for(int i = prizesDetailDY.size()-1; i >= 0; i--){
                  			Map map = (Map)prizesDetailDY.get(i);
                  			out.print("<tr>");
                  			out.print("<td>"+map.get("ChangeTime")+"</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("_ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>"); 
                  			if(Double.valueOf(""+map.get("Fund"))>=5000000){
                  				out.print("<td>"+new BigDecimal(5000000).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}else{
                  				out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("Fund"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}
                  			out.print("</tr>");
                  		 }
                  		
                  	 }
                  %>
                 <c:if test="${fn:length(prizes) <= 0}">
                 <tr> <td colspan="7">暂无记录</td> </tr>
                 </c:if>
				  
				</table>
				</div>
                <div class="tc-zsfx-close"></div>
          </div>
        </div>
      	</div>
      	<div class="tc-zsfxwhole" id="tc_zsfx_ql" style="display: none">
        <div class="tc-zsfxzyk">
            <div class="tc_zsfx">
				<table width="456" border="0" cellspacing="0" cellpadding="0" style="color:#FFF; text-align:center;margin:20px 0 0 20px;" >
				  <tr>
				    <td width="130" height="36" bgcolor="#f03333">红包结算时间</td>
				    <td width="121" height="36" bgcolor="#f03333">当日红包金额</td>
				    <td width="117" height="36" bgcolor="#f03333">红包总金额</td>
				    <td width="88" height="36" bgcolor="#f03333">结算基数</td>
				  </tr>
				</table>
				<div class="tc_zsfx2" style="overflow-x:hidden;overflow-y:auto; height:250px;" >
				<table width="456"  border="0" cellspacing="0" cellpadding="0"  >
				  <tr >
				    <td width="130">红包结算时间</td>
				    <td width="120">当日红包金额</td>
				    <td width="118">红包总金额</td>
				    <td width="88">结算基数</td>
				  </tr>
				  <%
                  	 if(prizesDetailQL != null){
                  		 for(int i = prizesDetailQL.size()-1; i >= 0; i--){
                  			Map map = (Map)prizesDetailQL.get(i);
                  			out.print("<tr>");
                  			out.print("<td>"+map.get("ChangeTime")+"</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>");
                  			out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("_ChangeAmount"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"元</td>"); 
                  			if(Double.valueOf(""+map.get("Fund"))>=5000000){
                  				out.print("<td>"+new BigDecimal(5000000).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}else{
                  				out.print("<td>"+new BigDecimal(Double.valueOf(""+map.get("Fund"))).setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue()+"</td>");
                  			}
                  			out.print("</tr>");
                  		 }
                  	 }
                  %>
                 <c:if test="${fn:length(prizes) <= 0}">
                 <tr> <td colspan="7">暂无记录</td> </tr>
                 </c:if>
				  
				</table>
				</div>
                <div class="tc-zsfx-close"></div>
          </div>
        </div>
      	</div>
      	<div class="tc-zsfxmb" id="bgzsfxmb"></div>
    <!--foot--><!-- 修改 -->
     <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
    <!--foot-end--><!-- 修改end -->
</body>
</html>


