<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="java.net.URLDecoder"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%!
	private List queryVoteQeustion(Integer vid){
		String sql ="SELECT * FROM ZX_Vote where type = 1 and pId = "+vid+" and isvalid = 1";
		return Utils.fetchDataRowsFromSqlOrCache(sql, expire);
	}
	
	private List queryVoteQeustionSelect(String qids){
		String sql ="SELECT * FROM ZX_Vote where type = 2 and pId in ("+qids+") and isvalid = 1";
		return Utils.fetchDataRowsFromSqlOrCache(sql, expire);
	}
	
	private List getVoteQuestions(Integer vid){
		List list = (List)Cache.get("DCLIST_"+vid);
		if(list == null){
			list = queryVoteQeustion(Integer.valueOf(vid));
			StringBuilder sb = new StringBuilder();
			
			if(list.size()>0){
				for(Object obj: list){
					Map mo = (Map)obj;
					sb.append(((Integer)mo.get("id")).toString()).append(",");
				}
			}
			String qids = "0";
			if(sb.lastIndexOf(",")>0?true:false){
				qids = sb.substring(0, sb.lastIndexOf(","));
			}
			
			List selects = queryVoteQeustionSelect(qids);
			if(selects.size()>0){
				Map<String, List> selectsMap = new HashMap<String, List>();
				for(Object obj: selects){
					Map mo = (Map)obj;
					Integer pId = (Integer)mo.get("pId");
					String key = String.valueOf(pId);
					List pSlelect = selectsMap.get(String.valueOf(pId));
					if(pSlelect==null){
						pSlelect = new ArrayList();
						selectsMap.put(key, pSlelect);
					}
					pSlelect.add(obj);
				}
				
				for(Object obj: list){
					Map mo = (Map)obj;
					Integer id = (Integer)mo.get("id");
					mo.put("SELECTS", selectsMap.get(String.valueOf(id)));
				}
			}
			
			Cache.set("DCLIST_"+vid, list, expire);
		}
		return list;
	}
%>

<%
String mobile = getLoginMobile(request);
String title ="";
if(mobile != null){
	try{
		String vid = Utils.getParameterValue(request,"id","0");
		title =Utils.getParameterValue(request,"title", "");
		if(!isNumberic(vid))
			vid="0";
		List list = getVoteQuestions(Integer.valueOf(vid));
		pageContext.setAttribute("list", list);
		pageContext.setAttribute("id", vid);
		pageContext.setAttribute("title", URLDecoder.decode(title,"UTF-8"));
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>信息中心_调查问卷</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/xxzx.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.post("dclb_ajax.jsp",function(data){
		$("#dc_list").html(data);
	});
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
	$.post("dclb_ajax.jsp",{num:num}, function(data){
		$("#dc_list").html(data);
	});
}
var selects = {};

function addSelect(qid, sid){
	selects[qid] = sid;
}

function getSelectNum(selects){
	var len = 0;
	for(var s in selects){
		len++;
	}
	return len;
}

function getSelectJSON(selects){
	return JSON.stringify(selects);
}

function submitVote(vid){
	var qnum = $("#qnum").val();
	if(qnum!=getSelectNum(selects)){
		return alert("您还选项未选择，完成后才能提交问卷！");
	}
	var suggest = $("#suggest").val();
	var vqs = getSelectJSON(selects);
	$.post("dcSubresult_ajax.jsp",{vid:vid, vqs: vqs, suggest:suggest}, function(data){
		if(data.state == 0){
			alert("提交成功!");
		}else if(data.state == -2){
			alert("您已提交过此问卷，请不要重复提交!");
		}else if(data.state == -3){
			alert("您还未登录，请先登录再提交!");
		}else
			alert("提交失败!");
	},'json');
}

function reset(){
	$("#suggest").val("");
	for(var s in selects){
		$("#s_"+selects[s]).attr('checked', false);
	}
	selects = {};
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
    	<div class="grzx_menu fl">
            <ul class="menu_list">
            	<li><p><a href=".">个人信息</a></p></li>
            	<!--li><p><a href="bonus_detail.jsp">证金红包</a></p></li-->
                <li><p><a href="xxzx.jsp">消息中心<span style="padding:0;color:#f00;" id="xxzx"><c:if test="${nrxxNum>0}">（${nrxxNum}）</c:if></span></a></p></li>
                <li><p><a href="zstq.jsp">专属特权</a></p></li>
                <li><p><a href="favorite.jsp">我的收藏</a></p></li>
                <li class="click"><p><a href="dclb.jsp">调查问卷</a></p></li>
                <li><p><a href="fxpg.jsp">风险评估</a></p></li>
                <li><p><a href="resetpwd.jsp">修改密码</a></p></li>
            </ul>
        </div>
    	<div class="fr grzx_right">
        	<div class="personal_right personal_wj">
        		<p class="personal_right_title">调查问卷</p>
                <p class="personal_wj_title tc" id="wjtitle">${title}</p>
                <p class="ti">为了更好地为您提供优质、专业、高效的服务，请留下您的宝贵意见或建议。让客户满意是我们最大的追求，证金从未停止前进的脚步！</p>
               	<input type="hidden" value="${fn:length(list)}" id="qnum"/>
               	<c:forEach items="${list}" var="r" varStatus="status">
	               	<p class="fb mt10" id="q_${r.ID }" >${status.index+1}.${r.TITLE }：</p>
	                <div class="personal_wj_choose">
	                	<c:forEach items="${r.SELECTS}" var="s" varStatus="status">
	                	<input name="qs_${r.ID }" id="s_${s.ID }" type="radio" value="${s.ID }" onclick="addSelect('${r.ID }','${s.ID }')"/><label>${s.TITLE }</label>
	                	</c:forEach>
	                </div>
               	</c:forEach>
                <div class="personal_wj_jy">
                	<p>其他您想对我们说的话：</p>
                    <textarea id="suggest" cols="" rows="3"  maxlength="150"></textarea>
                </div>
                <p class="ti">感谢您的参与，相信有了您的帮助，我们将做得更好！祝您投资愉快！</p>
                <div class="tc mt30"><input name="" type="button" class="personal_wj_able mr100" onclick="submitVote(${id});" value="提交"><input name="" type="button" onclick="reset()" class="personal_wj_enable" value="重置"></div>
            </div>
      	</div>
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>

