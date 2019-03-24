<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="xxzx_java.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>信息中心_证金贵金属</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/xxzx.js"></script>
<script type="text/javascript">
	function openHD(URI){
		window.open('hd_count.jsp?r='+encodeURI(URI));
		setTimeout(function(){refreshNRnum(0);refreshNRnum(2);} , 1000);
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
        	<div class="personal_right pr">
        		<p class="personal_right_title">信息中心</p>
                <ul class="personal_ggts_title">
                	<li id="mail_1" class="li_select" onclick="setMailTab(1,3)">证金来信<span class="red" style="font-size:12px;" id="nr_1"><c:if test="${zxlxNRNum>0}">（${zxlxNRNum}）</c:if></span></li>
                    <li id="mail_2" onclick="setMailTab(2,3)">活动信息<span class="red" style="font-size:12px;" id="nr_2"><c:if test="${hdxxNRNum>0}">（${hdxxNRNum}）</c:if></span></li>
                    <li id="mail_3" onclick="setMailTab(3,3)">公告提示<span class="red" style="font-size:12px;" id="nr_3"><c:if test="${ggtsNRNum>0}">（${ggtsNRNum}）</c:if></span></li>
                </ul>
                <!-- 证金来信 -->
                <div id="tab_mail_1" class="clear mt10">
                <div>
                	<div class="personal_ggts_btn fl"><input id="mail_1_allcheck" type="checkbox" onclick="checkAll(1, this)" class="check fl" /></div>
                    <input name="" onclick="delMail(1)" type="button" class="personal_ggts_btn" value="删 除" />
                    <input name="" onclick="getData(1,1)" type="button" class="personal_ggts_btn" value="刷 新" />
                    <div class="fr cur"><span onclick="up(1,1,${zxlxpgNum})" >上一页</span>
                    <span class="personal_ggts_page">
                    <span>${zxlxpgNum>0?1:0}/${zxlxpgNum}页</span>
                    <span class="trangle_down"></span></span>
                    <span onclick="next(1,1,${zxlxpgNum})" >下一页</span></div>
                    <div class="clear"></div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_ggts_tabletitle mt10">
                  <tr>
                    <td width="6%"><div class="personal_message_1 fr"></div><div class="fr personal_message_2 mr10"></div></td>
                    <td width="15%">发件人</td>
                    <td style="border-right:0;" width="54%">主题</td>
                    <td style="border-right:0;" class="tr pr10" width="15%">时间</td>
                  </tr>
                </table>
                <c:if test="${fn:length(zxlxList0)>0}">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message">
                <thead>
                	<tr>
                    	<td colspan="5">未读信息<span class="personal_wd_num">(${zxlxNRNum})</span></td>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach items="${zxlxList0}" var="r" varStatus="status">
                  	<c:if test="${r.isdeal==0&&(status.index%2)==0}">
                  	<tr class="bg_gray">
                    <td width="3%" class="tc"><input name="mail_1_check" type="checkbox" value="${r.ID}" /></td>
                    <td width="3%"><div class="personal_message_wd mauto"></div></td>
                    <td width="14%">证金贵金属</td>
                    <td width="49%"><a href="javascript:void(0);" onclick="getMailContent(1, '10011${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="22%" class="tr pr10">
					<c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
					</td>
                  	</tr>
                  	</c:if>
                  	<c:if test="${r.isdeal==0&&(status.index%2)==1}">
                  	<tr>
                    <td width="3%" class="tc"><input name="mail_1_check" type="checkbox" value="${r.ID}" /></td>
                    <td width="3%"><div class="personal_message_wd mauto"></div></td>
                    <td width="14%">证金贵金属</td>
                    <td width="19%"><a href="javascript:void(0);" onclick="getMailContent(1, '10011${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="22%" class="tr pr10">
                    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
                    </td>
                  	</tr>
                  	</c:if>
                  </c:forEach>
                  
                </tbody>
                </table>
				</c:if>
				<c:if test="${fn:length(zxlxList1)>0}">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message personal_yd_message">
                <thead>
                	<tr>
                    	<td colspan="5" class="fb">已读信息<span class="personal_wd_num">(${zxlxTotal-zxlxNRNum})</span></td>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach items="${zxlxList1}" var="r" varStatus="status">
                  	<c:if test="${r.isdeal==1&&(status.index%2)==0}">
                  	<tr class="bg_gray">
                    <td width="3%" class="tc"><input name="mail_1_check" type="checkbox" value="${r.ID}" /></td>
                    <td width="4%"><div class="personal_message_yd mauto"></div></td>
                    <td width="15%">证金贵金属</td>
                    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(1, '10011${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="25%" class="tr pr10">
                    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
                    </td>
                  	</tr>
                  	</c:if>
                  	<c:if test="${r.isdeal==1&&(status.index%2)==1}">
                  	<tr>
                    <td width="3%" class="tc"><input name="mail_1_check" type="checkbox" value="${r.ID}" /></td>
                    <td width="4%"><div class="personal_message_yd mauto"></div></td>
                    <td width="15%">证金贵金属</td>
                    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(1, '10011${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="25%" class="tr pr10">
                    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
					</td>
                  	</tr>
                  	</c:if>
                  </c:forEach>
                </tbody>
                </table>
                </c:if>
                <c:if test="${zxlxpgNum>1}">
                <div class="personal_dcwj_fy clear over">
                	<div class="up fl" onclick="up(1,1,${zxlxpgNum})" >上一页</div>
                    <div class="down fl" onclick="next(1,1,${zxlxpgNum})" >下一页</div>
                </div>
                </c:if>
                </div>
                
                <!-- 活动信息 -->
                <div id="tab_mail_2" style="display: none" class="mt20">
                <ul class="clear over personal_hd mt20">
                	<c:forEach items="${hdxxList}" var="r" varStatus="status">
	                <%-- <li class="">
	                    	<img src="http://tg.zhengjin99.com/apl${r.FILE_PATH }${r.FILE_NAME }" width="147" height="197" class="fl">
	                        <p class="">
	                        	<span class="fb personal_h42">${terminal:truncate(r.title, 20)}</span>
	                        	<span class="f12 xxzx_dis personal_h63">${terminal:truncate(r.SUMMARY, 30)}</span>
	                            <span class="fb mt15">活动时间</span>
								<span class="f12"><fmt:formatDate value="${r.VIDEO_TIME}" pattern="yyyy年MM月dd日" />-<fmt:formatDate value="${r.REC_TIME}" pattern="yyyy年MM月dd日" /></span>
								<span class="f12">${fn:substring(r.VIDEO_TIME,0,4)}年${fn:substring(r.VIDEO_TIME,5,7)}月${fn:substring(r.VIDEO_TIME,8,10)}日-${fn:substring(r.REC_TIME,0,4)}年${fn:substring(r.REC_TIME,5,7)}月${fn:substring(r.REC_TIME,8,10)}日</span>
	                            <c:if test="${r.FLAG==0}"><input name="" type="button"  value="即将开始" class="hd_future"></c:if>
	                            <c:if test="${r.FLAG==1}"><input name="" type="button" onclick="window.open('${r.VIDEO_SRC}')" value="我要参加" class="hd_on"></c:if>
	                            <c:if test="${r.FLAG==2}"><input name="" type="button"  value="活动已结束" class="hd_close"></c:if>
	                        </p>
	                    </li> --%>
	                <li class="">
			            <img src="${r.FILE_PATH }${r.FILE_NAME }" width="527" height="200" class="fl" />
			            <p class="">
			                <span class="fb">${terminal:truncate(r.title, 11)}</span>
			                <span class="f12">${terminal:truncate(r.SUMMARY, 35)}</span>
			                <span class="fb mt15">活动时间</span>
							<span class="f12">${fn:substring(r.VIDEO_TIME,0,4)}年${fn:substring(r.VIDEO_TIME,5,7)}月${fn:substring(r.VIDEO_TIME,8,10)}日-${fn:substring(r.REC_TIME,0,4)}年${fn:substring(r.REC_TIME,5,7)}月${fn:substring(r.REC_TIME,8,10)}日</span>
			                <input name="" type="button" value="点击查看详情" onclick="openHD('${r.VIDEO_SRC}');" class="hd_know" />
			            </p>
			        </li>
                    </c:forEach>
                </ul>
                <c:if test="${hdxxpgNum>1 }">
			    <div class="tc personal_page">
			    	<c:if test="${hdxxpgNum>1 }">
			    		<span class="page_ud"><a href="javascript:void(0)">&lt;</a></span>
			    	</c:if>
			    	
			    	<span class="page_select">1</span>
			    	<c:if test="${hdxxpgNum>=10 }">
				    	<c:forEach var="i" begin="2" end="8" step="1">
						  <span ><a href="javascript:void(0)" onclick="toPage(2, ${i}, ${hdxxpgNum})">${i}</a></span>
						</c:forEach>
					</c:if>
					<c:if test="${hdxxpgNum<10 }">
				    	<c:forEach var="i" begin="2" end="${hdxxpgNum}" step="1">
						  <span ><a href="javascript:void(0)" onclick="toPage(2, ${i}, ${hdxxpgNum})">${i}</a></span>
						</c:forEach>
					</c:if>
			        <c:if test="${hdxxpgNum>=10 }">
				        <span>…</span>
				    	<span class="page_select"><a href="javascript:void(0)" onclick="toPage(2, ${hdxxpgNum}, ${hdxxpgNum})">${hdxxpgNum }</a></span>
			    	</c:if>
			    	
			        <c:if test="${hdxxpgNum>1}">
			        	<span class="page_ud"><a href="javascript:void(0)" onclick="next(2,1,${hdxxpgNum})">&gt;</a></span>
			        </c:if>
			    </div>
			    </c:if>
                </div>
                
                <!-- 公告提示 -->
                <div id="tab_mail_3" style="display: none">
                <div class="clear mt10">
                	<div class="personal_ggts_btn fl"><input name="" type="checkbox" value="" onclick="checkAll(3, this)" class="check fl" /></div>
                    <input name="" type="button" onclick="delMail(3)" class="personal_ggts_btn" value="删 除" /><input name="" type="button" onclick="getData(3,1)" class="personal_ggts_btn" value="刷 新" />
                    <div class="fr cur"><span onclick="up(3,1,${ggtspgNum})" >上一页</span><span class="personal_ggts_page"><span>${ggtspgNum>0?1:0}/${ggtspgNum}页</span><span class="trangle_down"></span></span><span  onclick="next(3,1,${ggtspgNum})" >下一页</span></div>
                    <div class="clear"></div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_ggts_tabletitle mt10">
                  <tr>
                    <td width="6%"><div class="personal_message_1 fr"></div><div class="fr personal_message_2 mr10"></div></td>
                    <td width="15%">发件人</td>
                    <td style="border-right:0;" width="54%">主题</td>
                    <td style="border-right:0;" class="tr pr10" width="15%">时间</td>
                  </tr>
                </table>
                <c:if test="${fn:length(ggtsList0)>0}">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message">
                <thead>
                	<tr>
                    	<td colspan="5">未读信息<span class="personal_wd_num">(${ggtsNRNum})</span></td>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach items="${ggtsList0}" var="r" varStatus="status">
                  	<c:if test="${r.isdeal==0&&(status.index%2)==0}">
                  	<tr class="bg_gray">
                    <td width="3%" class="tc"><input name="mail_3_check"  type="checkbox" value="${r.ID}" /></td>
                    <td width="3%"><div class="personal_message_wd mauto"></div></td>
                    <td width="14%">证金贵金属</td>
                    <td width="49%"><a href="javascript:void(0);" onclick="getMailContent(3, '10013${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="22%" class="tr pr10">
					<c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
					</td>
                  	</tr>
                  	</c:if>
                  	<c:if test="${r.isdeal==0&&(status.index%2)==1}">
                  	<tr>
                    <td width="3%" class="tc"><input name="mail_3_check"  type="checkbox" value="${r.ID}" /></td>
                    <td width="3%"><div class="personal_message_wd mauto"></div></td>
                    <td width="14%">证金贵金属</td>
                    <td width="49%"><a href="javascript:void(0);" onclick="getMailContent(3, '10013${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="22%" class="tr pr10">
                    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
                    </td>
                  	</tr>
                  	</c:if>
                  </c:forEach>
                  
                </tbody>
                </table>
				</c:if>
				<c:if test="${fn:length(ggtsList1)>0}">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message personal_yd_message">
                <thead>
                	<tr>
                    	<td colspan="5" class="fb">已读信息<span class="personal_wd_num">(${ggtsTotal-ggtsNRNum})</span></td>
                    </tr>
                </thead>
                <tbody>
                  <c:forEach items="${ggtsList1}" var="r" varStatus="status">
                  	<c:if test="${r.isdeal==1&&(status.index%2)==0}">
                  	<tr class="bg_gray">
                    <td width="3%" class="tc"><input name="mail_3_check"  type="checkbox" value="${r.ID}" /></td>
                    <td width="4%"><div class="personal_message_yd mauto"></div></td>
                    <td width="15%">证金贵金属</td>
                    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(3, '10013${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="25%" class="tr pr10">
					<c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
					</td>
                  	</tr>
                  	</c:if>
                  	<c:if test="${r.isdeal==1&&(status.index%2)==1}">
                  	<tr>
                    <td width="3%" class="tc"><input name="mail_3_check"  type="checkbox" value="${r.ID}" /></td>
                    <td width="4%"><div class="personal_message_yd mauto"></div></td>
                    <td width="15%">证金贵金属</td>
                    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(3, '10013${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
                    <td width="25%" class="tr pr10">
					<c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
                    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
					</td>
                  	</tr>
                  	</c:if>
                  </c:forEach>
                </tbody>
                </table>
                </c:if>
                <c:if test="${ggtspgNum>1}">
                <div class="personal_dcwj_fy clear over">
                	<div class="up fl" onclick="up(3,1,${ggtspgNum})" >上一页</div>
                    <div class="down fl" onclick="next(3,1,${ggtspgNum})" >下一页</div>
                </div>
                </c:if>
                </div>
				
            </div>
      	</div>
        <div class="fr grzx_right" style="display: none" id="right_content">
        	<div class="personal_right">
        		<p class="personal_right_title">信息中心</p>
                <ul class="personal_ggts_title">
                	<li class="li_select">证金来信</li>
                    <li>活动信息</li>
                    <li class="br0">公告提示</li>
                </ul>
                <div class="clear mt10 personal_send_bd">
                	
                    <input name="" type="button" class="personal_ggts_btn" value="返 回"><input name="" type="button" class="personal_ggts_btn" value="删 除">
                    <div class="fr cur"><span class="mr10 enable_txt">上一封</span><span>下一封</span></div>
                    <div class="clear"></div>
                </div>
                <div class="personal_send_title">
                	<p class="fb personal_send_tt">---</p>
                    <p>发件人：<span>证金贵金属</span></p>
                    <p>时&nbsp;&nbsp;间：<span>---</span></p>
                </div>
                <div class="personal_send_main">
                	<p class="f14">无法打开信息内容!</p>  
                </div>
               
            </div>
      	</div>
      	<div class="clear"></div>
    </div>
    <%@ include file="foot_user_v2.jsp"%>
    <!-- foot -->
	<%@ include file="../foot_v2.jsp"%>
</body>
</html>

