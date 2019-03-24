<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	String mobile = getCookie(request, "WEBSSO_LID");
	String userId = getCookie(request, "WEBSSO_UID");
	String userType = getCookie(request, "WEBSSO_USERTYPE");
	List prizes = null;
	if(mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId)){
		Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
		//参加红包活动状态 hbFlag: 0 未参加， 1参加 
		Integer hbFlag = 0;
		boolean hasTrade = false;
		activityId = "zj99_bjhbqshb_20150428";
		Map obj = queryAction((String)info.get("UserID"), activityId);
		Double fund = null;
		Map newFund = null;
		if(obj != null){
			hbFlag = 1;
			//参加后从收益详细记录最新一条数据中获取计算基数
			newFund = getUserNewFund(mobile);
			if(newFund != null){
				fund = Double.valueOf((String)newFund.get("Fund"));
				hasTrade = hasTrade_bh(mobile);
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
		//红包详情
		prizes = getUserPrizeList_bh(mobile, null); 
		pageContext.setAttribute("prizes", prizes);
	}
	
	String type = Utils.getParameterValue(request, "type", "0");
	pageContext.setAttribute("type", type);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心_证金贵金属</title>
<link href="css/style_v2.css?v=20140107" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script>
var url = "../ws/put_resource_desc.jsp?callbackparam=?";
function party(){
	$.post("hbhd_ajax_bh.jsp",{type:'party',activityId:'zj99_bjhbqshb_20150428'},function(data){
		if(data.state == "0" ){
			alert("参加成功！");
			$("#bonus_before").hide();
			$("#bonus_close").show();
			$("#bonus_detail").hide();
			
	        $.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zj99_bjhbqshb_20150428', desc: '证金贵金属-白加黑霸气送红包', isSms: 0}, function(data) {
	        });
		}else if(data.state == "1" ){
			alert("您还不是激活客户，不能参加此活动！");
		}else{
			alert("只有激活用户才能参加活动!");	
		}
	},"json");
}

function showAgreement(){
	//return alert("抱歉，活动已结束！");
	var usertype = $.trim($.cookie('WEBSSO_USERTYPE'));
	var oiltype = $.trim($.cookie('WEBSSO_OILTYPE'));
	if(usertype == '0' || usertype == '-1' || usertype == '-10' || oiltype == '0'){
		$('.bonus_agreement').show();
	}else{
		$.getJSON(url, {mobile: $.cookie('WEBSSO_LID'), activityId: 'zj99_bjhbqshb_20150428', desc: '非激活客户申请参加证金贵金属-白加黑霸气送红包', isSms: 0}, function(data) {
        });
		alert("您还不是激活客户，不能参加此活动， \n稍后客服代表将联系您，请注意接听电话！");
	}
}

$(document).ready(function(){
	$('.question').bind('mouseenter',function(){
		$(this).find('.hint_txt').show();
	});
	$('.question').bind('mouseleave',function(){
		$(this).find('.hint_txt').hide();
	});
	
	var type = '${type}';
	if(type == '0'){
		$('.tab_table').hide();$('.tab_table1').show();$('.bonus_tab li').removeClass();$('#hdxq').addClass('sl');
	}else if(type == '1'){
        $('.tab_table').hide();$('.tab_table2').show();$('.bonus_tab li').removeClass();$('#hbxq').addClass('sl');
	}
		
});
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

	<div id="personal" class="clear mb20 bg_left_gray">
    	<%@ include file="left_menu.jsp"%>
    	<div class="fr grzx_right">
        	<div class="personal_right pr">
        		<p class="personal_right_title">证金红包</p>
                <!-- 红包start -->
                <div class="bonus_bg clear pr" id="bonus_close" style="display:<c:if test="${hbFlag == 1 && hasTrade == 0}">block</c:if><c:if test="${!(hbFlag == 1 && hasTrade == 0)}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金礼包</span><span>活动时间：2015-05-08至06-30</span></p>
                        <p class="baiyin num1">8<span>%</span>-18<span>%</span></p>
                        <p class="shiyou num1">9<span>%</span>-19<span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金礼包收益率）</span><span class="fr question"><span class="hint_txt">10万≤净入金＜20万收益相当于年化8%的礼包收益，30万≤净入金＜40万收益相当于年化10%的礼包收益（查看详情），礼包基数600万封顶，600万以上超出部分不享受本次活动</span></span><br clear="all" /></p>
                        <!-- <p class="clear tc before"><span class="fl">我的礼包计算基数：120,000元</span><span class="fr question"><span class="hint_txt">申请日开盘前的存量资金+当日净入金，其它日取净入金为基数，礼包基数按照区间档位进行划分，例：10万≤净入金＜20万，按10万礼包基数，20万≤净入金＜30万，按20万礼包基数</span></span><br clear="all" /></p> -->
                    </div>
                    <div class="fr bonus_bags pr">
                    	<div class="bonus_bags_close pr">
                        	<div class="bonus_dialog pa">您离礼包开启仅一步之遥....</div>
                        	<p class="title">如何开启礼包</p>
                            <p class="txt1">恭喜您参加！满足下面条件礼包将自动开启哦！</p>
                            <p class="txt clear wmz"><span class="fl">礼包基数大于等于10万.</span><br clear="all" /></p>
                            <div class="open"></div>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title_red">证金小秘书提醒您：</p>
                        <p>礼包满足条件后自动开启，将以短信和站内信的形式提醒您。</p>
                        <p>当日开始发放待兑礼包，次日12点后可在礼包详情查看。</p>
                        <p>注：完成交易要求，待兑礼包在活动结束后的15个工作日内兑换。</p>
                    </div>
                    <a href="bonus_detail_bh.jsp?type=0">查看活动详情</a>
                    <div class="clear"></div>
                </div>
                <div class="bonus_bg clear pr" id="bonus_before"  style="display:<c:if test="${hbFlag == 0}">block</c:if><c:if test="${hbFlag != 0}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金礼包</span><span>活动时间：2015-05-08至06-30</span></p>
                        <p class="baiyin num1">8<span>%</span>-18<span>%</span></p>
                        <p class="shiyou num1">9<span>%</span>-19<span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金礼包收益率）</span><span class="fr question"><span class="hint_txt">10万≤净入金＜20万收益相当于年化8%的礼包收益，30万≤净入金＜40万收益相当于年化10%的礼包收益（查看详情），礼包基数600万封顶，600万以上超出部分不享受本次活动</span></span><br clear="all" /></p>
                        <!-- <p class="clear tc before"><span class="fl">我的礼包计算基数：120,000元</span><span class="fr question"><span class="hint_txt">申请日开盘前的存量资金+当日净入金，其它日取净入金为基数，礼包基数按照区间档位进行划分，例：10万≤净入金＜20万，按10万礼包基数，20万≤净入金＜30万，按20万礼包基数</span></span><br clear="all" /></p> -->
                        
                    </div>
                    <div class="fr bonus_bags pr">
                    	<div class="bonus_bags_close pr">
                        	<p class="title">每日赚礼包</p>
                            <p class="clear je"><span class="fl">待兑礼包金额</span><span class="fr question"><span class="hint_txt">每日礼包金额之和，活动期间如有出金操作，累计礼包总金额将会清零</span></span><br clear="all" /></p>
                            <p class="tc no">0.00<span>元</span></p>
                            <input name="" type="button" class="join" onclick="showAgreement();"/>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title_red">证金小秘书提醒您：</p>
                        <p>礼包满足条件后自动开启，将以短信和站内信的形式提醒您。</p>
                        <p>当日开始发放待兑礼包，次日12点后可在礼包详情查看。</p>
                        <p>注：完成交易要求，待兑礼包在活动结束后的15个工作日内兑换。</p>
                    </div>
                    <a href="bonus_detail_bh.jsp?type=0">查看活动详情</a>
                    <div class="clear"></div>
                </div>
                <div class="bonus_bg clear pr" id="bonus_detail" style="display:<c:if test="${hbFlag == 1 && hasTrade == 1}">block</c:if><c:if test="${!(hbFlag == 1 && hasTrade == 1)}">none</c:if>;">
                	<div class="fl bonus_num">
                    	<p class="f12 time"><span class="title">证金礼包</span><span>活动时间：2015-05-08至06-30</span></p>
                        <p class="baiyin num1">8<span>%</span>-18<span>%</span></p>
                        <p class="shiyou num1">9<span>%</span>-19<span>%</span></p>
                        <p class="clear tc hint"><span class="fl">（证金礼包收益率）</span><span class="fr question"><span class="hint_txt">10万≤净入金＜20万收益相当于年化8%的礼包收益，30万≤净入金＜40万收益相当于年化10%的礼包收益（查看详情），礼包基数600万封顶，600万以上超出部分不享受本次活动</span></span><br clear="all" /></p>
                        <!-- <p class="clear tc before"><span class="fl">我的礼包计算基数：120,000元</span><span class="fr question"><span class="hint_txt">申请日开盘前的存量资金+当日净入金，其它日取净入金为基数，礼包基数按照区间档位进行划分，例：10万≤净入金＜20万，按10万礼包基数，20万≤净入金＜30万，按20万礼包基数</span></span><br clear="all" /></p> -->
                        
                    </div>
                    <div class="fr bonus_bags pr" style="padding-top:20px;">
                    	<div class="bonus_bags_open pr">
                            <p class="clear je pt10"><span class="fl">待兑礼包金额</span><span class="fr question"><span class="hint_txt">每日礼包金额之和，活动期间如有出金操作，累计礼包总金额将会清零</span></span><br clear="all" /></p>
                            <p class="tc no">
							 <%if(prizes != null && prizes.size() > 0){
                            	Map map = (Map)prizes.get(prizes.size()-1);
                            	out.print(map.get("ChangeAmount"));
                            }else{
                            	out.print("0.00");
                            }%>
							<span>元</span></p>
							<%if(prizes != null && prizes.size() > 0){
								Map map = (Map)prizes.get(prizes.size()-1);
                            	if((Double)(map.get("ChangeAmount"))<=0.0){
                            		out.print("<p>您还未达到兑换礼包的最低档位要求，继续加油哦~~(具体数据：请查看下方礼包详情！)</p>");
                            	}
                            }%>
                        </div>
                    </div>
                    <div class="pa f12 bonus_hint" style="left:375px;bottom:5px;">
                        <p class="title_red">证金小秘书提醒您：</p>
                        <p>礼包满足条件后自动开启，将以短信和站内信的形式提醒您。</p>
                        <p>当日开始发放待兑礼包，次日12点后可在礼包详情查看。</p>
                        <p>注：完成交易要求，待兑礼包在活动结束后的15个工作日内兑换。</p>
                    </div>
                    <a href="bonus_detail_bh.jsp?type=0">查看活动详情</a>
                    <div class="clear"></div>
                </div>
                <!-- 修改 -->
                <div class="bonus_agreement pa" style="display:none">
                	<input name="" type="button" value="×" class="bonus_agreement_close pa" onclick="$(this).parent().hide();" />
                	<p>请您阅读并同意《证金礼包活动协议》以完成参加这次活动。</p>
                    <div class="bonus_agreement_main">
                    	<h3 class="tc">证金礼包活动参与协议</h3>
                        <p>《证金礼包活动参与协议》（“协议”）是您（“用户”）与证金（“我公司”）之间有关参与证金礼包活动的法律协议。我公司在此特别提示用户认真阅读、充分理解本协议内容，并审慎选择接受或不接受本协议。用户一旦点击同意，即表示完全接受协议内容并同意接受本协议各项条款的约束。</p>
                        <p class="fb">证金礼包活动规则</p>
                        <p>1、	礼包活动时间：</p>
                        <p class="fb ti">5月8日-6月30日（54个自然日）</p>
                        
                        <p>2、	参与礼包资格：</p>
                        <p class="ti">天通银、海西银、大圆银、现货重油、海西油的客户，活动期内在个人中心申请成功且净入金大于等于10万元均可参与礼包活动，并从参与之日起开始计入礼包收益</p>
                        
                        <p>3、	获取礼包资格：</p>
                        <p class="ti">1) 礼包计算：</p> 
                        <p class="fb ti">计算公式：礼包=礼包基数*礼包收益率*N/365（N是参与活动天数）</p>
                        <p class="fb ti">活动期内，客户符合净入金要求且完成相应的交易手数（活动期内建仓和平仓才计算在内），即可获取相对应的礼包收益率，并通过礼包基数计算出礼包收益。</p>
                        <p class="ti"><b>礼包基数：</b>申请日开盘前的存量资金+当日净入金，其它日取净入金为基数，礼包基数按照区间档位进行划分，例如：10万≤净入金＜20万就算10万礼包基数，20万≤净入金＜30万就算20万礼包基数；</p>
                        <p class="ti">注：老客户以申请日开盘前的存量资金+活动期净入金计算，新客户按照当天净入金+活动期间净入金计算。</p>
                        
                        <p class="ti">2) 交易标准手定义：</p>
                        <p class="ti">天通银/海西银/大圆银1手标准手=15kg</p>
                        <p class="ti">海西油1手标准手=500桶</p>
                        <p class="ti">现货重油1手标准手=50吨</p>

                        <p>4、	礼包计算规则：</p>
                        <p class="fb ti">规则1：5月8日参加活动，客户的净入金必须按照礼包基数的档位划分</p>
                        <p class="ti">例如：15万的净入金也按照10万的礼包基数计算，完成200手交易要求后：白银礼包=10万*8%*54/365=1183.56元，而不是15万*8%*54/365，石油礼包=10万*9%*54/365=1331.51元，而不是15万*9%*54/365</p>
                        <p class="fb ti">规则2：5月8日参加活动，客户完成更高档交易数额，按照更高档对应的礼包收益率计算礼包</p>
                        <p class="ti">例如：20万的净入金完成400手即可获得礼包收益率8.25%，礼包=20万*8.25%*54/365=2441.1元，但是实际交易了600手，那么最终的礼包收益率按照600手对应的礼包收益率10%计算，礼包=20万*10%*54/365=2958.9元</p>
                        <p class="fb ti">规则3：同时拥有多个账户的投资者按照每个账户的礼金基数和交易手数计算礼包金额，礼金基数不能通用</p>
                        <p class="ti"><b>特例：同时操作海西油和海西银的客户，账户资金可以通用</b>，例如：海西所拥有10万净入金的客户，分别交易了200手白银和200手石油，那么获得的礼包收益=10万*8%*54/365+10万*9%*54/365=1331.51元+1183.56元=2515.07元。</p>
                        
                        <p>5、	礼包注意事项：</p>
                        <p class="fb ti">A 活动期间如有出金，此前的礼包将会清零</p>
                        <p class="ti">例1：5月20日账户出金，礼包基数在10万以下，那么5月8日至5月20日礼包和交易手数清零，后期需要重新加金至10万以上且交易至规定标准手数，方可自满足条件之日起重新计算并享受礼包；</p>
                        <p class="ti">例2：5月20日账户出金，剩余礼包基数在10万以上，那么5月8日至5月20日起礼包和交易手数清零，在5月20日之后起开始重新计算礼包基数和交易手数；</p>
                        <p class="ti">例3：针对30万以上的客户而言，假设5月20日账户出金，剩余礼包基数大于20万，那么5月8日至5月20日礼包清零，在5月20日当日重新按照新的礼包基数×10%（石油11%）×1/365的标准发放礼包，倘若剩余礼包基数小于20万，但高于10万，则5月8日至5月20日礼包清零，在5月20日以新的礼包基数×8%（石油9%）×1/365的标准享受礼包；</p>
                        <p class="fb ti">B 礼包基数受活动期净入金和交易手数影响，而交易盈亏不影响礼包基数；</p>
                        <p class="fb ti">C 每天中午12点以后，可以登录个人中心查看昨日礼包收益情况及明细；</p>
                        <p class="fb ti">拥有多个账户，开启礼包后无交易的按净入金最多的账户显示收益明细，有交易的按交易量最多的账户显示收益明细；</p>
                        <p class="fb ti">D 活动结束后十五个交易日内，公司统一为符合条件的客户发放礼包；</p>
                        <p class="fb ti">E 每个交易账户单独参与本次活动，不合并计算（特例除外）</p>
                        
                        <p class="fb">风险提示</p>
                        <p>1、认识风险</p>
                        <p>用户需认识到贵金属和石油投资的风险性，用户需结合自身的知识储备、投资经验、投资需求、风险偏好及自身的收入状况、资金量级等决定是否参与本活动，并独立做出投资决策，用户贸然投资可能产生潜在投资风险；</p>
                        <p>2、经营风险</p>
                        <p>因国家行业政策调整、法律法规修订等外部经营环境发生变化，我公司有权调整活动内容或暂停、中断本活动，但有义务告知用户，用户应知悉上述风险；</p>
                        <p>3、第三方风险</p>
                        <p>因网络接入单位、电信平台支持单位等第三方的网络故障、设备故障、系统故障，造成活动详情在网站显示错误、迟延、异常，或因数据原因导致的客户礼包金额统计错误、显示错误等，在此提示客户注意此类风险；</p>
                        <p>4、不可抗力风险</p>
                        <p>因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其它重大疫情、火灾等不可抗力或网络受到黑客攻击、网络病毒侵入或发作可能本活动信息显示异常或本活动提前终止；</p>
                        <p class="ti">上述风险提示并不保证完全揭示或充分说明用户参与本活动过程中的全部风险，建议用户仔细阅读上述提示，并认识到贵金属投资蕴含的较高风险。用户如同意本协议并参与本活动视为已对风险有足够清醒客观的认知，能够自主做出投资决策并独立承担投资风险。</p>
                        
                        <p class="fb">免责条款</p>
                        <p class="ti">因下列情形导致本活动信息传递延迟、或本活动中断、终止，我公司不承担法律责任：</p>
                        <p>1、因互联网接入单位、短信发送商、移动运营商等第三方的线路故障、通讯故障造成的信息传递异常；</p>
                        <p>2、我公司对网站进行停机维护或公司经营方针调整；</p>
                        <p>3、因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其它重大疫情、火灾造成的及其它不可抗力造成的网络服务异常；</p>
                        <p>4、因黑客攻击、网络病毒侵入或发作、网络管制导致活动信息显示异常；</p>
                        <p>5、我公司有权根据公司经营情况、突发性的政治或经济等因素决定随时终止本活动。本活动一经终止，所有礼包不再发放，不得兑现，且本公司不承担任何法律责任。</p>
                        
                        <p class="fb">协议效力</p>
                        <p>1、本协议为用户与我公司就证金礼包活动达成的最终和唯一的正式文本，取代和撤消双方之间先前所有的书面或口头保证、承诺、声明及其它一切书面文件。</p>
                        <p>2、如本协议的任何条款违法、无效，或因某种原因不可执行，那么该条款被认为与本协议分离，不影响本协议其它条款的效力。</p>
                        <p>3、我公司保留不定时修改活动内容及活动规则的权利，更新后的活动规则一旦公布即替代原来的活动规则，恕不再另行通知。</p>
                        
                        <p class="fb">争议解决</p>
                        <p>1、本协议的解释、效力及纠纷的解决，适用中华人民共和国法律。若用户和我公司发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此同意将纠纷或争议提交我公司所在地人民法院管辖。</p>
                        <p>2、本协议的解释权在法律允许的范围内归我公司所有。我公司有权不时修改、补充、完善本协议。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。</p>
                    </div>
                    <div class="tc"><input name="" type="button" class="bonus_agreement_btn1" value="我不同意" onclick="$('.bonus_agreement').hide();"/><input name="" type="button" class="bonus_agreement_btn2" value="我已阅读并同意" onclick="party();$('.bonus_agreement').hide();"/></div>
                </div>
                <!-- 红包end -->
                <div class="bonus_detail">
                	<ul class="bonus_tab">
                    	<li id="hdxq" class="sl" onclick="$('.tab_table').hide();$('.tab_table1').show();$('.bonus_tab li').removeClass();$(this).addClass('sl');">活动详情</li>
                        <li id="hbxq" onclick="$('.tab_table').hide();$('.tab_table2').show();$('.bonus_tab li').removeClass();$(this).addClass('sl');">礼包详情</li>
                    </ul>
                    <div class="tab_table1 tab_table ">
                        <p class="title">1、礼包活动时间：</p>
                        <p>5月8日-6月30日（54个自然日）</p>
                        <p class="title">2、参与活动资格：</p>
                        <p>天通银、海西银、大圆银、现货重油、海西油的客户，活动期内在个人中心申请成功且净入金大于等于10万元均可参与礼包活动，并从参与之日起开始计入礼包收益；</p>
                        <p class="title">3、获取礼包规则：</p>
                        <p>1）礼包计算</p>
                        <p>计算公式</p>
                        <p>礼包=礼包基数*礼包收益率*N/365（N是参与活动天数）</p>
                        <p>活动期内，客户符合净入金要求且完成相应的交易手数（活动期内建仓和平仓才计算在内），即可获取相对应的礼包收益率，并通过礼包基数计算出礼包收益。</p>
                        <p>礼包基数：申请日开盘前的存量资金+当日净入金，其它日取净入金为基数，礼包基数按照区间档位进行划分，例如：10万≤净入金＜20万就算10万礼包基数，20万≤净入金＜30万就算20万礼包基数；</p>
                        <p>注：老客户以申请日开盘前的存量资金+活动期净入金计算，新客户按照当天净入金+活动期间净入金计算。</p>
                        
                        <p>2）交易标准手定义：</p>
                        <p>天通银/海西银/大圆银1手标准手=15kg</p>
                        <p>海西油1手标准手=500桶</p>
                        <p>现货重油1手标准手=50吨</p>
                        
                        <p class="title">4、礼包计算规则：</p>
                        <p><b>规则1：5月8日参加活动，客户的净入金必须按照礼包基数的档位划分</b></p>
                        <p>例如：15万的净入金也按照10万的礼包基数计算，完成200手交易要求后：白银礼包=10万*8%*54/365=1183.56元，而不是15万*8%*54/365，石油礼包=10万*9%*54/365=1331.51元，而不是15万*9%*54/365</p>
                        <p><b>规则2：5月8日参加活动，客户完成更高档交易数额，按照更高档对应的礼包收益率计算礼包</b></p>
                        <p>例如：20万的净入金完成400手即可获得礼包收益率8.25%，礼包=20万*8.25%*54/365=2441.1元，但是实际交易了600手，那么最终的礼包收益率按照600手对应的礼包收益率10%计算，礼包=20万*10%*54/365=2958.9元</p>
                        <p><b>规则3：同时拥有多个账户的投资者按照每个账户的礼包基数和交易手数计算礼包金额，礼包基数不能通用</b></p>
                        <p><b class="red">特例：同时操作海西油和海西银的客户，账户资金可以通用</b>，例如：5月8日参加活动，海西所拥有10万净入金的客户，分别交易了200手白银和200手石油，那么获得的礼包收益=10万*8%*54/365+10万*9%*54/365=1331.51元+1183.56元=2515.07元。</p>
                        
                        <table border="0" cellpadding="0" cellspacing="0" style="border:none">
                        	<tr style="border:none">
                            	<td style="border:none">
                                	<p><b class="red">白银礼包明细表</b></p>
                        
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <th style="padding:0 5px;">礼金基数</th>
                                            <th style="padding:0 5px;">交易手数</th>
                                            <th style="padding:0 5px;">礼包收益率</th>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>100000</td>
                                            <td>200</td>
                                            <td>8.00%</td>
                                        </tr>
                                        <tr>
                                            <td>200000</td>
                                            <td>400</td>
                                            <td>8.25%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>300000</td>
                                            <td>600</td>
                                            <td>10.00%</td>
                                        </tr>
                                        <tr>
                                            <td>400000</td>
                                            <td>800</td>
                                            <td>10.25%</td>
                                        </tr>
                                        <tr>
                                            <td>500000</td>
                                            <td>1000</td>
                                            <td>10.50%</td>
                                        </tr>
                                        <tr>
                                            <td>600000</td>
                                            <td>1200</td>
                                            <td>10.75%</td>
                                        </tr>
                                        <tr>
                                            <td>700000</td>
                                            <td>1400</td>
                                            <td>11.00%</td>
                                        </tr>
                                        <tr>
                                            <td>800000</td>
                                            <td>1600</td>
                                            <td>11.25%</td>
                                        </tr>
                                        <tr>
                                            <td>900000</td>
                                            <td>1800</td>
                                            <td>11.50%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>1000000</td>
                                            <td>2000</td>
                                            <td>13.00%</td>
                                        </tr>
                                        <tr>
                                            <td>1200000</td>
                                            <td>2400</td>
                                            <td>13.25%</td>
                                        </tr>
                                        <tr>
                                            <td>1400000</td>
                                            <td>2800</td>
                                            <td>13.50%</td>
                                        </tr>
                                        <tr>
                                            <td>1600000</td>
                                            <td>3200</td>
                                            <td>13.75%</td>
                                        </tr>
                                        <tr>
                                            <td>1800000</td>
                                            <td>3600</td>
                                            <td>14.00%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>2000000</td>
                                            <td>4000</td>
                                            <td>15.00%</td>
                                        </tr>
                                        <tr>
                                            <td>2500000</td>
                                            <td>5000</td>
                                            <td>15.25%</td>
                                        </tr>
                                        <tr>
                                            <td>3000000</td>
                                            <td>6000</td>
                                            <td>15.50%</td>
                                        </tr>
                                        <tr>
                                            <td>3500000</td>
                                            <td>7000</td>
                                            <td>15.75%</td>
                                        </tr>
                                        <tr>
                                            <td>4000000</td>
                                            <td>8000</td>
                                            <td>16.00%</td>
                                        </tr>
                                        <tr>
                                            <td>4500000</td>
                                            <td>9000</td>
                                            <td>16.25%</td>
                                        </tr>
                                        <tr>
                                            <td>5000000</td>
                                            <td>10000</td>
                                            <td>16.50%</td>
                                        </tr>
                                        <tr>
                                            <td>5500000</td>
                                            <td>11000</td>
                                            <td>16.75%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>6000000</td>
                                            <td>12000</td>
                                            <td>18.00%</td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="border:none">&nbsp;</td>
                                <td style="border:none">
                                	<p><b class="red">石油礼包明细表</b></p>
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <th style="padding:0 5px;">礼金基数</th>
                                            <th style="padding:0 5px;">交易手数</th>
                                            <th style="padding:0 5px;">礼包收益率</th>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>100000</td>
                                            <td>200</td>
                                            <td>9.00%</td>
                                        </tr>
                                        <tr>
                                            <td>200000</td>
                                            <td>400</td>
                                            <td>9.25%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>300000</td>
                                            <td>600</td>
                                            <td>11.00%</td>
                                        </tr>
                                        <tr>
                                            <td>400000</td>
                                            <td>800</td>
                                            <td>11.25%</td>
                                        </tr>
                                        <tr>
                                            <td>500000</td>
                                            <td>1000</td>
                                            <td>11.50%</td>
                                        </tr>
                                        <tr>
                                            <td>600000</td>
                                            <td>1200</td>
                                            <td>11.75%</td>
                                        </tr>
                                        <tr>
                                            <td>700000</td>
                                            <td>1400</td>
                                            <td>12.00%</td>
                                        </tr>
                                        <tr>
                                            <td>800000</td>
                                            <td>1600</td>
                                            <td>12.25%</td>
                                        </tr>
                                        <tr>
                                            <td>900000</td>
                                            <td>1800</td>
                                            <td>12.50%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>1000000</td>
                                            <td>2000</td>
                                            <td>14.00%</td>
                                        </tr>
                                        <tr>
                                            <td>1200000</td>
                                            <td>2400</td>
                                            <td>14.25%</td>
                                        </tr>
                                        <tr>
                                            <td>1400000</td>
                                            <td>2800</td>
                                            <td>14.50%</td>
                                        </tr>
                                        <tr>
                                            <td>1600000</td>
                                            <td>3200</td>
                                            <td>14.75%</td>
                                        </tr>
                                        <tr>
                                            <td>1800000</td>
                                            <td>3600</td>
                                            <td>15.00%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>2000000</td>
                                            <td>4000</td>
                                            <td>16.00%</td>
                                        </tr>
                                        <tr>
                                            <td>2500000</td>
                                            <td>5000</td>
                                            <td>16.25%</td>
                                        </tr>
                                        <tr>
                                            <td>3000000</td>
                                            <td>6000</td>
                                            <td>16.50%</td>
                                        </tr>
                                        <tr>
                                            <td>3500000</td>
                                            <td>7000</td>
                                            <td>16.75%</td>
                                        </tr>
                                        <tr>
                                            <td>4000000</td>
                                            <td>8000</td>
                                            <td>17.00%</td>
                                        </tr>
                                        <tr>
                                            <td>4500000</td>
                                            <td>9000</td>
                                            <td>17.25%</td>
                                        </tr>
                                        <tr>
                                            <td>5000000</td>
                                            <td>10000</td>
                                            <td>17.50%</td>
                                        </tr>
                                        <tr>
                                            <td>5500000</td>
                                            <td>11000</td>
                                            <td>17.75%</td>
                                        </tr>
                                        <tr style="background:#FF0;">
                                            <td>6000000</td>
                                            <td>12000</td>
                                            <td>19.00%</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <p class="title">5、礼包注意事项：</p>
                        <p><b>A 活动期间如有出金，此前的礼包将会清零</b></p>
                        <p>例1：5月20日账户出金，礼包基数在10万以下，那么5月8日至5月20日礼包和交易手数清零，后期需要重新加金至10万以上且交易至规定标准手数，方可自满足条件之日起重新计算并享受礼包；</p>
                        <p>例2：5月20日账户出金，剩余礼包基数在10万以上，那么5月8日至5月20日起礼包和交易手数清零，在5月20日之后起开始重新计算礼包基数和交易手数；</p>
                        <p>例3：针对30万以上的客户而言，假设5月20日账户出金，剩余礼包基数大于20万，那么5月8日至5月20日礼包清零，在5月20日当日重新按照新的礼包基数×10%（石油11%）×1/365的标准发放礼包，倘若剩余礼包基数小于20万，但高于10万，则5月8日至5月20日礼包清零，在5月20日以新的礼包基数×8%（石油9%）×1/365的标准享受礼包；</p>
                        <p><b>B 礼包基数受活动期净入金和交易手数影响，而交易盈亏不影响礼包基数；</b></p>
                        <p><b>C 每天中午12点以后，可以登录个人中心查看昨日礼包收益情况及明细；</b></p>
                        <p><b>拥有多个账户，开启礼包后无交易的按净入金最多的账户显示收益明细，有交易的按交易量最多的账户显示收益明细；</b></p>
                        <p><b>D 活动结束后十五个交易日内，公司统一为符合条件的客户发放礼包；</b></p>
                        <p><b>E 每个交易账户单独参与本次活动，不合并计算（特例除外）</b></p>
                    </div>
                    
                    
                    <div class="tab_table2 tab_table hide">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <thead>
                        	<tr>
                            	<th><div style="width:88px; margin:0 auto;">交易所(品种)</div></th>
                                <th><div style="width:60px; margin:0 auto;"><span class="fl">净入金</span><span class="fl question"><span class="hint_txt" style="display:none">活动期间，入金-出金=净入金，交易盈亏不影响净入金</span></span></div></th>
                                <th>礼包基数</th>
                                <th><div style="width:110px; margin:0 auto;"><span class="fl">对应交易档位</span><span class="fl question"><span class="fl hint_txt" style="display:none">活动期间，如果达到相应交易档位就可以在活动结束后兑现礼包金额，如未达到相应交易档位要求，则到期无法兑换礼包金额</span></span></div></th>
                                <th><div style="width:76px; margin:0 auto;"><span class="fl">当前交易</span><span class="fl question"><span class="fl hint_txt" style="display:none">目前已经完成的交易数量，天通银/海西银/大圆银1手标准手=15kg，海西油1手标准手=500桶，现货重油1手标准手=50吨</span></span></div></th>
                                <th><div style="width:91px; margin:0 auto;"><span class="fl">礼包收益率</span><span class="fl question"><span class="fl hint_txt" style="display:none">10万≤净入金＜20万收益相当于年化8%的礼包收益，30万≤净入金＜40万收益相当于年化10%的礼包收益（查看详情），礼包基数600万封顶，600万以上超出部分不享受本次活动</span></span></div></th>
                                <th>参与日期</th>
                            </tr>
                            <%
                          	 if(prizes != null){
                          		 for(int i = prizes.size()-1; i >= 0; i--){
                          			Map map = (Map)prizes.get(i);
                          			 out.print("<tr>");
                          			 if(map.get("ExchangeID").equals("1") && map.get("ZJKind").equals("白银")){
	                          			 out.print("<td>海西银</td>");
                          			 }else if(map.get("ExchangeID").equals("1") && map.get("ZJKind").equals("石油")){
                          				out.print("<td>海西油</td>");
                          			 }else if(map.get("ExchangeID").equals("2") && map.get("ZJKind").equals("白银")){
                          				out.print("<td>天通银</td>");
                          			 }else if(map.get("ExchangeID").equals("3") && map.get("ZJKind").equals("白银")){
                          				out.print("<td>大圆银</td>");
                          			 }else if(map.get("ExchangeID").equals("4") && map.get("ZJKind").equals("石油")){
                          				out.print("<td>现货重油</td>");
                          			 }else{
                          				out.print("<td>暂无对应类型</td>");
                          			 }
                          			 out.print("<td>"+map.get("Fund")+"元</td>");
                          			 out.print("<td>"+map.get("BaseFund")+"元</td>"); 
                          			 out.print("<td>"+map.get("BaseQuantity")+"</td>");
                          			 out.print("<td>"+map.get("Quantity")+"</td>");
                          			 out.print("<td>"+Double.valueOf((String)map.get("BaseRate"))*100+"%</td>");
                          			 out.print("<td>"+map.get("MinDay")+"</td>");
                          			out.print("</tr>");
                          		 }
                          		
                          	 }
                          %>
                            <c:if test="${fn:length(prizes) <= 0}">
                            <tr> <td colspan="7">暂无记录</td> </tr>
                            </c:if>
                        </thead>
                        </table>
                    </div>
                </div>
            	</div>
            </div>
      	</div>
      	<div class="clear"></div>
    </div>
    <!--foot--><!-- 修改 -->
     <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
    <!--foot-end--><!-- 修改end -->
</body>
</html>


