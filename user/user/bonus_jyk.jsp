<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	try{
	String mobile1 = getLoginMobile(request);
	List<Map> prizes = null;
	if(mobile1 != null){
		Map info = getUserInfoFromCacheOrCrm(request, response, mobile1);
		Integer isparty = isPartyBGJH(mobile1); 
		if(isparty == 1){
			//红包详情
			prizes = getUserPrizeList(mobile1, 5);
		}
		//log.info("################ " + prizes);
		pageContext.setAttribute("prizes", prizes);
		pageContext.setAttribute("pageSize", 10);
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
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
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
        		<p class="personal_right_title">个人中心</p>
                
                <%@ include file="bonus_jyk_package.jsp"%>
                
                <div class="bonusganggan_detail">
                        <ul class="bonusganggan_tab">
                            <li class="sl" onclick="$('.tab_table').hide();$('.tab_table1').show();$('.bonusganggan_tab li').removeClass();$(this).addClass('sl');">活动详情</li>
                            <li onclick="$('.tab_table').hide();$('.tab_table2').show();$('.bonusganggan_tab li').removeClass();$(this).addClass('sl');">红包详情</li>
                        </ul>
                    
                    <div class="tab_table1 tab_table " style="background:#fff;width:740px;height:770px;">
                    
                        <p class="ti">1、活动时间：</p>
		                <p class="ti">2015年6月23日-2015年7月31日</p>
		                <p class="ti">2、入围资格：活动期间海西或齐鲁的净入金大于等于10万元；</p>
		                <p class="ti">3、 获取资格：活动期间没有出金动作，并在活动期操作1标准手石油；</p>
		                  <p class="ti">标准手定义：海西油1手标准手=500桶，现货重油1手标准手=50吨；现货重油5手10吨等于1标准手。</p>
		                  <p class="ti">4、活动说明：</p>
		                <p class="ti">4.1活动期间在“个人中心—标杆计划”点击“我要参与”后，您的净入金达到10万元，并且在活动期操作1标准手石油（建仓），便可以从申请参与活动且满足入金条件那天开始每天获取相对应的加油资金，活动结束次月将会把累计金额放在加油卡中寄给您。</p>
		                <p class="ti">
						<table width="362" border="1" align="center" cellpadding="0" cellspacing="0">
						  <tr>
							<td width="202" align="center" bgcolor="#CEFFFF">净入金</td>
							<td width="160" align="center" bgcolor="#CEFFFF">加油卡充值金额</td>
						  </tr>
						  <tr>
							<td align="center">30万﹥净入金≥10万</td>
							<td align="center">38元/天</td>
						  </tr>
						  <tr>
							<td align="center">50万﹥净入金≥30万</td>
							<td align="center">68元/天</td>
						  </tr>
						  <tr>
							<td align="center">100万﹥净入金≥50万</td>
							<td align="center">98元/天</td>
						  </tr>
						  <tr>
							<td align="center">200万﹥净入金≥100万</td>
							<td align="center">188元/天</td>
						  </tr>
						  <tr>
							<td align="center">500万﹥净入金≥200万</td>
							<td align="center">388元/天</td>
						  </tr>
						  <tr>
							<td align="center">净入金≥500万</td>
							<td align="center">888元/天</td>
						  </tr>
						</table>
						</p>
		                  <p class="ti">4.2客户的净入金特指客户在“个人中心-标杆计划”点击“我要参与”的前一个交易日的结算净值。比如6月25日点击参加，则净入金是6月24日交易所结算后账户净值。</p>
		                  <p class="ti">4.3新激活客户在激活当日点击“我要参加”，净入金为激活当日的净入金。</p>
		                  <p class="ti">4.4假如活动期账户出金，则出金日及出金日之前的“加油卡充值金额”清零，从出金日的第二个自然日重新计算“加油卡充值金额”。例如，净入金12万，已经获得38元/天*5天=190元“加油卡充值金额”，出金1万元，则190元清零。从第二个自然日重新计算“加油卡充值金额”，此时客户净入金为11万，需要重新操作1标准手石油，重新计算金额。</p>
		                  <p class="fb">礼包受活动期净入金和交易影响，交易盈亏不影响礼包中每日加油卡的充值金额；</p>
		                  <p class="fb">每天中午12点以后，可以登录个人中心查看昨日礼包情况及明细；</p>
		                  <p class="fb">8月31日之前，公司统一为符合条件的客户发放加油卡；</p>
		                  <p class="fb">加油卡一旦收到，请妥善保管，本加油卡不能挂失或补办；</p>
		                  <p class="fb">每个交易账户单独参与本次活动，不合并计算（特例除外）</p>
		                  <p class="fb">本公司有本活动最终解释权。</p>
                    </div>
                    <div class="tab_table2 tab_table hide">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <thead>
                        	<tr>
                            	<th>交易所</th>
                                <th>净入金</th>
                                <th>获得油卡储值金额</th>
                                <th>日期</th>
                            </tr>
                        </thead>
                        <tbody>
                          <c:if test="${ fn:length(prizes) == 0}">
                          	<tr class="tpage tpage_1">
	                            <td colspan="4">暂无详情数据</td>
	                          </tr>
                          </c:if>
                          <c:set var="pageNo" value="0"/> 
                          <c:forEach items="${ prizes}" var="r" varStatus="status">
                          	  <c:if test="${status.index%pageSize == 0}">
                          	  	<c:set var="pageNo" value="${pageNo+1}"/>  
                          	  </c:if> 
	                          <tr class="tpage tpage_${pageNo} <c:if test="${pageNo!=1}">hide</c:if>">
	                          	<c:if test="${r.ExchangeID==1}"><td>海西</td></c:if>
	                          	<c:if test="${r.ExchangeID==4}"><td>齐鲁</td></c:if>
	                            <td>${r.Fund}</td>
	                            <td>${r.ChangeAmount1}</td>
	                            <td>${r.ChangeTime}</td>
	                          </tr>
                          </c:forEach>
                          
                          <tr>
                            <td colspan="6">
                            	<div class="bonusganggan_page">
                                	<div class="bonusganggan_pager">
                                        <span><a href="javascript:void(0)" onclick="pre();">《上一页</a></span>
                                        <c:forEach begin="1" end="${pageNo}" step="1" var="r">
                                        	<span class="psl pn${r} <c:if test="${r==1}">sl</c:if>">
                                        	<a href="javascript:void(0)" onclick="$('.tpage').hide();$('.tpage_${r}').show();$('.psl').removeClass('sl');$(this).parent().addClass('sl');">${r }</a></span>
                                        </c:forEach>
                                        
                                        <span><a href="javascript:void(0)" onclick="next();">下一页》</a></span>
                                        <input type="hidden" id="pageNum" value="1"/>
                                        <input type="hidden" id="totalPage" value="${pageNo}"/>
                                    </div>
                                </div>
                            </td>
                          </tr>
                        </tbody>
                        </table>
						<script>
							function pre(){
								var pageNum = $('#pageNum').val();
								if(pageNum <= 1)
									return;
								pageNum = parseInt(pageNum) - 1;
								$('.psl').removeClass('sl');$('.pn'+pageNum).addClass('sl');
								$('.tpage').hide();$('.tpage_'+pageNum).show();
								$('#pageNum').val(pageNum);
							}
							function next(){
								var pageNum = $('#pageNum').val();
								var totalPage = $('#totalPage').val();
								if(pageNum >= totalPage)
									return;
								pageNum = parseInt(pageNum) + 1;
								$('.psl').removeClass('sl');$('.pn'+pageNum).addClass('sl');
								$('.tpage').hide();$('.tpage_'+pageNum).show();
								$('#pageNum').val(pageNum);
							}
						</script>
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


