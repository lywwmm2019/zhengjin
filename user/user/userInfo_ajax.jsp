<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.net.URLEncoder"%>
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
<%
    String callback = Utils.getParameterValue(request, "callback", "");
    String bizType = Utils.getParameterValue(request, "bizType", "");
	int state = 0;	
	String msg = "success";
	String crmUserId = "";
	Integer VIPTypeID = 0;
	Integer num = 0;
	Double myscore = 0d;
	String fw = "";
	String zbroom = "";
	String bizQQ = "";
	String bz = "\"\"";
	String zj = "\"0\"";
	try{
		String mobile = getLoginMobile(request);
		if(mobile != null){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				crmUserId = (String)info.get("UserID");
				VIPTypeID = (Integer)info.get("VIPTypeID");
				bizQQ = (String)info.get("BizQQ");
				Object score = info.get("Score");
				if(!(score instanceof Double)){
					myscore = Double.valueOf(score.toString());
				}else{
					myscore = (Double)score;
				}
				Map obj = queryUserFW(crmUserId);
				if(obj!= null){
					fw = (String)obj.get("fw");
					if(fw == null){
						fw = "";
					}
				}
				
				int maxAge = getMaxAge();
				addCookie(request, response, "VIPTypeID", VIPTypeID.toString(), maxAge, "/");
				addCookie(request, response, "Score", myscore.toString(), maxAge, "/");
				addCookie(request, response, "u_fw", fw, maxAge, "/");
				String utyp = getUserMailType(request);
				String emobile = encrypt(mobile);
				String regTime = (String)info.get("CreateTime");
				Integer bType = 0;
				if(StringUtils.isNotBlank(bizType))
					bType = Integer.valueOf(bizType);
				int zxlxNRNum = countNoReadMailByType(bType, "1", utyp, emobile, crmUserId, regTime);
                int ggtsNRNum = countNoReadMailByType(bType, "3", utyp, emobile, crmUserId, regTime);
                num = zxlxNRNum + ggtsNRNum + countNoReadHdxx(mobile);
                zbroom = getCookie(request, "WEBHXZB_UROOMS");
                
                //是否第一次访问证金银屏
                if(isFirst(crmUserId, "zjpy_first")){
                	zj = "1";;
                }else{
                	zj = "0";
                }
                addCookie(request, response, "zj", zj, maxAge, "/");
                
               //播主
               Map mbz = getUserLiveBZ(mobile);
               if(mbz != null){
                   bz = Json.toJson(mbz);
                   String name = (String)mbz.get("userName");
                   String joblevel = (String)mbz.get("joblevel");
                   String user_id = (String)mbz.get("user_id");
                   bz = "{\"name\":\""+name+"\",\"joblevel\":\""+joblevel+"\",\"img\":\"http://zhibo.zhengjin99.com/hxzb/skins/hxzb/bozhu/"+user_id+"_small.jpg\"}";
               }
               
			}else{
				state = -1;
				msg = "user info error";
			}
	    }else{
			state = -1;
			msg = "no login";
		}
	}catch(Exception e){
		e.printStackTrace();
		state = -1;
		msg = "system error";
	}
	/* response.setContentType("application/json;charset=gbk");
	msg = URLEncoder.encode(msg, "gbk"); */
	String result = "{}";
	if(state == 0)
		result = "{\"state\":\""+state+"\",\"userId\":\""+crmUserId+"\",\"VIPTypeID\":\""+VIPTypeID+"\",\"Score\":\""+myscore+"\",\"fw\":\""+fw+"\",\"xx\":\""+num+"\",\"zbroom\":\""+zbroom+"\",\"BizQQ\":\""+bizQQ+"\",\"bz\":"+bz+",\"zj\":"+zj+"}";
    else 
    	result = "{\"state\":\""+state+"\",\"msg\":\""+msg+"\"}";
	
	if (callback.equals("")) {
        out.print(result);
    } else {
        out.print(callback + "(" + result + ")");
    }
%>
