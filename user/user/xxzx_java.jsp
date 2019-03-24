
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="user_common.jsp"%>
<%
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			String phone = mobile;
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
			mobile = Utils.encrypt(mobile,Utils.DES_KEY);
			String crmUserId = (String)info.get("UserID");
			String regTime = (String)info.get("CreateTime");
			//符合要求的发送证金第一封信
			insertMail(0, crmUserId, mobile, regTime);
			
			String utyp = getUserMailType(request);
			Integer pageSize = 10;
			Integer zxlxNRNum = countNoReadMailByType(0, "1", utyp, mobile, crmUserId, regTime);
			int zxlxTotal = countMailByType(0, "1", utyp, mobile, crmUserId, regTime);
			int zxlxpgNum = 0;
			List list1 = null;
			if(zxlxTotal>0){ 
				list1 = queryMailByType(0, "1", utyp,  mobile, crmUserId, regTime, 1, pageSize);
				zxlxpgNum = getTotalPage(pageSize, zxlxTotal);
				encrytId(list1); 
			}
			List zxlxList0 = new ArrayList();
			List zxlxList1 = new ArrayList(); 
			splitReadAndNoReadMail(zxlxList0, zxlxList1, list1);
			pageContext.setAttribute("zxlxList0", zxlxList0);
			pageContext.setAttribute("zxlxList1", zxlxList1);
			pageContext.setAttribute("zxlxTotal", zxlxTotal);
			pageContext.setAttribute("zxlxpgNum", zxlxpgNum);
			pageContext.setAttribute("zxlxNRNum", zxlxNRNum);
			
			//公告提示
			Integer ggtsNRNum = countNoReadMailByType(0, "3", utyp, mobile, crmUserId, regTime);
			int ggtsTotal = countMailByType(0, "3", utyp, mobile, crmUserId, regTime);
			int ggtspgNum = 0;
			List list3 = null;
			if(ggtsTotal>0){
			    list3 = queryMailByType(0, "3", utyp, mobile, crmUserId, regTime, 1, pageSize);
			    ggtspgNum = getTotalPage(pageSize,ggtsTotal);
			    encrytId(list3); 
			}
			List ggtsList0 = new ArrayList();
			List ggtsList1 = new ArrayList();
			splitReadAndNoReadMail(ggtsList0, ggtsList1, list3);
			pageContext.setAttribute("ggtsList0", ggtsList0);
			pageContext.setAttribute("ggtsList1", ggtsList1);
			pageContext.setAttribute("ggtsTotal", ggtsTotal);
			pageContext.setAttribute("ggtspgNum", ggtspgNum);
			pageContext.setAttribute("ggtsNRNum", ggtsNRNum);
			}
			
			//活动信息
			String modelId = "730";
			int hdxxpgNum = 0;
			int hdxxTotal = countByModelId(modelId);
			List list2 = null;
			if(hdxxTotal > 0){
				list2 = getListByTimeDesc(1, 4, modelId); 
				hdxxpgNum = getTotalPage(4, hdxxTotal);
				dealColumn(list2);
			}
			int hhxxRNum = queryUserRHd(Utils.MD5(phone));
			pageContext.setAttribute("hdxxList", list2);
			pageContext.setAttribute("hdxxpgNum", hdxxpgNum);
			pageContext.setAttribute("hdxxNRNum", (hdxxTotal-hhxxRNum));
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>