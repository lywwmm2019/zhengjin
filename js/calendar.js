	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1,
			"d+" : this.getDate(),
			"h+" : this.getHours(),
			"m+" : this.getMinutes(),
			"s+" : this.getSeconds(),
			"q+" : Math.floor((this.getMonth() + 3) / 3),
			"S" : this.getMilliseconds()
		}
		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}
	
	String.prototype.toDate = function() {
		return new Date(Date.parse(this.replace(/-/g, "/")));
	};
	
	var dataHost = 'http://wx.zhengjin99.com';

	$(function() {
		var cal_link = 'http://www.zhengjin99.com/research/calendar.shtml';
		var cal_data = '<p class="yjzx_index_calender pr index_title">';
		cal_data += '�ƾ�����<a target="_blank" href="'+cal_link+'" class="more pa"></a><span class="yjzx_index_zjtj pa"></span></p>';
		cal_data += '<div class="yjzx_calender_time clear over">';
		var now = new Date();
		for ( var i = -2; i < 3; i++) {
			var time = now.getTime() + 1000 * 60 * 60 * 24 * i;
			var date = new Date(time);
			cal_data += '<a target="_blank" href="' + cal_link + '?date='+ date.format('yyyy-MM-dd') +'" class="' + (i == 0 ? 'sl' : '') 
						+ '"><span>' + getWeek(date) + '</span><span class="date">' + date.getDate() + '</span></a>';
		}
		$.ajax({
			dataType:'script',
			scriptCharset:'utf-8',
			url:dataHost + '/data/juling/calendar/' + now.format('yyyy-MM-dd') + '.json',
			success:function(){
				cal_data += '</div><div class="pr yjzx_calender_data">';
				var j = 0;
				for (var i = 0; j < 2 && i < json.length; i++) {
					if (now < json[i]['DECLAREDATE'].toDate()) {
						cal_data += '<div class="clear over ' + (j == 0 ? 'bd' : 'mt10') + '">';
						cal_data += makeData(json[i]);
						j++;
					}
				}
				if (j == 0) {
					if (json.length == 0) {
						cal_data += '<div class="clear over">������Ҫ�¼�</div>';
					} else {
						cal_data += '<div class="clear over bd">';
						cal_data += makeData(json[json.length-1]);
					}
				}
				cal_data += '<a target="_blank" href="'+cal_link+'" class="yjzx_calender_more pa">�鿴���ࡷ</a></div>';
				$('#cal_data').prepend(cal_data);
			}
		});
	});
	
	function makeData(item) {
		var str = '';
		str += '<div class="fl"><span class="time">' + item['DECLAREDATE'].substr(11)
				+ '</span> <img src="'+dataHost+'/images/country/'+ item['AREA_CODE'] +'.jpg" width="42" height="25" /></div>';
		str += '<div class="fr calender_datas">';
		str += '<p>' + item['EVENT'] + '</p>';
		str += '<table width="100%" border="0" cellspacing="0" cellpadding="0" class="mt10 mb10">';
		str += '<tr><td>ǰֵ</td>';
		str += '<td class="tc">Ԥ��ֵ</td>';
		str += '<td class="tc red">ʵ��ֵ</td>';
		str += '</tr><tr>';
		str += '<td>' + notNull(item['LAST_VALUE']) + '</td>';
		str += '<td class="tc">' + notNull(item['EXCEP_VALUE']) + '</td>';
		str += '<td class="tc red">' + notNull(item['REAL_VALUE']) + '</td>';
		str += '</tr></table></div>';
		str += '<div class="clear"></div></div>';
		return str;
	}

	function getWeek(date) {
		var day = '';
		switch (date.getDay()) {
		case 0:
			day = "��";
			break;
		case 1:
			day = "һ";
			break;
		case 2:
			day = "��";
			break;
		case 3:
			day = "��";
			break;
		case 4:
			day = "��";
			break;
		case 5:
			day = "��";
			break;
		case 6:
			day = "��";
			break;
		}
		return "��" + day;
	}

	function notNull(obj) {
		return obj ? obj : '--';
	}
