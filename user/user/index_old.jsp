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
	try{
	String mobile = getCookie(request, "WEBSSO_LID");
	String userId = getCookie(request, "WEBSSO_UID");
	String userType = getCookie(request, "WEBSSO_USERTYPE");
	if(mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId)){
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
		
		//参加红包活动状态 hbFlag: 0 未参加， 1参加 
		Integer hbFlag = 0;
		boolean hasTrade = false;
		Map obj = queryAction((String)info.get("UserID"), activityId);
		Double fund = null;
		Map newFund = null;
		if(obj != null){
			hbFlag = 1;
			//参加后从收益详细记录最新一条数据中获取计算基数
			newFund = getUserNewFund(mobile);
			if(newFund != null){
				fund = Double.valueOf((String)newFund.get("Fund"));
				hasTrade = hasTrade(mobile);
			}
		}
		//如果未参加或者获取最新计算基数为null, 最新存量金为计算基数
		if(fund == null)
			fund = getUserFirstFund(mobile);
		pageContext.setAttribute("hbFlag", hbFlag);
		pageContext.setAttribute("fund", fund);
		pageContext.setAttribute("lucre", newFund==null?"0.00":newFund.get("ChangeAmount"));
		pageContext.setAttribute("allLucre", newFund==null?"0.00":newFund.get("totalChangeAmount"));
		pageContext.setAttribute("hasTrade", hasTrade?1:0);
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
$(document).ready(function(){
	
})

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
	$.post("hbhd_ajax.jsp",{type:'party'},function(data){
		if(data.state == "0" ){
			alert("参加成功！");
			$("#bonus_before").hide();
			$("#bonus_close").show();
			$("#bonus_detail").hide();
			
	        $.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zjhsdhb_gjs_20150105', desc: '证金贵金属-喜气洋洋,证金贺岁大红包', isSms: 0}, function(data) {
	        });
		}else if(data.state == "1" ){
			alert("您还不是激活客户，不能参加此活动！");
		}else{
			alert("只有激活用户才能参加活动!");
		}
	},"json");
}

function showAgreement(){
	return alert("抱歉，活动已结束！");
	var usertype = $.trim($.cookie('WEBSSO_USERTYPE'));
	if(usertype == '0' || usertype == '-1' || usertype == '-10'){
		$('.bonus_agreement').show();
	}else{
		$.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zjhsdhb_gjs_20150105', desc: '非激活客户申请参加证金贺岁大红包活动', isSms: 0}, function(data) {
        });
		alert("您还不是激活客户，不能参加此活动， \n稍后客服代表将联系您，请注意接听电话！");
	}
}

$(document).ready(function(){
	$('.question').bind('mouseenter',function(){
		$(this).find('.hint_txt').show();
	})
	$('.question').bind('mouseleave',function(){
		$(this).find('.hint_txt').hide();
	})
});
</script>

</head>

<body>
	<!-- head -->
	<%@ include file="../head_v2.jsp"%>
	<!-- nav -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>
	<div id="personal" class="clear mb20 bg_left_gray">
        <div class="grzx_menu fl">
            <ul class="menu_list">
            	<li class="click"><p><a href=".">个人信息</a></p></li>
                <!--li><p><a href="bonus_detail.jsp">证金红包</a></p></li-->
                <li><p><a href="xxzx.jsp">消息中心<span style="padding:0;color:#f00;" id="xxzx"><c:if test="${nrxxNum>0}">（${nrxxNum}）</c:if></span></a></p></li>
                <li><p><a href="zstq.jsp">专属特权</a></p></li>
                <li><p><a href="favorite.jsp">我的收藏</a></p></li>
                <li><p><a href="dclb.jsp">调查问卷</a></p></li>
                <li><p><a href="fxpg.jsp">风险评估</a></p></li>
                <li><p><a href="resetpwd.jsp">修改密码</a></p></li>
            </ul>
        </div>
    	<div class="fr grzx_right">
        	<div class="personal_right pr">
        		<p class="personal_right_title">个人中心</p>
        		<div class="personal_index_head pa hide">
                	<div class="fl">
                	<!-- http://pic.zhengjin99.com -->
                        <ul class="personal_head_list fl" id="head1">
                            <c:forEach var="i" begin="0" end="34" step="1" >
                                <li onclick="$('#head_big').attr('src','/spage/user/head/face-${i}.jpg');"><img src="http://pic.zhengjin99.com/head/face-${i}.jpg" width="78" height="78"/><span class="pa head_bg"></span></li>
                            </c:forEach>
                        </ul>
                        <ul class="personal_head_list fl" id="head2" style="display: none;">
                            <c:forEach var="i" begin="35" end="60" step="1" >
                                <li onclick="$('#head_big').attr('src','/spage/user/head/face-${i}.jpg');"><img src="http://pic.zhengjin99.com/head/face-${i}.jpg" width="78" height="78"/><span class="pa head_bg"></span></li>
                            </c:forEach>
                        </ul>
                        <div class="clear" style="padding-left:180px;">
                        	<div class="personal_head_btn1" id="head_btn1" onclick="$('#head1').show();$('#head2').hide();$('#head_btn1').attr('className','personal_head_btn1');$('#head_btn2').attr('className','personal_head_btn2');">&lt;</div>
                            <div class="personal_head_btn2" id="head_btn2" onclick="$('#head2').show();$('#head1').hide();$('#head_btn2').attr('className','personal_head_btn1');$('#head_btn1').attr('className','personal_head_btn2');">&gt;</div>
                        </div>
                    </div>
                    
                    <div class="fr mr10 mt7">
                    	<img src="${headImage}" width="127" height="127" class="block mauto" id="head_big"/>
                        <p class="tc mt10">127*127</p>
                        <div class="mt10">
                        	<input id="confirm_bt" type="button" class="mauto block btn2" value="确定" onclick="changeHead();" />
                            <input name="" type="button" class="mauto block btn1" value="取消" onclick="$('.personal_index_head').hide();" />
                        </div>
                    </div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_index_table">
                  <tr>
                  	<td rowspan="6" width="23%" valign="top"><div class="tc fl"><img id="headImage" src="${headImage}" width="127" height="127" class="block" />
                  	<input name="" type="button" class="edit_head mt10" value="更换头像" onclick="$('.personal_index_head').show()"/></div></td>
                    <td valign="top" width="13%">账&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
                    <c:if test="${info==null}">
                    	<td width="74%"class="txt_gray"><p class="fb">${mobile}</p><p style="color:#FF0000;">您还未登录，请先登录！</p></td>
                    </c:if>
                    <c:if test="${info!=null}">
                    	<td width="74%"class="txt_gray"><p class="fb">${mobile}</p><p>此号码为您的登录账号！</p></td>
                    </c:if>
                    <td width="10%">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>特权级别：</td>
	                    <c:if test="${info.VIPTypeID==1}">
	                    	<td class="txt_gray">银卡客户<input name="" onclick="update()" type="button" value="我要升级" class="personal_up" /></td>
	                    </c:if>
	                    <c:if test="${info.VIPTypeID==2}">
	                    	<td class="txt_gray">金卡客户<input name="" onclick="update()" type="button" value="我要升级" class="personal_up" /></td>
	                    </c:if>
	                    <c:if test="${info.VIPTypeID==3}">
	                    	<td class="txt_gray">白金卡客户<input name="" onclick="update()" type="button" value="我要升级" class="personal_up" /></td>
	                    </c:if>
	                    <c:if test="${info.VIPTypeID==4}">
	                    	<td class="txt_gray">钻石卡客户</td>
	                    </c:if>
	                    <c:if test="${info.VIPTypeID!=1&&info.VIPTypeID!=2&&info.VIPTypeID!=3&&info.VIPTypeID!=4}">
	                    	<td class="txt_gray">体验客户<input name="" onclick="update()"  type="button" value="我要升级" class="personal_up" /></td>
	                    </c:if>
                    <%-- </c:if> --%>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>昵&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
                    <td class="txt_gray" id="userName_val">${nick }</td>
                    <td><input id="userName_button" type="button" class="edit" onclick="edit(3, 'userName')" value="编辑" /></td>
                  </tr>
                  <!-- <tr>
                    <td>出生日期：</td>
                    <td class="txt_gray">2014.3.12</td>
                    <td><input name="" type="button" class="edit" value="编辑" /></td>
                  </tr> -->
                  <tr>
                    <td>电子邮箱：</td>
                    <td class="txt_gray" id="email_val">${email}</td>
                    <td><input id="email_button" type="button" class="edit" onclick="edit(2, 'email')" value="编辑"/></td>
                  </tr>
                  <tr>
                    <td>当前积分：</td>
                    <td class="txt_gray">${info.Score}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td><input name="" type="button" class="edit" onclick="window.open('/zhengjin/mall')" value="积分商城" /></td>
                  </tr>
                </table>
                
                <!-- 红包start 
                <div class="bonus_bg clear pr" id="bonus_before" style="display:<c:if test="${hbFlag == 0}">block</c:if><c:if test="${hbFlag != 0}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金红包</span><span>活动时间：2015-01-07至02-06</span></p>
                        <p class="tc num">8<span>%</span>-12<span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金红包相当于年化收益率）</span><span class="fr question"><span class="hint_txt">5万-50万（不含50万）收益相当于年化收益率8%;50万-500万相当于年化收益率12%，红包基数500万封顶，500万以上的超出部分不享受本活动</span></span><br clear="all" /></p>
                        <p class="clear tc before"><span class="fl">我的红包计算基数：<fmt:formatNumber value="${fund}" pattern="#,##0.00#"/>元</span><span class="fr question"><span class="hint_txt">申请日取存量资金为基数，其他日取净入金为基数。每日12点前为前个交易日数据，12点后为上个交易日数据</span></span><br clear="all" /></p>
                        
                    </div>
                    <div class="fr bonus_bags pr">
                    	<div class="bonus_bags_close pr">
                        	<p class="title">每日赚红包</p>
                            <p class="clear je"><span class="fl">累计红包金额</span><span class="fr question"><span class="hint_txt">每日红包金额之和，活动期间如有出金操作，累计红包总金额将会清零</span></span><br clear="all" /></p>
                            <p class="tc no">0.00<span>元</span></p>
                            <input name="" type="button" class="join" onclick="showAgreement();"/>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title">证金小秘书提醒您：</p>
                        <p>红包满足条件后会自动开启，将以短信和消息中心的形式提醒您。</p>
                        <p>满足条件当日开始发放红包，次日12点后可在红包详情查看。</p>
                    </div>
                    <a href="bonus_detail.jsp?type=0">查看活动详情</a>
                    <div class="clear"></div>
                </div>
                
                
                <div class="bonus_bg clear pr" id="bonus_close" style="display:<c:if test="${hbFlag == 1 && hasTrade == 0}">block</c:if><c:if test="${!(hbFlag == 1 && hasTrade == 0)}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金红包</span><span>活动时间：2015-01-07至02-06</span></p>
                        <p class="tc num">8<span>%</span>-12<span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金红包相当于年化收益率）</span><span class="fr question"><span class="hint_txt">5万-50万（不含50万）收益相当于年化收益率8%;50万-500万相当于年化收益率12%，红包基数500万封顶，500万以上的超出部分不享受本活动</span></span><br clear="all" /></p>
                        <p class="clear tc js"><span class="fl">我的红包计算基数</span><span class="fr question"><span class="hint_txt">申请日取存量资金为基数，其他日取净入金为基数。每日12点前为前个交易日数据，12点后为上个交易日数据</span></span><br clear="all" /></p>
                        <p class="tc no"><fmt:formatNumber value="${fund}" pattern="#,##0.00#"/><span>元</span></p>
                        
                    </div>
                    <div class="fr bonus_bags pr">
                    	<div class="bonus_bags_close pr">
                        	<div class="bonus_dialog pa">您离红包开启仅一步之遥....</div>
                        	<p class="title">如何开启红包</p>
                            <p class="txt1">恭喜您参加！满足下面两个条件红包将自动开启哦！</p>
                            <c:if test="${fund >= 50000}">
                            <p class="txt clear mz">
                            </c:if>
                            <c:if test="${fund < 50000}">
                            <p class="txt clear wmz">
                            </c:if>
                            <span class="fl">1.红包基数大于等于5万。</span><span class="fr question"><span class="hint_txt">申请日取存量资金为基数须大于等于5万元，其他日取净入金为基数不受盈亏影响大于等于5万</span></span><br clear="all" /></p>
                            <p class="txt clear wmz"><span class="fl">2.活动期内，账户满足平仓1手15kg或30kg白银即可。</span><br clear="all" /></p>
                            <div class="open"></div>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title">证金小秘书提醒您：</p>
                        <p>红包满足条件后会自动开启，将以短信和消息中心的形式提醒您。</p>
                        <p>满足条件当日开始发放红包，次日12点后可在红包详情查看。</p>
                    </div>
                    <a href="bonus_detail.jsp?type=0">查看活动详情</a>
                    <div class="clear"></div>
                </div>
                
                <div class="bonus_bg clear pr" id="bonus_detail" style="display:<c:if test="${hbFlag == 1 && hasTrade == 1}">block</c:if><c:if test="${!(hbFlag == 1 && hasTrade == 1)}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金红包</span><span>活动时间：2015-01-07至02-06</span></p>
                        <p class="tc num"><c:if test="${fund >= 50000 && fund < 500000}">8</c:if><c:if test="${fund >= 500000}">12</c:if><span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金红包相当于年化收益率）</span><span class="fr question"><span class="hint_txt">5万-50万（不含50万）收益相当于年化收益率8%;50万-500万相当于年化收益率12%，红包基数500万封顶，500万以上的超出部分不享受本活动</span></span><br clear="all" /></p>
                        <p class="clear tc before"><span class="fl">我的红包计算基数：<fmt:formatNumber value="${fund}" pattern="#,##0.00#"/>元</span><span class="fr question"><span class="hint_txt">申请日取存量资金为基数，其他日取净入金为基数。每日12点前为前个交易日数据，10点后为上个交易日数据</span></span><br clear="all" /></p>
                        
                    </div>
                    <div class="fr bonus_bags pr" style="padding-top:20px;">
                    	<div class="bonus_bags_open pr">
                            <p class="clear je"><span class="fl">累计红包金额</span><span class="fr question"><span class="hint_txt">每日红包金额之和，活动期间如有出金操作，累计红包总金额将会清零</span></span><br clear="all" /></p>
                            <p class="tc no"><fmt:formatNumber value="${allLucre}" pattern="#,##0.00#"/><span>元</span></p>
                            <p class="clear yesterday"><span>昨日红包总金额:<span class="num"><fmt:formatNumber value="${lucre}" pattern="#,##0.00#"/></span>元 </span><span class="fr question"><span class="hint_txt">5万-50万（不含50万）：每日红包金额=每日红包基数×8%×1/365（收益相当于年化收益率8%）50万-500万：每日红包金额=每日红包基数×12%×1/365（相当于年化收益率12%）（红包基数500万封顶，500万以上的超出部分不享受本活动）</span></span><br clear="all" /></p>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title">证金小秘书提醒您：</p>
                        <p>红包满足条件后会自动开启，将以短信和消息中心的形式提醒您。</p>
                        <p>满足条件当日开始发放红包，次日12点后可在红包详情查看。</p>
                    </div>
                    <a href="bonus_detail.jsp?type=1">红包详情</a>
                    <div class="clear"></div>
                </div>
                
                <div class="bonus_agreement pa" style="display: none;">
                	<input name="" type="button" value="×" class="bonus_agreement_close pa" onclick="$(this).parent().hide();" />
                	<p>请您阅读并同意《证金红包活动协议》以完成参加这次活动。</p>
                    <div class="bonus_agreement_main">
                    	<h3 class="tc">证金红包活动参与协议</h3>
                        <p>《证金红包活动参与协议》（"协议"）是您（"用户"）与证金贵金属（"我公司"）之间有关参与证金红包活动的法律协议。我公司在此特别提示用户认真阅读、充分理解本协议内容，并审慎选择接受或不接受本协议。用户一旦点击同意，即表示完全接受协议内容并同意接受本协议各项条款的约束。</p>
                        <p class="fb">证金红包活动规则</p>
                        <p>1、	参与资格：</p>
                        <p class="ti">1月7日-2月6日只要满足下列两个条件即可参与证金红包活动；</p>
                        <p class="fb ti">A、	活动期内申请成功且资金基数大于等于5万元</p>
                        <p class="fb ti">红包基数：申请日取存量资金为基数，其他日取净入金为基数</p>
                        <p class="ti">注：老客户以申请日开盘前的存量资金加活动期净入金计算，新客户按照当天净入金量计算</p>
                        <p class="fb ti">B、	活动期内，账户满足平仓1手15kg或30kg白银即可</p>
                        <p>2、	红包计算规则：</p>
                        <p class="ti">5万-50万（不含50万）：</p>
                        <p class="ti"><b>每日</b>红包金额=<b>每日</b>红包基数×8%×1/365<b>（收益相当于年化收益率8%）</b></p>
                        <p class="ti">50万-500万：<b>（红包基数500万封顶，500万以上的超出部分不享受本活动）</b></p>
                        <p class="ti"><b>每日</b>红包金额=<b>每日</b>红包基数×12%×1/365<b>（相当于年化收益率12%）</b></p>
                        <p>3、	注意事项：</p>
                        <p class="fb ti">A 活动期间如有出金，此前的红包将会清零</p>
                        <p class="ti">例1：1月12日账户出金，剩余红包基数在5万以下，则1月7日至1月12日红包清零，后期需要重新加金至5万以上且<b>平仓1手15kg或30kg白银，方可自满足条件之日起重新享受红包；</b></p>
                        <p class="ti">例2：1月12日账户出金，剩余红包基数在5万以上，则1月7日至1月12日红包清零，如在1月12日当日<b>平仓1手15kg或30kg白银</b>，自1月12日<b>起开始以新的红包基数享受红包；</b></p>
                        <p class="ti">例3：针对50万以上的客户而言，假设1月12日账户出金，剩余红包基数大于50万，则1月7日至1月12日红包清零，在1月12日当日<b>平仓1手15kg或30kg白银</b>，则仍然按照<b>新的红包基数×12%×1/365</b>的标准发放红包，倘若剩余红包基数小于50万，但高于5万，则1月7日至1月12日红包清零，在1月12日当日<b>平仓1手15kg或30kg白银</b>方可以<b>新的红包基数×8%×1/365</b>的标准享受红包；</p>
                        <p class="fb ti">B 红包基数受活动期净入金影响，而交易盈亏不影响红包基数；</p>
                        <p class="fb ti">C 每天中午12点以后，可以登录个人中心查看昨日红包收益情况及明细；</p>
                        <p class="fb ti">D 活动结束后十个交易日内，公司统一为符合条件的客户发放红包；</p>
                        <p class="fb ti">E 每个交易账户单独参与本次活动，不合并计算；</p>
                        <p class="fb">风险提示</p>
                        <p>1、认识风险</p>
                        <p>用户需认识到贵金属投资的风险性，用户需结合自身的知识储备、投资经验、投资需求、风险偏好及自身的收入状况、资金量级等决定是否参与本活动，并独立做出投资决策，用户贸然投资可能产生潜在投资风险；</p>
                        <p>2、经营风险</p>
                        <p>因国家行业政策调整、法律法规修订等外部经营环境发生变化，我公司有权调整活动内容或暂停、中断本活动，但有义务告知用户，用户应知悉上述风险；</p>
                        <p>3、第三方风险</p>
                        <p>因网络接入单位、电信平台支持单位等第三方的网络故障、设备故障、系统故障，造成活动详情在网站显示错误、迟延、异常，或因数据原因导致的客户红包金额统计错误、显示错误等，在此提示客户注意此类风险；</p>
                        <p>4、不可抗力风险</p>
                        <p>因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其他重大疫情、火灾等不可抗力或网络受到黑客攻击、网络病毒侵入或发作可能本活动信息显示异常或本活动提前终止；</p>
                        <p class="ti">上述风险提示并不保证完全揭示或充分说明用户参与本活动过程中的全部风险，建议用户仔细阅读上述提示，并认识到贵金属投资蕴含的较高风险。用户如同意本协议并参与本活动视为已对风险有足够清醒客观的认知，能够自主做出投资决策并独立承担投资风险。</p>
                        <p class="fb">免责条款</p>
                        <p class="ti">因下列情形导致本活动信息传递延迟、或本活动中断、终止，我公司不承担法律责任：</p>
                        <p>1、因互联网接入单位、短信发送商、移动运营商等第三方的线路故障、通讯故障造成的信息传递异常；</p>
                        <p>2、我公司对网站进行停机维护或公司经营方针调整；</p>
                        <p>3、因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其他重大疫情、火灾造成的及其他不可抗力造成的网络服务异常；</p>
                        <p>4、因黑客攻击、网络病毒侵入或发作、网络管制导致活动信息显示异常；</p>
                        <p>5、我公司有权根据公司经营情况、突发性的政治或经济等因素决定随时终止本活动。本活动一经终止，所有红包不再发放，不得兑现，且本公司不承担任何法律责任。</p>
                        <p class="fb">协议效力</p>
                        <p>1、本协议为用户与我公司就证金红包活动达成的最终和唯一的正式文本，取代和撤消双方之间先前所有的书面或口头保证、承诺、声明及其他一切书面文件。</p>
                        <p>2、如本协议的任何条款违法、无效，或因某种原因不可执行，那么该条款被认为与本协议分离，不影响本协议其他条款的效力。</p>
                        <p>3、我公司保留不定时修改活动内容及活动规则的权利，更新后的活动规则一旦公布即替代原来的活动规则，恕不再另行通知。</p>
                        <p class="fb">争议解决</p>
                        <p>1、本协议的解释、效力及纠纷的解决，适用中华人民共和国法律。若用户和我公司发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此同意将纠纷或争议提交我公司所在地人民法院管辖。</p>
                        <p>2、本协议的解释权在法律允许的范围内归我公司所有。我公司有权不时修改、补充、完善本协议。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。</p>
                    </div>
                    <div class="tc"><input name="" type="button" class="bonus_agreement_btn1" value="我不同意" onclick="$('.bonus_agreement').hide();"/><input name="" type="button" class="bonus_agreement_btn2" value="我已阅读并同意" onclick="party();$('.bonus_agreement').hide();"/></div>
                </div>
                
                <!-- 红包end -->
                
                <p class="personal_right_title mt30">账户情况 
                <%-- [<c:if test="${Market==1}">海西</c:if><c:if test="${Market==2}">天交</c:if><c:if test="${Market==3}">海西，天交</c:if>
                <c:if test="${userType==0||userType==-1}">实盘激活</c:if><c:if test="${userType==1}">实盘未激活</c:if><c:if test="${userType==2}">模拟</c:if><c:if test="${userType==3}">注册</c:if>
                ] --%></p>
                <p class="fb mt10">实&nbsp;&nbsp;盘：</p>
                <table width="80%" border="0" cellspacing="0" cellpadding="0" class="personal_index_sp tc">
                  <tr>
                    <td class="fb" width="33%">交易所</td>
                    <td class="fb">账户名称</td>
                    <td class="fb" width="33%">开通/激活日期</td>
                  </tr>
                  <c:set var="ExchangeID" value="0"/>
                  <c:forEach items="${info.OpenAccountList}" var="r" varStatus="status">
                  	<c:if test="${r.ExchangeID==2&&(r.AccountTypeID==0||r.AccountTypeID==1)}">
                  		<c:set var="ExchangeID" value="${r.ExchangeID }"/>
	                  	<c:if test="${status.index==0}">
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	</c:if>
	                  	<c:if test="${status.index!=0&&r.AccountTypeID==0}">
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	</c:if>
	                </c:if>
                  </c:forEach>
                  <c:if test="${ExchangeID==2}">
                  	  <tr>
	                  <td class="fb">天交所</td>
		              <td>${accountId }</td>
		              <td>${openTime}</td>
		              </tr>
	              </c:if>
                  
                  <c:set var="ExchangeID" value="0"/>
                  <c:forEach items="${info.OpenAccountList}" var="r" varStatus="status">
                  	<c:if test="${r.ExchangeID==1&&(r.AccountTypeID==0||r.AccountTypeID==1)}">
                  		<c:set var="ExchangeID" value="${r.ExchangeID }"/>
	                  	<c:if test="${status.index==0}">
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	</c:if>
	                  	<c:if test="${status.index!=0&&r.AccountTypeID==0}">
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	</c:if>
	                </c:if>
                  </c:forEach>
                  <c:if test="${ExchangeID==1}">
                      <tr>
	                  <td class="fb">海西所</td>
		              <td>${accountId }</td>
		              <td>${openTime}</td>
		              </tr>
	              </c:if>
	              
	              <c:set var="ExchangeID" value="0"/>
                  <c:forEach items="${info.OpenAccountList}" var="r" varStatus="status">
                  	<c:if test="${r.ExchangeID==3&&(r.AccountTypeID==0||r.AccountTypeID==1)}">
                  		<c:set var="ExchangeID" value="${r.ExchangeID }"/>
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	<c:if test="${status.index!=0&&r.AccountTypeID==0}">
	                  	<c:set var="accountType" value="${r.AccountTypeID }"/>
	                  	<c:set var="accountId" value="${r.AccountID }"/>
	                  	<c:set var="openTime" value="${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):'---'}"/>
	                  	</c:if>
	                </c:if>
                  </c:forEach>
                  <c:if test="${ExchangeID==3}">
                      <tr>
	                  <td class="fb">大圆银泰</td>
		              <td>${accountId }</td>
		              <td>${openTime}</td>
		              </tr>
	              </c:if>
	              
                </table>
                <p class="fb mt30">模拟盘：</p>
                <table width="80%" border="0" cellspacing="0" cellpadding="0" style="background:#efeeea;" class="personal_index_sp tc">
                  <tr>
                    <td class="fb" width="33%">交易所</td>
                    <td class="fb">账户名称</td>
                    <td class="fb" width="33%">开通日期</td>
                  </tr>
                  <c:forEach items="${info.OpenAccountList}" var="r">
                  	  <tr>
	                  	 	<c:if test="${r.ExchangeID==2&&r.AccountTypeID==2}">
		                    <td class="fb">天交所</td>
		                    </c:if>
		                    <c:if test="${r.ExchangeID==1&&r.AccountTypeID==2}">
		                    <td class="fb">海西所</td>
		                    </c:if>
		                    <c:if test="${r.ExchangeID==3&&r.AccountTypeID==2}">
		                    <td class="fb">大圆银泰</td>
		                    </c:if>
		                    <c:if test="${r.AccountTypeID==2}">
		                    <td>${r.AccountID }</td>
		                    <td>${fn:length(r.AccountOpenTime)>10?fn:substring(r.AccountOpenTime, 0, 10):"---"}</td>
		                    </c:if>
		                  </tr>
                  </c:forEach>
                </table>
            </div>
      	</div>
      
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>
