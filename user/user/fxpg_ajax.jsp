<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.Utils"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%!
	private boolean saveFxpgResult(String userId, Integer core, String json){
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), 'fxpg')");
		boolean result = QueryRunner.runSql(sb.toString());
		if(result){
			String key = "fxpg_"+userId;
			Cache.set(key, core, expire);
		}
		return result;
	}

	private Integer hasFxpg(String userId){
		String key = "fxpg_"+userId;
		Integer core = (Integer)Cache.get(key);
		if(core == null){
			String sql = "SELECT * FROM ZX_JsonInfo where type='fxpg' and  jsonInfo like '%"+userId + "%'";
			List list = QueryRunner.getListBySql(sql);
			if(list!= null && list.size()>0){
				Map map = (Map) Json.fromJson((String)((Map)list.get(0)).get("jsonInfo"));
				core = (Integer)map.get("core");
				Cache.set(key, core, expire);
			}
			
		}
		return core;
	}
	
	private boolean delFxpgResult(String userId){
		String key = "fxpg_"+userId;
		Cache.delete(key);
		String sql = "delete FROM ZX_JsonInfo where type='fxpg' and  jsonInfo like '%"+userId + "%'";
		return QueryRunner.runSql(sql);
	}
%>
<%
String type = "0";
String mobile = getLoginMobile(request);
if(mobile != null){
	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	if(info!=null){
		mobile = encrypt(mobile);
		String crmUserId = (String)info.get("UserID");
		Integer VIPTypeID = (Integer)info.get("VIPTypeID");
		if(VIPTypeID == 2 || VIPTypeID == 3 || VIPTypeID == 4){//金卡以上客户才能进行风险评估
			Integer userCore = hasFxpg(crmUserId);
			type = Utils.getParameterValue(request,"type","1");//0无权限进行风险评估，1风险评估问卷，2风险评估结果
			if("1".equals(type)){
				if(userCore != null){//已进行过风险评估,显示结果
					pageContext.setAttribute("core", userCore);
					type = "2";
				}
			}else if("2".equals(type)){//提交问卷结果
				String result = Utils.getParameterValue(request,"result","");
				Integer core = 0;
				if(!"".equals(result) && !"{}".equals(result)){
					Map jsonInfo = new HashMap();
					Map map = (Map) Json.fromJson(result);
					Set<String> keys = map.keySet();
					for(String key: keys){
						Map obj = (Map)map.get(key);
						Integer oid = (Integer)obj.get("oid");
						core += oid;
					}
					jsonInfo.put("result", map);
					jsonInfo.put("userId", crmUserId);
					jsonInfo.put("mobile", mobile);
					jsonInfo.put("core", core);
					
					saveFxpgResult(crmUserId, core, Json.toJson(jsonInfo));
				}
				pageContext.setAttribute("core", core);
			}else if("3".equals(type)){//提交问卷结果
				delFxpgResult(crmUserId);
				type = "1";
			}
		}
	}
}
pageContext.setAttribute("type", type);	
%>
<c:if test="${type==0}">
	<div class="fr about_right">
        	<P align=center>&nbsp;</P>
			<P align=center>&nbsp;</P>
			<P align=center>&nbsp;</P>
			<P align=center>&nbsp;</P>
			<P align=center>&nbsp;</P>
			<P class=STYLE1 align=center>抱歉！您暂不能进行风险评估！</P>
			<P class=STYLE2 align=center>（只有金卡以上客户才能进行风险评估，请进入“个人中心-专属特权”升级）</P>
	</div>
</c:if>
<c:if test="${type==2}">
	<div class="personal_right personal_wj">
	<p class="personal_right_title">风险评估</p>
	      <table width="80%" border="0" cellspacing="0" cellpadding="0" class="personal_index_sp tc mauto" style="margin-top:30px;">
	      <tbody>
	      <c:if test="${core>50}">
	      	<tr><td class="fb" width="50%">${core}分</td><td class="fb">激进型</td></tr>
	      	<tr><td colspan="2"><a target="_blank" href="http://tg.zhengjin99.com/spage/info/733/fxpg_jj_1504.pdf">下载：风险评估建议书</a></td></tr>
	      </c:if>
	      <c:if test="${core<=50 && core>35}">
	      	<tr><td class="fb" width="50%">${core}分</td><td class="fb">进取型</td></tr>
	      	<tr><td colspan="2"><a target="_blank" href="http://tg.zhengjin99.com/spage/info/733/fxpg_jq_1504.pdf">下载：风险评估建议书</a></td></tr>
	      </c:if>
	      <c:if test="${core<=35 && core>19}">
	      	<tr><td class="fb" width="50%">${core}分</td><td class="fb">稳健型</td></tr>
	      	<tr><td colspan="2"><a target="_blank" href="http://tg.zhengjin99.com/spage/info/733/fxpg_wj_1504.pdf">下载：风险评估建议书</a></td></tr>
	      </c:if>
	      <c:if test="${core<=20}">
	      	<tr><td class="fb" width="50%">${core}分</td><td class="fb">保守型</td></tr>
	      	<tr><td colspan="2"><a target="_blank" href="http://tg.zhengjin99.com/spage/info/733/fxpg_bs_1504.pdf">下载：风险评估建议书</a></td></tr>
	      </c:if>
	      <tr>
	        <td colspan="2"><a href="javascript:void(0)" onclick="resetFxpg()">重新填写</a></td>
	      </tr>
	    </tbody></table>
	</div>
</c:if>


<c:if test="${type==1}">
<div class="personal_right personal_wj">
  <p class="personal_right_title">风险评估</p>
  <p class="personal_wj_title tc">证金贵金属客户风险评估调查问卷</p>
  <!-- <p class="ti">尊敬的     先生/女士：您好!为了更好地为VIP客户提供专业服务，满足全方位的投资需求，我们诚恳地邀请您参加此次调查。希望通过了解您的真实资产情况，来改进我们的服务方式和内容，并力争帮助您找到最适合的投资标准。请您放心，我们将对问卷结果严格保密，非常感谢您的参与！。</p>
  <p class="ti">证金贵金属投资顾问   ：010-58309166</p>
  <p class="ti">证金VIP客户服务电话：010-58309088</p> -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_fxpgtable">
  <tbody><tr>
     <td width="70%" class="personal_fxpgtdl">
     <p>尊敬的     先生/女士：</p>
     <p>您好!</p>
     <p class="ti">为了更好地为VIP客户提供专业服务，满足全方位的投资需求，我们诚恳地邀请您参加此次调查。希望通过了解您的真实资产情况，来改进我们的服务方式和内容，并力争帮助您找到最适合的投资标准。请您放心，我们将对问卷结果严格保密，非常感谢您的参与！</p></td>
     <td><p>证金贵金属投资顾问：</p>
     <p>010-58309166</p>
     <p>证金VIP客户服务电话：</p>
     <p>010-58309088</p></td>
   </tr>
  </tbody></table>
  <p class="personal_fxpgtitle">问卷题目（请选择）</p>
  <p class="fb mt10">1.您所处的年龄区间？：</p>
  <div class="personal_wj_choose">
    <input name="op_1" type="radio" value="1" onclick="addSelect('您所处的年龄区间？', 1, '25岁以下', 1)"><label>25岁以下</label>
  	<input name="op_1" type="radio" value="2" onclick="addSelect('您所处的年龄区间？', 1, '25-35岁', 2)"><label>25-35岁</label>
  	<input name="op_1" type="radio" value="3" onclick="addSelect('您所处的年龄区间？', 1, '35-45岁', 3)"><label>35-45岁</label>
  	<input name="op_1" type="radio" value="2" onclick="addSelect('您所处的年龄区间？', 1, '45岁以上', 2)"><label>45岁以上</label>
  </div>
  <p class="fb mt10">2.您的家庭年收入大致落在如下哪一区间？：</p>
  <div class="personal_wj_choose">
  	<input name="op_2" type="radio" value="2" onclick="addSelect('您的家庭年收入大致落在如下哪一区间？', 2, '50万元以下', 2)"><label>50万元以下</label>
  	<input name="op_2" type="radio" value="3" onclick="addSelect('您的家庭年收入大致落在如下哪一区间？', 2, '50-200万元', 3)"><label>50-200万元</label>
  	<input name="op_2" type="radio" value="4" onclick="addSelect('您的家庭年收入大致落在如下哪一区间？', 2, '200-1000万元', 4)"><label>200-1000万元</label>
  	<input name="op_2" type="radio" value="5" onclick="addSelect('您的家庭年收入大致落在如下哪一区间？', 2, '1000万以上', 5)"><label>1000万以上</label>
  </div>
  <p class="fb mt10">3.以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于：</p>
  <div class="personal_wj_choose">
  	<input name="op_3" type="radio" value="1" onclick="addSelect('以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于', 3, '≤150万', 1)"><label>≤150万</label>
  	<input name="op_3" type="radio" value="2" onclick="addSelect('以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于', 3, '160万-490万', 2)"><label>160万-490万</label>
  	<input name="op_3" type="radio" value="3" onclick="addSelect('以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于', 3, '500万-690万', 3)"><label>500万-690万</label>
  	<input name="op_3" type="radio" value="4" onclick="addSelect('以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于', 3, '700万-990万', 4)"><label>700万-990万</label>
  	<input name="op_3" type="radio" value="5" onclick="addSelect('以人民币计算，您的总资产净值（包括储蓄、现有投资组合、房地产投资、人寿保险、固定收入，同时请扣除债务如房屋贷款、其他贷款、信用卡账单等）介于', 3, '≥1000万', 5)"><label>≥1000万</label>
  </div>
  <p class="fb mt10">4.综合收益和风险，您最愿意将资金投资到下面哪个方向？：</p>
  <div class="personal_wj_choose">
  	<input name="op_4" type="radio" value="2" onclick="addSelect('综合收益和风险，您最愿意将资金投资到下面哪个方向？', 4, '债券、债券基金、货币市场基金', 2)"><label>债券、债券基金、货币市场基金</label>
  	<input name="op_4" type="radio" value="3" onclick="addSelect('综合收益和风险，您最愿意将资金投资到下面哪个方向？', 4, '信托', 3)"><label>信托</label>
  	<input name="op_4" type="radio" value="4" onclick="addSelect('综合收益和风险，您最愿意将资金投资到下面哪个方向？', 4, '股票、股票型基金', 4)"><label>股票、股票型基金</label>
  	<input name="op_4" type="radio" value="5" onclick="addSelect('综合收益和风险，您最愿意将资金投资到下面哪个方向？', 4, '期货、贵金属', 5)"><label>期货、贵金属</label>
  </div>
  <p class="fb mt10">5.您和您的家庭希望通过投资达到的目的是：</p>
  <div class="personal_wj_choose">
  	<input name="op_5" type="radio" value="1" onclick="addSelect('您和您的家庭希望通过投资达到的目的是', 5, '为养老、育儿准备', 1)"><label>为养老、育儿准备</label>
  	<input name="op_5" type="radio" value="2" onclick="addSelect('您和您的家庭希望通过投资达到的目的是', 5, '保值', 2)"><label>保值</label>
  	<input name="op_5" type="radio" value="3" onclick="addSelect('您和您的家庭希望通过投资达到的目的是', 5, '获得股息、分红等', 3)"><label>获得股息、分红等</label>
  	<input name="op_5" type="radio" value="4" onclick="addSelect('您和您的家庭希望通过投资达到的目的是', 5, '实现投资增值', 4)"><label>实现投资增值</label>
  	<input name="op_5" type="radio" value="5" onclick="addSelect('您和您的家庭希望通过投资达到的目的是', 5, '迅速获得高收益', 5)"><label>迅速获得高收益</label>
  </div>
  <p class="fb mt10">6.对您而言，保本比追求高收益更为重要 ：</p>
  <div class="personal_wj_choose">
  	<input name="op_6" type="radio" value="1" onclick="addSelect('对您而言，保本比追求高收益更为重要', 6, '非常同意', 1)"><label>非常同意</label>
  	<input name="op_6" type="radio" value="2" onclick="addSelect('对您而言，保本比追求高收益更为重要', 6, '同意', 2)"><label>同意</label>
  	<input name="op_6" type="radio" value="3" onclick="addSelect('对您而言，保本比追求高收益更为重要', 6, '无所谓', 3)"><label>无所谓</label>
  	<input name="op_6" type="radio" value="4" onclick="addSelect('对您而言，保本比追求高收益更为重要', 6, '不同意', 4)"><label>不同意</label>
  	<input name="op_6" type="radio" value="5" onclick="addSelect('对您而言，保本比追求高收益更为重要', 6, '完全不同意', 5)"><label>完全不同意</label>
  </div>
  <p class="fb mt10">7.您对投资收益和风险所持的态度是：</p>
  <div class="personal_wj_choose">
  	<div><input name="op_7" type="radio" value="2" onclick="addSelect('您对投资收益和风险所持的态度是', 7, '我不愿意承担风险，也不能接受投资的价值下跌', 2)"><label>我不愿意承担风险，也不能接受投资的价值下跌</label></div>
  	<div><input name="op_7" type="radio" value="4" onclick="addSelect('您对投资收益和风险所持的态度是', 7, '我希望避免风险，能够接受轻微的价格波动，以追求高于定期存款的回报', 4)"><label>我希望避免风险，能够接受轻微的价格波动，以追求高于定期存款的回报</label></div>
  	<div><input name="op_7" type="radio" value="6" onclick="addSelect('您对投资收益和风险所持的态度是', 7, '我对风险的态度一般，愿意在投资期限内接受较小的负面波动，只要回报能明显高于定期存款', 6)"><label>我对风险的态度一般，愿意在投资期限内接受较小的负面波动，只要回报能明显高于定期存款</label></div>
  	<div><input name="op_7" type="radio" value="8" onclick="addSelect('您对投资收益和风险所持的态度是', 7, '我能够承担风险，愿意接受一定范围的负面波动以提高投资的潜在回报，能够承担部分本金损失', 8)"><label>我能够承担风险，愿意接受一定范围的负面波动以提高投资的潜在回报，能够承担部分本金损失</label></div>
  	<div><input name="op_7" type="radio" value="10" onclick="addSelect('您对投资收益和风险所持的态度是', 7, '我希望承担风险，愿意为获得较高回报而承受较大的负面波动，能够承担本金损失', 10)"><label>我希望承担风险，愿意为获得较高回报而承受较大的负面波动，能够承担本金损失</label></div>
  </div>
  <p class="fb mt10">8.您的投资理财经验（包括股票、期货、贵金属、公募基金、银行理财及信托等）情况？：</p>
  <div class="personal_wj_choose">
  	<input name="op_8" type="radio" value="2" onclick="addSelect('您的投资理财经验（包括股票、期货、贵金属、公募基金、银行理财及信托等）情况？', 8, '3年以下', 2)"><label>3年以下</label>
  	<input name="op_8" type="radio" value="3" onclick="addSelect('您的投资理财经验（包括股票、期货、贵金属、公募基金、银行理财及信托等）情况？', 8, '3-6年', 3)"><label>3-6年</label>
  	<input name="op_8" type="radio" value="4" onclick="addSelect('您的投资理财经验（包括股票、期货、贵金属、公募基金、银行理财及信托等）情况？', 8, '6-9年', 4)"><label>6-9年</label>
  	<input name="op_8" type="radio" value="5" onclick="addSelect('您的投资理财经验（包括股票、期货、贵金属、公募基金、银行理财及信托等）情况？', 8, '9年以上', 5)"><label>9年以上</label>
  </div>
  <p class="fb mt10">9.您认为投资顾问应该更类似于如下哪一类角色？：</p>
  <div class="personal_wj_choose">
  	<div><input name="op_9" type="radio" value="2" onclick="addSelect('您认为投资顾问应该更类似于如下哪一类角色？', 9, '客户的朋友，有交易方面的事可及时通知客户，并协助客户处理一些日常操作问题', 2)"><label>客户的朋友，有交易方面的事可及时通知客户，并协助客户处理一些日常操作问题</label></div>
  	<div><input name="op_9" type="radio" value="3" onclick="addSelect('您认为投资顾问应该更类似于如下哪一类角色？', 9, '客户的顾问，提供有理有据的分析论据，客户自己做出操作决定', 3)"><label>客户的顾问，提供有理有据的分析论据，客户自己做出操作决定</label></div>
  	<div><input name="op_9" type="radio" value="4" onclick="addSelect('您认为投资顾问应该更类似于如下哪一类角色？', 9, '客户的老师，传授专业知识，推荐解读市场信息并给予相关操作建议', 4)"><label>客户的老师，传授专业知识，推荐解读市场信息并给予相关操作建议</label></div>
  	<div><input name="op_9" type="radio" value="5" onclick="addSelect('您认为投资顾问应该更类似于如下哪一类角色？', 9, '客户的管家，按照老师的建议操作，基本上没有自己的分析判断，也没时间学习', 5)"><label>客户的管家，按照老师的建议操作，基本上没有自己的分析判断，也没时间学习</label></div>
  </div>
  <p class="fb mt10">10.依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期：</p>
  <div class="personal_wj_choose">
  	<input name="op_10" type="radio" value="1" onclick="addSelect('依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期', 10, '下降', 1)"><label>下降</label>
  	<input name="op_10" type="radio" value="2" onclick="addSelect('依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期', 10, '不确定', 2)"><label>不确定</label>
  	<input name="op_10" type="radio" value="3" onclick="addSelect('依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期', 10, '维持稳定', 3)"><label>维持稳定</label>
  	<input name="op_10" type="radio" value="4" onclick="addSelect('依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期', 10, '缓慢增长', 4)"><label>缓慢增长</label>
  	<input name="op_10" type="radio" value="5" onclick="addSelect('依据您目前的情况，以下哪项最符合您和您的家庭对于自身未来5年收入的预期', 10, '快速增长', 5)"><label>快速增长</label>
  </div>
  <p class="fb mt10">11.您在挑选贵金属公司时，更看重其中的哪些因素？（可多选）：</p>
  <div class="personal_wj_choose">
  	<input name="op_11" type="checkbox" value="2" onclick="checkSelect(this, '您在挑选贵金属公司时，更看重其中的哪些因素？', 111, '资金安全性', 2)"><label>资金安全性</label>
  	<input name="op_11" type="checkbox" value="3" onclick="checkSelect(this, '您在挑选贵金属公司时，更看重其中的哪些因素？', 112, '公司的品牌和专业度', 3)"><label>公司的品牌和专业度</label>
  	<input name="op_11" type="checkbox" value="4" onclick="checkSelect(this, '您在挑选贵金属公司时，更看重其中的哪些因素？', 113, '服务客户数量和质量', 4)"><label>服务客户数量和质量</label>
  	<input name="op_11" type="checkbox" value="5" onclick="checkSelect(this, '您在挑选贵金属公司时，更看重其中的哪些因素？', 114, '投资顾问的水平', 5)"><label>投资顾问的水平</label>
  </div>
  
  <p class="ti">&nbsp;</p>
  <div class="tc mt30">
  <input name="" type="button" class="personal_wj_able mr100" onclick="subselect();" value="提交">
  </div>
</div>
</c:if>