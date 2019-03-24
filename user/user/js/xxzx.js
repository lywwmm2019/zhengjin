//个人中心-信息中心

function setMailTab(n,t){
	for(var i=1;i<=t;i++){
		if(n == i){
			$('#mail_'+i).addClass("li_select");
			$('#tab_mail_'+i).show();
		}else{
			$('#mail_'+i).removeClass("li_select");
			$('#tab_mail_'+i).hide();
		}
	}
	refreshNRnum(n);
}

//删除信息
function delMail(id){
	var mid = getDelIds(id);
	if(mid == "")
		return alert("请选要删除的选项!");
	if(confirm("您确定要删除吗？")){
		$.post("mail_del.jsp",{mid : mid, type:id},function(data){
				alert("删除成功!");
				getData(id, 1);
			}
		);
	}
	
}

function getDelIds(id){
	var ids = "";
	$("input[name='mail_"+id+"_check']").each(function(){
		if($(this).attr("checked") == true){
			if(ids == "")
				ids = $(this).val();
			else
				ids += "," + $(this).val();
		}
	}); 
	return ids;
}

function checkAll(id, obj){
	if(!obj)
		return false;
	if(obj.checked == true){
		checkedAll(id, true);
	}else{
		checkedAll(id, false);
	}
		
}

function checkedAll(id, checked){
	$("input[name='mail_"+id+"_check']").each(function(){
		$(this).attr("checked",checked);
	}); 
}

function up(type, num, total){
	if(num > 1)
		getData(type, num-1);
}

function next(type, num, total){
	if(num < total)
		getData(type, num+1);
}

function toPage(type, num, total){
	if(num > 0 && num <= total)
		getData(type, num);
}

function getData(type, num){
	$.post("xxzx_ajax.jsp",{id:type,
		num : num},function(data){
			$("#tab_mail_"+type).html(data);
		}
	);
	refreshNRnum(type);
}

function refreshNRnum(type){
	$.getScript("mail_ajax.jsp?id="+type, function() {
			if(type == 0){
				if(json.nrnum>0)
					$("#xxzx").html("（"+json.nrnum+"）");
				else
					$("#xxzx").html("");
			}else{
				if(json.nrnum>0)
					$("#nr_"+type).html("（"+json.nrnum+"）");
				else
					$("#nr_"+type).html("");
			}
		}
	);
}
function getMailContent(type, mid, isDeal){
	$("#right_list").hide();
	$("#right_content").show();
	$.post("mail_content.jsp",{id:type,
		mid : mid,isDeal:isDeal},function(data){
			$("#right_content").html(data);
			refreshNRnum(0);
		}
	);
	
}

function content2BackList(n, t){
	$("#right_list").show();
	$("#right_content").hide();
	setMailTab(n,t);
}

function backMailList(type, num){
	getData(type, num);
	$("#right_list").show();
	$("#right_content").hide();
}

function direct(url){
	 window.location.href=url;
}
