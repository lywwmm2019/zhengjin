//user center public js

function tozstq(){
	var vipType = getCookie("VIPTypeID");
	if(vipType != null && vipType != ""){
		var url = window.location.href;
		var pageName = "zstq_"+vipType + ".jsp";
		if(url.indexOf(pageName, 0) == -1){
			window.location.href = pageName;	
		}
	}
}
//升级
function update(flag, up){
	$.post("user_update.jsp",{type:1, up: up},function(data){
		if(flag == 1){
			if(data.state == 0)
				alert("您的申请已经提交至客户代表，稍后客户代表将和您联系！请您耐心等候!");
			if(data.state == 1)
				alert("已成功提交，无需重复!");
		}
		
		if(data.state == -1)
			alert("你未登录，请先登录!");
		
	},"json");
}

var mobileRES = /^(((1[3,7,8][0-9]{1})|159|158|151|152|153|154|155|156|157|150|147)+\d{8})$/;