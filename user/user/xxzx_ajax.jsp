<%@ include file="methods.jsp"%>
<%@ page import="com.gti.Utils"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>

<%
	try{
		String mobile = getLoginMobile(request);	 
		if(mobile != null){
			String utyp = getUserMailType(request);  
			Integer pageSize = 10;
			String type = Utils.getParameterValue(request,"id","1");
			String pageNum = Utils.getParameterValue(request,"num","1");
			if(("1".equals(type)||"3".equals(type)) && isNumberic(pageNum)){ //1证金来信， 3公告提示
				Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
				if(info!=null){
					mobile = encrypt(mobile);
					String crmUserId = (String)info.get("UserID");
					String regTime = (String)info.get("CreateTime"); 
					List list = queryMailByType(0, type, utyp, mobile, crmUserId, regTime, Integer.valueOf(pageNum), pageSize);
				
					Integer NRNum = countNoReadMailByType(0, type, utyp, mobile, crmUserId, regTime);
					int total = countMailByType(0, type, utyp, mobile, crmUserId, regTime);
					int pageTotalNum = getTotalPage(pageSize, total);
					encrytId(list); 	
					List list0 = new ArrayList();
					List list1 = new ArrayList();
					splitReadAndNoReadMail(list0, list1, list);
					pageContext.setAttribute("list0", list0);
					pageContext.setAttribute("list1", list1);
					pageContext.setAttribute("total", total);
					pageContext.setAttribute("pageTotalNum", pageTotalNum);
					pageContext.setAttribute("NRNum", NRNum);
					pageContext.setAttribute("num", pageNum);
					pageContext.setAttribute("id", type);
				}
			}else if("2".equals(type) && isNumberic(pageNum)){ //活动信息
				String modelId = "730";
				int total = countByModelId(modelId);
				int pageTotalNum = getTotalPage(6, total);
				List list = null;
				if(total > 0)
					list = getListByTimeDesc(Integer.valueOf(pageNum), 6, modelId); 
				dealColumn(list);
				pageContext.setAttribute("total", total);
				pageContext.setAttribute("pageTotalNum",pageTotalNum);
				pageContext.setAttribute("num", pageNum);
				pageContext.setAttribute("id", type);
				pageContext.setAttribute("hdxxList", list);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<c:if test="${id==2}">
	<ul class="clear over personal_hd mt20">
    	<c:forEach items="${hdxxList}" var="r" varStatus="status">
     	<%-- <li class="">
         	<img src="/spage${r.FILE_PATH }${r.FILE_NAME }" width="147" height="197" class="fl">
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
                <input name="" type="button" value="点击查看详情" onclick="window.open('${r.VIDEO_SRC}');" class="hd_know" />
            </p>
        </li>
        </c:forEach>
    </ul>
    <c:if test="${pageTotalNum>1}">
	    <div class="tc personal_page">
	    	<c:if test="${pageTotalNum>1}">
	    		<span class="page_ud"><a href="javascript:void(0)" onclick="up(2,${num},${pageTotalNum})">&lt;</a></span>
	    	</c:if>
	    	<c:if test="${num==1}">
	    		<span class="page_select">1</span>
	    	</c:if>
	    	<c:if test="${num!=1}">
	    		<span><a href="javascript:void(0)" onclick="toPage(2,1,${pageTotalNum})">1</a></span>
	    	</c:if>
	    	
	    	<c:if test="${pageTotalNum<=10}">
		    	<c:forEach var="i" begin="2" end="${pageTotalNum}" step="1">
		    		<c:if test="${num==i}">
		    			<span class="page_select"><a href="javascript:void(0)">${i}</a></span>
		    		</c:if>
		    		<c:if test="${num!=i}">
		    			<span ><a href="javascript:void(0)" onclick="toPage(2,${i}, ${pageTotalNum})">${i}</a></span>
		    		</c:if>
				</c:forEach>
				
	    	</c:if>
	    	
	    	<c:if test="${pageTotalNum>10}">
		    	<c:if test="${(num>5?(num-3):2) >2}">
		    	  <span>…</span>
		    	</c:if>
	    		
		    	<c:forEach var="i" begin="${num>5?(num-3):2}" end="${(num+4)<pageTotalNum?(num+4):(pageTotalNum-1)}" step="1">
		    		<c:if test="${num==i}">
		    			<span class="page_select"><a href="javascript:void(0)">${i}</a></span>
		    		</c:if>
		    		<c:if test="${num!=i}">
		    			<span ><a href="javascript:void(0)" onclick="toPage(2,${i}, ${pageTotalNum})">${i}</a></span>
		    		</c:if>
				</c:forEach>
				<c:if test="${num==pageTotalNum && pageTotalNum>1}">
	    			<span class="page_select">${pageTotalNum }</span>
		    	</c:if>
		    	<c:if test="${num!=pageTotalNum && pageTotalNum>10}">
			    	<span>…</span>
			    	<span><a href="javascript:void(0)" onclick="toPage(2,${pageTotalNum}, ${pageTotalNum})">${pageTotalNum }</a></span>
		    	</c:if>
	    	</c:if>
	    	
	    	
	    	
	        <c:if test="${pageTotalNum>1}">
	        	<span class="page_ud"><a href="javascript:void(0)" onclick="next(2,${num},${pageTotalNum})">&gt;</a></span>
	        </c:if>
	        
	    </div>
    </c:if>
</c:if>

<c:if test="${id==1||id==3}">
<div class="clear mt10">
	<div class="personal_ggts_btn fl"><input id="mail_1_allcheck" type="checkbox" onclick="checkAll(${id}, this)" class="check fl" /></div>
    <input name="" onclick="delMail(${id})" type="button" class="personal_ggts_btn" value="删 除" /><input name="" onclick="getData(${id},1)" type="button" class="personal_ggts_btn" value="刷 新" />
    <div class="fr cur"><span onclick="up(${id},${num},${pageTotalNum})">上一页</span><span class="personal_ggts_page"><span>${pageTotalNum==0?0:num}/${pageTotalNum}页</span><span class="trangle_down"></span></span><span onclick="next(${id},${num},${pageTotalNum})">下一页</span></div>
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
<c:if test="${fn:length(list0)>0}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message">
<thead>
	<tr>
    	<td colspan="5">未读信息<span class="personal_wd_num">(${NRNum})</span></td>
    </tr>
</thead>
<tbody>
  <c:forEach items="${list0}" var="r" varStatus="status">
  	<c:if test="${r.isdeal==0&&(status.index%2)==0}">
  	<tr class="bg_gray">
    <td width="3%" class="tc"><input name="mail_${id}_check" type="checkbox" value="${r.ID}" /></td>
    <td width="3%"><div class="personal_message_wd mauto"></div></td>
    <td width="14%">证金贵金属</td>
    <td width="49%"><a href="javascript:void(0);" onclick="getMailContent(${id}, '10010${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
    <td width="22%" class="tr pr10">
	<c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
	</td>
    </tr>
    </c:if>
  	<c:if test="${r.isdeal==0&&(status.index%2)==1}">
  	<tr class="">
    <td width="3%" class="tc"><input name="mail_${id}_check" type="checkbox" value="${r.ID}" /></td>
    <td width="3%"><div class="personal_message_wd mauto"></div></td>
    <td width="14%">证金贵金属</td>
    <td width="49%"><a href="javascript:void(0);" onclick="getMailContent(${id}, '10010${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
    <td width="22%" class="tr pr10">
    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if></td>
    </tr>
    </c:if>
    </c:forEach>
</tbody>
</table>
</c:if>
<c:if test="${fn:length(list1)>0}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_wd_message personal_yd_message">
            <thead>
            	<tr>
                	<td colspan="5" class="fb">已读信息<span class="personal_wd_num">(${total-NRNum})</span></td>
    </tr>
</thead>
<tbody>
  <c:forEach items="${list1}" var="r" varStatus="status">
  	<c:if test="${r.isdeal==1&&(status.index%2)==0}">
  	<tr class="bg_gray">
    <td width="3%" class="tc"><input name="mail_${id}_check" type="checkbox" value="${r.ID}" /></td>
    <td width="4%"><div class="personal_message_yd mauto"></div></td>
    <td width="15%">证金贵金属</td>
    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(${id}, '10010${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
    <td width="25%" class="tr pr10">
    <c:if test="${r.CREATETIME2 eq '-1'}"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
    <c:if test="${r.CREATETIME2 ne '-1'}">${r.CREATETIME2}</c:if>
    </td>
  	</tr>
  	</c:if>
  	<c:if test="${r.isdeal==1&&(status.index%2)==1}">
  	<tr class="">
    <td width="3%" class="tc"><input name="mail_${id}_check" type="checkbox" value="${r.ID}" /></td>
    <td width="4%"><div class="personal_message_yd mauto"></div></td>
    <td width="15%">证金贵金属</td>
    <td width="50%"><a href="javascript:void(0);" onclick="getMailContent(${id}, '10010${r.ID}',${r.ISDEAL})">${r.TITLE}</a></td>
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
<c:if test="${pageTotalNum > 1}">
<div class="personal_dcwj_fy clear over">
	<div class="up fl" onclick="up(${id},${num},${pageTotalNum})" >上一页</div>
    <div class="down fl" onclick="next(${id},${num},${pageTotalNum})" >下一页</div>
</div>
</c:if>
</c:if>
