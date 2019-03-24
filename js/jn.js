// JavaScript Document
$(document).ready(function(){
	var start=new StartV();
});


var num=0;

StartV=Backbone.View.extend({
	tagName:'div',
	el:'#main',
	template:_.template($('#template-Index').html()),
	//template:_.template($('#template-Page_4').html()),
	initialize:function(args){
		num=0;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		$(this.el).html(this.template);
		$('#page_index').unbind('click').bind('click',function(){
			var pagefoot=new PagefootV();
			var pageml=new PagemlV();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

PagefootV=Backbone.View.extend({
	tagName:'div',
	el:'#main',
	template:_.template($('#template-Page_main').html()),
	initialize:function(args){
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		$('.tz_ml').unbind('click').bind('click',function(){
			var pageml=new PagemlV();
			
		});
		$('.tz_fd').unbind('click').bind('click',function(){
			var page8=new Page8V();
		});
		$('.tz_fm').unbind('click').bind('click',function(){
			var start=new StartV();
		});
		$('.tz_ty').unbind('click').bind('click',function(){
			var text=$('.tz_sr').val();
			pageRun(text,0);
		});
		$('.tz_sy').unbind('click').bind('click',function(){
			pageRun(num-1,1);
		});
		$('.tz_xy').unbind('click').bind('click',function(){
			pageRun(num+1,1);
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page1V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_1').html()),
	initialize:function(args){
		num=2;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').unbind('click').bind('click',function(){
			var pageml=new PagemlV();
			
		});
		$('.right').unbind('click').bind('click',function(){
			var page2=new Page2V();
		});
		
	},
	load_dateOptions:function(){
		this.render();
	}
})

PagemlV=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_ml').html()),
	initialize:function(args){
		num=1;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		//duma.BeautifyScrollBar.init();
		$('.left').unbind('click').bind('click',function(){
			var start=new StartV();
			
		});
		$('.right').unbind('click').bind('click',function(){
			var page1=new Page1V();
		});
		$('#link_jsy').unbind('click').bind('click',function(){
			var page1=new Page1V();
		});
		$('#link_jrcl').unbind('click').bind('click',function(){
			var page2=new Page2V();
		});
		$('#link_cfgs').unbind('click').bind('click',function(){
			var page7=new Page7V();
		});
		$('#link_etf').unbind('click').bind('click',function(){
			var page4=new Page4V();
		});
		$('#link_jsjx').unbind('click').bind('click',function(){
			var page5=new Page5V();
		});
		$('#link_rdjj').unbind('click').bind('click',function(){
			var page3=new Page3V();
		});
		$('#link_mjsd').unbind('click').bind('click',function(){
			var page6=new Page6V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page2V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_2').html()),
	initialize:function(args){
		num=3;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page1=new Page1V();
			
		});
		$('.right').bind('click',function(){
			var page3=new Page3V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page3V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_3').html()),
	initialize:function(args){
		num=4;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page2=new Page2V();
			
		});
		$('.right').bind('click',function(){
			var page4=new Page4V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page4V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_4').html()),
	initialize:function(args){
		num=5;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page3=new Page3V();
			
		});
		$('.right').bind('click',function(){
			var page5=new Page5V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page5V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_5').html()),
	initialize:function(args){
		num=6;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page4=new Page4V();
			
		});
		$('.right').bind('click',function(){
			var page6=new Page6V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page6V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_6').html()),
	initialize:function(args){
		num=7;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page5=new Page5V();
			
		});
		$('.right').bind('click',function(){
			var page7=new Page7V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page7V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_7').html()),
	initialize:function(args){
		num=8;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		getinfo();
		//pageScroll();
		$('.left').bind('click',function(){
			var page6=new Page6V();
			
		});
		$('.right').bind('click',function(){
			var page8=new Page8V();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

Page8V=Backbone.View.extend({
	tagName:'div',
	el:'#page_main',
	template:_.template($('#template-Page_8').html()),
	initialize:function(args){
		num=9;
		$(this.el).html('');
		_.bindAll(this, "render", "load_dateOptions");
		this.load_dateOptions();
	},
	render:function(){
		//$('#waiting').remove();
		$(this.el).html(this.template);
		pageScroll();
		//getinfo();
		$('.left').bind('click',function(){
			var page7=new Page7V();
			
		});
		$('.right').bind('click',function(){
			var start=new StartV();
		});
	},
	load_dateOptions:function(){
		this.render();
	}
})

var content_data=[];
var content_num=[];

function pageScroll(num){
	var height1=$('.etf_main').height();
	var height2=$('.jsy_maintxt').height();
	if(height1>500){
		$('.etf_main').css('height','500px');
		duma.BeautifyScrollBar.init();
	}
	else{
		$('.etf_main').css({'overflow-y':'auto','height':'500px'});
	};
	if(height2>420){
		$('.jsy_maintxt').css('height','420px');
		duma.BeautifyScrollBar.init();
	}
	/*if(num==1){
		$('.etf_main').css('height','500px');
		duma.BeautifyScrollBar.init();
	}*/
}


function pageRun(str,pagetag){
	if(str==1){
		var pageml=new PagemlV();
	}
	else if(str==2){
		var page1=new Page1V();
	}
	else if(str==3){
		var page2=new Page2V();
	}
	else if(str==4){
		var page3=new Page3V();
	}
	else if(str==5){
		var page4=new Page4V();
	}
	else if(str==6){
		var page5=new Page5V();
	}
	else if(str==7){
		var page6=new Page6V();
	}
	else if(str==8){
		var page7=new Page7V();
	}
	else if(str==9){
		var page8=new Page8V();
	};
	if(pagetag==1){
		if(str==0){
			var start=new StartV();
		}
		else if(str==10){
			var start=new StartV();
		}
	}
}



function success_jsonpCallback(data) {
	//console.log(data);
	var datas=data.data;
	var content=datas.content;
	content=content.replace(/style/g, "");
	content_data.push(content);
	$('.dumascroll p').html(content);
	if(content.indexOf('IMG')!=-1){
		pageScroll(1);
	}
	else{
		pageScroll(0);
	}
}
function getinfo(){
	var data_value=$('.dumascroll').attr('data_value');
	var len=content_num.length;
	//var data_value="15,694,706";
	if(!data_value){
		data_value='';
	}
	var temp=data_value.split(",");
	var newsid=temp[0]+temp[1]+temp[2];
	for(var i=0;i<len;i++){
		if(newsid==content_num[i]){
			$('.dumascroll p').html(content_data[i]);
			pageScroll();					
			return;
		}
	}
	content_num.push(newsid);
	//var newsid=15694706;
	//$.getScript("http://tg.zhengjin99.com/zhengjin/outdata/getjrjcmscontentxml.jsp?iiid="+newsid+"&encode=utf-8&callbackparam=success_jsonpCallback");
	$.ajax({
		dataType:'script',
		scriptCharset:'gbk',////////
		url:'http://tg.zhengjin99.com/zhengjin/outdata/getjrjcmscontentxml.jsp',
		data:'iiid='+newsid+'&callbackparam=success_jsonpCallback',
		success:function(){
			
		}
	})
};

