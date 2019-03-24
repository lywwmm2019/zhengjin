// JavaScript Document

//$(function() {
	
	/********************************************************日K线******************************************************/
	var oldData;
	var oldData2;
	
	function KChart(num,index){
		var KUrl='/ForWeb/cmd3_'+num+'.txt';
		//$.getJSON(KUrl, function(data) {
		/*var d=new Date();
		//if(d.getUTCDay()==0||d.getUTCDay()==6){
			$('#container').html('今日休市，暂无数据！');
			$('#container2').html('今日休市，暂无数据！');
			$('#container').addClass('tc');
			$('#container2').addClass('tc');
			$('#K').hide();
			$('#Minute').hide();
			return;*/
		//}
		$.ajax({
			type:"GET",
			url:KUrl,
			dataType:"json",
			cache:false,
			success:function(data){
				var temp=0;
				var dataLength=data.length;
				
				if(oldData){
					/*for(var i=0;i<data.length;i++){
						if(oldData[i]['f3']!=data[i]['f3']){
							oldData[i]=data[i];
							temp=1;
						}
					}*/
					var oldDataLength=oldData.length;
					if(oldData[oldDataLength-1]['f3']!=data[dataLength-1]['f3']){
						oldData=data;
						temp=1;
					}
				}
				else{
					oldData=data;
					temp=1;
				}
				if(temp==1){
					getdata(data,index); 				
				}
			}
			
		});
	}/**/
	
	/********************************************************分时线******************************************************/
	function MinuteChart(num,index){
		var MinuteUrl='/ForWeb/cmd6.txt';
		
		
		var d=new Date();
		//if(d.getUTCDay()==0||d.getUTCDay()==6){
			/*$('#container').html('今日休市，暂无数据！');
			$('#container2').html('今日休市，暂无数据！');
			$('#container').addClass('tc');
			$('#container2').addClass('tc');
			$('#K').hide();
			$('#Minute').hide();
			return;*/
		//}
		//$.getJSON(MinuteUrl, function(data) {
		$.ajax({
			type:"GET",
			url:MinuteUrl,
			dataType:"json",
			cache:false,
			success:function(data){
				var temp2=0;
				var dataLength2=data.length;
				
				if(oldData2){
					/*for(var i=0;i<data.length;i++){
						if(oldData2[i]['f3']!=data[i]['f3']){
							oldData2[i]=data[i];
							temp2=1;
						}
					}*/
					var oldData2Length=oldData2.length;
					if(oldData2[oldData2Length-1]['f3']!=data[dataLength2-1]['f3']){
						oldData2=data;
						temp2=1;
					}
				}
				else{
					oldData2=data;
					temp2=1;
				}
				if(temp2==1){
					showChartK(data,index);
				}
			}
		});
	}/**/
	/********************************************************图表表格**********************************************************/
	function getTable(num,idname){
		var dataUrl='/ForWeb/cmd1.txt';
		/*$.getJSON(dataUrl, function(data) {
			showTable(num,data,idname); 
		})*/
		$.ajax({
			type:"GET",
			url:dataUrl,
			dataType:"json",
			cache:false,
			success:function(data){
				showTable(num,data,idname);
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				var txt=XMLHttpRequest.responseText; 
				txt=txt.replace('[','');
				txt=txt.replace(']','');
				var dataTxt=txt.split(',');
				var dataComplite=[];
				var datas=[];
					
				for(var i=0;i<dataTxt.length;i++){
					var temp=dataTxt[i].replace('{','');
					temp=temp.replace('}','');
					temp=temp.replace('"','');
					var temp2=temp.split(',');
					var arr1='';
					for(var j=0;j<temp2.length;j++){
						var temp3=temp2[j].split(':');
						temp3[0]=temp3[0].replace('"','');
						if(temp3[0]!='f1'){
							arr1=temp3[1];
						}
						else{
							arr1='';
						}
					}
					dataComplite.push(arr1);
					//
				}
				//dataComplite;
				var t1=dataComplite.length/13;
				var total=0;
				for(var a=0;a<t1;a++){
					var tt=13*a;
					total=dataComplite.length-tt;
					var tt2=[];
					for(var b=tt;b<tt+13;b++){
						tt2.push(dataComplite[b]);
					}
					datas.push(tt2);
				}
				
				showTable2(num,datas,idname);
				
				//alert(dataComplite);
				//alert(dataTxt);
			}
		});
	}
	
	/********************************************************图表表格填充(非IE)******************************************************/
	function showTable(num,tableData,idname){
		var l=tableData.length;
		var datas;
		var chartName='';
		var imgSrc='';
		
		
		for(var i=0;i<l;i++){
			if(num==tableData[i]['f13']){
				datas=tableData[i];				
			}
		}
		if(num=='1998005'){
			chartName='现货白银';
			imgSrc='ag';
		}
		else if(num=='1998006'){
			chartName='现货白银1000克';
			imgSrc='ag';
		}
		else if(num=='1998007'){
			chartName='现货白银30KG';
			imgSrc='ag';
		}
		else if(num=='1998001'){
			chartName='现货钯金';
			imgSrc='pd';
		}
		else if(num=='1998003'){
			chartName='现货镍';
			imgSrc='ni';
		}
		else if(num=='1998008'){
			chartName='现货铂金';
			imgSrc='pt';
		}
		else if(num=='1998010'){
			chartName='现货铜';
			imgSrc='cu';
		}
		else if(num=='1998012'){
			chartName='现货铝';
			imgSrc='al';
		}
		var str='<div class="over"><span class="name">'+chartName+'</span><img width="22" height="22" src="../images2014/'+imgSrc+'.png"></div>'+
                        '<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>收:<span class="" id="chartEnd">'+datas['f6']+'</span></td>'+
                            '<td>高:<span class="red" id="chartHigh">'+datas['f8']+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>开:<span class="green" id="chartOpen">'+datas['f7']+'</span></td>'+
                            '<td>低:<span class="green" id="chartLow">'+datas['f9']+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas['f3']+'</li>'+
                            '<li id="chartF">'+datas['f4']+'（'+datas['f5']+'%）</li>'+
                        '</ul>';
		
		
		var str2='<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>收:<span class="" id="chartEnd">'+datas['f6']+'</span></td>'+
                            '<td>高:<span class="red" id="chartHigh">'+datas['f8']+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>开:<span class="green" id="chartOpen">'+datas['f7']+'</span></td>'+
                            '<td>低:<span class="green" id="chartLow">'+datas['f9']+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas['f3']+'</li>'+
                            '<li id="chartF">'+datas['f4']+'（'+datas['f5']+'%）</li>'+
                        '</ul>';
		$('#chartTable').html(str);
		$('#'+idname+' .touziChart').html(str2);
		if(datas['f7']>=datas['f6']){
			$('#chartOpen').addClass('red').removeClass('green');
		}
		else{
			$('#chartOpen').addClass('green').removeClass('red');
		}
		if(datas['f3']>=datas['f6']){
			$('#chartNow').addClass('red').removeClass('green');
		}
		else{
			$('#chartNow').addClass('green').removeClass('red');
		}
	}
	
	
	
	/********************************************************图表表格填充(IE)******************************************************/
	function showTable2(num,tableData,idname){
		var l=tableData.length;
		var datas;
		var chartName='';
		var imgSrc='';
		
		
		for(var i=0;i<l;i++){
			var t1=num-0;
			var t2=tableData[i][12]-0;
			if(t1==t2){
				datas=tableData[i];				
			}
		}
		if(num=='1998005'){
			chartName='现货白银';
			imgSrc='ag';
		}
		else if(num=='1998006'){
			chartName='现货白银1000克';
			imgSrc='ag';
		}
		else if(num=='1998007'){
			chartName='现货白银30KG';
			imgSrc='ag';
		}
		else if(num=='1998001'){
			chartName='现货钯金';
			imgSrc='pd';
		}
		else if(num=='1998003'){
			chartName='现货镍';
			imgSrc='ni';
		}
		else if(num=='1998008'){
			chartName='现货铂金';
			imgSrc='pt';
		}
		else if(num=='1998010'){
			chartName='现货铜';
			imgSrc='cu';
		}
		else if(num=='1998012'){
			chartName='现货铝';
			imgSrc='al';
		}
		var str='<div class="over"><span class="name">'+chartName+'</span><img width="22" height="22" src="../images2014/'+imgSrc+'.png"></div>'+
                        '<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>收:<span class="" id="chartEnd">'+datas[5]+'</span></td>'+
                            '<td>高:<span class="red" id="chartHigh">'+datas[7]+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>开:<span class="green" id="chartOpen">'+datas[6]+'</span></td>'+
                            '<td>低:<span class="green" id="chartLow">'+datas[8]+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas[2]+'</li>'+
                            '<li id="chartF">'+datas[3]+'（'+datas[4]+'%）</li>'+
                        '</ul>';
		
		
		var str2='<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>收:<span class="" id="chartEnd">'+datas[5]+'</span></td>'+
                            '<td>高:<span class="red" id="chartHigh">'+datas[7]+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>开:<span class="green" id="chartOpen">'+datas[6]+'</span></td>'+
                            '<td>低:<span class="green" id="chartLow">'+datas[8]+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas[2]+'</li>'+
                            '<li id="chartF">'+datas[3]+'（'+datas[4]+'%）</li>'+
                        '</ul>';
		$('#chartTable').html(str);
		$('#'+idname+' .touziChart').html(str2);
		if(datas[6]>=datas[5]){
			$('#chartOpen').addClass('red').removeClass('green');
		}
		else{
			$('#chartOpen').addClass('green').removeClass('red');
		}
		if(datas[2]>=datas[5]){
			$('#chartNow').addClass('red').removeClass('green');
		}
		else{
			$('#chartNow').addClass('green').removeClass('red');
		}
	}
	
	/********************************************************日K线数据处理******************************************************/
	function getdata(data,index){
		// 初始化数组
		var ohlc = [],
			volume = [],
			da=[],
			five_line=[],
			ten_line=[],
			tw_line=[],
			line=[],
			mAcd=[],
			Dif=[],
			Dea=[],
			MAcd=[],
			M=[],
			tt1=[],
			tt2=[],
			tt3=[],
			close_array=[],
			column_red=[],
			column_green=[],
			dataLength = data.length;
			
		//EMA算法	
		function EMA(m,array){
			if (m == 0 || array.length==0)
			{
				return new Array();
			}
			var ema = new Array();
			ema.push(array[0]);
			for (var i=1;i<array.length;i++){
				var v = (array[i]*2+ema[i-1]*(m-1))/(m+1);
				ema.push(v);
			}
			return ema;
		}

		//i12, i26, i9 分别代表 12天，26天，9天
		//array是收盘价数组
		//MACD算法
		function MACD(array, i12, i26, i9) {
			var ema12 = EMA(i12,array);
			var ema26 = EMA(i26,array);
			var dif = [];
			for (var i = 0; i < ema12.length; i++) { dif.push(ema12[i] - ema26[i]); }
			var dea = EMA(i9,dif);
			var macd = [];
			//for (var i = 0; i < dea.length; i++) { macd.push(2*(dif[i] - dea[i])); }
			for (var i = 0; i < dea.length; i++) { macd.push((dif[i] - dea[i])); }
			return { macd: macd, dif: dif, dea: dea };
		}
			
		//将数据组装成highstock需要的格式
		for (i = 0; i < dataLength; i++) {
			var str=data[i]['f1'].toString();
			var year=str.substring(0,4);
			var month=str.substring(4,6);
			var day=str.substring(6,8);
			month=month-1;
			var utc=Date.UTC(year,month,day);
			ohlc.push([								//K线
				utc, // the date
				data[i]['f4'], // open
				data[i]['f5'], // high
				data[i]['f6'], // low
				data[i]['f7'] // close
			]);
			
			volume.push([							//成交量
				utc, // the date
				data[i]['f2'] // the volume
			])
			
			da.push([utc,data[i]['f9']]);			//涨幅 
			
			close_array.push(data[i]['f7']);
			
			M.push([utc,MACD(close_array,12,26,9)]);

			tt1=EMA(5,close_array);
			tt2=EMA(10,close_array);
			tt3=EMA(20,close_array);

		}
		
		//将MACD、DIF、DEA等指标组装成highstock需要的格式		
		for(var l=0;l<dataLength;l++){
			var temp=M[dataLength-1][1]['dif'][l]-M[dataLength-1][1]['dea'][l];			
			temp=temp.toFixed(2)-0;
			var temp1=temp>=0?temp:0;
			var temp2=temp<0?temp:0;
			mAcd.push([M[l][0],M[dataLength-1][1]['dif'][l].toFixed(2)-0]);
			Dif.push([M[l][0],M[dataLength-1][1]['dea'][l].toFixed(2)-0]);
			Dea.push([M[l][0],M[dataLength-1][1]['macd'][l].toFixed(2)-0]);
			five_line.push([M[l][0],Math.round(tt1[l])]);
			ten_line.push([M[l][0],Math.round(tt2[l])]);
			tw_line.push([M[l][0],Math.round(tt3[l])]);
			column_red.push([M[l][0],temp1]);
			column_green.push([M[l][0],temp2]);
		}
		
		MAcd.push(mAcd,Dif,Dea,column_red,column_green);
		line.push(five_line,ten_line,tw_line);
		// set the allowed units for data grouping
		

		// create the chart
		showchart(ohlc,da,line,MAcd,index);
	};
	
	/********************************************************分时线图表******************************************************/
	function showChartK(data,index){
		var date=new Date;
		var year=date.getFullYear();
		var month=date.getMonth()+1;
		var day=date.getDate();
		var data1=[],data2=[];
		var a=[],b=[];
		var tempTime=0;
		for(var i=0;i<data.length;i++){
			var time=data[i]['f2'].toString();
			var str=data[i]['f1'].toString();
			var year2=str.substring(0,4);
			var month2=str.substring(4,6);
			var day2=str.substring(6,8);
			month2=month2-1;
			var hour,minute;
			
			if(time.length>3){
				hour=time.substring(0,2);
				minute=time.substring(2,4);
			}
			else if(time.length==2){
				hour='0'; 
				minute=time.substring(0,2);
			}
			else if(time.length==1){
				hour='0';
				minute=time.substring(0,1);
				tempTime=i;
			}
			else{
				hour=time.substring(0,1);	
				minute=time.substring(1,3);			
			}
			if(tempTime!=0){
				day=day+1;
			}
			//var utc=Date.UTC(year,month,day,hour,minute);
			var utc=Date.UTC(year2,month2,day2,hour,minute);
			var temp1=[],temp2=[];
			temp1.push(utc,data[i]['f3']);
			data1.push(temp1);
		}
		//alert(data1);
		Highcharts.setOptions({
			lang: {
				rangeSelectorZoom: "范围"
			}
		});
		if(index){
			$('#container').highcharts('StockChart', {
				title : {
					text : '',
					style:{
						color:'#fff'
					}
				},
				navigator: {
					enabled: false
				},
				rangeSelector:{
					enabled:false
					
				},
				scrollbar:{
					enabled: false
				},
				tooltip:{
					/*animation:false,
					headerFormat: '',
					backgroundColor:'#fff',
					borderWidth:0,
					shadow:false,
					pointFormat: ' <span style="color:#f00">{series.name}</span>: <b>{point.y}</b>',
					positioner:function(){					
						return { x: 0, y: 0 };
					},*/
					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var hours=time.getUTCHours(),minute=time.getUTCMinutes();
					  tip += "时间："+hours+":"+minute+"<br/>";
					  tip += "价格："+this.y+"<br/>";
					  return tip;
					},
					crosshairs: [true, true]
				},			
				yAxis: [{ // Primary yAxis
					labels: {
						align:'left',
						x:-3,
						format: '{value}',
						style: {
							color: ['#f00']
						}
					},
					opposite:false
				}],
				
				series : [{
					name : '价格',
					type: 'line',
					data : data1,
					tooltip : {
						valueDecimals : 2
					}
				}]
			});
		}
		else{
			$('#container').highcharts('StockChart', {
				title : {
					text : '分时',
					style:{
						color:'#fff'
					}
				},
				rangeSelector:{
					inputEnabled:false,
					buttonTheme: { // styles for the buttons
						width:50					
					},
					selected : 1,
					buttons: [{
						type: 'minute',
						count: 30,
						text: '30分钟'
					}, {
						type: 'hour',
						count: 1,
						text: '1小时'
					}, {
						type: 'all',
						text: '分时'
					}]
				},
				tooltip:{
					//animation:false,
					headerFormat: '',
					//backgroundColor:'#00f',
					//borderWidth:0,
					//shadow:false,
					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var hours=time.getUTCHours(),minute=time.getUTCMinutes();
					  tip += "时间："+hours+":"+minute+"<br/>";
					  tip += "价格："+this.y+"<br/>";
					  return tip;
					},
					/*pointFormat: '<span style="color:#f00">时间：</span>: <b>{point.x}</b><span style="color:#f00">{series.name}</span>: <b>{point.y}</b>',
					positioner:function(){					
						return { x: 0, y: 0 };
					},*/
					crosshairs: [true, true]
				},			
				yAxis: [{ // Primary yAxis
					labels: {
						align:'left',
						x:-3,
						format: '{value}',
						style: {
							color: ['#f00']
						}
					},
					opposite:false
				}],
				
				series : [{
					name : '价格',
					type: 'line',
					data : data1,
					tooltip : {
						valueDecimals : 2
					}
				}]
			});
		}
	}
	
	
	/********************************************************日K线图表******************************************************/
	function showchart(ohlc,data,line,MAcd,index){
		Highcharts.setOptions({
			lang: {
				rangeSelectorZoom: "范围",
				months:['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
				shortMonths:['1','2','3','4','5','6','7','8','9','10','11','12']
			}
		});
		if(index){
			$('#container2').highcharts('StockChart', {
				title: {
					text: ''
				},	
				navigator: {
					enabled: false
				},
				plotOptions:{
					candlestick:{
						color:'#0f0',
						upColor:'#f00'
					},
					spline:{
						//enableMouseTracking:false
						states:{
							hover:{
								halo:{
									size: 1
								}
							}
						},
						lineWidth: 1
					},
					column:{
						color:'#0f0'
					}
					
				},
				tooltip:{
					headerFormat: '',
					borderColor:'#00f',
					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var year=time.getUTCFullYear(),month=time.getUTCMonth()+1,day=time.getUTCDate();
					  tip += "日期："+year+"年"+month+"月"+day+"日"+"<br/>";
					  tip += "开盘："+this.points[0].point.open+"<br/>";
					  tip += "高开："+this.points[0].point.high+"<br/>";
					  tip += "低开："+this.points[0].point.low+"<br/>";
					  tip += "收盘："+this.points[0].point.close+"<br/>";
					  return tip;
					}
				},
				rangeSelector : {
					enabled: false
				},
				scrollbar:{
					enabled: false
				},
				xAxis: {
					type: 'datetime',
					dateTimeLabelFormats: {
						second: '%Y-%m-%d<br/>%H:%M:%S',
						minute: '%Y-%m-%d<br/>%H:%M',
						hour: '%Y-%m-%d<br/>%H:%M',
						day: '%Y<br/>%m-%d',
						week: '%Y<br/>%m-%d',
						month: '%Y-%m',
						year: '%Y'
					}
				},
				yAxis: [{
					labels: {
						align: 'right',
						x: -3
					},
					title: {
						text: ''
					},
					offset: 0,
					lineWidth: 1,
					gridLineWidth:0
				},{
					labels: {
						enabled:false
					},
					title: {
						text: ''
					},
					color:'none',
					offset: 0,
					lineWidth: 1
				}],
				
				series: [{
					type: 'candlestick',
					name: '日线',
					data: ohlc
				}, {
					type: 'spline',
					name: 'increase',
					color:'none',
					data: data,
					yAxis: 1
				}, {
					type: 'spline',
					name: 'five',
					color:'#000',
					data: line[0]
				}, {
					type: 'spline',
					name: 'ten',
					color:'#2400ff',
					data: line[1]
				}, {
					type: 'spline',
					name: 'twenty',
					color:'#ff00ff',
					data: line[2]
				}]
			});
		}
		else{
			$('#container2').highcharts('StockChart', {
				title: {
					text: '日线'
				},	
				plotOptions:{
					candlestick:{
						color:'#0f0',
						upColor:'#f00'
					},
					spline:{
						//enableMouseTracking:false
						states:{
							hover:{
								halo:{
									size: 1
								}
							}
						},
						lineWidth: 1
					},
					column:{
						color:'#0f0'
					}
					
				},
				tooltip:{
					headerFormat: '',
					borderColor:'#00f',
					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var year=time.getUTCFullYear(),month=time.getUTCMonth()+1,day=time.getUTCDate();
					  tip = '<b>'+this.points[0].series.name+"</b><br/>";
					  tip += "日期："+year+"年"+month+"月"+day+"日"+"<br/>";
					  tip += "开盘："+this.points[0].point.open+"<br/>";
					  tip += "高开："+this.points[0].point.high+"<br/>";
					  tip += "低开："+this.points[0].point.low+"<br/>";
					  tip += "收盘："+this.points[0].point.close+"<br/>";				  
					  tip += "涨幅："+this.points[1].y+"%<br/>";
					  tip += "5MA："+this.points[2].y+"<br/>";
					  tip += "10MA："+this.points[3].y+"<br/>";
					  tip += "20MA："+this.points[4].y+"<br/>";				  
					  /*tip += "MACD："+this.points[5].y+"<br/>";
					  tip += "Dif："+this.points[6].y+"<br/>";
					  tip += "Dea："+this.points[7].y+"<br/>";*/
					  return tip;
					}
				},
				rangeSelector : {
					inputEnabled: false,
					selected: 1,
					buttonTheme: { // styles for the buttons
						width:40					
					},
					buttons: [{
						type: 'month',
						count: 1,
						text: '1个月'
					}, {
						type: 'month',
						count: 3,
						text: '3个月'
					}, {
						type: 'month',
						count: 6,
						text: '6个月'
					}, {
						type: 'year',
						count: 1,
						text: '1年'
					}, {
						type: 'all',
						text: '全部'
					}],
					inputEnabled: false, // it supports only days
					selected : 1 // all
				},
				xAxis: {
					type: 'datetime',
					dateTimeLabelFormats: {
						second: '%Y-%m-%d<br/>%H:%M:%S',
						minute: '%Y-%m-%d<br/>%H:%M',
						hour: '%Y-%m-%d<br/>%H:%M',
						day: '%Y<br/>%m-%d',
						week: '%Y<br/>%m-%d',
						month: '%Y-%m',
						year: '%Y'
					}
				},
				yAxis: [{
					labels: {
						align: 'right',
						x: -3
					},
					title: {
						text: ''
					},
					//height: '62%',
					offset: 0,
					lineWidth: 1,
					gridLineWidth:0
				},/*{
					labels: {
						enabled:false
					},
					title: {
						text: ''
					},
					top: '65%',
					height: '35%',
					offset: 0,
					lineWidth: 1
				},{
					labels: {
						enabled:false
					},
					title: {
						text: ''
					},
					top: '65%',
					height: '35%',
					offset: 0,
					lineWidth: 1
				},*/ {
					labels: {
						enabled:false
					},
					title: {
						text: ''
					},
					//height: '65%',
					color:'none',
					offset: 0,
					lineWidth: 1
				}],
				
				series: [{
					type: 'candlestick',
					name: '日线',
					data: ohlc
				}, {
					type: 'spline',
					name: 'increase',
					color:'none',
					data: data,
					//yAxis: 3
					yAxis: 1
				},{
					type: 'spline',
					name: 'five',
					color:'#000',
					data: line[0]
				}, {
					type: 'spline',
					name: 'ten',
					color:'#2400ff',
					data: line[1]
				}, {
					type: 'spline',
					name: 'twenty',
					color:'#ff00ff',
					data: line[2]
				}/*, {
					type: 'spline',
					name: 'MACD',
					data: MAcd[0],
					color:'none',
					yAxis: 1
				}, {
					type: 'spline',
					name: 'DIF',
					color:'#f0f',
					data: MAcd[1],
					yAxis: 1
				}, {
					type: 'spline',
					name: 'DEA',
					color:'#0ff',
					data: MAcd[2],
					yAxis: 1
				}, {
					type: 'column',
					name: 'macd',				
					color:'#f00',
					data: MAcd[3],
					yAxis: 2
				}, {
					type: 'column',
					name: 'macd',				
					color:'#0f0',
					data: MAcd[4],
					yAxis: 2
				}*/]
			});
		}
	}
	
//});