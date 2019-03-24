<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String mobile = getLoginMobile(request);
Integer isparty = 0;
if(mobile != null)
	isparty = isPartyBGJH(mobile);
Integer activation = 0;
Double total = 0D;
if(isparty == 1){
	List<Map> nprizes = getUserPrizeList(mobile, 5);
	if(getUserState(nprizes))
		activation = 1;
	if(nprizes != null && nprizes.size()>0)
		total = (Double)nprizes.get(nprizes.size()-1).get("ChangeAmount");
}
pageContext.setAttribute("isBgjh", isparty);
pageContext.setAttribute("activation", activation);
pageContext.setAttribute("total", total);
%>

<script type="text/javascript" src="../js/jquery.watermark-min.js"></script>
<script type="text/javascript">
	function partyBGJH(){
		var flag = false;
		$.ajax({ url: "json.jsp", async:false, data:{act:'partybgjh'}, dataType:"json", success: function (data) {
			if(data.state == 0 && data.code >= 0){
				$('.bonusganggan_wycjbutton').attr("onclick","");
				$('.bonusganggan_wycjbutton').val("已参加");
				flag = true;
			}else{
				alert(data.msg);
				$('.bonusganggan_agreement').hide();
			}
		}});
		return flag;
	}
	
	function subPartyDetail(){
		var flag = false;
		var name = $('#tc_name').val();
		var carNo = $('#tc_carNo').val();
		$.ajax({ url: "json.jsp", async:false, data:{act:'updatebgjh',carNo:carNo, name:name}, dataType:"json", success: function (data) {
			if(data.state == 0){
				flag = true;
			}
		}});
		
		$('#tc_ybw01').hide();
		return flag;
	}
	$(document).ready(function(){
		$("#tc_carNo").watermark({watermarkText: "请输入您的车牌号码"});
		$("#tc_name").watermark({watermarkText: "请输入您的姓名"});
	})
	
</script>
<!-- start-红包加油卡  -->
<div class="bonusganggan_bg clear pr" id="bonusganggan_detail">
	<div class="fl bonusganggan_num">
    	<p class="f12 time"><span>活动日期：2015年6月23日至2015年7月31日</span></p>
        <p class="tc blackword">您已经获得油卡充值金额</p>
        <p class="tc num"><fmt:formatNumber value="${total}" pattern="#,##0.00#"/></p>
        <p class="clear tc before">油卡状态：
        <c:if test="${isBgjh!=1 || (isBgjh==1 && activation == 0)}">
        <span>未激活</span>
        </c:if>
        <c:if test="${isBgjh==1 && activation == 1}">
        <span>已激活</span>
        </c:if>
        <span class="fr question"><span class="hint_txt">加油礼包激活条件，点击“我要参加”报名，交易1标准手石油，标准手定义，海西1手，齐鲁1手50T或者5手10T。</span></span></p>
        
    </div>                    
    <div class="clear"></div>
    <%-- <input class="bonusganggan_wycjbutton" type="button" <c:if test="${isBgjh!=1 }">value="我要参加" onclick="$('.bonusganggan_agreement').show();"</c:if><c:if test="${isBgjh==1 }">value="已参加"</c:if>/> --%>
    <input class="bonusganggan_wycjbutton" type="button" value="活动已结束"/>
</div>
<!-- 红包加油卡 -end -->
<!-- start 红包加油卡 -协议 -->
<div class="bonusganggan_agreement hide">
	<input name="" type="button" value="×" class="bonusganggan_agreement_close pa" onclick="$(this).parent().hide();" />
          	<p>请您阅读并同意《证金标杆计划油卡礼包活动参与协议》以完成参加这次活动。</p>
              <div class="bonusganggan_agreement_main">
              	<h3 align="center">证金标杆计划油卡礼包活动参与协议 </h3>
                  <p>《证金标杆计划油卡礼包活动参与协议》（“协议”）是您（“用户”）与证金（“我公司”）之间有关参与证金油卡礼包活动的法律协议。我公司在此特别提示用户认真阅读、充分理解本协议内容，并审慎选择接受或不接受本协议。用户一旦点击同意，即表示完全接受协议内容并同意接受本协议各项条款的约束。</p>
                  <p class="fb">证金礼包活动规则</p>
                <p class="ti" style="color:red;">本活动于6月23日开启，6月23日前报名，净入金取的是6月22日收盘结算账户净值</p>
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
                  <p class="fb">风险提示</p>
                  <p class="ti">1、认识风险</p>
                  <p class="ti">用户需认识到贵金属和石油投资的风险性，用户需结合自身的知识储备、投资经验、投资需求、风险偏好及自身的收入状况、资金量级等决定是否参与本活动，并独立做出投资决策，用户贸然投资可能产生潜在投资风险；</p>
                  <p class="ti">2、经营风险</p>
                  <p class="ti">因国家行业政策调整、法律法规修订等外部经营环境发生变化，我公司有权调整活动内容或暂停、中断本活动，但有义务告知用户，用户应知悉上述风险；</p>
                  <p class="ti">3、第三方风险</p>
                  <p class="ti">因网络接入单位、电信平台支持单位等第三方的网络故障、设备故障、系统故障，造成活动详情在网站显示错误、迟延、异常，或因数据原因导致的客户礼包金额统计错误、显示错误等，在此提示客户注意此类风险；</p>
                  <p class="ti">4、不可抗力风险</p>
                  <p class="ti">因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其他重大疫情、火灾等不可抗力或网络受到黑客攻击、网络病毒侵入或发作可能本活动信息显示异常或本活动提前终止；</p>
                  <p class="ti">上述风险提示并不保证完全揭示或充分说明用户参与本活动过程中的全部风险，建议用户仔细阅读上述提示，并认识到贵金属投资蕴含的较高风险。用户如同意本协议并参与本活动视为已对风险有足够清醒客观的认知，能够自主做出投资决策并独立承担投资风险。</p>
                  <p class="fb">免责条款</p>
                  <p class="ti">因下列情形导致本活动信息传递延迟、或本活动中断、终止，我公司不承担法律责任：</p>
                  <p class="ti">1、因互联网接入单位、短信发送商、移动运营商等第三方的线路故障、通讯故障造成的信息传递异常；</p>
                  <p class="ti">2、我公司对网站进行停机维护或公司经营方针调整；</p>
                  <p class="ti">3、因地震、台风、战争、罢工、瘟疫、爆发性和流行性传染病或其他重大疫情、火灾造成的及其他不可抗力造成的网络服务异常；</p>
                  <p class="ti">4、因黑客攻击、网络病毒侵入或发作、网络管制导致活动信息显示异常；</p>
                  <p class="ti">5、我公司有权根据公司经营情况、突发性的政治或经济等因素决定随时终止本活动。本活动一经终止，所有礼包不再发放，不得兑现，且本公司不承担任何法律责任。</p>
                  <p class="fb">协议效力</p>
                  <p class="ti">1、本协议为用户与我公司就证金礼包活动达成的最终和唯一的正式文本，取代和撤消双方之间先前所有的书面或口头保证、承诺、声明及其他一切书面文件。</p>
                  <p class="ti">2、如本协议的任何条款违法、无效，或因某种原因不可执行，那么该条款被认为与本协议分离，不影响本协议其他条款的效力。</p>
                  <p class="ti">3、我公司保留不定时修改活动内容及活动规则的权利，更新后的活动规则一旦公布即替代原来的活动规则，恕不再另行通知。</p>
                  <p class="fb">争议解决</p>
                  <p class="ti">1、本协议的解释、效力及纠纷的解决，适用中华人民共和国法律。若用户和我公司发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此同意将纠纷或争议提交我公司所在地人民法院管辖。</p>
                  <p class="ti">2、本协议的解释权在法律允许的范围内归我公司所有。我公司有权不时修改、补充、完善本协议。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。</p>
          </div>
              <div class="tc"><input name="" type="button" class="bonusganggan_agreement_btn1" value="我不同意" onclick="$('.bonusganggan_agreement').hide();"/>
<input name="" type="button" class="bonusganggan_agreement_btn2" value="我已阅读并同意" onclick="if(partyBGJH()){$('.bonusganggan_agreement').hide();$('#tc_ybw01').show();}"/>
      </div>
</div>
<!-- 红包加油卡 -协议-end -->
<!-- start-红包加油卡 -录入框 -->
     <div class="tc-whole" id="tc_ybw01">
<div class="tc-login">
    <div class="tc01">	
    <input class="tc-name" type="text" value="请输入您的车牌号码" id="tc_carNo"/>
    <input class="tc-phone" type="text"  value="请输入您的姓名" id="tc_name"/>
    <input id="ljland" class="tc-submit" type="button" value="" onclick="subPartyDetail();"/>  
    <div class="tc-close" id="error01" onclick="$('#tc_ybw01').hide();"></div>
        </div>
    </div>
</div>
<!-- 红包加油卡 -录入框 -end -->
