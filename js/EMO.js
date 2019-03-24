// JavaScript Document



var dataHost = 'http://wx.zhengjin99.com';

//if (!navigator.userAgent.match(/AppleWebKit.*Mobile.*/)) location = "visit.html";

function getParam(item) {
	var svalue = location.search.match(new RegExp('[\?\&]' + item + '=([^\&]*)(\&?)','i'));
	return svalue?decodeURIComponent(svalue[1]):'';
}

function getFileName() {
	return location.href.substr(location.href.lastIndexOf('/')+1).split('?')[0];
}



function showPage(pageNo, pageSize, total) {
	var str = "";
	var pageCount = Math.ceil(total / pageSize);
	if (pageCount > 10) pageCount = 10; 
	if (pageCount > 1) {
		if (pageNo > 1) {
			str += '<span><a href="javascript:getData('+(pageNo-1)+');">上一页</a></span>';
		} else {
			str += '<span>上一页</span>';
		}
		for (var i = 1; i <= pageCount; i++) {
			if (i == pageNo) {
				str += '<span class="curpage"> '+i+' </span>';
			} else {
				str += '<span class="otherpage"><a href="javascript:getData('+i+');">'+i+'</a></span>';
			}
		}
		if (pageNo < pageCount) {
			str += '<span><a href="javascript:getData('+(pageNo+1)+');">下一页</a></span>';
		} else {
			str += '<span>下一页</span>';
		}
	}
	$("#pager").html(str);
	
}

