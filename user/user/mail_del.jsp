<%@page import="com.gti.Utils"%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@page import="com.gti.cache.Cache"%>
<%@ include file="methods.jsp"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
	private List queryhasRead(String mobile, String userId, String mids){
		String sql  = "select * from ZX_Mail_Send where (tow = '"+mobile+"' or tow = '"+userId+"') and mailId in ("+mids+") and isvalid = 1";
		return QueryRunner.getListBySql(sql);
	}
%>
<%
	try{
		String mid = Utils.getParameterValue(request,"mid","");
		String type = Utils.getParameterValue(request,"type","1");
		String mobile = getLoginMobile(request);
		if(mobile != null && !"".equals(mid)){
			Map info = getUserInfoFromCacheOrCrm(request, response, mobile);
			if(info!=null){
				mobile = encrypt(mobile);
				String crmUserId = (String)info.get("UserID");
				String[] mids = mid.split(",");
				if(mids != null && mids.length > 0){
					String ids = "";
					int k = 0;
					for(String eid: mids){
						if(k==0)
							ids = Utils.DESdecrypt(eid).replace("a2b3c4d5e5f", "");
						else
							ids += "," + Utils.DESdecrypt(eid).replace("a2b3c4d5e5f", "");
						k++;
					}
					System.out.println(ids);
					List hasRead = queryhasRead(mobile, crmUserId, ids);
					StringBuilder insert = new StringBuilder();
					StringBuilder update = new StringBuilder();
					insert.append("INSERT INTO ZX_Mail_Send(tow, mailId,isDeal, dealTime, isvalid) VALUES ");
					update.append("update ZX_Mail_Send set isvalid = 0 ");
					update.append("where (tow = '").append(mobile).append("' or tow = '").append(crmUserId).append("') ");
					update.append("and mailId in (-1 ");
					int upnum = 0;
					int innum = 0;
					for(String id: mids){
						id = Utils.DESdecrypt(id).replace("a2b3c4d5e5f", "");
						boolean flag = false;
						for(Object obj: hasRead){
							Map objm = (Map)obj;
							if(((Integer)objm.get("mailId")).toString().equals(id)){
								flag = true;
								break;
							}
						}
						if(!flag){
							insert.append("(");
							insert.append("'").append(crmUserId).append("'");
							insert.append(",").append(id);
							insert.append(",").append(1);
							insert.append(",GETDATE(),0),");
							innum++;
						}else{
							update.append(",").append(id);
							upnum++;
						}
						
					}
					
					if(upnum > 0){
						update.append(")");
						QueryRunner.runSql(update.toString());
					}
					
					if(innum > 0){
						insert.delete(insert.lastIndexOf(","), insert.length());
						QueryRunner.runSql(insert.toString());
					}
					if(upnum > 0 || innum > 0){
						clearUserCacheByKey(mobile);
					}
					
				}
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>