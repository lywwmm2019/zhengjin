// JavaScript Document
(function( $ ){
	var settings = {
		defaultScrollingColumn:".zt_right",
		contentSet:null
	};
	
	var scrollTimer = 0;
	var animating = true;
	var shouldAnimate = true;
	
	var methods = {
		init:function(options){
			var pp = this;
			
			adjustColumnPos();
			return this.each(function(){				
				var $this = $(this), 
					data = $this.data("goofyScroller")
				
				$.extend(settings, options);
				$(pp).scroll(onWindowScroll);
				
				// If the plugin hasn't been initialized yet
				if ( ! data ) {
					$this.data("goofyScroller", {
						target : $this
					});
				}
			});
		}
	};
	
	adjustColumnPos = function()
	{
		$(settings.defaultScrollingColumn).css("bottom", 0);
	}
	
	onWindowScroll = function()
	{
		$(settings.defaultScrollingColumn).css("bottom", - $(this).scrollTop());
	}
	
	$.fn.goofyScroller = function(method) {
		// Method calling logic
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on jquery.goofyScroller' );
		}
	};
})( jQuery );