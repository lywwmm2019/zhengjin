<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@ include file="methods.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
//加载用户基本信息
try{ 
	String r = Utils.getParameterValue(request, "redirect", "");
	String mobile = getCookie(request, "WEBSSO_LID");
	String userId = getCookie(request, "WEBSSO_UID");
	String userType = getCookie(request, "WEBSSO_USERTYPE");
	
	if(mobile != null && !"".equals(mobile) && userId!=null && !"".equals(userId) && userType!=null && !"".equals(userType)){
		response.sendRedirect(".");
	}
	
	pageContext.setAttribute("redirect", r);
	//服务人数显示
	Integer fwtotal = 569880;
    try {
        String sql = "SELECT COUNT(DISTINCT phone) as total from ZX_Phone";
        List list = Utils.fetchDataRowsFromSqlOrCache(sql, expire);
        if (list.size() > 0) {
            fwtotal = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
        }
    } catch (Exception e) {
        log.error("total fw users", e);
    }
	pageContext.setAttribute("fwtotal", fwtotal);
	
	String hreferer = request.getHeader("referer");
    String hfrom = Utils.getParameterValue(request,"from", "");
    if(hfrom != null && "jiaoyibao".equals(hfrom)){
        pageContext.setAttribute("head", 0);
        hreferer = "";
    }else if (hreferer != null && hreferer.contains("from=jiaoyibao")){
        pageContext.setAttribute("head", 0);
        hreferer = "from=jiaoyibao";
    }else{
        hreferer = "";
    }
    pageContext.setAttribute("hreferer", hreferer);
	
}catch(Exception e){
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="keywords" content="证金贵金属,白银,白银分析,白银投资,白银价格,白银交易,炒白银,白银走势,白银软件,模拟炒银,美联储,白银在线分析" />
<meta name="description" content="证金贵金属，首家赴美纳斯达克上市公司中国最大最专业的白银投资服务平台，致力于白银投资、白银交易、现货白银、白银价格、炒白银、现货白银走势、白银行情、模拟炒银、现货白银开户、投资资讯、分析评论、贵金属投资等贵金属综合性投资服务" />
<title>登录_证金贵金属</title>
<link href="http://www.zhengjin99.com/images/logo.ico" rel="shortcut icon">
<link href="../css/style_v2.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/zhengjin/js/jquery.cookie.js"></script> 
<script type="text/javascript" src="../js/index_common_2014.js?v=20150702"></script>
<script type="text/javascript" src="../js/jquery.watermark.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var mobile = getCookie("WEBSSO_LID");
		if(mobile!="")
			$("#passport3").val(mobile);
		else
			$("#passport3").watermark("请输入您的手机号码");
		$("#password3").watermark("请输入您的密码");
	})
	
	//绑定enter提交
	function BindEnter3(obj, redirect){
	    if(obj.keyCode == 13) {
			zjgjs.sso.login3('3',redirect);
			obj.returnValue = false;
	     }
	}
	
	function getParam(item) {
	    var svalue = location.search.match(new RegExp('[\?\&]' + item + '=([^\&]*)(\&?)','i'));
	    return svalue?decodeURIComponent(svalue[1]):'';
	}
	
	function reg(){
		var url = "register.jsp";
		if( getParam("from") == "jiaoyibao")
			 url += "?from=jiaoyibao&activityID=rjkhdzc_changshakhd_20140710";
        window.location.href = url;
	}
</script>
</head>

<body>
    <c:if test="${head != 0}">
	<!--  -->
	<div id="head">
        <div class="w990 mauto over clear logo">
        	<h1>
            	<a href="http://www.zhengjin99.com"><img src="../images/logo.png" width="199" height="47" alt="证金贵金属" class="block fl" /></a>
                <img src="../images/logo_login.png" width="59" height="35" alt="登录" class="block fl" />
            	<img src="../images/kefu.png" width="294" height="32" alt="客服电话：010-58309199" class="block fr" />
            </h1>
        </div>
    </div>

    </c:if>
    <!--  -->
    <div id="login" class="pr">
    	<div class="banner1 pr">
            <div class="w990 mauto pr login_dialog" style="z-index:9;">            	
            	<div class="login_main pa">
                    <ul class="txt">
                    	<li><span>${fwtotal}</span>人</li>
                        <li>正在享受证金服务</li>
                    </ul>
                    <div class="login_input_name"><input name="" id="passport3" type="text" maxlength="11"/></div>
                    <div class="login_input_pwd"><input name="" id="password3" type="password" maxlength="12" onkeypress="BindEnter3(event, '${redirect}')"/></div>
                    <div class="tr forgot"><a href="findpwd.jsp">忘记密码</a></div>
                    <input name="" type="button" class="login_btn block"  onclick="zjgjs.sso.login3('3', '${redirect}')" />
                    <p>还没有账号<a href="javascript:void(0)" onclick="reg();" class="ml5">立即注册</a></p>
                    <c:if test="${head != 0}">
                    <div class="open"><input name="" type="button" class="mn" onclick="location.href='/zhengjin/mnkh/'"/><input name="" type="button" class="sp" onclick="location.href='/zhengjin/spAndYyKH/khts.jsp'"/></div>
                    </c:if>
                </div>
            </div>
            <div class="login_bg"></div>
        </div>
    </div>
    
    <!-- foot -->
    <%@ include file="../foot_v2.jsp"%>
    
    
    
    
    
<script type="text/javascript">
function setTab(name,cursel,n){
		for(i=1;i<=n;i++){
		  var menu=document.getElementById(name+i);
		  var con=document.getElementById("con_"+name+"_"+i);
		  menu.className=i==cursel?"hover":"";
		  con.style.display=i==cursel?"block":"none";
		}
	}

$(function(){
	var loc = '';
	var fromUrl = '';
	$.getUrlParam = function(name)
	{
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r!=null) return unescape(r[2]); return null;
	}
	loc = $.getUrlParam("activityId");
	fromUrl = $.getUrlParam("fromUrl");
	if(loc == '' || loc == null){
		$("#activityId").val("zjsy_thjh_20151023");
	}else{
		$("#activityId").val(loc);
	}
	if(fromUrl == '' || fromUrl == null){
		$("#tc").hide();
		$("#bomb-mask").hide();
	}else{
		$("#tc").show();
		$("#bomb-mask").show();
	}
	
	$(".close").click(function(){
		$("#tc").hide();
		$("#bomb-mask").hide();
	});		
});

function register(){
	var mobile = $("#passport").val();
	if(!isMobile(mobile)){
		alert("您输入的手机号码格式错误，请重新输入。");
		return false;
	}
	// 注册资源
	var url = "http://tg.zhengjin99.com/zhengjin/ws/put_resource_desc.jsp?callbackparam=?";
	var desc = '';
	var activityId = $("#activityId").val();
    $.getJSON(url, {mobile: mobile, activityId: activityId, desc: desc, isSms: 0}, function(data) {
    	console.log(data);
    }); 
	alert("您的申请已提交，稍后会有客服代表与您联系，请稍候。如有疑问，请联系010-58309199。");
	$("#tc").hide();
	$("#bomb-mask").hide();
	window.location.href = 'http://tg.zhengjin99.com/zhengjin/user/login.jsp';
}
function isMobile(val) {
	var reg = /^1[34578]\d{9}$/;
	return reg.test(val);
}

</script>
<style type="text/css">
html,body,div,p,ul,li,span,img,small,img{padding:0;margin:0;}
li{list-style:none;}
img{display:block;}
body,html{width:100%;height:100%;}
/*弹窗*/
.tc-mb{ position:absolute; width:100%; height:6891px; top:0px;left:0px;
background:#000; filter:alpha(opacity=80); -moz-opacity:0.8; opacity:0.8; z-index:10; display:none;}
.tc-whole{position:absolute;width:100%;height:100%;top:0px;left:0px;z-index:19; display:none;}
#tc{width:468px;height:470px;margin:0px auto; z-index:92;position:fixed;_position: absolute;
 _top: expression(documentElement.scrollTop + 0 + "px");left:50%;margin-left:-234px;top:50%;margin-top:-235px;}
.tc-error{ position:absolute; width:50px;height:50px;right:0px;top:0px;background:url(images/error.png) no-repeat;z-index:599;}
#s_log{background:url(images/background.png) no-repeat; width:468px; height:470px; }
#s_log .close{ width:30px; height:30px; right:13px;top:17px;z-index:99;zoom:1;display:block;position:absolute; cursor:pointer;}
#s_log p{ font-family:"微软雅黑"; height:100px;padding-top:49px; font-size:26px; text-align:center;color:#FFF;}
#s_log p span{font-size:34px;}
#s_log dl p{ font-family:"微软雅黑"; height:30px;padding-top:39px; font-size:28px; text-align:center;color:#666;}

#s_log ul{margin:30px 0 0 60px;}
#s_log li{float:left; display:inline; margin-right:20px; cursor:pointer;}
#s_log .log_dl,#s_log .log_dl:hover,#s_log .log_zc,#s_log .log_zc:hover,#s_log .hover .log_dl,#s_log .hover .log_zc{display:block;width:167px; height:43px;}
#s_log .log_dl{background:url(images/login_grey.png);}
#s_log .log_dl:hover,#s_log .hover .log_dl{background:url(images/login_red.png);}
#s_log .log_zc{background:url(images/register_grey.png);}
#s_log .log_zc:hover,#s_log .hover .log_zc{background:url(images/register_red.png);}

.dl_bg{ padding-top:58px;}
.dl_bg dd{margin:16px 0 0 77px;}
.dl_bg dd label{ font-size:16px; color:#999; padding-right:10px;}
.inputphone{width:228px; height:36px; background:url(images/input.png);  border:0px;outline:none; font-size:16px; padding:0 5px; line-height:36px;}
.inputpassword{width:228px; height:36px; background:url(images/password.png);  border:0px;outline:none; font-size:16px; padding:0 5px; line-height:36px;}
.inputinterview{width:356px; height:54px; background:url(images/warnum_23.png);  border:0px;outline:none; font-size:16px; text-align:center; line-height:54px; margin:20px 0 0 56px;}

.input2{width:149px; height:44px; background:#FFF;  border:0px; outline:none; font-size:16px; padding:0 5px; line-height:40px;}
.input3{width:131px; height:44px; background:#FFF;  border:0px; outline:none; position:absolute;top:255px;left:375px;}
.dl_bg .lost_psw{margin:10px 0 0 456px;}
.dl_bg .lost_psw a{font-size:14px; color:#6b4100;}
#s_log .log_btn{background:url(images/get-into-btn.png) no-repeat; width:330px; height:59px;cursor:pointer; border:none; outline:none;margin:0 auto;display:block;margin-top:38px;}
#s_log .log_btn2{background:url(images/back.png) no-repeat; width:175px; height:55px; margin:27px 0 0 14px; cursor:pointer; border:none; outline:none;}
#s_log .log_btn3{background:url(images/submit_big.png) no-repeat; width:245px; height:58px; margin:27px 0px 0px 110px; cursor:pointer; border:none; outline:none;}
#s_log .log_btn4{background:url(images/submit-01.png) no-repeat; width:250px; height:53px; margin:27px 0px 0px 110px; cursor:pointer; border:none; outline:none;}


.zc_bg{ padding-top:68px;}
.zc_bg dd{margin:16px 0 0 77px;}
.zc_bg dd label{  font-size:16px; color:#999; padding-right:10px;}
.zc_input{width:294px; height:44px; background:url(image/input_long.jpg); border:0; outline:none; font-size:16px; padding:0 5px; line-height:40px;}
.zc_bg dd #mobile2{width:280px;}
.zc_bg .lost_psw{margin:10px 0 0 170px; position:relative; color:#f00;}


#bomb-mask{width:100%;height:100%;top:0;left:0;z-index:88;background:#000;filter:alpha(opacity:70);opacity:0.7;position:fixed;_position: absolute;                                       /*IE6 用absolute模拟fixed*/
 _top: expression(documentElement.scrollTop + 0 + "px"); /*IE6 动态设置top位置*/}

</style>
<input type="hidden" value="" id="activityId"/>
<div id="bomb-mask" style="display: none;"></div>
<div class="tc" id="tc" style="display: none;">
  <div id="s_log" > <a href="javascript:void(0);" class="close"></a>
    <p>证金大宗商品2号文件</br>
      <span>添红计划11月11日开启</span></p>
    <ul>
      <li id="a1" onclick="setTab('a',1,2)" class="hover"><a class="log_dl"></a></li>
      <li id="a2" onclick="setTab('a',2,2)"><a class="log_zc"></a></li>
    </ul>
    <div id="con_a_1" class="dl_bg" style="display:block;">
      <dl>
        <dd>
          <label>输入手机号</label>
          <input id="passport6" class="inputphone" type="text" maxlength="11" placeholder="请输入您的手机号码">
        </dd>
        <dd>
          <label style="padding-right:25px;">输入密码</label>
          <input id="password6"  class="inputpassword" type="password" maxlength="30" placeholder="请输入您密码">
        </dd>
      </dl>
      <input type="button" class="log_btn" value="" onclick="zjgjs.sso.login7('6','http://tg.zhengjin99.com/zhengjin/user/')">
     </div>
    <div id="con_a_2" class="zc_bg" style="display:none">
      <dl>
        <dd>
          <label>输入手机号</label>
          <input id="passport" class="inputphone" type="text" maxlength="11" placeholder="请输入您的手机号码" class="input1">
        </dd>
      </dl>
      <input type="button" class="log_btn" value="" onclick="register();">
    </div>
  </div>
</div>
    
</body>
</html>
