// JavaScript Document
 
/***
		火线行情专用 
***/


//$(function() {
	
var Price=function(){
	var oldData;
	var oldDataSZ,oldDataSC;
	var oldData2;
	var oldData2G;
	var oldnum;
	var oldnum2;
	var yesterday;
	var day;
	var newData;
	var dataK1=0,dataK2=0;
	var lastTime=0;
}
	
	
	
	/********************************************************日K线******************************************************/
Price.prototype={
	
	 KChart:function(num,index){
		//var KUrl='/ForWeb/cmd3_'+num+'.txt';
		var that=this;
		
		
		
		if(num==399001){
			var KUrl="http://flashdata2.jrj.com.cn/history/js/index/399001/day.js";
		}
		else if(num==000001){
			var KUrl="http://flashdata2.jrj.com.cn/history/js/index/000001/day.js";
		}
		else{			
			var KUrl="http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=4&code="+num+"&type=1&date=&time=&offset=";
		}
		
		if(that.dataK1==1&&num==000001){
			var datas=that.changeDataK(that.oldDataSZ);
			that.getdata(datas,1);
			return;
		}else if(that.dataK2==1&&num==399001){
			var datas=that.changeDataK(that.oldDataSC);
			that.getdata(datas,1);
			return;
		}
		
		
		
		$.getScript(KUrl, function() {
			if(num==000001||num==399001){
				var data,datasTable;
				var idName;
				if(num==000001){
					data=i_d_000001;
					that.oldDataSZ=i_d_000001;
					idName="shangzheng";
					that.dataK1=1;
				}
				else{
					data=i_d_399001;
					that.oldDataSC=i_d_399001;
					idName="shencheng";
					that.dataK2=1;
				}
				
				var datas=that.changeDataK(data);
				that.getdata(datas,1);
			}
			else{
				
				var data=b;
				var temp=0;
				var dataLength=data.d.d.length;
				
				if(that.oldData){
					var oldDataLength=that.oldData.d.d.length;
					if(that.oldData.d.d[oldDataLength-1]['n']!=data.d.d[dataLength-1]['n']){
						that.oldData=data;
						temp=1;
					}
					else{
						temp=2;
					}
				}
				else{
					that.oldData=data;
					temp=1;
				};
				if(that.oldnum&&that.oldnum!=num){
					that.getdata(data);
					that.oldnum=num;
					return;
				}
				else{
					that.oldnum=num;
				}
				if(temp==1||index==5){
					that.getdata(data); 				
				}
				else{
					return;
				}
			//}
			}
			
		});
	},/**/
	
	/********************************************************分时线******************************************************/
	MinuteChart:function(num,index){
		var that=this;
		
		
		
		
		if(num==399001){
			var MinuteUrl="http://flashdata2.jrj.com.cn/today/js/index/399001.js";
		}
		else if(num==000001){
			var MinuteUrl="http://flashdata2.jrj.com.cn/today/js/index/000001.js";
		}
		else{			
			var MinuteUrl="http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=3&code="+num+"&date=&time=&offset=";
		}
		
		//
		$.getScript(MinuteUrl, function() {
			if(num==000001||num==399001){
				var data,datasTable;
				var idName;
				if(num==000001){
					data=Min_000001;
					idName="shangzheng";
				}
				else{
					data=Min_399001;
					idName="shencheng";
				}
				var datas;
				var temp2=0;
				var dataLength2=data.Data.length;
				that.newData=data.Data[dataLength2-1][1];
				that.yesterday=data.Summary.A2;
				that.lastTime=data.Data[dataLength2-1][0];
				
				if(that.oldData2G&&that.oldData2G.Data){
					var oldData2Length=that.oldData2G.Data.length;
					if(that.oldData2G.Data[oldData2Length-1][0]!=data.Data[dataLength2-1][0]){
						that.oldData2G=data;
						temp2=1;
					}
					else if(that.oldData2G.Data[oldData2Length-1][1]!=data.Data[dataLength2-1][1]){
						that.oldData2G=data;
						temp2=1;
					}
					else{
						temp2=2;
					}
				}
				else{
					that.oldData2G=data;
					temp2=1;
				};
				if(that.oldnum2&&that.oldnum2!=num){
					temp2=1;
				}
				else{
					temp2=2;
				}
				that.oldnum2=num;
				if(temp2==1){
					datas=that.changeDataMin(that.oldData2G);
					datasTable=that.changeDataTable(that.oldData2G,num);
					that.showChartK(datas,1);
					that.showTable(num,datasTable,idName);
				}
				else{
					return;
				}
			}		
			else{
				
				var data=b;
				var temp2=0;
				var dataLength2=data.d[0].d.length;
				that.day=data.d[0].d[0].d;
				
				if(that.oldData2){
					var oldData2Length=that.oldData2.d[0].d.length;
					if(that.oldData2.d[0].d[oldData2Length-1]['t']!=data.d[0].d[dataLength2-1]['t']){
						that.oldData2=data;
						temp2=1;
					}
					else if(that.oldData2.d[0].d[oldData2Length-1]['n']!=data.d[0].d[dataLength2-1]['n']){
						that.oldData2=data;
						temp2=1;
					}
					else{
						temp2=2;
					}
				}
				else{
					that.oldData2=data;
					temp2=1;
				};
				if(that.oldnum2&&that.oldnum2!=num){
					that.showChartK(data,index);
					that.oldnum2=num;
					return;
				}
				else{
					that.oldnum2=num;
				};
				if(temp2==1){
					that.showChartK(data,index);
				}
				else{
					return;
				}
			}
			 
			//}
		});
	},/**/
	
	/*****************************************************股指数据重新组装（分时）******************************************************/
	changeDataMin:function(data){
		var t1=[],t2=[],t3=[];
		for(var i=0;i<data.Data.length;i++){
			t1.push({"t":data.Data[i][0],"d":this.day,"n":data.Data[i][1].toFixed(2)-0,"a":data.Data[i][2]});
		}
		t2.push({"t":this.day,"y":this.yesterday,"d":t1});
		t3.push({"s":0,"e":"ok","d":t2});
		
		return t3[0];
		//alert(Datas[0]['t']);
	},
	
	/*****************************************************股指数据重新组装（日K）******************************************************/
	changeDataK:function(data){
		var t1=[],t2=[],t3=[];
		for(var i=0;i<data.rows.length;i++){
			var u=data.rows[i][2]-data.rows[i][7];
			u=u.toFixed(2)-0;
			t1.push({"d":data.rows[i][0],"t":0,"n":data.rows[i][2].toFixed(2)-0,"o":data.rows[i][1],"h":data.rows[i][3],"l":data.rows[i][4],"u":u,"a":data.rows[i][5],"e":data.rows[i][6]});
		}
		t2.push({"y":0,"d":t1});
		t3.push({"s":0,"e":"ok","d":t2[0]});
		
		return t3[0];
		//alert(Datas[0]['t']);
	},
	
	/*****************************************************股指数据重新组装（表格）******************************************************/
	changeDataTable:function(data,num){
		var t1=[],t2=[],t3=[],t4=[];
		var length=data.Data.length;
		var u=data.Data[length-1][1]-this.yesterday;
		u=u.toFixed(2)-0;
		var n=data.Data[length-1][1].toFixed(2)-0;
		t1.push({"u":u,"d":this.day,"t":data.Data[length-1][0],"s":0,"b":0,"a":num,"n":n,"o":data.Data[0][1],"l":data.Summary.A4,"h":data.Summary.A3,"y":this.yesterday});
		t2.push({"c":0,"d":t1});
		t3.push({"s":0,"e":"ok","d":t2});
		
		return t3[0];
		//alert(Datas[0]['t']);
	},
	
	
	
	
	/********************************************************图表表格**********************************************************/
	getTable:function(num,idname){
		//var dataUrl='/ForWeb/cmd1.txt';
		var that=this;
		
		$.getScript("http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=5", function() {
				var data=b;
				that.showTable(num,data,idname);
			});
		
	},
	
	/********************************************************图表表格填充(非IE)******************************************************/
	showTable:function(num,tableData,idname){
		
		var l=tableData.length;
		var datas;
		var chartName='';
		var imgSrc='';
		
		for(var j=0;j<tableData.d.length;j++){
			for(var i=0;i<tableData.d[j].d.length;i++){
				//if(num==tableData[i]['f13']){
				if(num==tableData.d[j].d[i].a){
					datas=tableData.d[j].d[i];				
				}
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
		else if(num=='1991001'){
			chartName='大圆银10kg';
			imgSrc='ag';
		}
		else if(num=='1991002'){
			chartName='大圆银100kg';
			imgSrc='ag';
		}
		else if(num=='1991003'){
			chartName='大圆银50kg';
			imgSrc='ag';
		}
		var zd=datas.u/datas.y*100;
		var str2=
						'<ul style="right:5px;bottom:10px;" class="tc">'+
                            '<li class="f28" id="chartNow">'+datas['n']+'</li>'+
                            '<li id="chartF">'+datas['u']+'（'+zd.toFixed(2)+'%）</li>'+
                        '</ul>';
		$('#'+idname+' .touziChart').html(str2);
		if(datas['o']>=datas['y']){
			$('#chartOpen').addClass('red').removeClass('green');
		}
		else{
			$('#chartOpen').addClass('green').removeClass('red');
		}
		if(datas['n']>=datas['y']){
			$('#chartNow').addClass('red').removeClass('green');
		}
		else{
			$('#chartNow').addClass('green').removeClass('red');
		}
	},
	
	
	
	
	
	/********************************************************日K线数据处理******************************************************/
	getdata:function(data,index){
		var that=this;
		
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
			GPL=[],
			GPE=[],
			close_array=[],
			column_red=[],
			column_green=[],
			dataLength = data.d.d.length;
			
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
			var str=data.d.d[i]['d'].toString();
			var year=str.substring(0,4);
			var month=str.substring(4,6);
			var day=str.substring(6,8);
			month=month-1;
			var utc=Date.UTC(year,month,day);
			ohlc.push([								//K线
				utc, // the date

				data.d.d[i]['o'],
				data.d.d[i]['h'],
				data.d.d[i]['l'],
				data.d.d[i]['n']
			]);
			
			GPL.push([							//成交量
				utc, // the date
				//data[i]['f2'] // the volume
				data.d.d[i]['a']
			])
			GPE.push([							//成交额
				utc, // the date
				//data[i]['f2'] // the volume
				data.d.d[i]['e']
			])
			
			//da.push([utc,data[i]['f9']]);			//涨幅 
			var temp_da=data.d.d[i]['u']/data.d.d[i]['y']*100;
			da.push([utc,data.d.d[i]['u']]);	
			
			//close_array.push(data[i]['f7']);
			close_array.push(data.d.d[i]['n']);
			
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
		that.showchart(ohlc,da,line,MAcd,index,GPL,GPE);
	},
	
	/********************************************************分时线图表******************************************************/
	showChartK:function(datas,index){
		
		var data=datas.d[0].d;
		var date=new Date;
		var year=date.getFullYear();
		var month=date.getMonth()+1;
		var day=date.getDate();
		var data1=[],data2=[];
		var a=[],b=[];
		var tempTime=0;
		for(var i=0;i<data.length;i++){
			
			year=data[i].d.toString().substring(0,4);
			month=data[i].d.toString().substring(4,6);
			day=data[i].d.toString().substring(6,8);
			if(data[i].t<100){
				hour='0';
				minute=data[i].t;
			}
			else if(data[i].t<1000&&data[i].t>=100){
				hour='0'+data[i].t.toString().substring(0,1);
				minute=data[i].t.toString().substring(1,3);
			}
			else{
				hour=data[i].t.toString().substring(0,2);
				minute=data[i].t.toString().substring(2,4);
			}
			//hour=data[i].t.toString().length==3?data[i].t.toString().substring(0,1):data[i].t.toString().substring(0,2);
			//minute=data[i].t.toString().length==3?data[i].t.toString().substring(1,3):data[i].t.toString().substring(2,4);
			var utc=Date.UTC(year,month,day,hour,minute);
			//var utc=Date.UTC(year2,month2,day2,hour,minute);
			var temp1=[],temp2=[];
			temp1.push(utc,data[i].n);
			temp2.push(utc,data[i].a);
			data1.push(temp1);
			data2.push(temp2);
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
				scrollbar:{
					enabled:false
					
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
					  tip += "成交量："+this.points[1].y+"<br/>";
					  
					  return tip;
					},
					/*pointFormat: '<span style="color:#f00">时间：</span>: <b>{point.x}</b><span style="color:#f00">{series.name}</span>: <b>{point.y}</b>',
					positioner:function(){					
						return { x: 0, y: 0 };
					},*/
					crosshairs: [true, true]
				},			
				yAxis: [{
					labels: {
						align:'left',
						x:-3,
						format: '{value}',
						style: {
							color: ['#f00']
						}
					},
					opposite:false
				},{
					labels: {
						enabled:false,
						align:'left',
						x:-3,
						format: '{value}',
						style: {
							color: ['#f00']
						}
					},
					title: {
						text: ''
					},
					opposite:false,
					color:'none'
				}],
				
				series : [{
					name : '价格',
					type: 'line',
					data : data1,
					tooltip : {
						valueDecimals : 2
					}
				},{
					name : '成交量',
					type : 'column',
					data : data2,
					color:'none',
					yAxis: 1,
					tooltip : {
						valueDecimals : 2
					}
				}]
			});
		}
		else{
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
				scrollbar:{
					enabled:false
					
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
	},
	
	
	/********************************************************日K线图表******************************************************/
	showchart:function(ohlc,data,line,MAcd,index,GPL,GPE){
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
				scrollbar:{
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
					  tip = '<b>'+this.points[0].series.name+"</b><br/>";
					  tip += "日期："+year+"年"+month+"月"+day+"日"+"<br/>";
					  tip += "开盘："+this.points[0].point.open+"<br/>";
					  tip += "最高："+this.points[0].point.high+"<br/>";
					  tip += "最低："+this.points[0].point.low+"<br/>";
					  tip += "收盘："+this.points[0].point.close+"<br/>";				  
					  tip += "涨跌价："+this.points[1].y+"<br/>";
					  tip += "成交量："+this.points[5].y+"<br/>";
					  tip += "成交额："+this.points[6].y+"<br/>";	
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
				},{
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
				},{
					labels: {
						enabled:false
					},
					title: {
						text: ''
					},
					//height: '65%',
					color:'none',
					offset: 0
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
				}, {
					type: 'column',
					name: 'liang',
					color:'none',
					data: GPL,
					yAxis: 2
				}, {
					type: 'column',
					name: 'chengjiaoe',
					color:'none',
					data: GPE,
					yAxis: 2
				}]
			});
		}
		else{
			$('#container2').highcharts('StockChart', {
				title: {
					text: ''
				},	
				navigator: {
					enabled: false
				},
				scrollbar:{
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
					  tip = '<b>'+this.points[0].series.name+"</b><br/>";
					  tip += "日期："+year+"年"+month+"月"+day+"日"+"<br/>";
					  tip += "开盘："+this.points[0].point.open+"<br/>";
					  tip += "最高："+this.points[0].point.high+"<br/>";
					  tip += "最低："+this.points[0].point.low+"<br/>";
					  tip += "收盘："+this.points[0].point.close+"<br/>";				  
					  tip += "涨跌："+this.points[1].y+"<br/>";
					  tip += "5MA："+this.points[2].y+"<br/>";
					  tip += "10MA："+this.points[3].y+"<br/>";
					  tip += "20MA："+this.points[4].y+"<br/>";	
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
				},{
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
				}]
			});
		}
	}
}
//});