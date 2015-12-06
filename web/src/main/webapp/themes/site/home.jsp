<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en"> <!--<![endif]-->

<!-- Mirrored from htmlstream.com/preview/unify-v1.8/Blog/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 04 Dec 2015 14:14:57 GMT -->
<head>
    <title>Unify - Responsive Website Template</title>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="favicon.ico">

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

    <!-- CSS Theme -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/theme-colors/default.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/css/theme-skins/dark.css"/>">

    <!-- CSS Customization -->
    <link rel="stylesheet" href="<c:url value="/themes/site/css/custom.css"/>">
</head>

<body class="header-fixed header-fixed-space-v2">


<div class="wrapper">
<!--=== Header v8 ===-->
<div class="header-v8 header-sticky">
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="navigation.jsp"></jsp:include>
</div>
<!--=== End Header v8 ===-->
<decorator:body></decorator:body>


<div class="cd-user-modal"> <!-- this is the entire modal form, including the background -->
    <div class="cd-user-modal-container"> <!-- this is the container wrapper -->
        <ul class="cd-switcher">
            <li><a href="javascript:void(0);">Login</a></li>
            <li><a href="javascript:void(0);">Register</a></li>
        </ul>

        <div id="cd-login"> <!-- log in form -->
            <form class="cd-form">
                <p class="social-login">
                    <span class="social-login-facebook"><a href="#"><i class="fa fa-facebook"></i> Facebook</a></span>
                    <span class="social-login-google"><a href="#"><i class="fa fa-google"></i> Google</a></span>
                    <span class="social-login-twitter"><a href="#"><i class="fa fa-twitter"></i> Twitter</a></span>
                </p>

                <div class="lined-text"><span>Or use your account on Blog</span>
                    <hr>
                </div>

                <p class="fieldset">
                    <label class="image-replace cd-email" for="signin-email">E-mail</label>
                    <input class="full-width has-padding has-border" id="signin-email" type="email"
                           placeholder="E-mail">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace cd-password" for="signin-password">Password</label>
                    <input class="full-width has-padding has-border" id="signin-password" type="text"
                           placeholder="Password">
                    <a href="javascript:void(0);" class="hide-password">Hide</a>
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <input type="checkbox" id="remember-me" checked>
                    <label for="remember-me">Remember me</label>
                </p>

                <p class="fieldset">
                    <input class="full-width" type="submit" value="Login">
                </p>
            </form>

            <p class="cd-form-bottom-message"><a href="javascript:void(0);">Forgot your password?</a></p>
            <!-- <a href="javascript:void(0);" class="cd-close-form">Close</a> -->
        </div>
        <!-- cd-login -->

        <div id="cd-signup"> <!-- sign up form -->
            <form class="cd-form">
                <p class="social-login">
                    <span class="social-login-facebook"><a href="#"><i class="fa fa-facebook"></i> Facebook</a></span>
                    <span class="social-login-google"><a href="#"><i class="fa fa-google"></i> Google</a></span>
                    <span class="social-login-twitter"><a href="#"><i class="fa fa-twitter"></i> Twitter</a></span>
                </p>

                <div class="lined-text"><span>Or register your new account on Blog</span>
                    <hr>
                </div>

                <p class="fieldset">
                    <label class="image-replace cd-username" for="signup-username">Username</label>
                    <input class="full-width has-padding has-border" id="signup-username" type="text"
                           placeholder="Username">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace cd-email" for="signup-email">E-mail</label>
                    <input class="full-width has-padding has-border" id="signup-email" type="email"
                           placeholder="E-mail">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace cd-password" for="signup-password">Password</label>
                    <input class="full-width has-padding has-border" id="signup-password" type="text"
                           placeholder="Password">
                    <a href="javascript:void(0);" class="hide-password">Hide</a>
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <input type="checkbox" id="accept-terms">
                    <label for="accept-terms">I agree to the <a href="javascript:void(0);">Terms</a></label>
                </p>

                <p class="fieldset">
                    <input class="full-width has-padding" type="submit" value="Create account">
                </p>
            </form>

            <!-- <a href="javascript:void(0);" class="cd-close-form">Close</a> -->
        </div>
        <!-- cd-signup -->

        <div id="cd-reset-password"> <!-- reset password form -->
            <p class="cd-form-message">Lost your password? Please enter your email address. You will receive a link to
                create a new password.</p>

            <form class="cd-form">
                <p class="fieldset">
                    <label class="image-replace cd-email" for="reset-email">E-mail</label>
                    <input class="full-width has-padding has-border" id="reset-email" type="email" placeholder="E-mail">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <input class="full-width has-padding" type="submit" value="Reset password">
                </p>
            </form>

            <p class="cd-form-bottom-message"><a href="javascript:void(0);">Back to log-in</a></p>
        </div>
        <!-- cd-reset-password -->
        <a href="javascript:void(0);" class="cd-close-form">Close</a>
    </div>
    <!-- cd-user-modal-container -->
</div>
<!-- cd-user-modal -->
</div>
<!--/wrapper-->

<!-- JS Global Compulsory -->
<script src="<c:url value="/themes/site/plugins/jquery/jquery.min.js"/>"></script>
<script src="<c:url value="/themes/site/plugins/jquery/jquery-migrate.min.js"/>"></script>
<script src="<c:url value="/themes/site/plugins/bootstrap/js/bootstrap.min.js"/>"></script>
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
<script src="<c:url value="/themes/site/plugins/login-signup-modal-window/js/main.js"/>"></script>
<!-- Gem jQuery -->
<!-- JS Customization -->
<script src="<c:url value="/themes/site/js/custom.js"/>"></script>
<!-- JS Page Level -->
<script src="<c:url value="/themes/site/js/app.js"/>"></script>
<script src="<c:url value="/themes/site/js/plugins/fancy-box.js"/>"></script>
<script src="<c:url value="/themes/site/js/plugins/owl-carousel.js"/>"></script>
<script src="<c:url value="/themes/site/js/plugins/master-slider-showcase1.js"/>"></script>
<script src="<c:url value="/themes/site/js/plugins/style-switcher.js"/>"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        App.initCounter();
        FancyBox.initFancybox();
        OwlCarousel.initOwlCarousel();
        OwlCarousel.initOwlCarousel2();
        StyleSwitcher.initStyleSwitcher();
        MasterSliderShowcase1.initMasterSliderShowcase1();
    });
</script>


<script src="<c:url value="/themes/site/plugins/respond.js"/>"></script>
<script src="<c:url value="/themes/site/plugins/html5shiv.js"/>"></script>
<script src="<c:url value="/themes/site/plugins/placeholder-IE-fixes.js"/>"></script>

<!--[if lt IE 9]>
<![endif]-->
</body>

<!-- Mirrored from htmlstream.com/preview/unify-v1.8/Blog/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 04 Dec 2015 14:29:47 GMT -->
</html>