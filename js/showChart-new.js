// JavaScript Document
  
//$(function() {

var Price=function(){
	var oldData;
	var oldData2;
	var oldnum;
	var oldnum2;
}

	
	/********************************************************��K��******************************************************/
Price.prototype={
	
	KChart:function(num,index){
		//var KUrl='/ForWeb/cmd3_'+num+'.txt';
		var that=this;
		var KUrl="http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=4&code="+num+"&type=1&date=&time=&offset=";

		$.getScript(KUrl, function() {
			
				var data=b;
				var temp=0;
				try{
				var dataLength=data.d.d.length;
				
				if(that.oldData){ //oldData���ϴ��и��ĵ����ݣ����������ݸ��ϴ�һ������ôdata��oldDataһ������������ݳ��֣���ô�����жϾ�֪���µĺ;ɵ��в��
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
					that.getdata(data,index);
					that.oldnum=num;
					return;
				}
				else{
					that.oldnum=num;
				}
				if(temp==1){
					that.getdata(data,index); 				
				}
				else{
					return;
				}
			//}
		}catch(e){};
			
		});
	},/**/
	
	/********************************************************��ʱ��******************************************************/
	MinuteChart:function(num,index){
		var that=this;

		var MinuteUrl="http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=3&code="+num+"&date=&time=&offset=&version=1";
		$.getScript(MinuteUrl, function() {
				
				var data=b;
				var temp2=0;
				try{
				var dataLength2=data.d[0].d.length;
				
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
			//}
		}catch(e){}
		});
	},/**/
	/********************************************************ͼ����**********************************************************/
	getTable:function(num,idname){
		var that=this;

		$.getScript("http://bjgjshq.zhengjin99.com/mongooper/cmdh5.jsp?pattern=5", function() {
				try{
				var data=b;
				that.showTable(num,data,idname);
				}catch(e){};
			});
	},
	
	/********************************************************ͼ�������(��IE)******************************************************/
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
		if(num=='1998263'){
			chartName='�ֻ�����';
			imgSrc='ag';
		}
		/*else if(num=='1998006'){
			chartName='�ֻ�����1000��';
			imgSrc='ag';
		}
		else if(num=='1998007'){
			chartName='�ֻ�����30KG';
			imgSrc='ag';
		}*/
		else if(num=='1998285'){
			chartName='�ֻ��ٽ�';
			imgSrc='pd';
		}
		else if(num=='1998279'){
			chartName='�ֻ���';
			imgSrc='ni';
		}
		else if(num=='1998271'){
			chartName='�ֻ�����';
			imgSrc='pt';
		}
		else if(num=='1998261'){
			chartName='�ֻ�ͭ';
			imgSrc='cu';
		}
		else if(num=='1998275'){
			chartName='�ֻ���';
			imgSrc='al';
		}
		else if(num=='1991001'){
			chartName='��Բ��10kg';
			imgSrc='ag';
		}
		/*else if(num=='1991002'){
			chartName='��Բ��100kg';
			imgSrc='ag';
		}
		else if(num=='1991003'){
			chartName='��Բ��50kg';
			imgSrc='ag';
		}
		else if(num=='1991007'){
			chartName='��Բ����15t';
			imgSrc='ag';
		}
		
		else if(num=='1991009'){
			chartName='��Բ����50t';
			imgSrc='ag';
		}
		else if(num=='1991008'){
			chartName='��Բ����150t';
			imgSrc='ag';
		}*/
		try{
		var zd=datas.u/datas.y*100;
		}catch(e){};
		var str= '<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>��:<span class="" id="chartEnd">'+datas['y']+'</span></td>'+
                            '<td>��:<span class="red" id="chartHigh">'+datas['h']+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>��:<span class="green" id="chartOpen">'+datas['o']+'</span></td>'+
                            '<td>��:<span class="green" id="chartLow">'+datas['l']+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas['n']+'</li>'+
                            '<li id="chartF">'+datas['u']+'��'+zd.toFixed(2)+'%��</li>'+
                        '</ul>';
		
		
		var str2='<table width="60%" cellspacing="0" cellpadding="0" border="0">'+
                          '<tbody><tr>'+
                            '<td>��:<span class="" id="chartEnd">'+datas['y']+'</span></td>'+
                            '<td>��:<span class="red" id="chartHigh">'+datas['h']+'</span></td>'+
                          '</tr>'+
                          '<tr>'+
                            '<td>��:<span class="green" id="chartOpen">'+datas['o']+'</span></td>'+
                            '<td>��:<span class="green" id="chartLow">'+datas['l']+'</span></td>'+
                          '</tr>'+
                        '</tbody></table>'+
						'<ul style="right:5px;bottom:10px;" class="pa tc">'+
                            '<li class="f40" id="chartNow">'+datas['n']+'</li>'+
                            '<li id="chartF">'+datas['u']+'��'+zd.toFixed(2)+'%��</li>'+
                        '</ul>';
		$('#chartTable').html(str);
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
	
	
	
	
	
	/********************************************************��K�����ݴ���******************************************************/
	getdata:function(data,index){
		
		var that=this;
		// ��ʼ������
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
			dataLength = data.d.d.length;
			
		//EMA�㷨	
		function EMA(m,array){
			try{
			if (m == 0 || array.length==0)
			{
				return new Array();
			}
			var ema = new Array();
			ema.push(array[0]);
			for (var i=1;i<array.length;i++){
				
				var v = (array[i]*2+ema[i-1]*(m-1))/(m+1);
				
				
				ema.push(v);
			//alert(array.length)
			}
		return ema;
		   }catch(e){};
		}

		//i12, i26, i9 �ֱ���� 12�죬26�죬9��
		//array�����̼�����
		//MACD�㷨
		function MACD(array, i12, i26, i9) {
			try{
			var ema12 = EMA(i12,array);
			var ema26 = EMA(i26,array);
			var dif = [];
			for (var i = 0; i < ema12.length; i++) { dif.push(ema12[i] - ema26[i]); }
			var dea = EMA(i9,dif);
			var macd = [];
			//for (var i = 0; i < dea.length; i++) { macd.push(2*(dif[i] - dea[i])); }
			for (var i = 0; i < dea.length; i++) { macd.push((dif[i] - dea[i])); }
			return { macd: macd, dif: dif, dea: dea };
			}catch(e){};
		}
			
		//��������װ��highstock��Ҫ�ĸ�ʽ
		for (i = 0; i < dataLength; i++) {
			var str=data.d.d[i]['d'].toString();
			var year=str.substring(0,4);
			var month=str.substring(4,6);
			var day=str.substring(6,8);
			month=month-1;
			var utc=Date.UTC(year,month,day);
			ohlc.push([								//K��
				utc, // the date

				data.d.d[i]['o'],
				data.d.d[i]['h'],
				data.d.d[i]['l'],
				data.d.d[i]['n']
			]);
			
			volume.push([							//�ɽ���
				utc, // the date

				data.d.d[i]['n']
			])
			
			//da.push([utc,data[i]['f9']]);			//�Ƿ� 
			var temp_da=data.d.d[i]['u']/data.d.d[i]['y']*100;
			da.push([utc,data.d.d[i]['u']]);	
			

			close_array.push(data.d.d[i]['n']);
			
			M.push([utc,MACD(close_array,12,26,9)]);

			tt1=EMA(5,close_array);
			tt2=EMA(10,close_array);
			tt3=EMA(20,close_array);

		}
		
		//��MACD��DIF��DEA��ָ����װ��highstock��Ҫ�ĸ�ʽ		
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
		that.showchart(ohlc,da,line,MAcd,index);
	  
	},
	
	/********************************************************��ʱ��ͼ��******************************************************/
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

			var temp1=[],temp2=[];
			temp1.push(utc,data[i].n);
			data1.push(temp1);
		}
		//alert(data1);
		Highcharts.setOptions({
			lang: {
				rangeSelectorZoom: "��Χ"
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

					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var hours=time.getUTCHours(),minute=time.getUTCMinutes();
					  tip += "ʱ�䣺"+hours+":"+minute+"<br/>";
					  tip += "�۸�"+this.y+"<br/>";
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
					name : '�۸�',
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
					text : '��ʱ',
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
						text: '30����'
					}, {
						type: 'hour',
						count: 1,
						text: '1Сʱ'
					}, {
						type: 'all',
						text: '��ʱ'
					}]
				},
				tooltip:{

					headerFormat: '',

					formatter:function(){   
					  //debugger
					  var tip = "";
					  var time=new Date(this.x);
					  var hours=time.getUTCHours(),minute=time.getUTCMinutes();
					  tip += "ʱ�䣺"+hours+":"+minute+"<br/>";
					  tip += "�۸�"+this.y+"<br/>";
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
					name : '�۸�',
					type: 'line',
					data : data1,
					tooltip : {
						valueDecimals : 2
					}
				}]
			});
		}
		
	},
	
	
	/********************************************************��K��ͼ��******************************************************/
	showchart:function(ohlc,data,line,MAcd,index){
		try{
		Highcharts.setOptions({
			lang: {
				rangeSelectorZoom: "��Χ",
				months:['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
				shortMonths:['1','2','3','4','5','6','7','8','9','10','11','12']
			}
		});
		}catch(e){}
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
					  tip += "���ڣ�"+year+"��"+month+"��"+day+"��"+"<br/>";
					  tip += "���̣�"+this.points[0].point.open+"<br/>";
					  tip += "��ߣ�"+this.points[0].point.high+"<br/>";
					  tip += "��ͣ�"+this.points[0].point.low+"<br/>";
					  tip += "���̣�"+this.points[0].point.close+"<br/>";
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
					name: '����',
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
					text: '����'
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
					  tip += "���ڣ�"+year+"��"+month+"��"+day+"��"+"<br/>";
					  tip += "���̣�"+this.points[0].point.open+"<br/>";
					  tip += "��ߣ�"+this.points[0].point.high+"<br/>";
					  tip += "��ͣ�"+this.points[0].point.low+"<br/>";
					  tip += "���̣�"+this.points[0].point.close+"<br/>";				  
					  tip += "�ǵ���"+this.points[1].y+"<br/>";
					  tip += "5MA��"+this.points[2].y+"<br/>";
					  tip += "10MA��"+this.points[3].y+"<br/>";
					  tip += "20MA��"+this.points[4].y+"<br/>";				  
					  /*tip += "MACD��"+this.points[5].y+"<br/>";
					  tip += "Dif��"+this.points[6].y+"<br/>";
					  tip += "Dea��"+this.points[7].y+"<br/>";*/
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
						text: '1����'
					}, {
						type: 'month',
						count: 3,
						text: '3����'
					}, {
						type: 'month',
						count: 6,
						text: '6����'
					}, {
						type: 'year',
						count: 1,
						text: '1��'
					}, {
						type: 'all',
						text: 'ȫ��'
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
					name: '����',
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
	
}

//});