<%@page import="com.gti.Utils"%>
<%@page import="java.net.URLEncoder"%>
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
	private List queryVotes(Integer type, String pollId){
		String sql = String.format("SELECT * FROM ZX_Vote where type = %s and pId in (%s)  and isvalid = 1", type, pollId);
        return Utils.fetchDataRowsFromSqlOrCache(sql, expire);
	}
	
	private List getVoteQuestions(Integer pollId){
	    List list = (List)Cache.get("DCLIST_"+pollId);
	    if(list == null){
	        list = queryVotes(1, Integer.valueOf(pollId).toString());
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
	        
	        List selects = queryVotes(2, qids);
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
	        
	        Cache.set("DCLIST_"+pollId, list, expire);
	    }
	    return list;
	}
	
	public List queryVoteResult(Integer pollId){
		String sql = ";with subqry(id, type, title, pId) as ( "
			        +" select id, type, title, pid from ZX_Vote where id = " + pollId + " "
			        +" union all "
			        +" select v.id, v.type, v.title,v.pId from ZX_Vote v,subqry "
			        +" where v.pid = subqry.id "
			        +" )select subqry.id, subqry.title, COUNT(vr.mobile) num from subqry "
			        +" LEFT JOIN ZX_Vote_Result vr on vr.vqId = subqry.id "
			        +" where subqry.type = 2 "
			        +" GROUP BY subqry.id, subqry.title "; 
		return QueryRunner.getListBySql(sql);
	}
	
	public List queryChildren(Integer pollId){
        String sql = "select v.pId, v.id, v.title, COUNT(vr.id) num " +
        		"from ZX_Vote v " +
        		"LEFT JOIN ZX_Vote_Result vr on vr.vqId = v.id " +
        		"where type = 2  " +
        		"and pId = " + pollId +" "+
        		"GROUP BY v.pId,  v.id, v.title";
        return QueryRunner.getListBySql(sql);
    }
	
	public Integer queryPollNum(Integer pollId){
        String sql = "select COUNT(DISTINCT vr.mobile) total " +
        		"from ZX_Vote_Result vr " +
        		"where vr.qId = " + pollId;
        Integer total = 0;
        List list = QueryRunner.getListBySql(sql);
        if (list.size() > 0) {
            total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
        }
        return total;
    }
	
	public Integer queryUserIsPoll(String userId, Integer pollId){
        String sql = "select COUNT(DISTINCT vr.mobile) total " +
                "from ZX_Vote_Result vr " +
                "where vr.qId = " + pollId + "and mobile = " + userId;
        Integer total = 0;
        List list = QueryRunner.getListBySql(sql);
        if (list.size() > 0) {
            total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
        }
        return total;
    }
	
	public Map getPoll(String crmUserId, String pollId){
		Integer id = Integer.valueOf(pollId);
        List list = queryChildren(id);
        Map data = new HashMap();
        ((Map)data).put("rows", list);
        Integer total = queryPollNum(id);
        ((Map)data).put("total", total);
        
        if(crmUserId != null){
            if(queryUserIsPoll(crmUserId, id) > 0)
                data.put("isPoll", 1);
            else
                data.put("isPoll", 0);
        }else{
            data.put("isPoll", -1);
        }
        ((Map)data).put("state", 0);
        return data;
	}
	
%>

<%
	String callback = Utils.getParameterValue(request,"callback","");
    Object data = null;
	try{
		String type = Utils.getParameterValue(request,"type","data");
		String pollId = Utils.getParameterValue(request,"pollId","0");
		if("data".equals(type)){
			String crmUserId = null;
			String mobile = getLoginMobile(request); 
			if(mobile != null){
				Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	            if(info!=null){
	                crmUserId = (String)info.get("UserID");
	            }
			}
			data = getPoll(crmUserId, pollId);
		}else if("poll".equals(type)){
			String ypp = getCookie(request, "ypp");
            if(!"1".equals(ypp)){
                String mobile = getLoginMobile(request); 
                Calendar cal = Calendar.getInstance();
                String crmUserId = "" + cal.getTimeInMillis();
            	if(mobile != null){
	            	Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
	            	crmUserId = (String)info.get("UserID");
            	}
            	
            	String vId = Utils.getParameterValue(request,"vId","");
            	String vqs = Utils.getParameterValue(request,"vqs","");
            	Map map = (Map) Json.fromJson(vqs);
            	StringBuilder sb = new StringBuilder();
                sb.append("INSERT into ZX_Vote_Result(vId, qId, vqId, mobile, suggest, createTime) VALUES ");
            	for(Object obj: map.keySet()){
            		String key = obj.toString();
            		sb.append("(").append(vId);
                    sb.append(", ").append(pollId);
                    sb.append(", ").append(key);
                    sb.append(", '").append(crmUserId).append("'");
                    if(map.get(key) != null && !"".equals(map.get(key)))
                        sb.append(", '").append(map.get(key)).append("'");
                    else
                        sb.append(", null");
                    sb.append(",GETDATE())");
                    sb.append(",");
            	}
            	
            	QueryRunner.runSql(sb.substring(0, sb.lastIndexOf(",")));
            	
            	data = getPoll(crmUserId, pollId);
            }else{
            	Map map = new HashMap();
            	map.put("state", -1);
            	map.put("msg", "polled!");
            	data = map;
            }
        }
		
	}catch(Exception e){
		Map map = new HashMap();
        map.put("state", -1);
        map.put("msg", "system error!");
        data = map;
		e.printStackTrace();
	}

	String json = Json.toJson(data);
	json = json.replaceAll("\\n", "").replaceAll("\\r", "").replaceAll(" ", "");
	System.out.println(json);
	if (callback.equals("")) {
	    out.print(json);
	} else {
	    out.print(callback + "(" + json + ")");
	}
%>