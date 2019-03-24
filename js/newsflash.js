
	$(function() {
		var dataHost = 'http://wx.zhengjin99.com';
		var news_data = '<p class="yjzx_index_news pr index_title">¿ìÑ¶¿ìµÝ</p>';
		$.ajax({
			dataType:'script',
			scriptCharset:'utf-8',
			url:dataHost + '/data/juling/news/list.json',
			success:function(){
				news_data += '<ul>';
				for ( var i = 0; i < 5 && i < news.length; i++) {
					news_data += '<li><span class="time">';
					news_data += news[i]['DECLAREDATE'].substr(11);
					news_data += '</span><span>';
					news_data += news[i]['TITLE'];
					news_data += '</span></li>';
				}
				news_data += '</ul>';
				$('#news_data').html(news_data);
			}
		});
	});
