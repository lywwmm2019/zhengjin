<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%!
private boolean hasSubmit(String json, String mobile, String type){
	String sql = "SELECT count(*) as total FROM ZX_JsonInfo where type='"+type+"' and  jsonInfo like '%"+json + "%'";
	String key = MD5(json);
	Integer total = (Integer)Cache.get(key);
	if(total == null){
		List list = QueryRunner.getListBySql(sql);
		total = 0;
		if(list.size()>0){
			total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
		}
		if(total>0){//提交过设置缓存
			Cache.set(key, total, expire);
		}
	}
	
	if(total > 0)
		return true;
	return false;
}

private boolean hasDeal(String userId){
	String sql = "SELECT * FROM ZX_JsonInfo where type='jsfw' and  jsonInfo like '%\"userId\" :\""+userId+"\"%' order by createTime desc";
	List list = QueryRunner.getListBySql(sql);
	boolean flag = false;
	try{
	if(list != null){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		for(Object obj: list){
			Map mobj = (Map)obj;
			String jsonInfo = (String)mobj.get("jsonInfo");
			Map map = (Map) Json.fromJson(jsonInfo);
			String isvalid = (String)map.get("isvalid");
			String time = (String)map.get("time");
			Date rtime = sdf.parse(time);
			if("0".equals(isvalid) && rtime.after(now)){
				flag = true;
				break;
			}
		}
	}
	}catch(Exception e){
		e.printStackTrace();
	}
	return flag;
}

%>
<%
boolean flag = false;
boolean hasDeal = false;
String mobile = getLoginMobile(request);
if(mobile != null){
	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	if(info!=null){
		String crmUserId = "";
		Integer VIPTypeID = 0;
		if(info!=null){ 
			crmUserId = (String)info.get("UserID");
			VIPTypeID = (Integer)info.get("VIPTypeID");
		}
		if(VIPTypeID == 4){
			String jsontype = "jsfw_accepted";
			String json = crmUserId+"_jsfw";
			if(hasSubmit(json, mobile, jsontype))//是否接受免责申明
				flag = true;
			if(hasDeal(crmUserId))
				hasDeal = true;
		}
	}
}
pageContext.setAttribute("accepted", flag?1:0);
pageContext.setAttribute("deal", hasDeal?1:0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>接送服务_证金贵金属</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/zhengjin/sphy/css/style2.css"  />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="/zhengjin/js/index_common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var width=$(window).width();
	var height=$(window).height(),mh=$('.personal_js_mzsm').height();
	var hw=width/2;
	var hh=height/2;
	var hmh=mh/2;
	$('.personal_js_mzsm').css('left',hw-312);
	$('.personal_js_mzsm').css('top',hh-hmh);
	$('.personal_besure').css('left',hw-275);
	$('.personal_besure').css('top',hh-217);
	$(window).scroll(function(){
		var scrolltop=$(window).scrollTop();
		$('.personal_js_mzsm').css('top',hh-hmh+scrolltop);
		$('.personal_besure').css('top',hh-217+scrolltop);
	})
})
function checkRedirect(ac,deal){
	var userName = cookie("WEBSSO_ZJUSERNAME");
	var sso_userID = cookie("WEBSSO_UID");
	if (sso_userID == null || sso_userID == 0 || sso_userID == ""
			|| userName == null || userName == "") {
		var url = window.location.href;
		url = "login.jsp?r=" + encodeURIComponent(url);
		window.location.href = url;
	} else {
		var VIPTypeID = cookie("VIPTypeID");
		if(VIPTypeID == 4){
			if(ac == 1){
				if(deal == 1)
					return alert("您有未完成的接送服务，无法重复申请接送服务");
				accepted(ac);
			}else{
				$("#mzsm").show();
			}
		}else{
			if(confirm("如需服务请点击确定升级!")){
				update(1,4);
			}
			
		}
	}
}

function accepted(ac){
	if(ac == 0){
		$.post("jsfw_ajax.jsp",{"act":1}, function(data){
			if(data.state=='0'){
				window.location.href = "jsfw.jsp"
			}
		},"json");
	}else{
		window.location.href = "jsfw.jsp"
	}
}
</script>
</head>

<body>
	<!-- head -->
	<%@ include file="../head2.jsp"%>
	<div class="personal_js_index">
        <div class="personal_js_index01"></div>
        <div class="personal_js_index02"></div>
        <div class="personal_js_index03"></div>
        <!-- 首页 -->
        <div id="main0">
        <div class="personal_js_index04">
            <div class="personal_js_w800 pr">
                <a href="javascript:void(0)" class="pa" onclick="checkRedirect(${accepted}, ${deal});"></a>
            </div>
        </div>
        <div class="personal_js_index05"></div>
        <div class="personal_js_index06"></div>
        <div class="personal_js_index07"></div>
        <div class="personal_js_index08"></div>
        <div class="personal_js_index09"></div>
        <div class="personal_js_index10"></div>
        </div>
       
    <!-- 免责声明 -->
    <div id="mzsm" class="personal_js_mzsm pa hide" style="left:0;top:0;">
    	<div class="personal_mzsm_top pr">
        	<div class="personal_mzsm_close pa" style="top:11px;right:25px;" onclick="$('.personal_js_mzsm').hide()"></div>
        </div>
        <div class="personal_mzsm_mid">
        	<p>本次接送服务旨在为来京客户提供便利，为了保障您的出行安全，且能顺利享受此项服务，请在您享受此服务的过程中，全程遵循证金贵金属定制的服务守则。您通过阅读及填写此声明，表明您已经完全知晓和理解以下的条款和内容，并承诺遵守：</p>
            <ul>
            	<li class="clear over"><span class="fl num">1</span><span class="fr txt">客户自愿申请享受此接送服务，在服务过程中，由于不可抗力因素（包括但不限于天气变化
、堵车、交通管制、车辆故障、交通意外等因素）造成的时间延误等风险，请您明确知悉，并具备自行承担由此造成损失的能力。</span></li>
                <li class="clear over"><span class="fl num">2</span><span class="fr txt">客户承诺不携带宠物、枪支、弹药、管制刀具及其它类似的物品和危险物品，包括爆炸品、气体、易燃物品和任何一类具有危险性的物质和物品以及国家法律规定的违禁物品，若违反此条例，司机可立刻停止接送服务，相关风险及损失需由您自行承担。</span></li>
                <li class="clear over"><span class="fl num">3</span><span class="fr txt">在整个接送服务过程中，请自行保管好随身携带的行李及贵重物品，避免因行或贵重物品丢失给您造成损失。</span></li>
                <li class="clear over"><span class="fl num">4</span><span class="fr txt">将您送达指定的目的地后，我司即完成了与接送相关的所有服务，如您还有其他需求，我司会在能力范围内积极响应，但超出我公司服务范围的，有权拒绝，请您予以谅解。</span></li>
                <li class="clear over"><span class="fl num">5</span><span class="fr txt">若在提供服务过程中发生交通意外，所有损失及责任由事故责任方承担。若因此对您造成
         任何伤害，我司深表遗憾，并会积极配合您进行对责任方的索赔及追偿。</span></li>
                <li class="clear over"><span class="fl num">6</span><span class="fr txt">请您自觉遵守交通规则，不得对司机提出违反交通规则或法律、法规等不正当、不合理要
求，若您有上述不合理要求，司机有权拒绝并有权立即终止正在进行的接送服务。如因您的任何不当或非法行为造成的后果需由您自行承担，与司机及证金贵金属无关。</span></li>
                <li class="clear over"><span class="fl num">7</span><span class="fr txt">证金贵金属保留对声明中所公布的规则、守则、条款进行补充、修正与更改的权利，并在法律许可的范围内保留对以上所有文字说明的最终解释权。</span></li>
                <li class="clear over"><span class="fl num">8</span><span class="fr txt">再次提示您认真阅读免责声明中的所有内容并遵照执行。</span></li>
            </ul>
            <div class="tc personal_mzsm_agreement"><input name="" type="button" class="personal_mzsm_agree" onclick="accepted(${accepted});"/><input name="" type="button" class="personal_mzsm_disagree" onclick="$('.personal_js_mzsm').hide()" /></div>
        </div>
        <div class="personal_mzsm_bottom"></div>
    </div>
    
    <!-- cnzz -->
    <div style="display:none">
		<script type="text/javascript" src="../js/count.js"></script>
	</div>
</body>
</html>
