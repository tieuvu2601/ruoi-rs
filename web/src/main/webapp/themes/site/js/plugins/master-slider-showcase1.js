var MasterSliderShowcase1 = function () {

    return {

        //Master Slider
        initMasterSliderShowcase1: function () {
			var slider = new MasterSlider();
		
			slider.control('arrows');	
			slider.control('slideinfo',{insertTo:"#partial-view-1" , autohide:false, align:'bottom', size:0});
			slider.control('circletimer' , {color:"#fff" , stroke:9});
			
			slider.setup('masterslider' , {
                autoplay: true,
                loop:true,
				width:1100,
				height:450,
				space:10,
		        speed: 17,
				view:'fadeWave',
				layout:'partialview'
			});
        }
        
    };
    
}();