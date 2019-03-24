﻿<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>信息中心_证金贵金属</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/xxzx.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	getData(1);
});

function next(num, total){
	if(num>0 && num < total)
		getData(num+1);
}

function up(num, total){
	if(num>1)
		getData(num-1);
}
function getData(num){
	$.post("favorite_ajax.jsp",{type:1,num:num}, function(data){
		$("#list").html(data);
	});
}

function del(num, id){
	if(id == null || id == "")
		return alert("请选要删除的选项!");
	if(confirm("您确定要删除吗？")){
		$.post("favorite_ajax.jsp",{type:0,id:id}, function(data){
			getData(num);
		});
	}
}

function delAll(num){
	var ids = getDelIds("CheckBox");
	if(ids == null || ids == "")
		return alert("请选择删除项");
	del(num, ids);
}

function checkAll(id, obj){
	if(!obj)
		return false;
	if(obj.checked == true){
		checkedAll(id, true);
	}else{
		checkedAll(id, false);
	}
		
}

function checkedAll(name, checked){
	$("input[name='"+name+"']").each(function(){
		$(this).attr("checked",checked);
	}); 
}

function getDelIds(name){
	var ids = "";
	$("input[name='"+name+"']").each(function(){
		if($(this).attr("checked") == true){
			if(ids == "")
				ids = $(this).val();
			else
				ids += "," + $(this).val();
		}
	}); 
	return ids;
}
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
        <div class="fr grzx_right" id="right_list">
        	<div class="personal_right pr" id="list">
        		<p class="personal_right_title">我的收藏</p>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_favorite_table">
                <thead>
                  <tr>
                    <td width="35%" class="tl pl5" height="25">标题</td>
                    <td width="20%">所属栏目</td>
                    <td width="15%">收藏日期</td>
                    <td width="15%"><input name="" type="checkbox" value="" class="mr10">全选</td>
                    <td width="15%" class="bd0"><input type="button" name="button" id="button" value="批量移除" class="btn"></td>
                  </tr>
                  <tr><td colspan="5" height="20" style="border:0;">&nbsp;</td></tr>
                </thead>
                <tbody>
                  <tr><td colspan="5" height="20" style="border:0;">你还没有收藏，赶紧去收藏喜欢的文章吧</td></tr>
                </tbody>
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

