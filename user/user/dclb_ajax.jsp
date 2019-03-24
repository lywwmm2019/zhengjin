<%@page import="com.gti.Utils"%>
<%@page import="java.net.URLEncoder"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="terminal" uri="/WEB-INF/tld/terminal.tld"%>
<%@ include file="methods.jsp"%>
<%!
	private List queryDcList(int pageNum, int pageSize){
		int start = (pageNum - 1)* pageSize+1;
		int end = start + (pageSize-1);
		String sql ="SELECT * FROM( " +
			"SELECT ROW_NUMBER() over (order by m.createTime desc) as RowNumber, m.* "+
			"from ZX_Vote m where m.type in (0,-1) and m.isvalid = 1 "+
			") as x WHERE x.RowNumber BETWEEN "+start+" and " + end;
		return Utils.fetchDataRowsFromSqlOrCache(sql, expire);
	}
	
	private Integer countDcList(){
		Integer totalRow = 0;
		String sql = "select count(*) as total from ZX_Vote where type in (0,-1) and isvalid = 1";
		List list = Utils.fetchDataRowsFromSqlOrCache(sql, expire);
		if(list.size() > 0){
			totalRow = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
		}
		return totalRow;
	}
%>

<%
String mobile = getLoginMobile(request);	
if(mobile != null){
	try{
		int pageSize  = 8;
		String pageNum = Utils.getParameterValue(request,"num","1");
		Integer total = countDcList();
		List list = null;
		if(total>0){
			list = queryDcList(Integer.valueOf(pageNum), pageSize);
			for(Object obj: list){
				Map map = (Map)obj;
				String title = (String)map.get("TITLE");
				map.put("ETITLE", URLEncoder.encode(title, "UTF-8"));
			}
		}
		int totalPageNum = getTotalPage(pageSize, total);
		pageContext.setAttribute("list", list);
		pageContext.setAttribute("totalPageNum", totalPageNum);
		pageContext.setAttribute("num", pageNum);
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="personal_dcwj_table">
   <thead>
     <tr>
       <td width="85%" class="pl5">标题</td>
       <td class="tc">日期</td>
     </tr>
   </thead>
   <tbody>
   	  <c:forEach items="${list }" var="r" varStatus="status">
   	  <c:if test="${status.index%2==0}">
   	  <tr>
        <td class="bg_gray pl5">
        <c:if test="${r.type!=0}">
        <a href="dcwj2.jsp?id=${r.id}&title=${r.ETITLE}" target="_blank">${terminal:truncate(r.TITLE, 30)}</a>
        </c:if>
        <c:if test="${r.type==0}">
        <a href="dcwj.jsp?id=${r.id}&title=${r.ETITLE}" target="_blank">${terminal:truncate(r.TITLE, 30)}</a>
        </c:if>
        </td>
        <%-- <td class="bg_gray pl5"><a onclick="openUrl(${r.id}, '${r.ETITLE}')" target="blank">${terminal:truncate(r.TITLE, 30)}</a></td> --%>
        <td class="tc bg_gray"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy.MM.dd" /></td>
      </tr>
      </c:if>
      <c:if test="${status.index%2==1}">
      <tr>
        <td class="pl5">
        <c:if test="${r.type!=0}">
        <a href="dcwj2.jsp?id=${r.id}&title=${r.ETITLE}" target="_blank">${terminal:truncate(r.TITLE, 30)}</a>
        </c:if>
        <c:if test="${r.type==0}">
        <a href="dcwj.jsp?id=${r.id}&title=${r.ETITLE}" target="_blank">${terminal:truncate(r.TITLE, 30)}</a>
        </c:if>
        </td>
        <%-- <td class="pl5"><a onclick="openUrl(${r.id}, '${r.ETITLE}')" target="blank">${terminal:truncate(r.TITLE, 30)}</a></td> --%>
        <td class="tc"><fmt:formatDate value="${r.CREATETIME}" pattern="yyyy.MM.dd" /></td>
      </tr>
      </c:if>
   	  </c:forEach>
      
</tbody>
    
</table>
<c:if test="${totalPageNum>1}">
    <div class="personal_dcwj_fy clear over">
    <div class="up fl" onclick="up(${num}, ${totalPageNum})">上一页</div>
    <div class="down fl" onclick="next(${num}, ${totalPageNum})">下一页</div>
</div> 
</c:if>
