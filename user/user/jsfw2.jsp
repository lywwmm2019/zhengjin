<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="methods.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
private Integer hasDeal(String userId){
	String sql = "SELECT * FROM ZX_JsonInfo where type='jsfw' and  jsonInfo like '%\"userId\" :\""+userId+"\"%' order by createTime desc";
	List list = QueryRunner.getListBySql(sql);
	Integer flag = 0;
	boolean flag1 = false;
	boolean flag2 = false;
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
			String fw = (String)map.get("fw");
			Date rtime = sdf.parse(time);
			if("0".equals(isvalid) && rtime.after(now)){
				if("1".equals(fw)){
					flag1 = true;
				}
				if("2".equals(fw)){
					flag2 = true;
				}	
				if(flag1 && flag2){
					break;
				}
			}
		}
	}
	}catch(Exception e){
		e.printStackTrace();
	}
	if(flag1 && flag2){
		flag = 3;
	}
	if(flag1 && !flag2){
		flag = 1;
	}
	if(!flag1 && flag2){
		flag = 2;
	}	
	return flag;
}
%>
<%
boolean flag = false;
Integer deal = 0;
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
			if(hasSubmit(json, mobile, jsontype))
				flag = true;
			deal = hasDeal(crmUserId);
		}
			
	}
}
pageContext.setAttribute("today", new Date()); 
pageContext.setAttribute("deal", deal); 
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
	
	//初始化
	$("#main0").show();
	$("#confimEidt").hide();
	$("#mzsm").hide();
	$("#main1").hide();
})
Date.prototype.str2date = function(c_date) {
    if (!c_date)
        return "";
    var tempArray = c_date.split("-");
    if (tempArray.length != 3) {
        alert("你输入的日期格式不正确,正确的格式:2000-05-01 02:54:12");
        return 0;
    }
    var dateArr = c_date.split(" ");
    var date = null;
    if (dateArr.length == 2) {
        var yymmdd = dateArr[0].split("-"); 
        var hhmmss = dateArr[1].split(":");
        date = new Date(yymmdd[0], yymmdd[1] - 1, yymmdd[2], hhmmss[0], hhmmss[1], hhmmss[2]);
    } else {
        date = new Date(tempArray[0], tempArray[1] - 1, tempArray[2], 00, 00, 01);
    }
    return date;
};
var hasfw = 0;
var accept = 0;
function checkRedirect(deal){
	hasfw = deal;
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
				if(deal == 3)
					return alert("您有未完成的接送服务，请完成后再提交新的申请!");
				else
					$("#mzsm").show();
		}else{
			if(confirm("如需服务请点击确定升级!")){
				update(1,4);
			}
			
		}
	}
}
function accepted(){
	accept = 1;
	$("#mzsm").hide();
	$("#main0").hide();
	$("#confimEidt").hide();
	$("#main1").show();
}
function confirmData(){
	
	var id =  $("#type").val();
	var code = $("#code_"+id).val();
	if(code == "" || code=="请输入您乘坐的航班号"|| code=="请输入您乘坐的火车车次")
		return alert("航班号或车次不能为空");
	var site = $("#site_"+id).val();
	if(site == ""|| site=="请输入您的航站楼"|| site=="请输入您到达的车站")
		return alert("航站楼或到达火车站不能为空");
	var time = $("#time_"+id).val();
	if(time == "")
		return alert("接机或接车时间不能为空");
	var t = new Date().str2date(time);
	var now = new Date();
	if((t.getDate() - now.getDate())<=2){
		return alert("预约时间不正确，只能预约2天以后的接送服务");
	}
	if(t.getHours()<9){
		return alert("预约时间只能在9:00~24:00之间");
	}
	var name = $("#name_"+id).val();
	if(name == ""|| name=="请输入您的姓名")
		return alert("姓名不能为空");
	var phone = $("#phone_"+id).val();
	if(phone == ""|| phone=="请输入您的手机号码")
		return alert("手机号不能为空");
	if(!mobileRES.test(phone)){
		return alert("手机号格式错误");
	}
	var mobile = cookie("WEBSSO_LID");
	if(mobile!=phone){
		return alert("输入的手机号与网站登录的号码不一致");
	}
	var num = $("input[name='num_"+id+"']:checked").val()
	if(num == "")
		return alert("人数不能为空");
	var fw = $("input[name='fw_"+id+"']:checked").val()
	if(fw == "")
		return alert("接送类型不能为空");
	var des = $("#des_"+id).val();
	if(des == "")
		return alert("目的地不能为空");
	if(id==0){
		$("#codeName").text("航班号：");
		$("#siteName").text("航站楼：");
		$("#timeName").text("接机时间：");
	}else{
		$("#codeName").text("火车车次：");
		$("#siteName").text("到达车站：");
		$("#timeName").text("接车时间：");
	}
	
	$("#fw").text(fw==1?"接":"送");
	$("#code").text(code);
	$("#site").text(site);
	$("#time").text(time);
	$("#name").text(name);
	$("#phone").text(phone);
	$("#num").text(num);
	$("#des").text(des);
	
	$("#confimEidt").show();
}
function subRequest(){
	var id =  $("#type").val();
	var code = $("#code_"+id).val();
	if(code == "" || code=="请输入您乘坐的航班号"|| code=="请输入您乘坐的火车车次")
		return alert("航班号或车次不能为空");
	var site = $("#site_"+id).val();
	if(site == ""|| site=="请输入您的航站楼"|| site=="请输入您到达的车站")
		return alert("航站楼或到达火车站不能为空");
	var time = $("#time_"+id).val();
	if(time == "")
		return alert("接机或接车时间不能为空");
	var name = $("#name_"+id).val();
	if(name == ""|| name=="请输入您的姓名")
		return alert("姓名不能为空");
	var phone = $("#phone_"+id).val();
	if(phone == ""|| phone=="请输入您的手机号码")
		return alert("手机号不能为空");
	if(!mobileRES.test(phone)){
		return alert("手机号格式错误");
	}
	var mobile = cookie("WEBSSO_LID");
	if(mobile!=phone){
		return alert("输入的手机号与网站登录的号码不一致");
	}
	var num = $("input[name='num_"+id+"']:checked").val()
	if(num == "")
		return alert("人数不能为空");
	var fw = $("input[name='fw_"+id+"']:checked").val()
	if(fw == "")
		return alert("接送类型不能为空");
	var des = $("#des_"+id).val();
	if(des == "")
		return alert("目的地不能为空");
	
	$.post("jsfw_ajax.jsp",{"act":0,"type":id,"code":code,"site":site,"time":time,"name":name,"phone":phone,"num":num,"des":des,"fw":fw}, function(data){
		
		if(data.state=='0'){
			$('#confimEidt').hide();
			clear();
			if(hasfw == 0)
				hasfw = fw;
			else if(hasfw == 1 || hasfw == 2)
				hasfw = 3;
			
			if(hasfw == 3)
				location.reload();
			else{
				if(confirm("提交成功，稍后有贵宾客服与您联系！ 要继续申请接送服务吗？")){
					
				}else{
					location.reload();
				}
			}
				
		}else{
			alert(data.msg);
		}
		$('#subButton').show();
	},"json");
}

function clear(){
	var id =  $("#type").val();
	$("#code_"+id).val("");
	$("#site_"+id).val("");
	$("#time_"+id).val("");
	$("#name_"+id).val("");
	$("#phone_"+id).val("");
	$("#num_"+id).val("");
	$("#des_"+id).val("");
	$("#fw_"+id).val("1");
	$("#code").text("");
	$("#site").text("");
	$("#time").text("");
	$("#name").text("");
	$("#phone").text("");
	$("#num").text("1");
	$("#des").text("");
}
function setHint(id,text){
	var val = $("#"+id).val();
	if(val == ""){
		$("#"+id).val(text);
	}
}
function clearHint(id,text){
	var val = $("#"+id).val();
	if(val == text){
		$("#"+id).val("");
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
                <a href="javascript:void(0)" class="pa" onclick="checkRedirect(${deal});"></a>
            </div>
        </div>
        <div class="personal_js_index05"></div>
        <div class="personal_js_index06"></div>
        <div class="personal_js_index07"></div>
        <div class="personal_js_index08"></div>
        <div class="personal_js_index09"></div>
        <div class="personal_js_index10"></div>
        </div>
        <!-- 填写表单 -->
        <div id="main1" class="hide">
        <div class="personal_js_index04_02"></div>
   		<div class="bg_dae2e2">
        	<div class="personal_js_main over">
            	<ul class="pr clear over" style="left:150px;top:1px;">
                	<li class="sl" onclick="$('.plane_table').show();$('.train_table').hide();$(this).siblings().removeClass('sl');$(this).addClass('sl');$('#type').val(0);">按机场信息填写</li>
                    <li onclick="$('.train_table').show();$('.plane_table').hide();$(this).siblings().removeClass('sl');$(this).addClass('sl');$('#type').val(1);">按火车车次填写</li>
                </ul>
                <input type="hidden" id="type" value="0"/>
                <div class="personal_js_msg">
                	<table width="90%" border="0" cellspacing="0" cellpadding="0" class="plane_table">
                      <tbody>
                      <tr>
                        <td class="tr" width="100"><span>*</span> 接送：</td>
                        <td><input name="fw_0" type="radio" value="1" checked=true><label>接</label><input name="fw_0" type="radio" value="2"><label>送</label></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 航班号：</td>
                        <td><input id="code_0" maxlength="25" onblur="setHint('code_0','请输入您乘坐的航班号')" onfocus="clearHint('code_0','请输入您乘坐的航班号')" type="text" class="input_txt" value="请输入您乘坐的航班号"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 航站楼：</td>
                        <td><input id="site_0" maxlength="30" type="text" class="input_txt" onblur="setHint('site_0','请输入您的航站楼')" onfocus="clearHint('site_0','请输入您的航站楼')" value="请输入您的航站楼"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送时间：</td>
                        <td><input id="time_0" maxlength="19" type="text" class="input_txt2" onfocus="javascript:setday(this);"'></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 客户姓名：</td>
                        <td><input id="name_0" maxlength="20" type="text" class="input_txt" onblur="setHint('name_0','请输入您的姓名')" onfocus="clearHint('name_0','请输入您的姓名')" value="请输入您的姓名"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 手机电话：</td>
                        <td><input id="phone_0" maxlength="11" type="text" class="input_txt" onblur="setHint('phone_0','请输入您的手机号码')" onfocus="clearHint('phone_0','请输入您的手机号码')" value="请输入您的手机号码"><span class="notice">注：注册账号时使用的手机号码</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送人数：</td>
                        <td><input name="num_0" type="radio" value="1" checked=true><label>1</label><input name="num_0" type="radio" value="2"><label>2</label><input name="num_0" type="radio" value="3"><label>3</label><span class="notice">注：最多三人</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送地点：</td>
                        <td><textarea id="des_0" maxlength="100" cols="" rows=""></textarea><span class="notice">注：限北京五环内</span></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><input name="" type="button" class="input_submit" onclick="confirmData();"></td>
                      </tr>
                    </tbody></table>
                    
                    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="train_table hide">
                      <tbody>
                      <tr>
                        <td class="tr" width="100"><span>*</span> 接送：</td>
                        <td><input name="fw_1" type="radio" value="1" checked=true><label>接</label><input name="fw_1" type="radio" value="2"><label>送</label></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 火车车次：</td>
                        <td><input id="code_1" maxlength="20" type="text" class="input_txt" onblur="setHint('code_1','请输入您乘坐的火车车次')" onfocus="clearHint('code_1','请输入您乘坐的火车车次')" value="请输入您乘坐的火车车次"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 到达车站：</td>
                        <td><input id="site_1" maxlength="25" type="text" class="input_txt" onblur="setHint('site_1','请输入您到达的车站')" onfocus="clearHint('site_1','请输入您到达的车站')" value="请输入您到达的车站"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送时间：</td>
                        <td><input id="time_1" maxlength="19" type="text" class="input_txt2" onfocus="javascript:setday(this)" ></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 客户姓名：</td>
                        <td><input id="name_1" maxlength="20" type="text" class="input_txt" onblur="setHint('name_1','请输入您的姓名')" onfocus="clearHint('name_1','请输入您的姓名')" value="请输入您的姓名"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 手机电话：</td>
                        <td><input id="phone_1" maxlength="11" type="text" class="input_txt" onblur="setHint('phone_1','请输入您的手机号码')" onfocus="clearHint('phone_1','请输入您的手机号码')" value="请输入您的手机号码"><span class="notice">注：注册账号时使用的手机号码</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送人数：</td>
                        <td><input name="num_1" type="radio" value="1" checked=true><label>1</label><input name="num_1" type="radio" value="2"><label>2</label><input name="num_1" type="radio" value="3"><label>3</label><span class="notice">注：最多三人</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接送地点：</td>
                        <td><textarea id="des_1" maxlength="100" cols="" rows=""></textarea><span class="notice">注：限定五环内</span></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><input name="" type="button" class="input_submit" onclick="confirmData();"></td>
                      </tr>
                    </tbody></table>

                </div>
            </div>
        </div>
        </div>
    </div>
	<!-- 填写信息确认 -->
    <div id="confimEidt" class="personal_besure pa hide" style="left:0;top:0;z-index:99;">
    	<div class="personal_besure_close pa" style="right:6px;top:6px;" onclick="$(this).parent().hide();"></div>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tbody>
          <tr>
            <td class="tr" >接送类型:</td>
            <td class="msg" width="280" id="fw">--</td>
          </tr>
          <tr>
            <td class="tr" id="codeName">航班号:</td>
            <td class="msg" width="280" id="code">--</td>
          </tr>
          <tr>
            <td class="tr" id="siteName">航站楼:</td>
            <td class="msg" id="site">--</td>
          </tr>
          <tr>
            <td class="tr" id="timeName">接机时间:</td>
            <td class="msg" id="time">--</td>
          </tr>
          <tr>
            <td class="tr">您的姓名:</td>
            <td class="msg" id="name">--</td>
          </tr>
          <tr>
            <td class="tr">您的电话:</td>
            <td class="msg" id="phone">--</td>
          </tr>
          <tr>
            <td class="tr">人 数:</td>
            <td class="msg"  id="num">0</td>
          </tr>
          <tr>
            <td class="tr" valign="top">送往地:</td>
            <td class="msg"><p class="sp_msg"  id="des">--</p></td>
          </tr>
          <tr>
            <td colspan="2" class="tc" style="border:0;"><input id="subButton" name="" type="button" class="ok" onclick="$(this).hide();subRequest();"><input name="" type="button" class="edit"  onclick="$('#confimEidt').hide();"></td>
          </tr>
        </tbody></table>
    </div>
    <!-- 免责声明 -->
    <div id="mzsm" class="personal_js_mzsm pa hide" style="left:0;top:0;">
    	<div class="personal_mzsm_top pr">
        	<div class="personal_mzsm_close pa" style="top:11px;right:25px;" onclick="$('.personal_js_mzsm').hide()"></div>
        </div>
        <div class="personal_mzsm_mid">
        	<p>本次接送服务为证金贵金属免费提供给客户的一项增值服务，旨在为来京客户提供交通便利，为了保障您的出行安全，请您认真阅读并确保完全知晓和理解以下内容：</p>
            <ul>
            	<li class="clear over"><span class="fl num">1</span><span class="fr txt">客户自愿申请此项接送服务，在服务过程中，由于不可抗力因素（包括但不限于天气变化 、堵车、交通管制、车辆故障、交通意外等）造成的时间延误等风险，请您明确知悉，并自行承担由此带来的不便和损失。</span></li>
                <li class="clear over"><span class="fl num">2</span><span class="fr txt">客户承诺不携带宠物、枪支、弹药、管制刀具及其它类似的物品和危险物品，包括爆炸品、气体、易燃物品和任何一类具有危险性的物质和物品以及国家法律规定的违禁物品，若违反此条例，司机可立刻停止接送服务，相关风险及损失需由您自行承担。</span></li>
                <li class="clear over"><span class="fl num">3</span><span class="fr txt">在整个接送服务过程中，请您自行保管好随身携带的行李及贵重物品，避免因行李或贵重物品丢失给您造成损失。</span></li>
                <li class="clear over"><span class="fl num">4</span><span class="fr txt">将您送达指定的目的地后，我司即完成了与接送相关的所有服务，如您还有其他需求，我司会在能力范围内积极响应，但超出我公司服务范围的，有权拒绝，请您予以谅解。</span></li>
                <li class="clear over"><span class="fl num">5</span><span class="fr txt">若在提供服务过程中发生交通意外，所有损失及责任由事故责任方承担，我司会积极配合您进行对责任方进行索赔及追偿。</span></li>
                <li class="clear over"><span class="fl num">6</span><span class="fr txt">请您不要对司机提出违反交通规则或其他法律法规的要求。若您有上述不合理要求，司机有权拒绝并终止正在进行的接送服务，并由您自行承担由此带来的后果。</span></li>
                <li class="clear over"><span class="fl num">7</span><span class="fr txt">证金贵金属保留对声明中所公布的规则、守则、条款进行补充、修正与更改的权利，并在法律许可的范围内保留对以上所有文字说明的最终解释权。</span></li>
                <li class="clear over"><span class="fl num">8</span><span class="fr txt">请您认真阅读免责声明并确认知晓所有内容。</span></li>
            </ul>
            <div class="tc personal_mzsm_agreement"><input name="" type="button" class="personal_mzsm_agree" onclick="accepted();"/><input name="" type="button" class="personal_mzsm_disagree" onclick="$('.personal_js_mzsm').hide()" /></div>
        </div>
        <div class="personal_mzsm_bottom"></div>
    </div>
    <!-- cnzz -->
    <div style="display:none">
		<script type="text/javascript" src="../js/count.js"></script>
	</div>
</body>
</html>
