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
%>
<%
boolean flag = false;
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
		}
			
	}
}
if(!flag)
	response.sendRedirect("jsfwindex.jsp");
pageContext.setAttribute("today", new Date()); 
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
<script type="text/javascript" src="/zhengjin/js/index_common.js"></script>
<script type="text/javascript" src="js/common.js"></script>
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
	var des = $("#des_"+id).val();
	if(des == "")
		return alert("目的地不能为空");
	
	$.post("jsfw_ajax.jsp",{"act":0,"type":id,"code":code,"site":site,"time":time,"name":name,"phone":phone,"num":num,"des":des}, function(data){
		alert(data.msg);
		if(data.state=='0'){
			$('#confimEidt').hide();
			clear();
			window.location.href = "jsfwindex.jsp"
		}
		$('#subButton').show();
	},"json");
}

function clear(){
	var id =  $("#type").val();
	$("#code_"+id).text("");
	$("#site_"+id).text("");
	$("#time_"+id).text("");
	$("#name_"+id).text("");
	$("#phone_"+id).text("");
	$("#num_"+id).text("");
	$("#des_"+id).text("");
	$("#code").text("");
	$("#site").text("");
	$("#time").text("");
	$("#name").text("");
	$("#phone").text("");
	$("#num").text("");
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
      
        <!-- 填写表单 -->
        <div id="main1">
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
                        <td class="tr" width="100">&nbsp;</td>
                        <td><span class="notice_font14">注：此项服务适用于北京地区</span></td>
                      </tr>
                      <tr>
                        <td class="tr" width="100"><span>*</span> 航班号：</td>
                        <td><input id="code_0" maxlength="25" onblur="setHint('code_0','请输入您乘坐的航班号')" onfocus="clearHint('code_0','请输入您乘坐的航班号')" type="text" class="input_txt" value="请输入您乘坐的航班号"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 航站楼：</td>
                        <td><input id="site_0" maxlength="30" type="text" class="input_txt" onblur="setHint('site_0','请输入您的航站楼')" onfocus="clearHint('site_0','请输入您的航站楼')" value="请输入您的航站楼"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接机时间：</td>
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
                        <td class="tr"><span>*</span> 来京人数：</td>
                        <td><input name="num_0" type="radio" value="1" checked=true><label>1</label><input name="num_0" type="radio" value="2"><label>2</label><input name="num_0" type="radio" value="3"><label>3</label><span class="notice">注：最多三人</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 目的地点：</td>
                        <td><textarea id="des_0" maxlength="100" cols="" rows=""></textarea><span class="notice">注：限定五环内</span></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><input name="" type="button" class="input_submit" onclick="confirmData();"></td>
                      </tr>
                    </tbody></table>
                    
                    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="train_table hide">
                      <tbody>
                      <tr>
                        <td class="tr" width="100">&nbsp;</td>
                        <td><span class="notice_font14">注：此项服务适用于北京地区</span></td>
                      </tr>
                      <tr>
                        <td class="tr" width="100"><span>*</span> 火车车次：</td>
                        <td><input id="code_1" maxlength="20" type="text" class="input_txt" onblur="setHint('code_1','请输入您乘坐的火车车次')" onfocus="clearHint('code_1','请输入您乘坐的火车车次')" value="请输入您乘坐的火车车次"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 到达车站：</td>
                        <td><input id="site_1" maxlength="25" type="text" class="input_txt" onblur="setHint('site_1','请输入您到达的车站')" onfocus="clearHint('site_1','请输入您到达的车站')" value="请输入您到达的车站"></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 接车时间：</td>
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
                        <td class="tr"><span>*</span> 来京人数：</td>
                        <td><input name="num_1" type="radio" value="1" checked=true><label>1</label><input name="num_1" type="radio" value="2"><label>2</label><input name="num_1" type="radio" value="3"><label>3</label><span class="notice">注：最多三人</span></td>
                      </tr>
                      <tr>
                        <td class="tr"><span>*</span> 目的地点：</td>
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
          <tbody><tr>
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
    <!-- cnzz -->
    <div style="display:none">
		<script type="text/javascript" src="../js/count.js"></script>
	</div>
</body>
</html>
