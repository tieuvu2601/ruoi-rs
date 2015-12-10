var OwlCarousel = function () {

    return {

        //Owl Carousel
        initOwlCarousel: function () {
	        //Blog Carousel
			var owl = jQuery(".blog-carousel-old").owlCarousel({
                items : 1,
                itemsDesktop : [1000,1],
                itemsDesktopSmall : [900,1],
                itemsTablet: [600,1],
                itemsMobile : [479,1],
                slideSpeed: 700
            });
            jQuery(".next-v3").click(function(){ owl.trigger('owl.next');})
            jQuery(".prev-v3").click(function(){ owl.trigger('owl.prev');});

            var owl_v1 = jQuery(".carousel_v1").owlCarousel({
                items : 1,
                itemsDesktop : [1000,1],
                itemsDesktopSmall : [900,1],
                itemsTablet: [600,1],
                itemsMobile : [479,1],
                slideSpeed: 12000
            });
            jQuery(".btn-next-v1").click(function(){ owl_v1.trigger('owl.next');})
            jQuery(".btn-prev-v1").click(function(){ owl_v1.trigger('owl.prev');});

            var owl_v2 = jQuery(".carousel_v2").owlCarousel({
                items : 1,
                itemsDesktop : [1000,1],
                itemsDesktopSmall : [900,1],
                itemsTablet: [600,1],
                itemsMobile : [479,1],
                slideSpeed: 12000
            });
            jQuery(".btn-next-v2").click(function(){ owl_v2.trigger('owl.next');})
            jQuery(".btn-prev-v2").click(function(){ owl_v2.trigger('owl.prev');});

            var owl_v3 = jQuery(".carousel_v3").owlCarousel({
                items : 1,
                itemsDesktop : [1000,1],
                itemsDesktopSmall : [900,1],
                itemsTablet: [600,1],
                itemsMobile : [479,1],
                slideSpeed: 12000
            });
            jQuery(".btn-next-v3").click(function(){ owl_v3.trigger('owl.next');})
            jQuery(".btn-prev-v3").click(function(){ owl_v3.trigger('owl.prev');});

        },

        //Owl Carousel v2
        initOwlCarousel2: function () {
            //Blog Carousel
            var owl = jQuery(".blog-carousel-v2").owlCarousel({
                items : 1,
                itemsDesktop : [1000,1],
                itemsDesktopSmall : [900,1],
                itemsTablet: [600,1],
                itemsMobile : [479,1],
                slideSpeed: 12000
            });
            jQuery(".next-v4").click(function(){
                owl.trigger('owl.next');
            })
            jQuery(".prev-v4").click(function(){
                owl.trigger('owl.prev');
            })
        }
        
    };
    
}();