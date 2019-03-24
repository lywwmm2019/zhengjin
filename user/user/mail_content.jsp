<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ page import="com.gti.Utils"%>
<%@ include file="methods.jsp"%>
<%
	try{
		String mobile = getLoginMobile(request);	
		if(mobile != null){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				String crmuserId = (String)info.get("UserID");
				String type = Utils.getParameterValue(request,"id","1");
				String mid = Utils.getParameterValue(request,"mid","1");
				String isDeal = Utils.getParameterValue(request,"isDeal","1");
				
				/* if(!isNumberic(mid))
					mid = "100111"; */
				mid = Utils.DESdecrypt(mid.substring(5)).replace("a2b3c4d5e5f", "");
				mobile = encrypt(mobile);
				//查询信息内容
				List list = queryMailContentById(mobile, Integer.valueOf(mid));
				Object mail = null;
				if(list!=null && list.size()>0)
					mail = list.get(0);
				if("0".equals(isDeal)){//未读信息，设置成已读
					setisDeal(mobile, crmuserId, Integer.valueOf(mid));
					clearUserCacheByKey(mobile);
				}
				pageContext.setAttribute("type", type);
				pageContext.setAttribute("mail", mail);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<div class="personal_right">
<p class="personal_right_title">信息中心</p>
      <ul class="personal_ggts_title">
      		<c:if test="${type==1}">
	      		<li id="mail_1" class="li_select" onclick="content2BackList(1,3)">证金来信</li>
	        	<li id="mail_2" onclick="content2BackList(2,3)">活动信息</li>
	        	<li id="mail_3" class="br0" onclick="content2BackList(3,3)">公告提示</li>
      		</c:if>
      		<c:if test="${type==2}">
	      		<li id="mail_1" onclick="content2BackList(1,3)">证金来信</li>
	        	<li id="mail_2" class="li_select" onclick="content2BackList(2,3)">活动信息</li>
	        	<li id="mail_3" class="br0" onclick="content2BackList(3,3)">公告提示</li>
      		</c:if>
      		<c:if test="${type==3}">
	      		<li id="mail_1" onclick="content2BackList(1,3)">证金来信</li>
	        	<li id="mail_2" onclick="content2BackList(2,3)">活动信息</li>
	        	<li id="mail_3" class="br0 li_select" onclick="content2BackList(3,3)">公告提示</li>
      		</c:if>
      </ul>
      <div class="clear mt10 personal_send_bd">
          <input name="" type="button" onclick="backMailList(${type})"class="personal_ggts_btn" value="返 回">
          <!-- <input name="" type="button" class="personal_ggts_btn" value="删 除"> -->
          <!-- <div class="fr cur"><span class="mr10 enable_txt">上一封</span><span>下一封</span></div> -->
          <div class="clear"></div>
      </div>
      <div class="personal_send_title">
      	<p class="fb personal_send_tt">${mail.TITLE}</p>
          <p>发件人：<span>证金贵金属</span></p>
          <p>时&nbsp;&nbsp;间：<span><fmt:formatDate value="${mail.CREATETIME}" pattern="yyyy年MM月dd日    HH:mm:ss" /></span></p>
          <c:if test="${mail.savefileName != null}">
          	<p>附&nbsp;&nbsp;件：
          	<a target="_blank" href="http://tg.zhengjin99.com${mail.filepath}/${mail.savefileName}">${mail.fileName}</a>
          	</p>
          </c:if>
          
      </div>
      <div class="personal_send_main">
		<p class="ti">${fn:replace(mail.CONTENT, '/apl', '')}</p>
      </div>
</div>