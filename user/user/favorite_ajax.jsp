<%@page import="com.gti.Utils"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>
<%@ include file="methods.jsp"%> 
<%!
	private int countFavorite(String mobile){
		String sql = "SELECT count(*) total FROM ZX_JsonInfo where type='favorite' and jsonInfo like '%"+ mobile + "%'";
		String key = "FAVORITE_NUM_"+mobile;
		Integer total = (Integer)Cache.get(key);
		if(total == null){
			total = 0;
			List list = QueryRunner.getListBySql(sql);
			if(list.size()>0){
				total = (Integer)((Map)list.get(0)).get("total");
			}
			Cache.set(key, total, expire);
		}
		return total;
	}
	
	private List queryFavorite(Integer pageNum, Integer pageSize, String mobile){
		int start = (pageNum - 1)* pageSize+1;
		int end = start + (pageSize-1);
		String sql ="SELECT * FROM( " +
			"SELECT ROW_NUMBER() over (order by m.createTime desc) as RowNumber, m.* " +
			"from ZX_JsonInfo m where type='favorite' and jsonInfo like '%"+ mobile + "%'" +
			") as x WHERE x.RowNumber BETWEEN "+start+" and " + end;
		
		List listdata = new ArrayList();
		List list = QueryRunner.getListBySql(sql);
		for(Object obj: list){
			Map mapObj =  (Map)obj;
			Map tmp = (Map) Json.fromJson((String)mapObj.get("jsonInfo"));
			tmp.put("id", mapObj.get("id"));
			tmp.put("createTime", mapObj.get("createTime"));
			listdata.add(tmp);
		}
		return listdata;
	}
	
	
	private boolean delFavorite(String id, String mobile){
		String sql="delete from ZX_JsonInfo where id in (" +id + ") and jsonInfo like '%"+ mobile + "%'";
		String key = "FAVORITE_NUM_"+mobile;
		Cache.delete(key);
		return QueryRunner.runSql(sql);
	}
%>

<%
String mobile = getLoginMobile(request);	
if(mobile != null){
	String type = Utils.getParameterValue(request,"type","1");
	String id = Utils.getParameterValue(request,"id","0");
	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	if(info!=null){
		mobile = encrypt(mobile);
		String crmUserId = (String)info.get("UserID");
		if("0".equals(type)){
			delFavorite(id, crmUserId);
		}else if("1".equals(type)){
			try{
				int pageSize = 8;
				String pageNum = Utils.getParameterValue(request,"num","1");
				String key = "FAVORITE_NUM_"+crmUserId;
				List listdata = null;
				Integer total = (Integer)Cache.get(key);
				if(total == null){
					total = 0;
					String sql = "SELECT count(*) total FROM ZX_JsonInfo where type='favorite' and jsonInfo like '%"+ crmUserId + "%'";
					List list = QueryRunner.getListBySql(sql);
					if(list.size()>0){
						total = (Integer)((Map)list.get(0)).get("total");
						if(total>0)
						listdata = queryFavorite(Integer.valueOf(pageNum), Integer.valueOf(pageSize), crmUserId);
					}
					Cache.set(key, total,expire);
					Cache.set(key+"_"+pageNum, listdata,expire);
				}else{
					listdata = (List)Cache.get(key+"_"+pageNum);
					if(listdata == null){
						listdata = queryFavorite(Integer.valueOf(pageNum), Integer.valueOf(pageSize), crmUserId);
					}
				}
				
				int totalPageNum = getTotalPage(pageSize, total);
				pageContext.setAttribute("list", listdata);
				pageContext.setAttribute("totalPageNum", totalPageNum);
				pageContext.setAttribute("num", pageNum);
				pageContext.setAttribute("type", pageNum);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}
%>

				<p class="personal_right_title">我的收藏</p>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_favorite_table">
                <thead>
                  <tr>
                    <td width="35%" class="tl pl5" height="25">标题</td>
                    <td width="20%">所属栏目</td>
                    <td width="15%">收藏日期</td>
                    <td width="15%"><input name="" type="checkbox" value="" onclick="checkAll('CheckBox', this)"class="mr10">全选</td>
                    <td width="15%" class="bd0"><input type="button" name="button" id="button" onclick="delAll(${num})" value="批量移除" class="btn"></td>
                  </tr>
                  <tr><td colspan="5" height="20" style="border:0;">&nbsp;</td></tr>
                </thead>
                <tbody>
                  <tr>
                  <c:forEach items="${list}" var="r" varStatus="status">
	                  <c:if test="${(status.index%2)==0}">
	                  	<tr class="personal_favorite_gray">
	                  </c:if>
	                  <c:if test="${(status.index%2)==1}"><tr></c:if>
                  
                    <td class="personal_favorite_title pl5" width="35%"><a href="${r.url}" target="_blank">${terminal:truncate(r.title, 12)}</a></td>
                    <td width="20%">${r.modelName}</td>
                    <td width="15%"><fmt:formatDate value="${r.createTime}" pattern="yyyy.MM.dd" /></td>
                    <td width="15%"><input name="CheckBox" type="checkbox" value="${r.id}"></td>
                    <td width="15%"><input type="button" name="button" id="button" value="删除" onclick="del(${num}, ${r.id})" class="btn"></td>
                  </tr>
                  </c:forEach>
                  <c:if test="${fn:length(list)<=0}"><tr><td colspan="5" height="20" style="border:0;">你还没有收藏，赶紧去收藏喜欢的文章吧</td></tr></c:if>
                </tbody>
                </table>
				<c:if test="${totalPageNum>1}">
				<div class="personal_dcwj_fy clear over">
                	<div class="up fl" onclick="up(${num},${totalPageNum})">上一页</div>
                    <div class="down fl" onclick="next(${num},${totalPageNum})">下一页</div>
                </div>
                </c:if>