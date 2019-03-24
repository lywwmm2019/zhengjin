//个人中心-我的收藏
//收藏文章
function addFavorite(){
	var url = "http://www.zhengjin99.com/2014/04/03085816978434.shtml";
	var title = "04.03早评：ADP数据瑕不掩瑜 白银反弹依旧受到压制";
	var model = "每日评论";
	$.post("favorite_sub_ajax.jsp",
			{model:model,title : title, url:url},
		function(data){
			alert(data.msg);
		}
	);
}
