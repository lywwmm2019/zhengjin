<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%!
	private Map getOpObj(String title, String val, String type, List<Map> ops){
		Map obj = new HashMap();
		obj.put("title", title);
		obj.put("val", val);
		obj.put("type", type);
		obj.put("ops", ops);
		return obj;
	}
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心_证金贵金属</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/json2.js"></script>
<script type="text/javascript" src="js/function.js"></script>

<STYLE type=text/css>
.STYLE1 {
	FONT-FAMILY: Arial, Helvetica, sans-serif; COLOR: #669933; FONT-SIZE: 36px; FONT-WEIGHT: bold
}
.STYLE2 {
	FONT-FAMILY: Arial, Helvetica, sans-serif; COLOR: #FF0000; FONT-SIZE: 14px; FONT-WEIGHT: bold
}
</STYLE>
<script type="text/javascript">
function Op(q, qid, o, oid){ //use constructor 
	this.q = q; 
	this.qid = qid; 
	this.o = o;  
	this.oid = oid;  
	return this; 
} 
	
var selects = {};

function addSelect(q, qid, o, oid){
	var op = new Op(q, qid, o, oid);
	selects[qid] = op;
}
function checkSelect(obj, q, qid, o, oid){
	if(obj.checked == true){
		var op = new Op(q, qid, o, oid);
		selects[qid] = op;
	}else{
		selects[qid] = undefined;
	}
}

function getSelectNum(selects){
	var len = 0;
	for(var s in selects){
		if(typeof(selects[s]) != "undefined")
			len++;
	}
	return len;
} 

function subselect(){
	if(getSelectNum(selects)>=11){
		$.post("fxpg_ajax.jsp",{type:2, result:JSON.stringify(selects)},function(data){
				$("#right_content").html(data);
			}
		);
	}else{
		return alert("您还有选项未选择，完成后才能提交问卷！");
	}
}

function resetFxpg(){
	if(confirm("重新填写将清除上次的评估结果！确定要重新填写吗？")){
		$.post("fxpg_ajax.jsp",{type:3},function(data){
			$("#right_content").html(data);
		});
	}
}

$(document).ready(function(){
	$.post("fxpg_ajax.jsp",{type:1},function(data){
		$("#right_content").html(data);
	});
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
	<div id="personal" class="clear mb20 over bg_left_gray">
    	<%@ include file="left_menu.jsp"%>
    	<div class="fr grzx_right" id="right_content"></div>
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>
