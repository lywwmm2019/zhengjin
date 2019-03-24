	$(document).ready(function() {
		$('ul.yjzx_research').bind({
			'mouseleave':function(){
			$('ul.yjzx_research li:first').find('.time').hide();
			$('ul.yjzx_research li:first').addClass('first');
			$('ul.yjzx_research li:first').find('.yjzx_tj_list').show();
		}})
		
		$('ul.yjzx_research li').bind({
			'mouseenter':function(){
				$(this).find('.time').hide();
				$(this).find('.yjzx_tj_list').show();
				$(this).siblings().removeClass('first');
				$(this).addClass('first');
				$(this).siblings().find('.yjzx_tj_list').hide();
				$(this).siblings().find('.time').show();
				
			},'mouseleave':function(){
				$(this).find('.time').show();
				$(this).find('.yjzx_tj_list').hide();
				$(this).removeClass('first');
			}
		})
		
		$('ul#tagswx li').bind('click',function(){
			var num=$(this).index();
			$(this).removeClass('grey2');
			$(this).siblings().addClass('grey2');
			$('.wx_div').hide();
			$('#tagContentwx'+num).show();
		})
	})
