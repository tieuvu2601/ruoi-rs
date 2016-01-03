<%@ include file="/common/taglibs.jsp" %>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- Mirrored from htmlstream.com/preview/unify-v1.8/Blog/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 06 Dec 2015 10:44:01 GMT -->
<head>
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>
    <meta name="description" content="<decorator:getProperty property="meta.description"></decorator:getProperty>"/>
    <meta name="keywords" content="<decorator:getProperty property="meta.keywords"></decorator:getProperty>">
    <meta name="robots" content="index,follow"/>
    <meta name="author" content="">
    <meta name="copyright" content=""/>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="<c:url value="/themes/site/favicon.ico"/>">

    <!-- Web Fonts -->
    <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700'>

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/bootstrap/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/blog.style.css"/>">

    <!-- CSS Header and Footer -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/headers/header-v8.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/footers/footer-v8.css"/>">

    <!-- CSS Implementing Plugins -->
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/animate.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/line-icons/line-icons.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/fancybox/source/jquery.fancybox.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/font-awesome/css/font-awesome.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/login-signup-modal-window/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/owl-carousel/owl-carousel/owl.carousel.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/master-slider/masterslider/style/masterslider.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/master-slider/masterslider/skins/default/style.css"/>">

    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/sky-forms-pro/skyforms/css/sky-forms.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/login-signup-modal-window/css/style.css"/>">

    <!-- CSS Theme -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/theme-colors/green.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/theme-skins/dark.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/app.css"/>">
    <!-- CSS Customization -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/custom.css"/>">

    <!-- JS Global Compulsory -->
    <script src="<c:url value="/themes/site/plugins/jquery/jquery.min.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/jquery/jquery-migrate.min.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/bootstrap/js/bootstrap.min.js"/>"></script>
<decorator:head/>

<body class="header-fixed header-fixed-space-v2">
    <div class="wrapper">
        <!--=== Header v8 ===-->
        <div class="header-v8 header-sticky">
            <jsp:include page="/themes/site/header.jsp"></jsp:include>
            <jsp:include page="/themes/site/navigation.jsp"></jsp:include>
        </div>
        <!--=== End Header v8 ===-->

        <decorator:body/>

        <jsp:include page="/themes/site/footer.jsp"></jsp:include>

        <jsp:include page="/themes/site/loginandregister.jsp"></jsp:include>

    </div><!--/wrapper-->

    <!-- JS Implementing Plugins -->
    <script src="<c:url value="/themes/site/plugins/back-to-top.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/smoothScroll.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/counter/waypoints.min.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/counter/jquery.counterup.min.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/fancybox/source/jquery.fancybox.pack.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/owl-carousel/owl-carousel/owl.carousel.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/master-slider/masterslider/masterslider.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/master-slider/masterslider/jquery.easing.min.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/modernizr.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/login-signup-modal-window/js/main.js"/>"></script> <!-- Gem jQuery -->
    <!-- JS Customization -->
    <script src="<c:url value="/themes/site/js/custom.js"/>"></script>
    <!-- JS Page Level -->
    <script src="<c:url value="/themes/site/js/app.js"/>"></script>
    <script src="<c:url value="/themes/site/js/plugins/fancy-box.js"/>"></script>
    <script src="<c:url value="/themes/site/js/plugins/owl-carousel.js"/>"></script>
    <script src="<c:url value="/themes/site/js/plugins/master-slider-showcase1.js"/>"></script>
    <script src="<c:url value="/themes/site/js/plugins/style-switcher.js"/>"></script>
    <script>
        jQuery(document).ready(function() {
            App.init();
            App.initCounter();
            FancyBox.initFancybox();
            OwlCarousel.initOwlCarousel();
            OwlCarousel.initOwlCarousel2();
            StyleSwitcher.initStyleSwitcher();
            MasterSliderShowcase1.initMasterSliderShowcase1();
        });
    </script>
    <!--[if lt IE 9]>
    <script src="<c:url value="/themes/site/plugins/respond.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/html5shiv.js"/>"></script>
    <script src="<c:url value="/themes/site/plugins/placeholder-IE-fixes.js"/>"></script>
    <![endif]-->
</body>

</html>