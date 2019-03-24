// JavaScript Document

	$('html head').append('\
			<style type="text/css">\
				.clear{clear:both;}\
				.mask_box{width:100%;height:100%;position:fixed;background:#000;opacity:0.7;filter:alpha(opacity=70);display:none;top:0;left:0;z-index:999}\
				.pop_five{display:none;}\
				.pop_two{display:none;}\
				.pop_three{display:none;}\
				.pop_four{display:none;}\
				.pop_box{width:36%;min-width:520px;position:fixed;top:50%;left:50%;margin-top:-188px;margin-left:-18%;background:#FFF;border-radius:10px;}\
				.pop_box .pop_content{width:90%;padding:5%;}\
				.pop_box .pop_content .nr{width:100%;position:relative;margin:0 auto;}\
				.pop_box .pop_content .nr img{width:15%;position:relative;margin:0 auto;display:block;}\
				.pop_box .pop_content .nr p{font-family:\'微软雅黑\',\'Microsoft Yahei\';font-size:15px;color:#434343;padding:3% 0;line-height:25px;}\
				.pop_box .pop_content .nr a{font-family:\'微软雅黑\',\'Microsoft Yahei\';font-size:14px;color:#f39c26;text-align:center;padding-top:3%;display:block;text-decoration:underline;}\
				.pop_box .pop_content span{width:45%;height:40px;position:relative;margin:2% auto;background:#f39c26;border-radius:15px;display:block;font-family:\'微软雅黑\',\'Microsoft Yahei\';font-size:15px;color:#fff;text-align:center;line-height:40px;margin-top:5%;}\
				.pop_two .pop_content .nr  p{padding-top:7%;text-align:center;}\
				.pop_three .pop_content .btn{width:73%;position:relative;margin:0 auto;}\
				.pop_three .pop_content .btn span:nth-child(1){float:left;width:45%;}\
				.pop_three .pop_content .btn span:nth-child(2){float:right;width:45%;}\
				.pop_four .pop_content .btn{width:73%;position:relative;margin:0 auto;}\
				.pop_four .pop_content .btn span:nth-child(1){float:left;width:45%;}\
				.pop_four .pop_content .btn span:nth-child(2){float:right;width:45%;}\
				.pop_four .pop_content .nr  p{padding-top:7%;text-align:center;}\
				.pop_five .pop_content .btn{width:73%;position:relative;margin:0 auto;}\
				.pop_five .pop_content .btn span:nth-child(1){width:45%;}\
				.pop_five .pop_content .btn span:nth-child(2){float:right;width:45%;}\
			</style>\
		');
		
	
	
	function WindowPop(op){
			this.op = op || {};
			
			$('.mask_box').remove();
			$('body').append('<div class="mask_box"></div>');
			
			var text = this.op.text?'<p class="text-word">'+ this.op.text.word +'</p>':'',
			link = this.op.link?' <a class="text-link" href="'+ this.op.link.href +'">'+ this.op.link.word +'</a>':'';
			
			var btn = '';
			
			if(this.op.btn){
				btn = '<div class="btn">';
				for(var i = 0; i <this.op.btn.length; i++){
					btn += '<span class="btn-list">'+ this.op.btn[i].word +'</span>';
					if(this.op.btn.length > 1 && i != this.op.btn.length-1){
						btn += '<p style="display:block;padding:0 4%;float:left;height:40px;"></p>';
					}
				}
				btn += '</div>'
			}
			
			
			var id = 'pop_box_'+ $('.pop_box').length;
			
			$('body').append('\
				<div class="pop_box  pop_five" id="'+ id +'" style="z-index:'+ (++WindowPop.zIndex) +'">\
				  <div class="pop_content">\
					 <div class="nr">\
						 <img src="images/pop_robot.png"/>\
						'+ text +'\
						 '+ link +'\
					 </div>\
					'+ btn +'\
					 <div class="clear"></div>\
				  </div>\
				</div>\
			');
			
			
			this.e = $('#'+id);
			this.e.find('.text-word').css(this.op.text?this.op.text.style:'');
			this.e.find('.text-link').css(this.op.link?this.op.link.style:'');
			
			var me = this;
			
			if(me.op.btn){
				
				if(me.op.btn.length > 1){
					me.e.find('.btn-list').css('float','left');
				}
				
				for(var i=0;i<me.op.btn.length; i++){
					(function(i){
						me.op.btn[i].style.background?'':me.op.btn[i].style.background = '#f39c26';
						me.e.find('.btn-list').eq(i).css(me.op.btn[i].style).click(function(){
							me.op.btn[i].callback();	
						});
					})(i);
				}
			}
			
		}
		
	WindowPop.zIndex = 999;	
	WindowPop.prototype.maskShow = function(){
		$('.mask_box').show();
	}	
	
	WindowPop.prototype.maskHide = function(){
		$('.mask_box').hide();
	}	
	
		
	WindowPop.prototype.show = function(){
		this.maskShow();
		this.e.show();	
	}	
		
	WindowPop.prototype.hide = function(){
		this.maskHide();
		this.e.hide();	
	}		