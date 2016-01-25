<%@ include file="/common/taglibs.jsp" %>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- Mirrored from htmlstream.com/preview/unify-v1.8/Blog/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 06 Dec 2015 10:44:01 GMT -->
<head>
    <meta name="google-site-verification" content="pLlTKLs0FWecFBX01uipQb3XildhPhLVNPX-0k5i1ww" />
    <title><decorator:title/></title>
    <meta name="description" content="<decorator:getProperty property="meta.description"></decorator:getProperty>"/>
    <meta name="keywords" content="<decorator:getProperty property="meta.keywords"></decorator:getProperty>">
    <meta name="robots" content="index,follow"/>
    <meta name="author" content="">
    <meta name="copyright" content=""/>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <!-- Favicon -->
    <link rel="shortcut icon" href="<c:url value="/themes/site/favicon/favicon-32x32.png"/>">

    <link rel="apple-touch-icon" sizes="57x57" href="<c:url value="/themes/site/favicon/apple-icon-57x57.png"/>">
    <link rel="apple-touch-icon" sizes="60x60" href="<c:url value="/themes/site/favicon/apple-icon-60x60.png"/>">
    <link rel="apple-touch-icon" sizes="72x72" href="<c:url value="/themes/site/favicon/apple-icon-72x72.png"/>">
    <link rel="apple-touch-icon" sizes="76x76" href="<c:url value="/themes/site/favicon/apple-icon-76x76.png"/>">
    <link rel="apple-touch-icon" sizes="114x114" href="<c:url value="/themes/site/favicon/apple-icon-114x114.png"/>">
    <link rel="apple-touch-icon" sizes="120x120" href="<c:url value="/themes/site/favicon/apple-icon-120x120.png"/>">
    <link rel="apple-touch-icon" sizes="144x144" href="<c:url value="/themes/site/favicon/apple-icon-144x144.png"/>">
    <link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/themes/site/favicon/apple-icon-152x152.png"/>">
    <link rel="apple-touch-icon" sizes="180x180" href="<c:url value="/themes/site/favicon/apple-icon-180x180.png"/>">
    <link rel="icon" type="image/png" sizes="192x192"  href="<c:url value="/themes/site/favicon/android-icon-192x192.png"/>">
    <link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/themes/site/favicon/favicon-32x32.png"/>">
    <link rel="icon" type="image/png" sizes="96x96" href="<c:url value="/themes/site/favicon/favicon-96x96.png"/>">
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/themes/site/favicon/favicon-16x16.png"/>">
    <link rel="manifest" href="<c:url value="/themes/site/favicon/manifest.json"/>">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="<c:url value="/themes/site/favicon/ms-icon-144x144.png"/>">
    <meta name="theme-color" content="#ffffff">

    <!-- Web Fonts -->
    <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700'>

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/bootstrap/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/blog.style.css"/>">

    <!-- CSS Header and Footer -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/headers/header-v8.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/footers/footer-v7.css"/>">

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

    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/sweetalert/lib/sweet-alert.css"/>">

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
<c:set var="domainUrl" value="${pageContext.request.serverName}"/>
<body class="header-fixed header-fixed-space-v2" domainUrl="${domainUrl}">
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
    <script src="<c:url value="/themes/admin/vendor/sweetalert/lib/sweet-alert.min.js"/>"></script>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-72353184-1', 'auto');
        ga('send', 'pageview');

    </script>
    <script>
        jQuery(document).ready(function() {
            App.init();
            App.initCounter();
            FancyBox.initFancybox();
            OwlCarousel.initOwlCarousel();
            OwlCarousel.initOwlCarousel2();
            StyleSwitcher.initStyleSwitcher();
            MasterSliderShowcase1.initMasterSliderShowcase1();
            $("#register-customer-btn").on('click', function(){
                if(registerCustomerFormValidate($("#registerForm"))){
                    if(registerCustomerFormEmailValidate($("#registerForm"))){
                        swal({
                            title: "<fmt:message key="site.customer.register.success"/>",
                            text: "<fmt:message key="site.customer.register.success.message"/>",
                            type: "success",
                            timer: 1500,
                            showConfirmButton: false
                        });
                        $("#registerForm").submit();
                    }
                } else {
                    swal({
                        title: "<fmt:message key="site.customer.register.error"/>",
                        text: "<fmt:message key="site.customer.register.error.message"/>",
                        type: "error"
                    });
                }
            });

            $("#register-customer-footer-btn").on('click', function(){
                if(registerCustomerFormValidate($("#registerFormFooter"))){
                    if(registerCustomerFormEmailValidate($("#registerFormFooter"))){
                        swal({
                            title: "<fmt:message key="site.customer.register.success"/>",
                            text: "<fmt:message key="site.customer.register.success.message"/>",
                            type: "success",
                            timer: 1500,
                            showConfirmButton: false
                        });
                        $("#registerFormFooter").submit();
                    }
                } else {
                    swal({
                        title: "<fmt:message key="site.customer.register.error"/>",
                        text: "<fmt:message key="site.customer.register.error.message"/>",
                        type: "error"
                    });
                }
            });
        });

        function registerCustomerFormValidate(formElement){
            var isValid = true;
            $(formElement).find('.required-field').each(function(){
               if($.trim($(this).val()) == ""){
                   $(this).addClass("error");
                   isValid = false;
               }  else {
                   $(this).removeClass("errors");
               }
            });
            return isValid;
        }

        function registerCustomerFormEmailValidate(formElement){
            var isValid = true;
            $(formElement).find('.cus-email-field').each(function(){
                if( !validateEmail($(this).val())) {
                    $(this).addClass("error");
                    isValid = false;
                    swal({
                        title: "<fmt:message key="site.customer.register.error"/>",
                        text: "<fmt:message key="site.email.not.valid"/>",
                        type: "error"
                    });
                } else {
                    $(this).removeClass("errors");
                }
            });
            return isValid;
        }

        function validateEmail(email) {
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            return emailReg.test(email);
        }
    </script>
</body>
</html>