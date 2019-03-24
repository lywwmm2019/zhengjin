<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.gti.Utils"%>
<%@page import="com.gti.cache.Cache"%>
<%@page import="org.nutz.json.Json"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="jspdata.glt.DateUtils"%>
<%@page import="org.apache.log4j.Logger" %>
<%@page import="java.math.BigDecimal"%>
<%-- <%@page import="jspdata.aps.CookieUtils"%> --%>
<%@page import="com.gti.runner.QueryRunner"%>
<%@ include file="../util.jsp"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%!
	public final static Logger log = Logger.getLogger("user-methods");  
	public static String expire = "0s";
	private Map<String, String> zsmap =  new  HashMap() {{
		put("13632923938", "4");
		put("15000006801", "4");
		put("13439007615", "0");
		put("13600005833", "4" );
		put("13700001104", "4" );
		put("13700005911", "4" );
		put("13700005134", "4" );
		put("13700002488", "4" );
		put("15000003025", "4" );
		put("15000009066", "4" );
		put("15000006801", "4" );
		put("13121829730", "1" );
		put("15000004259", "1" );
		put("15000001047", "4" );
		put("15000007735", "4" );
		put("15000007278", "4" );
		put("15100003066", "4" );
		//put("13635448609", "0" );
		put("13900001889", "2" );
		put("13488888812", "1" );
		put("13488888813", "2" );
		put("13488888814", "3" );
		put("13488888815", "4" );
		put("13500002517", "4" );
		put("18600006577", "4" );
		put("15101021903", "1" );
		put("18600139123", "1" );
		
		put("15101021903", "1" );
		put("15712880390", "2" );
		put("18601355388", "3" );
		put("18600139123", "4" );
		put("13621335351", "4" );
		
		put("13439007614", "3");
		// 李燕
		put("18612761964","4");
		put("13600000083","4");
		
	}};
	private Map<String, String> utypemap =  new  HashMap() {{
		put("13632923938", "-1");
        put("13439007614", "0");
        put("13439007615", "2");
        put("15000006801", "0");
        //put("13635448609", "1");
        put("13900001889", "0");
        put("18101366632", "2");
        put("18600006577", "-1");
        put("15101021903", "0" );
		put("15712880390", "0" );
		put("18601355388", "0" );
		put("18600139123", "0" );
		// 李燕
		put("18612761964","0");
		put("13600000083","0");
    }};
	private Map<String, String> marketmap =  new  HashMap() {{
        put("13439007615", "1");
        put("15000006801", "1|2|3|4");
        //put("13635448609", "1");
        put("13900001889", "1");
        put("18101366632", "3");
        put("18600139123", "1");
        put("15101021903", "2");
        put("13439007614", "1|2|3");
        put("13600000083", "1|2|3|4");
    }};
	//通过手机号从crm获取用户信息
	private Map getUserInfoFromCacheOrCrm(HttpServletRequest request, HttpServletResponse response, String mobile){
		String key = "USER_INFO_" + mobile;
		Map obj = (Map)Cache.get(key);
		if(obj == null){
			try{
				String url = "http://crm.zhengjin99.com/external/getgjsuserinfo?mobile=" + mobile;
				log.debug(getIpAddress(request)+" getgjsuserinfo?mobile="+((mobile!=null&&mobile.length()>=11)?(mobile.substring(0,3)+"*****"+mobile.substring(8,11)):""));
				Map parmas = new HashMap();
				parmas.put("mobile", mobile);
				String data = Utils.url2StringUnsafe(url, "UTF-8");
				obj = (Map) Json.fromJson(data);
				Cache.set(key, obj, expire);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		String viptype = "0";
		//设置用户为钻石卡，用于测试
		String zstype = zsmap.get(mobile);
		int maxAge = getMaxAge();
		
		if(zstype != null){
			viptype = zstype;
			obj.put("VIPTypeID", Integer.valueOf(zstype));
			addCookie(request, response, "WEBSSO_USERTYPE", "0", maxAge, "/");
		}else{
			viptype = ((Integer)obj.get("VIPTypeID")).toString();
		}
		
		//设置用户类型
		String utype = utypemap.get(mobile);
		if(utype != null){
			addCookie(request, response, "WEBSSO_USERTYPE", utype, maxAge, "/");
		}
		
		//用户积分
		Double myscore = 0d;
		Object score = obj.get("Score");
        if(!(score instanceof Double)){
            myscore = Double.valueOf(score.toString());
        }else{
            myscore = (Double)score;
        }
        
        //根据账号判断用户所属交易所
        List<Map> accounts = (List<Map>)obj.get("OpenAccountList");
        String ssoType = getCookie(request, "WEBSSO_USERTYPE");
        String market = getUserMarketType(ssoType, accounts);
        //设置用户所属交易所
        String smarket = marketmap.get(mobile);
        if(smarket != null){
        	market = smarket;
        }
		addCookie(request, response, "VIPTypeID", viptype, maxAge, "/");
		addCookie(request, response, "Score", myscore.toString(), maxAge, "/");
		addCookie(request, response, "Market", market, maxAge, "/");
		return obj;
	}
	
	private int getExchange(Integer exchange){
		return (int)(exchange+Math.pow(2, exchange-1));
	}
	/**
	 *
	 * 	0:无交易所；
	 	1:海西;
		2:天交;
		3:大圆银泰;
		4:齐鲁;
	
		以|分开  ： 1|2|3|4
	 **/
	private String getUserMarketType(String ssoType, List<Map> accounts){
	    if(ssoType == null || "".equals(ssoType.trim()) || accounts == null || accounts.size() == 0)
	    	return "";
	    String market = "";
	    ssoType = ssoType.replace("%252520", "").replace("%20","").trim();
	    Integer accountTypetemp = 9; 
	    if(ssoType.equals("2")){//模拟用户
	    	accountTypetemp = 2;
        }else if(ssoType.equals("1")){//实盘未激活用户
        	accountTypetemp = 1;
        }else if(ssoType.equals("0")||ssoType.equals("-1")){//实盘激活用户
        	accountTypetemp = 0; 
        }
	    
	    for(Map account: accounts){
        	Integer accountType = (Integer)account.get("AccountTypeID");
        	if(accountType==accountTypetemp){
        		Integer exchange = (Integer)account.get("ExchangeID");
        		if("".equals(market))
        			market = exchange+"";
        		else
        			market += "|"+exchange;
        	}
        }
	    
	    return market;
	}
	//获取cookie保存时间
	private int getMaxAge(){
		Date now = new Date();
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(now);
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(now);
		cal2.add(Calendar.DAY_OF_YEAR, 1);
		cal2.set(Calendar.HOUR_OF_DAY, 4);
		cal2.set(Calendar.MINUTE, 0);
		cal2.set(Calendar.SECOND, 0);
		return (int) (cal2.getTimeInMillis() - cal1.getTimeInMillis())/1000;
	}
	
	//按信息类型获取分页数据
	private List queryMailByType(Integer bizType, String type, String utype, String mobile, String userId, String regTime,Integer pageNo, Integer pageSize){
		int start = (pageNo - 1)* pageSize+1;
		int end = start + (pageSize-1);
		int top = pageNo * pageSize;
		String sql = "SELECT * FROM( "+
					"SELECT top "+top+" ROW_NUMBER() over (order by y.isDeal asc, y.createTime desc) as RowNumber, y.* from( "+
					"select m.id,m.title,m.createTime, m.fromwName, m.type,m.isvalid, ms.tow, "+
					"ISNULL(ms.isDeal, 0) as isDeal,  "+
					"ISNULL(ms.isvalid, 1) as disvalid "+
					"from ZX_Mail m "+
					"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id and (ms.tow = '"+mobile+"' or ms.tow = '"+userId+"') "+
					"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type in (4,"+utype+") "+
					
					//s_type = 0 发给个人的信息
					" UNION  "+
					"select m.id,m.title,m.createTime, m.fromwName, m.type,m.isvalid, ms.tow, "+
					"ISNULL(ms.isDeal, 0) as isDeal,  "+
					"ISNULL(ms.isvalid, 1) as disvalid "+
					"from ZX_Mail m "+
					"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id "+
					"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type = 0  and m.toId = '"+userId+"' "+
					
					") as y where y.disvalid = 1 "+
					") as x WHERE x.RowNumber BETWEEN "+start+" and " + end;
		//收集key
		setUserCacheKey(mobile, sql);
		//查询数据
		List list = Utils.fetchDataRowsFromSqlOrCache(sql, expire);
		//处理信息时间用于显示
		dealResult(list);
		return list;
	}
	
	private void dealResult(List list){
		if(list != null){
			Calendar cal = Calendar.getInstance();
			int hour = cal.get(Calendar.HOUR_OF_DAY);
			int minute = cal.get(Calendar.MINUTE);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(cal.getTime());
			for(Object obj: list){
				Map objmap = (Map)obj;
				Timestamp ctime = (Timestamp)objmap.get("CREATETIME");
				String now = sdf.format(new Date(ctime.getTime()));
				String str = "-1";
				if(today.equals(now)){
					int k = hour-ctime.getHours();
					str = k>0?(k+"小时前"):((minute-ctime.getMinutes())+"分钟前");
				}
				objmap.put("CREATETIME2", str);
			}
		}
	}
	
	//按类型获取用户信息总条数
	private int countMailByType(Integer bizType,  String type, String utype, String mobile, String userId, String regTime){
		Integer totalRow = 0; 
		try{
			String sql ="SELECT count(*) as total from( select m.id, ISNULL(ms.isvalid, 1) as disvalid  " + 
					"from ZX_Mail m " + 
					"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id and (ms.tow = '"+mobile+"' or ms.tow = '"+userId+"') "+
					"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type in (4,"+utype+") "+
					" UNION  "+
					"select m.id, ISNULL(ms.isvalid, 1) as disvalid  "+
					"from ZX_Mail m "+
					"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id "+
					"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type = 0 and m.toId = '"+userId+"' "+
					") as y where y.disvalid = 1 ";
			
			//key
			String key = "mail_"+mobile+"_total_"+type;
			totalRow = (Integer)Cache.get(key);
			if(totalRow == null){
				List list = QueryRunner.getListBySql(sql);
				if (list.size() > 0) {
					totalRow = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
				}
				Cache.set(key, totalRow, expire);
				//收集用户缓存key
				setUserCacheKey(mobile, key);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return totalRow;
	}
	
	//将已读\未读数据分开
	private void splitReadAndNoReadMail(final List noReadList, final List readList, final List list){
		if(list == null || list.size() <= 0)
			return;
		for(Object obj:list){
			Map objm = (Map)obj;
			if("0".equals(objm.get("isDeal")))
				noReadList.add(objm);
			else
				readList.add(objm);
		}
	}
	//获取总页数
	private int getTotalPage(Integer pageSize, int total){
		int pageTotalNum = 0;
		if(total > 0){
			if(total%pageSize>0){
				pageTotalNum = total/pageSize+1;
			}else{
				pageTotalNum = total/pageSize;
			}
		}
		return pageTotalNum;
	}
	//根据信息id获取内容
	private List queryMailContentById(String mobile, Integer id){
		String sql = "SELECT m.* , n.FILE_NAME as savefileName , n.FILE_PATH as filepath, n.TITLE as fileName from ZX_Mail m  " +
					"LEFT JOIN APL_NEWS_MAIN n on n.AUTHOR_ID = m.id  " +
					"where m.isvalid = 1 and m.id = " + id;
		setUserCacheKey(mobile, sql);
		List list = Utils.fetchDataRowsFromSqlOrCache(sql, expire);
		return list;
	}
	
	//将信息设置成已读
	private void setisDeal(String mobile, String userId, Integer mid){
		try{
			String sql = "INSERT INTO ZX_Mail_Send(tow, mailId,isDeal, dealTime, isvalid) VALUES('"+userId+"', "+mid+", 1, GETDATE(), 1)";
			QueryRunner.runSql(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据时间倒序获取已发活动的内容
	 */
	private List getListByTimeDesc(Integer pageNo, Integer pageSize, String modelId) {
		int start = (pageNo - 1)* pageSize+1;
		int end = start + (pageSize-1);
		String sql = "select * from (select ROW_NUMBER() over (order by b.PUBLISH_TIME desc) as RowNumber, "
				+ "b.*,q.MODEL_ID from APL_NEWS_PUBLISH q,APL_NEWS_MAIN b where q.NEWS_ID = b.NEWS_ID "
				+ " and q.MODEL_ID = " + modelId
		        + ") as x WHERE x.RowNumber BETWEEN " + start + " AND " + end;
		return Utils.fetchDataRowsFromSqlOrCache(sql, expire);
	}

	/**
	 * 统计已发布的活动总条数
	 */
	private int countByModelId(String modelId) {
		String sql = " select count(*) as total from APL_NEWS_PUBLISH q,APL_NEWS_MAIN b where q.NEWS_ID = b.NEWS_ID "
			+ " and q.MODEL_ID = " + modelId;
		List list = Utils.fetchDataRowsFromSqlOrCache(sql, expire);
		int total = 0;
		if(list != null &&  list.size()>0)
			total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
		return total;
	}
	
	/**
     * 统计已发布的活动总条数
     */
    private int countNoReadHdxx(String mobile) {
    	int hdxxTotal = countByModelId("730");
        int hhxxRNum = queryUserRHd(Utils.MD5(mobile));
        return (hdxxTotal>=hhxxRNum)?(hdxxTotal - hhxxRNum):0;
	}
	/**
	 *  判断活动是否结束 0:还未开始,  1:开始，2:结束
	 */
	private List dealColumn(List list){
		if(list != null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			Calendar caltemp = Calendar.getInstance();
			
			for(Object obj: list){
				Map om = (Map)obj;
				String start = (String)om.get("VIDEO_TIME");
				String end = (String)om.get("REC_TIME");
				if(start == null || end == null || start.length() < 10 || end.length() < 10)
					om.put("FLAG", 0); 
				try{
					cal.setTime(sdf.parse(sdf.format(cal.getTime())));
					Date startDate = sdf.parse(start);
					caltemp.setTime(startDate);
					if(cal.getTimeInMillis()<caltemp.getTimeInMillis()){
						om.put("FLAG", 0);
					}else{
						Date endDate = sdf.parse(end);
						caltemp.setTime(endDate);
						if(cal.getTimeInMillis()>caltemp.getTimeInMillis()){
							om.put("FLAG", 2);
						}else
							om.put("FLAG", 1);
					}
					
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	//获取登录用户的手机号
	private String getLoginMobile(HttpServletRequest request){
		String mobile = getCookie(request, "WEBSSO_LID");
		String userId = getCookie(request, "WEBSSO_UID");
		String userType = getCookie(request, "WEBSSO_USERTYPE");
		if(mobile == null || "".equals(mobile) || userId==null || "".equals(userId) || userType == null || "".equals(userType)){
			mobile = null;
		}
		return mobile;
	}
	
	private String getMailTypes(String utype, String vipType, String market){
		String types = utype;
		
		if(!"0".equals(vipType)){
			types += ","+"1"+vipType;
		}
		String[] markets = market.split("\\|");
		for(String m: markets){
			if("".equals(m))
				continue;
			Integer ssotype = Integer.valueOf(utype);
			if(ssotype==10){
				ssotype += Integer.valueOf(vipType);
				types += ",100" + m;
			}
			types += ","+ssotype + "0" + m;
		}
		return types;
	}
	//根据用户类型等级判断查询信息用到的类型值
	private String getUserMailType(HttpServletRequest request){
		String type = "3";
		String ssoType = getCookie(request, "WEBSSO_USERTYPE");
		String market = getCookie(request, "Market");
		if(ssoType == null || "".equals(ssoType)){
			return type;
		}
		if(market == null){
			market = "";
		}
		ssoType = ssoType.replace("%252520", "").replace("%20","").trim();
		if("3".equals(ssoType)){//注册用户
			type = "3";
		}else if("2".equals(ssoType)||"1".equals(ssoType)){//模拟用户、实盘未激活用户
			getMailTypes(ssoType, "0", market);
		}else if("0".equals(ssoType)||"-1".equals(ssoType)||"-10".equals(ssoType)){//实盘激活用户、样板用户
			String vipType = getCookie(request, "VIPTypeID");
			ssoType = "10";
			if(vipType == null || "".equals(vipType) || "0".equals(vipType)){
				return type = ssoType;
			}
			type = getMailTypes(ssoType, vipType, market);
		}
		return type;
	}
	
	//根据信息类型获取未读条数
	private int countNoReadMailByType(Integer bizType, String type, String utype, String mobile, String userId, String regTime){
		Integer totalRow = 0; 
		
		String sql ="SELECT count(*) as total from( select m.id, ISNULL(ms.isvalid, 1) as disvalid, ISNULL(ms.isDeal, 0) as isDeal " + 
		"from ZX_Mail m " + 
		"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id and (ms.tow = '"+mobile+"' or ms.tow = '"+userId+"') "+
		"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type in (4,"+utype+") "+
		" UNION  "+
		"select m.id, ISNULL(ms.isvalid, 1) as disvalid, ISNULL(ms.isDeal, 0) as isDeal "+
		"from ZX_Mail m "+
		"LEFT JOIN ZX_Mail_Send ms on ms.mailId = m.id "+
		"where m.bizType = "+bizType+" and m.isvalid = 1 and m.createTime >= '"+regTime+"' and type = "+type+" and s_type = 0 and m.toId = '"+userId+"' "+
		") as y where y.disvalid = 1 and y.isDeal = 0";
		//key
		String key = "mail_noread_"+mobile+"_"+type;
		try{
			totalRow = (Integer)Cache.get(key);
			if(totalRow==null){
				List list = QueryRunner.getListBySql(sql);
				if (list.size() > 0) {
					totalRow = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
				}
				Cache.set(key, totalRow, expire);
				//收集缓存key，用于信息操作变更清除
				setUserCacheKey(mobile, key);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return totalRow;
	}
	
	//存储用户缓存数据的key
	private void setUserCacheKey(String mobile, String key){
		Map<String, String> map = (Map<String, String>)Cache.get("Mail_key_"+mobile);
		if(map == null)
			map = new HashMap<String, String>();
		map.put(key,key);
		Cache.set("Mail_key_"+mobile, map);
	}
	//根据用户的缓存的key 清除所有缓存
	private void clearUserCacheByKey(String mobile){
		Map<String, String> map = (Map<String, String>)Cache.get("Mail_key_"+mobile);
		if(map != null){
			Set<String> keys = map.keySet();
			for(String key: keys){
				Cache.delete(key);
			}
		}
	}
	public String getIpAddress(HttpServletRequest request) {
		String ip = "";
		String ips = request.getHeader("X-Forwarded-For");
		if (ips == null || ips.equals("")) {
			ip = request.getHeader("X-Real-IP");
			if (ip == null || ip.equals("")) {
				ip = request.getRemoteAddr();
			}
		} else {
			ip = ips.split(",")[0];
		}
		return ip;
	}
	
	public Integer queryUserRHd(String emobile){
		String sql = "SELECT count(*) as total FROM ZX_Phone where phone = '"+ emobile + "' and activity_id like 'hd_%'";
		List list = QueryRunner.getListBySql(sql);
		Integer total = 0;
		if(list.size()>0){
			total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
		}
		return total;
	}
	
    private String type ="user_select_fw";
    private Map queryUserFW(String userId){
        String key = "fw_"+userId;
        String sql = "SELECT *  FROM ZX_JsonInfo where type='"+type+"' and  jsonInfo like '%"+ userId + "%'";
        Map obj = (Map)Cache.get(key);
        if(obj == null){
            List list = QueryRunner.getListBySql(sql);
            if(list != null && list.size() > 0){
                obj = (Map)list.get(0);
                String jsonInfo = (String)obj.get("jsonInfo");  
                Map jsonmap = (Map)Json.fromJson(jsonInfo);
                obj.put("fw", jsonmap.get("fw"));
            }
            Cache.set(key, obj, expire);
        }
        
        return obj;
    }
    
    private String addUserFW(String userId, String[] fwId){
        
        Map obj = queryUserFW(userId);
        String jsonInfo = "";
        if(obj != null)
            jsonInfo = (String)obj.get("fw");
        String [] jsons = jsonInfo.split(",");
        for(String id: fwId){
            boolean flag = false;
            for(String oid: jsons){
                if(oid.equals(id)){
                    flag = true;
                    break;
                }
            }
            
            if(!flag){
                if(jsonInfo.equals(""))
                    jsonInfo = id;
                else
                    jsonInfo = jsonInfo + ","+id;
            }
        }
        
        String key = "fw_"+userId;
        String sql = "";
        
        Map data = new HashMap();
        data.put("userId", userId);
        data.put("fw", jsonInfo);
        String json = Json.toJson(data).replaceAll("\r", "") .replaceAll("\n", "");
        if(obj != null){
            String id = ((Long)obj.get("id")).toString();
            sql = "update ZX_JsonInfo set jsonInfo = '"+json+"', updateTime = GETDATE() where id = "+id;
        }else 
            sql = "INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), '"+type+"')";
        
        if(!QueryRunner.runSql(sql))
            jsonInfo = null;
        Cache.delete(key);
        return jsonInfo;
    }
    
    private String deleteUserFW(String userId, String[] fwId){
        
        Map obj = queryUserFW(userId);
        
        String jsonInfo = "";
        if(obj != null)
            jsonInfo = (String)obj.get("fw");
        String [] jsons = jsonInfo.split(",");
        String newjsonInfo = "";
        for(String oid: jsons){
            boolean flag = false;
            for(String id: fwId){
                if(oid.equals(id)){
                    flag = true;
                    break;
                }
            }
            
            if(!flag){
                 if(newjsonInfo.equals(""))
                     newjsonInfo = oid;
                 else
                     newjsonInfo = newjsonInfo + ","+oid;
            }
        }
        
        String key = "fw_"+userId;
        String sql = "";
        Map data = new HashMap();
        data.put("userId", userId);
        data.put("fw", newjsonInfo);
        String json = Json.toJson(data).replaceAll("\r", "") .replaceAll("\n", "");
        if(obj != null){
            String id = ((Long)obj.get("id")).toString();
            sql = "update ZX_JsonInfo set jsonInfo = '"+json+"', updateTime = GETDATE() where id = "+id;
        }else 
            sql = "INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), '"+type+"')";
        if(!QueryRunner.runSql(sql))
        	newjsonInfo = null;
        Cache.delete(key);
        return newjsonInfo;
    }
    
    private String updateUserFW(String userId, String[] fwId){
        
        Map obj = queryUserFW(userId);
        
        String jsonInfo = "";
        
        for(String id: fwId){
        	if(jsonInfo.equals(""))
        		jsonInfo = id;
            else
            	jsonInfo = jsonInfo + ","+id;
        }
           
        String key = "fw_"+userId;
        String sql = "";
        Map data = new HashMap();
        data.put("userId", userId);
        data.put("fw", jsonInfo);
        String json = Json.toJson(data).replaceAll("\r", "") .replaceAll("\n", "");
        if(obj != null){
            String id = ((Long)obj.get("id")).toString();
            sql = "update ZX_JsonInfo set jsonInfo = '"+json+"', updateTime = GETDATE() where id = "+id;
        }else 
            sql = "INSERT into ZX_JsonInfo(jsonInfo, createTime, updateTime, type) VALUES ('"+json+"', GETDATE(), GETDATE(), '"+type+"')";
        if(!QueryRunner.runSql(sql))
            jsonInfo = null;
        Cache.delete(key);
        return jsonInfo;
    }
    
    private String getRegTime(HttpServletRequest request){
    	String time = "";
    	try{
	    	String regTime = getCookie(request, "WEBSSO_REGTIME");
	    	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
	    	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	time = sdf2.format(sdf1.parse(regTime));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return time;
    }
    
    private boolean insertMail(Integer bizType, String userId, String mobile, String regTime){
    	
    	if(userId == null || "".equals(userId))
    		return false;
    	Integer type = 1;
    	Integer stype = 0;
    	String fromwId = "10";
    	String fromName = "管理员";
    	String title = "欢迎来到证金";
    	String content = "<div style=\"text-align: left;\"><span style=\"font-size:16px;\"><strong>尊敬的客户您好：</strong></span></div>" +
    		    "<br /><br />" +
    		    "<span style=\"font-size:16px;\">&nbsp; &nbsp; &nbsp; &nbsp; 欢迎您登陆使用个人中心，个人中心是证金为您量身定做的提供专属服务的一站式服务平台。这是一个属于您自己的天地，在这里，您可以查看您的账户信息以及证金给您发送的消息通知，可以查看证金最新的活动信息，可以根据最新的公告提示做好资金安排与风险控制。<br />" +
    		    "&nbsp; &nbsp; &nbsp; &nbsp; 同时，您还享有证金为您提供的专属特权，体验个性化服务：有专业的投资顾问根据您的投资偏好及风险承受能力做出风险评估；有专业的投资团队为您提供实时的投资分析报告；有贴心的客户服务团队为您提供一站式售后服务；证金立志让您体验投资中最大的快乐！<br />" +
    		    "&nbsp; &nbsp; &nbsp; &nbsp; 友情提示：为了确保您的账户及积分商城的安全，建议您登陆个人中心后修改密码。感谢您对我们的大力支持，我们将竭诚为您提供更加优质，专业，高效的服务，祝您投资愉快！</span><br />"+
                "<br /><br />" +
                "<div style=\"text-align: right;\"><span style=\"font-size:16px;\"><strong>证金贵金属 &nbsp; &nbsp; &nbsp; &nbsp;</strong></span></div>";
        try{
	    	String query = "select count(*) as total from ZX_Mail where title = '"+title+"' and toId = '"+userId+"' and type = '"+type+"' and s_type = '"+stype+"' and fromwId ='"+fromwId+"'";
	    	log.info("had first maill " + query);
	    	List list = QueryRunner.getListBySql(query);
	    	Integer total = 0;
	        if(list.size()>0){
	            total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
	        }
	        if(total > 0){ 
	        	log.info("had first maill " + userId);
	        	return false;
	        }
	        String times = "2014-09-25 09:00:00";
	    	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	Date time  = sdf1.parse(times);
	    	if(time.after(sdf1.parse(regTime))){
	    		log.info("insert first maill time over! " + userId);
	    		return false;
	    	}
	    	StringBuilder sb = new StringBuilder(); 
	        sb.append("INSERT into ZX_Mail(title, content, bizType, type, s_type, fromwId, fromwName, toId, toName, createTime, updateTime, isvalid) " +  
	        "VALUES ('"+title+"','"+content+"', " + bizType + ", '"+type+"', '"+stype+"', '"+fromwId+"', '"+fromName+"','"+userId+"','"+mobile+"', GETDATE(), GETDATE(), 1)");
	        if(QueryRunner.runSql(sb.toString())){
	            clearUserCacheByKey(mobile);
	            log.info("insert first maill success! " + userId);
	            return true;
	        }
        }catch(Exception e){
        	log.error("insert first maill error! " + userId, e);
        }
    	
        return false;
    }
    
    
  //通过手机号从crm获取用户信息
    private Map getUserLiveBZ(String mobile){
        String key = "USER_INFO_BZ_" + mobile;
        Map obj = (Map)Cache.get(key);
        obj = null;
        if(obj == null){
            try{
                String url = "http://manage.zhengjin99.com/usermanage/External/queryBoZhuInfoByMobile.do?mobile=" + mobile;
                String data = Utils.url2StringUnsafe(url, "UTF-8");
                obj = (Map)Json.fromJson(data);
                List<Map> bzs = (List<Map>)obj.get("boZhuInfoList");
                if(bzs != null && bzs.size() > 0){
                	for(Map bz: bzs){
                		String zbo = (String)bz.get("isZhuBo");
                        if("1".equals(zbo)){
                        	obj = bz;
                        	break;
                        }
                    }
                	
                	if(obj == null)
                		obj = bzs.get(0);
                }else{
                	obj = null;
                }
                Cache.set(key, obj, expire);
            }catch(Exception e){
            	log.error("get user bozhu error! ", e);
                e.printStackTrace();
            }
        }
        return obj;
  }
  
  private boolean isFirst(String userId, String type){
	  String sql = "SELECT count(*) as total FROM ZX_JsonInfo where type='"+type+"' and  jsonInfo like '%"+ userId + "%'";
      String key = "FIRST_"+type+"_"+userId;
      Integer total = (Integer)Cache.get(key);
      if(total == null){
          List list = QueryRunner.getListBySql(sql);
          total = 0;
          if(list.size()>0){
              total = Integer.valueOf(((Map) list.get(0)).get("total")+ "");
          }
          if(total>0){//提交过设置缓存
              Cache.set(key, total, expire);
          }
      }
      
      if(total > 0)
          return true;
      return false;
  }
  
  private void encrytId(List<Map> list){
	  if(list != null && list.size() > 0){
		  for(Map map: list){
			  try{
				  Integer id = (Integer)map.get("id");
				  String eId = Utils.encrypt("a2b3c4d5e5f" + id.toString(), Utils.DES_KEY);
				  map.put("id", eId);
				  map.put("ID", eId);
			  }catch(Exception e){
				  e.printStackTrace();
			  }
			  
		  }
	  }
  }
  
  private String activityId = "zjhb-20140107";
  private Integer partyAction(String mobile){
  	String url = "http://crm.zhengjin99.com/external/GJSUserJoinAction?Mobile=" + mobile+"&ActionID=6";
  	String data = Utils.url2StringUnsafe(url, "UTF-8");
  	System.out.println("-------"+data);
  	Map obj = (Map) Json.fromJson(data);
  	return (Integer)obj.get("code");
  }

  private void addAction(String userId, String activityId, Integer flag){
  	String sql = String.format("insert into ZX_Activity_User(activityId, flag, userId, createTime, updateTime) values('%s', %s, '%s', GETDATE(), GETDATE())", activityId, flag, userId);
  	QueryRunner.runSql(sql);
  }

  private void updateAction(String userId, String activityId, Integer flag){
  	String sql = String.format("update into ZX_Activity_User set flag = %s, updateTime = GETDATE() where activityId = '%s' and userId = '%s'", flag, activityId, userId);
  	QueryRunner.runSql(sql);
  }

  private Map queryAction(String userId, String activityId){
  	String sql = String.format("select * from  ZX_Activity_User where activityId = '%s' and userId = '%s'", activityId, userId);
  	List list = QueryRunner.getListBySql(sql);
  	System.out.println("---------------"+sql);
  	if(list != null && list.size() > 0)
  		return (Map)list.get(0); 
  	return null;
  }
  
  private Map getUserNewFund(String mobile){
	  List<Map> list = getUserPrizeList(mobile, 6);

	  if(list != null && list.size() > 0){
		  if(list.size() > 1){
			  Map obj1 = list.get(list.size()-1);
			  Map obj2 = list.get(list.size()-2);
			  
			  String AccountID1 = (String)obj1.get("AccountID");
			  String AccountID2 = (String)obj2.get("AccountID");
			  if(AccountID1.equals(AccountID2)){
				  return obj1;
			  }else{
				  Double fund1 = Double.valueOf((String)obj1.get("Fund"));
				  Double fund2 = Double.valueOf((String)obj2.get("Fund"));
				  if(fund1 >= fund2){
					  return obj1;
				  }else{
					  return obj2;
				  }
			  }
		  }else{
			  return list.get(list.size()-1);
		  }
	  }
	  return null;
  }
  
  private Map getUserNewFund_bgjh(String mobile){
	  List<Map> list = getUserPrizeList_bh(mobile, 5);
	  
	  if(list != null && list.size() > 0){
		  if(list.size() > 1){
			  Map obj1 = list.get(list.size()-1);
			  Map obj2 = list.get(list.size()-2);
			  
			  String AccountID1 = (String)obj1.get("AccountID");
			  String AccountID2 = (String)obj2.get("AccountID");
			  if(AccountID1.equals(AccountID2)){
				  return obj1;
			  }else{
				  Double fund1 = Double.valueOf((String)obj1.get("Fund"));
				  Double fund2 = Double.valueOf((String)obj2.get("Fund"));
				  if(fund1 >= fund2){
					  return obj1;
				  }else{
					  return obj2;
				  }
			  }
		  }else{
			  return list.get(list.size()-1);
		  }
	  }
	  return null;
  }
  
  private boolean getUserState(List<Map> list){
	  boolean result = false;
	  try{
	  if(list != null && list.size() > 0){
		  String Q1 = "";
		  String Q4 = "";
		  for(Map obj: list){
			  if(!"".equals(Q1) && !"".equals(Q4))
				  break;
			  String ExchangeID = (String)obj.get("ExchangeID");
			  Double ChangeAmount = (Double)obj.get("ChangeAmount");
			  if("1".equals(ExchangeID) && "".equals(Q1)){
				  if(ChangeAmount >= 0)
					  Q1 = "true";
				  else
					  Q1 = "false";
			  }else if("4".equals(ExchangeID) && "".equals(Q4)){
				  if(ChangeAmount >= 0)
					  Q4 = "true";
				  else
					  Q4 = "false";
			  }
		  }
		 
		  if("true".equals(Q1) || "true".equals(Q4))
			  result = true;
	  }
	  }catch(Exception e){
		  e.printStackTrace();
	  }
	  
	  return result;
  }
  
  private Double getUserFirstFund(String mobile){
	  	String url = "http://crm.zhengjin99.com/external/gjsuserfund?mobile=" + mobile; 
	  	String data = Utils.fetchDataFromUrlOrCacheWithReturn(url, null, expire, "UTF-8");
	  	Map map = (Map) Json.fromJson(data);
	  	Integer state = (Integer)map.get("code");
	  	Double value = 0D;
		if(state == 0){
			Object fundObj = map.get("value");
			if(!(fundObj instanceof Double)){
	            value = Double.valueOf(fundObj.toString());
	        }else{
	        	value = (Double)fundObj;
	        }
		}
		
	  	return value;
  }
  private boolean hasTrade_bh(String mobile){
	  List<Map> list = getUserPrizeList_bh(mobile,null);
	  if(list != null && list.size() > 0){
		  for(Map map: list){
			  Double ChangeAmount = Double.valueOf((String)map.get("Fund"));
			  if(ChangeAmount >= 100000)
				  return true;
		  }
	  }
	  return false;
  }
  
  private boolean hasTrade(String mobile){
	  List<Map> list = getUserPrizeList(mobile, 6);
	  if(list != null && list.size() > 0){
		  for(Map map: list){
			  Double ChangeAmount = Double.valueOf(map.get("ChangeAmount")+"");
			  if(ChangeAmount > 0)
				  return true;
		  }
	  }
	  return false;
  }
  
  private List<Map> getUserPrizeList(String mobile, Integer ActionId){
	  String key = "UserPrize_"+mobile;
	  List<Map> list = (List<Map>)Cache.get(key);
      if(list == null){
		  String url = "http://crm.zhengjin99.com/external/GJSUserPrizeList?mobile=" + mobile;
		  if(ActionId != null)
			  url += "&ActionId="+ActionId;
		  String data = Utils.url2StringUnsafe(url, "UTF-8");
		  Map map = (Map) Json.fromJson(data);
		  Integer code = (Integer)map.get("code");
		  if(code == 0){
			  Object msg = map.get("msg");
			  if(!"".equals(msg.toString())){
				  list = (List)Json.fromJson((String)msg);
				  list = changeValue_bh(list);
			 }
		  }
	  	  if(list != null)
	  	  	  Cache.set(key, list, expire);
      }
	  return list;
  }
  /**
  * 白加黑礼包
  */
  private List<Map> getUserPrizeList_bh(String mobile, Integer ActionId){
	  String key = "UserPrize_"+mobile;
	  List<Map> list = null;//(List<Map>)Cache.get(key);
      if(list == null){
		  String url = "http://crm.zhengjin99.com/external/GJSUserPrizeList?mobile=" + mobile;
		  if(ActionId != null)
			  url += "&ActionId="+ActionId;
		  String data = Utils.url2StringUnsafe(url, "UTF-8");
		  Map map = (Map) Json.fromJson(data);
		  Integer code = (Integer)map.get("code");
		  if(code == 0){
			  Object msg = map.get("msg");
			  if(!"".equals(msg.toString())){
				  // {"code":0,"msg":"[{\"UserID\":\"150305261793828003\",\"AccountID\":\"109909000192\",\"ChangeAmount\":\"87.67\",\"ChangeMemo\":\"\",\"ChangeTime\":\"2015/4/30\",\"Fund\":\"983651.2000\",\"Rate\":\"0.08\",\"ZJKind\":\"白银\",\"Quantity\":\"286.666664123535\",\"BaseFund\":\"200000.0000\",\"BaseQuantity\":\"400\",\"ExchangeID\":\"3\",\"MinDay\":\"2015/4/27 0:00:00\"}]"}
				  list = (List)Json.fromJson((String)msg);
				  /* Map obj = new HashMap();
				  obj.put("UserID", "130129261436089944");
				  obj.put("AccountID", "12910093214");
				  obj.put("ChangeAmount", "2.00");
				  obj.put("ChangeMemo", "缺平仓交易");
				  obj.put("ChangeTime", "2014/12/8");
				  obj.put("Fund", "89314.7400");
				  obj.put("Rate", "0.08");
				  Map obj2 = new HashMap();
				  obj2.put("UserID", "130129261436089944");
				  obj2.put("AccountID", "12910093214");
				  obj2.put("ChangeAmount", "3.00");
				  obj2.put("ChangeMemo", "缺平仓交易");
				  obj2.put("ChangeTime", "2014/12/9");
				  obj2.put("Fund", "89314.7400");
				  obj2.put("Rate", "0.08");
				  list = new ArrayList<Map>();
				  list.add(obj);
				  list.add(obj2); */
				  list = changeValue_bh(list);
			 }
		  }
	  	 // if(list != null)
	  	  	  //Cache.set(key, list, expire);
      }
      //log.info("getUserPrizeList_bh : " + list);
	  return list;
  }
  private List changeValue_bh(List<Map> list){
	  if(list == null)
		  return null;
	  Double _ChangeAmount = 0D;
	  for(Map map: list){
		  String _Fund = (String)map.get("Fund");
		  String _BaseFund = (String)map.get("BaseFund");
		  map.put("MinDay", ((String)map.get("MinDay")).replace("/", "-").substring(0,9));
		  map.put("Fund", _Fund.length()>2?_Fund.substring(0,_Fund.length()-2):_Fund);
		  map.put("BaseFund",_BaseFund.length()>2?_BaseFund.substring(0,_BaseFund.length()-2):_BaseFund);
		  _ChangeAmount = _ChangeAmount + Double.valueOf((String)map.get("ChangeAmount").toString());
		  map.put("ChangeAmount1",map.get("ChangeAmount"));
		  map.put("ChangeAmount",_ChangeAmount);
		  
	  }
	  return list;
  }
  private List changeValue(List<Map> list){
	  if(list == null)
		  return null;
	  Double totalChangeAmount = 0D;
	  Double totalChangeAmount212 = 0D;
	  for(Map map: list){
		  String changeAmount = (String)map.get("ChangeAmount");
		  String AccountID = (String)map.get("AccountID");
		  if(AccountID.startsWith("212")){
			  totalChangeAmount212 += Double.valueOf(changeAmount);
			  map.put("totalChangeAmount", Double.valueOf(totalChangeAmount212.toString()));
		  }else{
			  totalChangeAmount += Double.valueOf(changeAmount);
			  map.put("totalChangeAmount", Double.valueOf(totalChangeAmount.toString()));
		  }
		  
		  map.put("ChangeTime", ((String)map.get("ChangeTime")).replace("/", "-"));
	  }
	 
	  return list;
  }
  
  private Map partyBGJH(String mobile,String name, String carNo){
	  Map obj = new HashMap();
	  try{
          String url = "http://crm.zhengjin99.com/external/GJSUserJoinAction?Mobile="+mobile+"&ActionID=5&Para1="+name+"&Para2=" + carNo;
          String data = Utils.url2StringUnsafe(url, "UTF-8");
          obj = (Map)Json.fromJson(data);
      }catch(Exception e){
      	log.error("partyBGJH error ", e);
        e.printStackTrace();
      }
	  return obj;
  }
  
  private Integer isPartyBGJH(String mobile){
	  Integer code = -9;
	  try{
          String url = "http://crm.zhengjin99.com/external/GetGJSUserActionState?Mobile="+mobile+"&ActionID=5";
          String data = Utils.url2StringUnsafe(url, "UTF-8");
          Map obj = (Map)Json.fromJson(data);
          code = (Integer)obj.get("code"); 
	  }catch(Exception e){
      	log.error("isPartyBGJH error ", e);
        e.printStackTrace();
      }
	  return code;
  }
  
  private Map updateBGJHDetail(String mobile,String name, String carNo){
	  Map obj = new HashMap();
	  try{
		  name = URLEncoder.encode(name, "utf-8");
          String url = "http://crm.zhengjin99.com/external/GJSUserActionInfoUpdate?Mobile="+mobile+"&ActionID=5&Para1="+name+"&Para2=" + carNo;
          String data = Utils.url2StringUnsafe(url, "UTF-8");
          obj = (Map)Json.fromJson(data);
      }catch(Exception e){
      	log.error("partyBGJH error ", e);
        e.printStackTrace();
      }
	  return obj;
  }
  // ---------------------------------- 添红计划新增方法---------------------------
  /**
  * 查询每个交易所数据和
  */
  private List<Map> getUserPrizeListSum(String mobile, Integer ActionId){
	  Map<String,String> mapTmp = new HashMap<String,String>();
	  String key = "UserPrize_"+mobile;
	  List<Map> list = (List<Map>)Cache.get(key);
      if(list == null){
		  String url = "http://crm.zhengjin99.com/external/GJSUserPrizeList?mobile=" + mobile;
		  if(ActionId != null)
			  url += "&ActionId="+ActionId;
		  String data = Utils.url2StringUnsafe(url, "UTF-8");
		  Map map = (Map) Json.fromJson(data);
		  Integer code = (Integer)map.get("code");
		  if(code == 0){
			  Object msg = map.get("msg");
			  if(!"".equals(msg.toString())){
				  list = (List)Json.fromJson((String)msg);
				  list = changeValueThjh(list);
			 }
		  }
	  	  if(list != null)
	  	  	  Cache.set(key, list, expire);
      }
	  return list;
  }
  private List changeValueThjh(List<Map> list){
	  List<Map> listTmp = new ArrayList<Map>();
	  List<Map> listtj = new ArrayList<Map>();
	  List<Map> listdy = new ArrayList<Map>();
	  List<Map> listql = new ArrayList<Map>();
	  if(list == null)
		  return null;
	  else{
		  for(int i=0;i<list.size();i++){
			  if(list.get(i).get("ExchangeID").equals("2")){
				  listtj.add(list.get(i));
			  }else if(list.get(i).get("ExchangeID").equals("3")){
				  listdy.add(list.get(i));
			  }else if(list.get(i).get("ExchangeID").equals("4")){
				  listql.add(list.get(i));
			  }
		  }
		  listTmp.addAll(listtj);
		  listTmp.addAll(listdy);
		  listTmp.addAll(listql);
	  }
	  list = listTmp;
	  List<Map> listResult = new ArrayList<Map>();
	  Double _ChangeAmount = 0D;
	  Map mapTmp = null;
	  for(int i=0;i<list.size();i++){
		  if(mapTmp == null){
			  mapTmp = new HashMap(); 
			  mapTmp.put("ExchangeID",list.get(i).get("ExchangeID"));
			  mapTmp.put("ChangeTime",((String)list.get(i).get("MinDay")).split(" ")[0].replace("/", "-"));
			  mapTmp.put("ChangeAmount",list.get(i).get("ChangeAmount"));
			  mapTmp.put("Quantity",list.get(i).get("Quantity"));
			  _ChangeAmount = _ChangeAmount + Double.valueOf(list.get(i).get("ChangeAmount").toString());
			  mapTmp.put("Rate",list.get(i).get("Rate"));
			  String _Fund = (String)list.get(i).get("Fund");
			  mapTmp.put("Fund",_Fund.length()>2?_Fund.substring(0,_Fund.length()-2):_Fund);
		  }else{
			  if(mapTmp.get("ExchangeID").equals(list.get(i).get("ExchangeID"))){
				  _ChangeAmount = _ChangeAmount + Double.valueOf(list.get(i).get("ChangeAmount").toString());
			  }else{
				  mapTmp.put("_ChangeAmount",_ChangeAmount);
				  listResult.add(mapTmp);
				  _ChangeAmount = 0D;
				  mapTmp = new HashMap();
				  mapTmp.put("ExchangeID",list.get(i).get("ExchangeID"));
				  mapTmp.put("ChangeTime",((String)list.get(i).get("MinDay")).split(" ")[0].replace("/", "-"));
				  mapTmp.put("ChangeAmount",list.get(i).get("ChangeAmount"));
				  mapTmp.put("Quantity",list.get(i).get("Quantity"));
				  _ChangeAmount = _ChangeAmount + Double.valueOf(list.get(i).get("ChangeAmount").toString());
				  mapTmp.put("_ChangeAmount",_ChangeAmount);
				  mapTmp.put("Rate",list.get(i).get("Rate"));
				  String _Fund = (String)list.get(i).get("Fund");
				  mapTmp.put("Fund",_Fund.length()>2?_Fund.substring(0,_Fund.length()-2):_Fund);
			  }
		  }
		  if(i == list.size()-1){
			  mapTmp.put("_ChangeAmount",_ChangeAmount);
			  System.out.println(_ChangeAmount);
			  listResult.add(mapTmp);
		  }
	  }
	  System.out.println(listResult.size());
	  return listResult;
  }
  	/**
  	* 返回对应交易所的数据
  	*/
	private List<Map> getUserPrizeListDetail(String mobile, Integer ActionId,Integer ExchangeID){
	  Map mapTmp = null;
	  String key = "UserPrize_"+ExchangeID+"_"+mobile;
	  List<Map> listResult = (List<Map>)Cache.get(key);
      if(listResult == null){
		  String url = "http://crm.zhengjin99.com/external/GJSUserPrizeList?mobile=" + mobile;
		  if(ActionId != null)
			  url += "&ActionId="+ActionId;
		  String data = Utils.url2StringUnsafe(url, "UTF-8");
		  Map map = (Map) Json.fromJson(data);
		  Integer code = (Integer)map.get("code");
		  Double _ChangeAmount = 0D;
		  if(code == 0){
			  Object msg = map.get("msg");
			  if(!"".equals(msg.toString())){
				  List<Map> list = (List)Json.fromJson((String)msg);
				  if(null == list || list.size() == 0){
					  return null;
				  }else{
					  listResult = new ArrayList<Map>();
					  for(int i=list.size()-1;i>=0;i--){
						  if(list.get(i).get("ExchangeID").equals(ExchangeID+"")){
							  mapTmp = new HashMap();
							  mapTmp.put("ExchangeID",(String)list.get(i).get("ExchangeID"));
							  mapTmp.put("ChangeTime",((String)list.get(i).get("MinDay")).split(" ")[0].replace("/", "-"));
							  mapTmp.put("ChangeAmount",(String)list.get(i).get("ChangeAmount"));
							  _ChangeAmount = _ChangeAmount + Double.valueOf(list.get(i).get("ChangeAmount").toString());
							  String _Fund = (String)list.get(i).get("Fund");
							  mapTmp.put("Fund",_Fund.length()>2?_Fund.substring(0,_Fund.length()-2):_Fund);
							  mapTmp.put("_ChangeAmount",_ChangeAmount+"");
							  listResult.add(mapTmp);
							  mapTmp = null;
						  }
					  }
				  }
			 }
		  }
	  	  if(listResult != null && listResult.size()>0)
	  	  	  Cache.set(key, listResult, expire);
      }
	  return listResult;
  }
  /**
  * 查询是否有收益
  */
	private boolean hasTradeThjh(String mobile){
		  List<Map> list = getUserPrizeListSum(mobile, 6);
		  if(list != null && list.size() > 0){
			  for(Map map: list){
				  Double ChangeAmount = Double.valueOf(map.get("ChangeAmount")+"");
				  if(ChangeAmount > 0)
					  return true;
			  }
		  }
		  return false;
	  }
  
  
%>