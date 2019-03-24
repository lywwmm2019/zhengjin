// JavaScript Document

function ScrollImg(idname,opt){
		var obj=$.extend({
			type:'left',
			speed:5000,
			hasfoot:true,
			run:true
		},opt);
		var foot='';
		//var width=$('#'+idname+' li:first').width();
		var width=$(window).width();
		var height=$('#'+idname+' li:first').height()+20;
		var direction;
		var num=$('#'+idname+' li').length;
		var arr=[];
		var m=0,footnum=0,foothover=0;
		var str='';
		var _li=$('#'+idname+' li'),_ul=$('#'+idname+' ul');		
		var type=obj.type,otherType;
		var li_style=[];
		var linkUrl=[];
		
		
		//样式初始化
		$('#'+idname).css({'position':'relative','zoom':'1'});
		_ul.css({'clear':'both','overflow':'hidden','position':'relative','zoom':'1'});
		_li.css({'position':'absolute','width':width});	
		
		//根据方向初始化位置	
		if(type=='left'||type=='right'){
			direction=width;
			_ul.css({'width':width*num,'height':height});
			otherType='top';
			_li.css(otherType,'0');
			if(type=='right'){
				_ul.css({'left':0-width*num+width});
			}
		}	
		else if(type=='top'||type=='bottom'){
			direction=height;
			_ul.css({'width':width,'height':height*num});
			otherType='left';
			_li.css(otherType,'0');			
			if(type=='bottom'){
				_ul.css({'top':0-height*num+height});
			}
		}

		//初始化数据
		for(var i=0;i<num;i++){
			li_style.push(_li.eq(i).attr('style'));//push() 方法可向数组的末尾添加一个或多个元素，并返回新的长度;要想数组的开头添加一个或多个元素，请使用 unshift() 方法。	
			linkUrl.push(_li.eq(i).attr('onclick'));//attr() 方法设置或返回被选元素的属性值
			_li.eq(i).css(type,direction*i);
			arr.push(direction*i);
			if(obj.hasfoot){
				//footnum=i+1;
				//str=str+'<span>'+footnum+'</span>';
				str=str+'<div data_foot='+i+' class="point_white"></div>';
			}	
				
		}
		if(obj.hasfoot){
			//foot='<div class="mall_lb_foot clear over"><div class="fr">'+str+'</div><div class="clear over" style="*height:0;line-height:0;"></div></div>';
			foot='<div class="point pa" style="left:0;top:360px;">'+
					'<div class="point_main mauto" style="width:'+num*25+'px;">'+str+'</div>'+
				'</div>';
			$('#'+idname).after(foot);
			$('.point_main div:first').addClass('point_red').removeClass('point_white');
		}	
		
		
		//滚动
		function slide(){	
			var n=direction*num-direction;			
			var txt=$('#'+idname+' ul li:first').html();
			/*if(!txt){
				clearInterval(t);
			}*/
			var _liStyle=$('#'+idname+' ul li:first').attr('style');
			var _linkUrl=$('#'+idname+' ul li:first').attr('onclick');
			if(m>0){
				$('#'+idname+' li:first').remove();
				_ul.append('<li style=\''+_liStyle+'position:absolute;width:'+width+'px;'+otherType+':0;'+type+':'+n+'px\' onclick=\''+_linkUrl+'\'>'+txt+'</li>');
				arr.shift();
				arr.push(n);
			}		
			for(var i=0;i<num;i++){
				var temp=arr[i]-direction;	
				var scrollLi=$('#'+idname+' li').eq(i);
				if(type=='left'){
					scrollLi.animate({left:arr[i]-direction},1000);
				}	
				else if(type=='right'){
					scrollLi.animate({right:arr[i]-direction},1000);
				}	
				else if(type=='top'){
					scrollLi.animate({top:arr[i]-direction},1000);
				}
				else if(type=='bottom'){
					scrollLi.animate({bottom:arr[i]-direction},1000);
				}		
				$('#'+idname+' li').eq(i).animate({left:arr[i]-direction},1000);
				arr[i]=temp;
			}
			//console.log(temp);
			
			m++;
			foothover++;
			footnum=foothover%num;
			//footnum=footnum+1;
			$('.point_red').addClass('point_white').removeClass('point_red');
			$('.point_main div').eq(footnum).addClass('point_red').removeClass('point_white');
		}
		if(obj.run){
			var t=setInterval(slide,obj.speed);
		}
		
		
		//数字标签效果
		$('.point .point_main div').bind({'mouseover':function(e){
			e=e?e:window.e;
			/*if($(e.target).parents('.banner_parent').attr('id')!=idname){
				return;
			}*/
			$('.point_red').addClass('point_white').removeClass('point_red');
			$(this).addClass('point_red').removeClass('point_white');
			clearInterval(t);
			//var f=$(this).text();
			var f=$(this).attr('data_foot');
			var tempLi=$(this).parents('.point').siblings('#banner_img').find('ul');
			f=f-0;
			$(this).parents('.point').siblings('#banner_img').find('li').remove();
			for(var j=0;j<num;j++){
				//alert(li.eq(f).css('left'));	
				var tp=direction*j;							
				if(f+j>=num){
					_li.eq(f+j-num).css(type,direction*j);
					var li_txt=_li.eq(f+j-num).html();
					tempLi.append('<li style=\'position:absolute;width:'+width+'px;'+otherType+':0;'+type+':'+tp+'px;'+li_style[f+j-num]+'\' onclick=\''+linkUrl[f+j-num]+'\'>'+li_txt+'</li>');
				}
				else{
					_li.eq(f+j).css(type,direction*j);					
					var li_txt=_li.eq(f+j).html();
					tempLi.append('<li style=\'position:absolute;width:'+width+'px;'+otherType+':0;'+type+':'+tp+'px;'+li_style[f+j]+'\' onclick=\''+linkUrl[f+j]+'\'>'+li_txt+'</li>');
					//$('.'+classname+' ul').append(li.eq(f+j).html());
				}
				arr[j]=tp;
				m=0;
			}	
			foothover=f;		
		},'mouseout':function(e){
			e=e?e:window.e;
			/*if($(e.target).parents('.banner_parent').attr('id')!=idname){
				return;
			}*/
			t=setInterval(slide,obj.speed);
		}})
	}