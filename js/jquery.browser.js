;(function($)  
{  
  
    $.extend(  
    {  
        NV:function(name)  
        {  
var NV = {};  
var UA = navigator.userAgent.toLowerCase();  
try  
{  
    NV.name=!-[1,]?'ie':  
    (UA.indexOf("firefox")>0)?'firefox':  
    (UA.indexOf("chrome")>0)?'chrome':  
    window.opera?'opera':  
    window.openDatabase?'safari':  
    'unkonw';  
}catch(e){};  
try  
{  
    NV.version=(NV.name=='ie')?UA.match(/msie ([\d.]+)/)[1]:  
    (NV.name=='firefox')?UA.match(/firefox\/([\d.]+)/)[1]:  
    (NV.name=='chrome')?UA.match(/chrome\/([\d.]+)/)[1]:  
    (NV.name=='opera')?UA.match(/opera.([\d.]+)/)[1]:  
    (NV.name=='safari')?UA.match(/version\/([\d.]+)/)[1]:  
    '0';  
}catch(e){};  
try  
{  
    NV.shell=(UA.indexOf('360ee')>-1)?'360¼«ËÙä¯ÀÀÆ÷':  
    (UA.indexOf('360se')>-1)?'360°²È«ä¯ÀÀÆ÷':  
    (UA.indexOf('se')>-1)?'ËÑ¹·ä¯ÀÀÆ÷':  
    (UA.indexOf('aoyou')>-1)?'åÛÓÎä¯ÀÀÆ÷':  
    (UA.indexOf('theworld')>-1)?'ÊÀ½çÖ®´°ä¯ÀÀÆ÷':  
    (UA.indexOf('worldchrome')>-1)?'ÊÀ½çÖ®´°¼«ËÙä¯ÀÀÆ÷':  
    (UA.indexOf('greenbrowser')>-1)?'ÂÌÉ«ä¯ÀÀÆ÷':  
    (UA.indexOf('qqbrowser')>-1)?'QQä¯ÀÀÆ÷':  
    (UA.indexOf('baidu')>-1)?'°Ù¶Èä¯ÀÀÆ÷':  
    'Î´Öª»òÎÞ¿Ç';  
}catch(e){}  
            switch(name)  
            {  
                case 'ua':  
                case 'UA':br=UA;break;  
                case 'name':br=NV.name;break;  
                case 'version':br=NV.version;break;  
                case 'shell':br=NV.shell;break;  
                default:br=NV.name;  
            }  
            return br;  
        }  
    });  
})(jQuery); 
