// JavaScript Document
 
/***
		��������ר�� 
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
	
	
	
	/********************************************************��K��******************************************************/
Price.prototype={
	
	 KChart:function(num,index){
		//var KUrl='/ForWeb/cmd3_'+num+'.txt';
		var that=this;
		
		num=num-0;
		
		
		
		
		if(that.dataK1==1&&num==000001){
			var datas=that.changeDataK(that.oldDataSZ);
			that.getdata(datas,1);
			return;
		}else if(that.dataK2==1&&num==399001){
			var datas=that.changeDataK(that.oldDataSC);
			that.getdata(datas,1);
			return;
		}
		
		if(num==399001||num==000001){
			if(num==399001){
				var KUrl="http://flashdata2.jrj.com.cn/history/js/index/399001/day.js";
			}
			else if(num==000001){
				var KUrl="http://flashdata2.jrj.com.cn/history/js/index/000001/day.js";
			}
			
			
			$.getScript(KUrl, function() {
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
				
				
				
			});
		}
		else{			
			var KUrl='/ForWeb/cmd3_'+num+'.txt';
			$.ajax({
				type:"GET",
				url:KUrl,
				dataType:"json",
				cache:false,
				success:function(data){
					var temp=0;
					var dataLength=data.length;
					
					
					if(that.oldData){
						/*for(var i=0;i<data.length;i++){
							if(oldData[i]['f3']!=data[i]['f3']){
								oldData[i]=data[i];
								temp=1;
							}
						}*/
						var oldDataLength=that.oldData.length;
						if(that.oldData[oldDataLength-1]['f3']!=data[dataLength-1]['f3']){
							that.oldData=data;
							temp=1;
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
					if(temp==1||index==5){
						that.getdata(data); 				
					}
				}
				
			});
		}
		
		
	},/**/
	
	/********************************************************��ʱ��******************************************************/
	MinuteChart:function(num,index){
		var that=this;
		
		
		
		
		if(num==399001||num==000001){
			if(num==399001){
				var MinuteUrl="http://flashdata2.jrj.com.cn/today/js/index/399001.js";
			}
			else if(num==000001){
				var MinuteUrl="http://flashdata2.jrj.com.cn/today/js/index/000001.js";
			}
			
			
			$.getScript(MinuteUrl, function() {

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

				//}
			});
		}
		else{			
			var MinuteUrl='/ForWeb/cmd2_'+num+'.txt';
			
			$.ajax({
				type:"GET",
				url:MinuteUrl,
				dataType:"json",
				cache:false,
				success:function(data){
					var temp2=0;
					var dataLength2=data.length;
					that.day=data[dataLength2-1]['f1'];
					
					
					if(that.oldData2){
	
						var oldData2Length=that.oldData2.length;
						if(that.oldData2[oldData2Length-1]['f2']!=data[dataLength2-1]['f2']){
							that.oldData2=data;
							temp2=1;
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
					}
					if(temp2==1){
						that.showChartK(data,index);
					}
				}
			});
		}
		
		//
		
	},/**/
	
	/*****************************************************��ָ����������װ����ʱ��******************************************************/
	changeDataMin:function(data){
		var t1=[],t2=[],t3=[];
		for(var i=0;i<data.Data.length;i++){
			t1.push({"f1":this.day,"f2":data.Data[i][0],"f3":data.Data[i][1].toFixed(2)-0,"f4":data.Data[i][4],"f5":data.Data[i][2],"f6":data.Data[i][3]});
			//t1.push({"f1":20150115,"f2":data.Data[i][0],"f3":data.Data[i][1].toFixed(2)-0,"f4":data.Data[i][4],"f5":data.Data[i][2],"f6":data.Data[i][3]});
		}
		
		return t1;
		//alert(Datas[0]['t']);
	},
	
	/*****************************************************��ָ����������װ����K��******************************************************/
	changeDataK:function(data){
		var t1=[],t2=[],t3=[];
		for(var i=0;i<data.rows.length;i++){
			var u=data.rows[i][2]-data.rows[i][7];
			u=u.toFixed(2)-0;
			t1.push({"f1":data.rows[i][0],"f2":0,"f3":data.rows[i][2].toFixed(2)-0,"f4":data.rows[i][1],"f5":data.rows[i][3],"f6":data.rows[i][4],"f7":data.rows[i][2].toFixed(2)-0,"f8":0,"f9":u,"f10":0,"f11":data.rows[i][5],"f12":data.rows[i][6]});
		}
		
		return t1;
		//alert(Datas[0]['t']);
	},
	
	/*****************************************************��ָ����������װ�����******************************************************/
	changeDataTable:function(data,num){
		var t1=[],t2=[],t3=[],t4=[];
		var length=data.Data.length;
		var u=data.Data[length-1][1]-this.yesterday;
		u=u.toFixed(2)-0;
		var zd=u/this.yesterday*100;
		zd=zd.toFixed(2)-0;
		var n=data.Data[length-1][1].toFixed(2)-0;
		t1.push({"f1":0,"f2":0,"f3":data.Data[length-1][1].toFixed(2)-0,"f4":u,"f5":zd,"f6":this.yesterday,"f7":data.Data[0][1],"f8":data.Summary.A3,"f9":data.Summary.A4,"f10":0,"f11":0,"f12":0,"f13":num});
		
		return t1;
		//alert(Datas[0]['t']);
	},
	
	
	
	
	/********************************************************ͼ����**********************************************************/
	getTable:function(num,idname){
		var that=this;
		
		var dataUrl='/ForWeb/cmd1.txt';

		$.ajax({
			type:"GET",
			url:dataUrl,
			dataType:"json",
			cache:false,
			success:function(data){
				that.showTable(num,data,idname);
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
				
				that.showTable2(num,datas,idname);
				
				//alert(dataComplite);
				//alert(dataTxt);
			}
		});
	},
	
	/********************************************************ͼ�������(��IE)******************************************************/
	showTable:function(num,tableData,idname){
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
			chartName='�ֻ�����';
			imgSrc='ag';
		}
		else if(num=='1998006'){
			chartName='�ֻ�����1000��';
			imgSrc='ag';
		}
		else if(num=='1998007'){
			chartName='�ֻ�����30KG';
			imgSrc='ag';
		}
		else if(num=='1998001'){
			chartName='�ֻ��ٽ�';
			imgSrc='pd';
		}
		else if(num=='1998003'){
			chartName='�ֻ���';
			imgSrc='ni';
		}
		else if(num=='1998008'){
			chartName='�ֻ�����';
			imgSrc='pt';
		}
		else if(num=='1998010'){
			chartName='�ֻ�ͭ';
			imgSrc='cu';
		}
		else if(num=='1998012'){
			chartName='�ֻ���';
			imgSrc='al';
		}
		
		
		var str2=
						'<ul style="right:5px;bottom:10px;" class="tc">'+
                            '<li class="f28" id="chartNow">'+datas['f3']+'</li>'+
                            '<li id="chartF">'+datas['f4']+'��'+datas['f5']+'%��</li>'+
                        '</ul>';
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
	},
	
	
	
	/********************************************************ͼ�������(IE)******************************************************/
	showTable2:function(num,tableData,idname){
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
			chartName='�ֻ�����';
			imgSrc='ag';
		}
		else if(num=='1998006'){
			chartName='�ֻ�����1000��';
			imgSrc='ag';
		}
		else if(num=='1998007'){
			chartName='�ֻ�����30KG';
			imgSrc='ag';
		}
		else if(num=='1998001'){
			chartName='�ֻ��ٽ�';
			imgSrc='pd';
		}
		else if(num=='1998003'){
			chartName='�ֻ���';
			imgSrc='ni';
		}
		else if(num=='1998008'){
			chartName='�ֻ�����';
			imgSrc='pt';
		}
		else if(num=='1998010'){
			chartName='�ֻ�ͭ';
			imgSrc='cu';
		}
		else if(num=='1998012'){
			chartName='�ֻ���';
			imgSrc='al';
		}
		
		
		var str2=
						'<ul style="right:5px;bottom:10px;" class="tc">'+
                            '<li class="f28" id="chartNow">'+datas[2]+'</li>'+
                            '<li id="chartF">'+datas[3]+'��'+datas[4]+'%��</li>'+
                        '</ul>';
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
			GPL=[],
			GPE=[],
			close_array=[],
			column_red=[],
			column_green=[],
			dataLength = data.length;
			
		//EMA�㷨	
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

		//i12, i26, i9 �ֱ���� 12�죬26�죬9��
		//array�����̼�����
		//MACD�㷨
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
			
		//��������װ��highstock��Ҫ�ĸ�ʽ
		for (i = 0; i < dataLength; i++) {
			var str=data[i]['f1'].toString();
			var year=str.substring(0,4);
			var month=str.substring(4,6);
			var day=str.substring(6,8);
			month=month-1;
			var utc=Date.UTC(year,month,day);
			ohlc.push([								//K��
				utc, // the date
				data[i]['f4'], // open
				data[i]['f5'], // high
				data[i]['f6'], // low
				data[i]['f7'] // close
			]);
			
			GPL.push([							//�ɽ���
				utc, // the date
				//data[i]['f2'] // the volume
				data[i]['f11']
			])
			GPE.push([							//�ɽ���
				utc, // the date
				//data[i]['f2'] // the volume
				data[i]['f12']
			])
			
			da.push([utc,data[i]['f9']]);			//�Ƿ� 
			
			close_array.push(data[i]['f7']);
			
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
		that.showchart(ohlc,da,line,MAcd,index,GPL,GPE);
	},
	
	/********************************************************��ʱ��ͼ��******************************************************/
	showChartK:function(data,index){
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
			var utc=Date.UTC(year,month,day,hour,minute);
			//var utc=Date.UTC(year2,month2,day2,hour,minute);
			var temp1=[],temp2=[];
			temp1.push(utc,data[i]['f3']);
			temp2.push(utc,data[i]['f5']);
			data1.push(temp1);
			data2.push(temp2);
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
					  tip += "ʱ�䣺"+hours+":"+minute+"<br/>";
					  tip += "�۸�"+this.y+"<br/>";
					  tip += "�ɽ�����"+this.points[1].y+"<br/>";
					  
					  return tip;
					},
					/*pointFormat: '<span style="color:#f00">ʱ�䣺</span>: <b>{point.x}</b><span style="color:#f00">{series.name}</span>: <b>{point.y}</b>',
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
					name : '�۸�',
					type: 'line',
					data : data1,
					tooltip : {
						valueDecimals : 2
					}
				},{
					name : '�ɽ���',
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
					text : ''
				},
				navigator: {
					enabled: false
				},
				scrollbar:{
					enabled: false
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
					  tip += "ʱ�䣺"+hours+":"+minute+"<br/>";
					  tip += "�۸�"+this.y+"<br/>";
					  return tip;
					},
					/*pointFormat: '<span style="color:#f00">ʱ�䣺</span>: <b>{point.x}</b><span style="color:#f00">{series.name}</span>: <b>{point.y}</b>',
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
	showchart:function(ohlc,data,line,MAcd,index,GPL,GPE){
		Highcharts.setOptions({
			lang: {
				rangeSelectorZoom: "��Χ",
				months:['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
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
					  tip += "���ڣ�"+year+"��"+month+"��"+day+"��"+"<br/>";
					  tip += "���̣�"+this.points[0].point.open+"<br/>";
					  tip += "��ߣ�"+this.points[0].point.high+"<br/>";
					  tip += "��ͣ�"+this.points[0].point.low+"<br/>";
					  tip += "���̣�"+this.points[0].point.close+"<br/>";				  
					  tip += "�ǵ��ۣ�"+this.points[1].y+"<br/>";
					  tip += "�ɽ�����"+this.points[5].y+"<br/>";
					  tip += "�ɽ��"+this.points[6].y+"<br/>";	
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
					  tip += "���ڣ�"+year+"��"+month+"��"+day+"��"+"<br/>";
					  tip += "���̣�"+this.points[0].point.open+"<br/>";
					  tip += "�߿���"+this.points[0].point.high+"<br/>";
					  tip += "�Ϳ���"+this.points[0].point.low+"<br/>";
					  tip += "���̣�"+this.points[0].point.close+"<br/>";				  
					  tip += "�Ƿ���"+this.points[1].y+"%<br/>";
					  tip += "5MA��"+this.points[2].y+"<br/>";
					  tip += "10MA��"+this.points[3].y+"<br/>";
					  tip += "20MA��"+this.points[4].y+"<br/>";	
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
				}]
			});
		}
	}
}
//});