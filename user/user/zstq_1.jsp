
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专属特权银卡客户_个人中心_证金贵金属</title>
<link href="css/style_v2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<STYLE type=text/css>.STYLE1 {
	FONT-FAMILY: Arial, Helvetica, sans-serif; COLOR: #669933; FONT-SIZE: 36px; FONT-WEIGHT: bold
}
</STYLE>
<script>
	function changeul(id1,id2,id3){
		$('.personal_zstq_main').hide();
		$('#'+id1).show();
		$('.lv0sl').removeClass('lv0sl');
		if(id2){
			$('#'+id2).addClass('lv0sl');
		}	
		var length=$('.personal_zstq ul li').length;
		//$('#'+id3).addClass('ulsl');
		for(var i=0;i<length;i++){
			var temp=i+1;
			$('.personal_zstq ul li').eq(i).removeClass('lv'+temp+'_hover');
		}	
		if(id3){
			var classname=$('#'+id3).attr('class');			
			$('#'+id3).addClass(classname+'_hover');
		}
	}
	$(document).ready(function(){
		//tozstq();
		$('.personal_hd').parent().bind('mouseenter',function(){			
			if(!$(this).find('.personal_hd').is(':animated')){
				var display=$(this).find('.personal_hd').css('display');
				var top=$(this).find('.personal_hd').css('top');
				if(display=='block'&&top=='0px'){
					return;
				}
				h=$(this).height();
				$(this).find('.personal_hd').css('top',h);
				$(this).find('.personal_hd').show();
				$(this).find('.personal_hd').animate({top:'0'},1500);
			}
			
		})
		$('.personal_hd').bind('mouseleave',function(){
			if(!$(this).is(':animated')){
				$(this).animate({top:h},1500);
			}
		})

	})
	
	function openClose(id1, id2){
		if($('#'+id1).is(':hidden')){
			$('#'+id1).show();
		}else{
			$('#'+id1).hide();
		}
		$('#'+id2).hide();
	}
</script>

</head>

<body>
	<!-- head -->
	
	<!-- nav -->
	<div id="nav" class="pr">
    	<ul class="w990 mauto">
        </ul>
    </div>
	<div id="personal" class="clear mb20 over bg_left_gray">
    	
    	<div class="fr grzx_right">
			<div class="personal_tyk">
        		<p class="personal_right_title">专属特权</p>
                <div class="personal_zstq">
                	<ul class="bq clear over">
                    	<li class="lv1" onclick="changeul('tyk','','tykli')" id="tykli"><span>体验客户</span></li>
                        <li class="lv2 sl" onclick="changeul('pk','')" id="pkli"><span>银卡客户</span></li>
                        <li class="lv0" onclick="changeul('jk','jkli')" id="jkli"><span>金卡客户</span></li>
                        <li class="lv0" onclick="changeul('zsk','zskli')" id="zskli"><span>白金卡客户</span></li>
                        <li class="lv0" onclick="changeul('hj','hjli')" id="hjli"><span>钻石卡客户</span></li>
                    </ul>
                    
                  <div class="personal_zstq_main hide personal_jk_enable" id="jk">
                    	<div class="personal_zstq_top pr">
                        	<div class="personal_zstq_left">
                            	
                            </div>
                            
                          	<div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="openClose('personal_zstq_tqdisjk', 'personal_zstq_discribeqtjk');"><input name="" type="button" class="wysj" value="我要升级" onclick="openClose('personal_zstq_discribeqtjk', 'personal_zstq_tqdisjk');">
                            </div>
                          	<div class="pa personal_zstq_tqdis hide" id="personal_zstq_tqdisjk">
                          		<div class="arrow pa" style="right:175px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_tqdisjk').hide();"></div>
                            	<p class="title fb">金卡客户级别须知</p>
                                <p>1、净入金总额达到8～50万（含8万）之间，即可专享金卡特权。</p>
                                <p>2、如果因净入金变化引起所属级别发生变化，新级别将在次日12：00前生效。</p>
                          	</div>
                            <div class="pa personal_zstq_discribe hide" id="personal_zstq_discribeqtjk">
                            	<div class="arrow pa" style="right:50px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_discribeqtjk').hide();"></div>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tbody><tr>
                                    <td><p class="fb">金卡客户</p></td>
                                    <td class="pl10">净入金总额达到8～50万（含8万）之间，即可专享金卡特权</td>
                                    
                                  </tr>
                                  <tr>
                                    <td colspan="2" style="background:none;" height="10"></td>
                                  </tr>
                                  <tr>
                                    
                                    <td class="tc" colspan="2"><input name="" type="button" class="wysj" onclick="update(1,2);"value="立即申请" style="margin-right:20px;"><input name="" type="button" class="tqsm" value="取消"></td>
                                  </tr>
                                </tbody></table>
                          	</div>
                        </div>
                        
          				<div class="personal_zstq_mid clear over">
                        	<div class="fl personal_zstq_mleft pr">
                            	<span class="pa zs">专属</span>
                            	<img src="images/enable_fxpg_logo.gif" width="116" height="94">
                                <p class="f24 tc title">风险评估</p>
                                <p>通过问卷测评发现客户的投资偏好及风险承受能力，然后经过专业老师的解析后给出合理的投资建议</p>
                            </div>                            
							<div class="fr personal_zstq_mrightt pr">
                                <span class="pa zs">专属</span>
                                <img src="images/enable_clbg_logo.gif" width="40" height="30" class="fl" style="margin-top:10px;">
                                <p class="f24 tc title fl ml10" style="margin-top: 10px;">投资策略报告</p>
                                <p class="clear" style="margin:0;">每次非农、美联储会议纪要等重大事件来临前，投资顾问将根据对行情的实时研判和专业分析，发布最及时、最有价值的投资策略报告至客户，帮助大家合理把握重大事件带来的投资机遇，我们相信“成功的策略塑造成功的投资”。<br />发布时间：重大事件当天下午16点以前发送至“证金来信”中。</p>
                            </div>
							<div class="fr personal_zstq_mrightb pr">
                            	<span class="pa zs">专属</span>
                            	<img src="images/enable_jljf_logo.gif" width="72" height="82" class="fl">
                                <p class="f24 title ml80">奖励积分</p>
                                <p class="pt10" style="margin-left:80px;">客户参与公司的各项回馈活动时，有额外获得积分的权利，具体奖励以各活动细则为准</p>                            </div>
            				<div class="clear"></div>
                        </div>
                        
                        <div class="clear over personal_zstq_foot">
                        	<img src="images/jin_more.gif" width="120" height="120">
                        	<a href="#"><img src="images/enable_hx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_kfzx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_wtxd.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_jfsc.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_grzx.gif" width="120" height="120"></a>
                            <a href="#" class="small"><img src="images/enable_yscl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjyp.png" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_hxhis.gif" width="125" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_cjrl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjxy.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zxzx.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjjn.gif" width="55" height="55"></a>
                        </div>
                        
                  </div>
                  
                  
                  <div class="personal_zstq_main personal_tyk_pass hide" id="tyk">
                    	<div class="personal_zstq_top pr">
                        	<div class="personal_zstq_left">
                            	
                            </div>
                            <div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="openClose('personal_zstq_tqdistyk', '');">
                            </div>
                          	<div class="pa personal_zstq_tqdis hide" id="personal_zstq_tqdistyk">
                          		<div class="arrow pa" style="right:65px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_tqdistyk').hide();"></div>
                            	<p class="title fb">体验客户级别须知</p>
                                <p>1、体验客户尚未成为正式用户，只能享有基础服务。</p>
                                <p>2、如果因净入金变化引起所属级别发生变化，新级别将在次日12：00前生效。</p>
                          	</div>
                            
                        </div>
                        
          				<div class="personal_zstq_mid clear over">
                        	<div class="fl personal_zstq_mrightb pr cur" style="margin-top:0" onclick="location.href='.'">
                            	<span class="pa zs">专属</span>
                            	<img src="images/able_tyk_grzx.gif" width="82" height="76" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:76px;">个人中心</p>
                                <p class="clear">为不同级别的客户提供专属服务的一站式服务平台.</p>
                            </div>
							<div class="fl personal_zstq_mrightb pr cur" style="margin:0" onclick="location.href='http://vd.jrj.com/front/chat/?room=1'">
                            	<!-- <span class="pa zs">专属</span>
                            	<img src="images/able_tyk_kfzx.gif" width="92" height="76" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:76px;">金融面对面</p>
                                <p class="clear">通过网络课堂的方式为客户提供投资理财专业知识的分享</p>
                                <div class="fl personal_zstq_mrightb hide pa personal_hd" style="margin:0;top:0;left:0;z-index:99;width:96%;_width:100%;">
                                    <span class="pa zs">专属</span>
                                    <img src="images/bgh_pass_small.gif" width="33" height="27" class="fl">
                                    <p class="f24 tc title fl ml10" style="line-height:27px;">金融面对面</p>
                                    <p class="clear">此节目以独立的分析判断、独到的专业角度，全面覆盖贵金属、证券、期货、理财等各个领域，成为国内投资者首选的热点透析类视频节目。为投资者解决了持续性热点不好把握、持续性事件分析不全面、持续性机会不好操作等问题。</p>
                            	</div> -->
                            	
                            	<span class="pa zs">专属</span>
                                <img src="images/bgh_pass_small.gif" width="33" height="27" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:27px;">证金直播</p>
                                <p class="clear">此节目以独立的分析判断、独到的专业角度，全面覆盖贵金属、证券、期货、理财等各个领域，成为国内投资者首选的热点透析类视频节目。为投资者解决了持续性热点不好把握、持续性事件分析不全面、持续性机会不好操作等问题。</p>
                            </div>
            				<div class="clear"></div>
                        </div>
                        <!-- <script type="text/javascript" charset="utf-8" src="http://gate.looyu.com/49537/105923.js"></script>
                          <div id="doyoo_share" style="display:none;"></div>
                          <link rel="stylesheet" type="text/css" href="http://static.doyoo.net/110402/looyu.css?1205021"><script type="text/javascript" src="http://static.doyoo.net/110402/looyu.js?120618"></script> <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1" height="1" id="looyuShare"><param name="movie" value="http://static.doyoo.net/110402/../default/swf/looyu2.swf"><param name="allowScriptAccess" value="always"><embed src="http://static.doyoo.net/110402/../default/swf/looyu2.swf" allowscriptaccess="always" width="1" height="1" name="looyuShare" type="application/x-shockwave-flash"></object> -->
              
                        <div class="clear over personal_zstq_foot">
                        	<img src="images/enable_more.gif" width="120" height="120">
                            <div class="fl" style="width:300px;">
                            <a target="_blank" href="http://www.zhengjin99.com/list/list_yanjiu_zaowan.shtml" class="small"><img src="images/jin_yscl.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://vd.jrj.com/front/chat/?room=1" class="small"><img src="images/jin_zjyp.jpg" width="55" height="55"></a>
                            <a target="_blank" href="http://zhibo.zhengjin99.com/hxzb/" class="small"><img src="images/jin_hxhis.gif" width="125" height="55"></a>
                            <a target="_blank" href="http://www.zhengjin99.com/research/calendar.shtml" class="small"><img src="images/jin_cjrl.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://www.zhengjin99.com/list/list_yanjiu_xueyuan.shtml" class="small"><img src="images/jin_zjxy.gif" width="55" height="55"></a>
                            <a href="http://www.zhengjin99.com/service/zxzx_index.html?head=2" target="_blank" class="small"><img src="images/jin_zxzx.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://tg.zhengjin99.com/zhengjin/cfzk" class="small"><img src="images/jin_zjjn.gif" width="55" height="55"></a>
                            </div>
                        </div>
                        
                  </div>
                  
                  
                  <div class="personal_zstq_main personal_pk_now" id="pk">
                    	<div class="personal_zstq_top pr">
                        	<div class="personal_zstq_left personal_zstq_leftyk">
                            	
                            </div>
                            <div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="openClose('personal_zstq_tqdispk', 'personal_zstq_discribepk');"><input name="" type="button" class="wysj" value="我要升级" onclick="openClose('personal_zstq_discribepk', 'personal_zstq_tqdispk');">
                            </div>
                          	<div class="pa personal_zstq_tqdis hide" id="personal_zstq_tqdispk">
                          		<div class="arrow pa" style="right:175px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_tqdispk').hide();"></div>
                            	<p class="title fb">银卡客户级别须知</p>
                                <p>1、激活后历史最大净入金达到3～8万（包含3万），即可专享银卡特权。</p>
                                <p>2、如果因净入金变化引起所属级别发生变化，新级别将在次日12：00前生效。</p>
                          	</div>
                            <div class="pa personal_zstq_discribe hide" id="personal_zstq_discribepk">
                            	<div class="arrow pa" style="right:50px;"></div>
                                <div class="personal_sj">
                                    <div class="close pa" onclick="$('#personal_zstq_discribepk').hide();"></div>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      
                                        <tbody><tr><td><p class="fb">金卡客户</p></td>
                                        <td class="pl10">净入金总额达到8～50万（含8万）之间，即可专享金卡特权。</td>
                                        <td><input name="" type="button" class="lv_up" onclick="update(0,2);$(this).parents('.personal_sj').siblings('.personal_zstq_distj').show();$(this).parents('.personal_sj').hide();"></td>
                                      </tr>
                                      <tr>
                                        <td colspan="3" style="background:none;" height="10"></td>
                                      </tr>
                                      <tr>
                                        <td><p class="fb">白金卡客户</p></td>
                                        <td class="pl10">净入金总额达到50～300万（含50万）之间，即可专享白金特权。</td>
                                        <td><input name="" type="button" class="lv_up" onclick="update(0,3);$(this).parents('.personal_sj').siblings('.personal_zstq_distj').show();$(this).parents('.personal_sj').hide();"></td>
                                      </tr>
                                      <tr>
                                        <td colspan="3" style="background:none;" height="10"></td>
                                      </tr>
                                      <tr>
                                        <td><p class="fb">钻石卡客户</p></td>
                                        <td class="pl10">净入金总额达到300万（含300万）以上，即可专享钻石特权。</td>
                                        <td><input name="" type="button" class="lv_up" onclick="update(0,4);$(this).parents('.personal_sj').siblings('.personal_zstq_distj').show();$(this).parents('.personal_sj').hide();"></td>
                                      </tr>                                  
                                    </tbody></table>
                                </div>
                                <div class="hide personal_zstq_distj">
                                    <div class="arrow pa" style="right:50px;"></div>
                                    <p class="tc">您的申请已经提交至客户代表，稍后客户代表将和您联系！请您耐心等候！</p>
                                    <p class="tc" style="margin-top:100px;"><input name="" type="button" class="tqsm" value="关闭" onclick="$('#personal_zstq_discribepk').hide();"></p>
                                </div>
                          	</div>
                        </div>
                        
          				<div class="personal_zstq_mid clear over">
                            <div class="fl personal_zstq_mleft pr cur" style="height:390px;" onclick="window.open('http://zhibo.zhengjin99.com/hxzb')">
                                <span class="pa zs">专属</span>
                                <img src="images/pk_hx_logo.gif" width="99" height="87">
                                <p class="f24 tc title" style="padding:0;">大咖工作室</p>
                                <p class="f16 tc title" style="padding:0;">（PC+APP+微信）</p>
                                <p class="f14 tc title" style="padding:0;">（参与特殊市场活动但未达标者除外）</p>
                                <p>国内顶尖的贵金属投资交流平台，凝聚一批最活跃、最专业、最主流且最有经验的金融市场专家，第一时间为投资者解析实时行情、在线答疑，此外还会定期进行投资者教育，致力于将投资者打造成为投资高手。<br /><br />服务时间：交易日的9:00-24:00（法定节假日除外）。</p>
                            </div>
                            
                            <div class="fr personal_zstq_mrightt pr">
                                <span class="pa zs">专属</span>
                                <img src="images/pk_dhwt_logo.gif" width="73" height="81" class="fl">
                                <p class="f24 title fl ml10">电话委托下单</p>
                                <p class="ml10 fl">拨打010-58309009委托专人下单，行情永不错过。<br />工作时间：早7:00-次日4:00(法定节假日除外)</p>
                            </div>
                            
                            <div class="fr personal_zstq_mrightb pr cur" style="margin-right:0;height:268px;" onclick="window.open('/zhengjin/mall/myscore.jsp?type=2')">
                                <span class="pa zs">专属</span>
                                <img src="images/pk_jfsc_logo.gif" width="41" height="51" class="fl">
                                <p class="f24 tc title fl ml10">积分商城</p>
                                <p class="clear">为回馈客户对我们的信任和支持，我们为客户倾情推出积分商城，客户可以通过交易获得相应积分，利用积分在积分商城中兑换相应的商品。<br /><br />温馨提示：积分兑换规则，请点击进入积分商城查看</p>
                            </div>
                            
                            <div class="fr personal_zstq_mrightb pr" style="background:#ebe7d9;height:268px;">
                                <span class="pa zs">专属</span>
                                <img src="images/pk_kfzx_logo.gif" width="49" height="49" class="fl">
                                <p class="f24 tc title fl ml10">客服专线</p>
                                <p class="ml10 fl">010-58309166</p>
                                <p class="ml10 fl"><br>&nbsp;</p>
                                <p class="ml10 fl" style="padding-left: 48px;">工作时间：<br />09:00-12:00<br />13:00-21:00</p>
                                <p class="fl" style="padding-left: 48px;">(法定节假日除外)</p>
            				<div class="clear"></div>
                        </div>
                        
                        <div class="clear over personal_zstq_foot">
                        	<img src="images/jin_more.gif" width="120" height="120">
                        	<a href="."><img src="images/jin_grzx.gif" width="120" height="120"></a>
                            <a target="_blank" href="http://www.zhengjin99.com/list/list_yanjiu_zaowan.shtml" class="small"><img src="images/jin_yscl.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://vd.jrj.com/front/chat/?room=1" class="small"><img src="images/jin_pu_zjyp.jpg" width="55" height="55"></a>
                            <a target="_blank" href="http://zhibo.zhengjin99.com/hxzb/" class="small"><img src="images/jin_hxhis.gif" width="125" height="55"></a>
                            <a target="_blank" href="http://www.zhengjin99.com/research/calendar.shtml" class="small"><img src="images/jin_cjrl.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://www.zhengjin99.com/list/list_yanjiu_xueyuan.shtml" class="small"><img src="images/jin_zjxy.gif" width="55" height="55"></a>
                            <a href="javascript:doyoo.util.openChat('g=66550')" class="small"><img src="images/jin_zxzx.gif" width="55" height="55"></a>
                            <a target="_blank" href="http://tg.zhengjin99.com/zhengjin/cfzk" class="small"><img src="images/jin_zjjn.gif" width="55" height="55"></a>
                        </div>
                        
                  </div>
                  </div>
                  
                  <div class="personal_zstq_main personal_zstq_enable hide" id="zsk">
                    	<div class="personal_zstq_top pr">
                        	<div class="personal_zstq_left">
                            	
                            </div>
                            <div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="openClose('personal_zstq_tqdiszsk', 'personal_zstq_discribeqtzsk');"><input name="" type="button" class="wysj" value="我要升级" onclick="openClose('personal_zstq_discribeqtzsk', 'personal_zstq_tqdiszsk');">
                            </div>
                            <div class="pa personal_zstq_discribe hide" id="personal_zstq_diszsk">
                            	<div class="arrow pa" style="right:50px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_diszsk').hide();"></div>
                            	<p class="tc">您的申请已经提交至客户代表，稍后客户代表将和您联系！请您耐心等候！</p>
                                
                          	</div>
                            <div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="$('#personal_zstq_tqdiszsk').show();"><input name="" type="button" class="wysj" value="我要升级" onclick="$('#personal_zstq_discribeqtzsk').show();">
                            </div>
                          	<div class="pa personal_zstq_tqdis hide" id="personal_zstq_tqdiszsk">
                          		<div class="arrow pa" style="right:175px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_tqdiszsk').hide();"></div>
                            	<p class="title fb">白金客户级别须知</p>
                                <p>1、净入金总额达到50～300万（含50万）之间，即可专享白金卡特权。</p>
                                <p>2、如果因净入金变化引起所属级别发生变化，所属级别的更新将在次日12:00前进行。</p>
                          	</div>
                            <div class="pa personal_zstq_discribe hide" id="personal_zstq_discribeqtzsk">
                            	<div class="arrow pa" style="right:50px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_discribeqtzsk').hide();"></div>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tbody><tr>
                                    <td><p class="fb">白金卡客户</p></td>
                                    <td class="pl10">净入金总额达到50～300万（含50万）之间，即可专享白金卡特权</td>
                                    
                                  </tr>
                                  <tr>
                                    <td colspan="2" style="background:none;" height="10"></td>
                                  </tr>
                                  <tr>
                                    
                                    <td class="tc" colspan="2"><input name="" type="button" class="wysj" onclick="update(1,3);" value="立即申请" style="margin-right:20px;"><input name="" type="button" class="tqsm" value="取消"></td>
                                  </tr>
                                </tbody></table>
                          	</div>
                            
                        </div>
                        
          				<div class="personal_zstq_mid clear over">
                        	<div class="fl personal_zstq_mrightb pr" style="margin-top:0;">
                                <span class="pa zs">专属</span>
                                <img src="images/jin_enable_kf.gif" width="85" height="83" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:82px;">VIP专属热线</p>
                                <p class="clear">VIP客户专享热线010-58309088，由高级客服提供一对一的优先贴心服务</p>
                            </div>
                            
                            <div class="fl personal_zstq_mrightb pr cur" style="margin:0;">
                                <span class="pa zs">专属</span>
                                <img src="images/jin_enable_zbs.gif" width="35" height="40" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:25px;">VIP直播室</p>
                                <p class="clear">汇聚国内顶尖并具有丰富经验的投资顾问，专为高端VIP客户量身设计的投资直播平台，内容涉及到一对一服务、精英团内参、全程攻略、私人订制等等，让最高端的服务和最完善的策略为您的操作保驾护航！服务时间：交易日的9:00-24:00（法定节假日除外）。</p>
                            </div>
                            
                            <div class="fr personal_zstq_mrightb pr" style="margin-right:0;">
                                <span class="pa zs">专属</span>
                                <img src="images/jin_enable_chjlb.gif" width="37" height="27" class="fl">
                                <p class="f24 title flml10">彩虹俱乐部--尚品生活沙龙</span></p>
                                <p class="clear">聘请资深生活顾问，与客户分享红酒品鉴、高尔夫技巧等知识，致力于提升高端客户的生活品质，让客户在感受投资乐趣的同时也能享受高品质生活质感。尚品生活沙龙将不定期举行，届时客户代表将为客户送上邀请函</p>
                            </div>
                            
                            <div class="fr personal_zstq_mrightb pr">
                                <span class="pa zs">专属</span>
                                <img src="images/jin_enable_tznc.gif" width="35" height="25" class="fl">
                                <p class="f24 tc title fl ml10" style="line-height:25px;">VIP投资内参</p>
                                <p class="clear">定位于高端客户，研究专家从贵金属市场中精选最具价值的数据即时分享，多空持仓博弈，让您全面了解市场上投资者的心态，为自己的操作提供重要依据；江恩轮中轮理论，独创的操作模型将投资变得简单明了，我们全方位多维度剖析市场，帮助您获得投资线索并进行投资决策，每周五17:00点更新</p>
                            </div>
                            
                            <div class="fl personal_zstq_mrightb pr">
                                <span class="pa zs">专属</span>
                                <img src="images/khgh_future.gif" width="74" height="74" class="fl" style="margin-left:20px;">
                                <p class="f24 tc title fl ml10" style="line-height:74px;">客户关怀</p>
                                <p class="clear pt10"">为客户提供多种多样的温馨关怀服务，比如节日祝福、赠送生日礼物等</p>
                            </div>
            				<div class="clear"></div>
                        </div>
                        
                        <div class="clear over personal_zstq_foot">
                        	<img src="images/enable_more.gif" width="120" height="120">
                        	<a href="#"><img src="images/enable_fxpg.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_clbg.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_jljf.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_hx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_kfzx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_wtxd.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_jfsc.gif" width="120" height="120"></a>
                            <a href="#" class="small"><img src="images/enable_yscl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjyp.png" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_hxhis.gif" width="125" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_cjrl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjxy.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zxzx.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjjn.gif" width="55" height="55"></a>
                        </div>                        
                  </div>
                  
                  
                  <div class="personal_zstq_main personal_hj hide personal_hj_enable" id="hj">
                    	<div class="personal_zstq_top pr">
                        	<div class="personal_zstq_left">
                            	
                            </div>
                            <div class="personal_zstq_right pa">
                            	<input name="" type="button" class="tqsm" value="特权声明" onclick="openClose('personal_zstq_tqdishj','personal_zstq_discribeqthjk');"><input name="" type="button" class="wysj" value="我要升级" onclick="openClose('personal_zstq_discribeqthjk', 'personal_zstq_tqdishj');">
                            </div>
                          	<div class="pa personal_zstq_tqdis hide" id="personal_zstq_tqdishj">
                          		<div class="arrow pa" style="right:175px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_tqdishj').hide();"></div>
                            	<p class="title fb">钻石客户级别须知</p>
                                <p>1、净入金总额达到300万（含300万）以上，即可专享钻石卡特权。</p>
                                <p>2、如果因净入金变化引起所属级别发生变化，所属级别的更新将在次日12:00前进行。</p>
                          	</div>
                            <div class="pa personal_zstq_discribe hide" id="personal_zstq_discribeqthjk">
                            	<div class="arrow pa" style="right:50px;"></div>
                                <div class="close pa" onclick="$('#personal_zstq_discribeqthjk').hide();"></div>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tbody><tr>
                                    <td><p class="fb">钻石卡客户</p></td>
                                    <td class="pl10">净入金总额达到300万（含300万）以上，即可专享钻石卡特权</td>
                                    
                                  </tr>
                                  <tr>
                                    <td colspan="2" style="background:none;" height="10"></td>
                                  </tr>
                                  <tr>
                                    
                                    <td class="tc" colspan="2"><input name="" type="button" class="wysj" onclick="update(1,4);" value="立即申请" style="margin-right:20px;"><input name="" type="button" class="tqsm" value="取消"></td>
                                  </tr>
                                </tbody></table>
                          	</div>
                        </div>
                        
          				<div class="personal_zstq_mid clear over">
							<div class="fl personal_zstq_mrightt pr" style="height:190px;" >
                                <span class="pa zs">专属</span>
                                <img src="images/enable_zjdz_logo.gif" width="60" height="50" class="fl">
                                <p class="f24 tc title fl ml10">专家定制</p>
                                <p class="clear">由首席投顾和首席分析师组成的专家组，为客户量身定制投资行为分析和投资理财建议，致力于打造个性化的高级私人定制服务。申请之后5个交易日内反馈至客户“个人中心—信息中心—证金来信”中，并电话详细解读</p>
                                <span class="more pa"><a href="javascript:void(0)">了解更多》</a></span>
                            </div>
                            
                            <div class="fl personal_zstq_mrightb pr" style="height:190px;" >
                                <span class="pa zs">专属</span>
                                <img src="images/enable_chjlb_logo.gif" width="75" height="50" class="fl">
                                <p class="f24 tc title fl ml10">彩虹俱乐部--倾情接送服务</p>
                                <p>&nbsp;</p>
                                <p class="clear">为了能让贵宾客户来京时享受到便利快捷的交通服务，我们为钻石卡用户倾情提供来京飞机/火车接送服务，届时您来京时，可派专车将您从机场/车站送至您来京的目的地，您离京时，可派专车将您送至机场/车站。<br />温馨提示：倾情接送服务需使用积分商城中的电子兑换券进行预约，点击进入电子券兑换</p>
                                <span class="more pa"><a href="javascript:void(0)">了解更多》</a></span>
                            </div>
                            
                            <div class="fl personal_zstq_mrightt pr" style="margin-top: 30px;height:190px;">
                                <span class="pa zs">专属</span>
                                <img src="images/hotel_enable.gif" width="62" height="55" class="fl">
                                <p class="f24 tc title fl ml10">彩虹俱乐部--五星级酒店预订服务</p>
                                <p>&nbsp;</p>
                                <p class="clear">为了能让贵宾客户来京时享受到温馨舒适的住宿环境，我们为钻石卡用户倾情提供五星级酒店预订服务。<br />温馨提示：五星级酒店预订服务需使用积分商城中的电子兑换券进行预约，点击进入电子券兑换</p>
                                <span class="more pa"><a href="javascript:void(0)">了解更多》</a></span>
                            </div>
            				<div class="clear"></div>
                        </div>
                        
                        <div class="clear over personal_zstq_foot">
                        	<img src="images/jin_more.gif" width="120" height="120">
                        	<a href="javascript:void(0)"><img src="images/enable_khgh.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_zsrx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_zbs.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_chjlb.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_tznc.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_fxpg.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_clbg.gif" width="120" height="120"></a>
                        	<a href="#"><img src="images/enable_jljf.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_hx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_kfzx.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_wtxd.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_jfsc.gif" width="120" height="120"></a>
                            <a href="#"><img src="images/enable_grzx.gif" width="120" height="120"></a>
                            <div class="clear"></div>
                            <a href="#" class="small"><img src="images/enable_yscl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjyp.png" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_hxhis.gif" width="125" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_cjrl.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjxy.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zxzx.gif" width="55" height="55"></a>
                            <a href="#" class="small"><img src="images/enable_zjjn.gif" width="55" height="55"></a>
                            <div class="clear"></div>
                        </div>
                        
                  </div>
                  
                </div>
            </div>
      	</div>
      
      	<div class="clear"></div>
    </div>
   
</body>
</html>
