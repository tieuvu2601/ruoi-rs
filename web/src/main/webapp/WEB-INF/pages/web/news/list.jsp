<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>Title of page!</title>
    <meta name="description" content="must be revise after !!!!! ">
</head>

<!--=== Breadcrumbs ===-->
<div class="breadcrumbs breadcrumbs-light">
    <div class="container">
        <h1 class="pull-left">Post Layout v1</h1>
        <ul class="pull-right breadcrumb">
            <li><a href="index.html">Home</a></li>
            <li><a href="#">Post Layouts</a></li>
            <li class="active">Post Layout v1</li>
        </ul>
    </div>
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->

<!--=== Container Part ===-->
<div class="container content-sm">
<div class="row">
<div class="col-md-9 md-margin-bottom-50">
<div class="row margin-bottom-50">
<div class="col-sm-6">
    <c:forEach var="idx" begin="1" end="10">
        <!-- Blog Thumb -->
        <div class="blog-thumb margin-bottom-20">
            <div class="blog-thumb-hover">
                <img src="<c:url value="/themes/site/img/blog/img${idx}.jpg"/>" alt="">
                <a class="hover-grad" href="<c:url value="/news/${idx}/tilte-of-new.html"/>"><i class="fa fa-video-camera"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="<c:url value="/news/${idx}/tilte-of-new.html"/>">Nadège Vanhee-Cybulski makes Hermès debut</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>
        <!-- End Blog Thumb -->
    </c:forEach>
    <!-- End Blog Thumb -->
</div>

<div class="col-sm-6">
    <c:forEach var="idx" begin="11" end="20">
        <!-- Blog Thumb -->
        <div class="blog-thumb margin-bottom-20">
            <div class="blog-thumb-hover">
                <img src="<c:url value="/themes/site/img/blog/img${idx}.jpg"/>" alt="">
                <a class="hover-grad" href="<c:url value="/news/${idx}/tilte-of-new.html"/>"><i class="fa fa-video-camera"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="<c:url value="/news/${idx}/tilte-of-new.html"/>">Nadège Vanhee-Cybulski makes Hermès debut</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>
        <!-- End Blog Thumb -->
    </c:forEach>
</div>
</div><!--/end row-->

<!-- Pager v4 -->
<ul class="pager pager-v4">
    <li class="previous"><a class="rounded-3x" href="#">&larr; Older</a></li>
    <li class="page-amount">1 of 7</li>
    <li class="next"><a class="rounded-3x" href="#">Newer &rarr;</a></li>
</ul>
<!-- End Pager v4 -->
</div>

<div class="col-md-3">
    <!-- Blog Thumb v3 -->
    <div class="margin-bottom-50">
        <h2 class="title-v4">Blog &amp; Comments</h2>

        <div class="blog-thumb-v3">
            <small><a href="#">Evan Bartlett</a></small>
            <h3><a href="#">Cameron's silence on defence is shameful</a></h3>
        </div>

        <hr class="hr-xs">

        <div class="blog-thumb-v3">
            <small><a href="#">Jonathan Owen</a></small>
            <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
        </div>

        <hr class="hr-xs">

        <div class="blog-thumb-v3">
            <small><a href="#">Susie Lau</a></small>
            <h3><a href="#">Fashion's first selfies: It was a 16th-century German accountant who started the trend for style blogging</a></h3>
        </div>

        <hr class="hr-xs">

        <div class="blog-thumb-v3">
            <small><a href="#">John Rentoul</a></small>
            <h3><a href="#">How to run a country: A 10 point manifesto for leaders who stand – and want to deliver</a></h3>
        </div>

        <hr class="hr-xs">

        <div class="blog-thumb-v3">
            <small><a href="#">Richard Garner</a></small>
            <h3><a href="#">Controversial plan to test new primary school pupils infuriates teachers</a></h3>
        </div>
    </div>
    <!-- End Blog Thumb v3 -->

    <!-- Social Shares -->
    <div class="margin-bottom-50">
        <h2 class="title-v4">Social</h2>
        <ul class="blog-social-shares">
            <li>
                <i class="rounded-x fb fa fa-facebook"></i>
                <a class="rounded-3x" href="#">Like</a>
                <span class="counter">31,702</span>
            </li>
            <li>
                <i class="rounded-x tw fa fa-twitter"></i>
                <a class="rounded-3x" href="#">Follow Us</a>
                <span class="counter">164,290</span>
            </li>
            <li>
                <i class="rounded-x gp fa fa-google-plus"></i>
                <a class="rounded-3x" href="#">Add to circle</a>
                <span class="counter">5,425,764</span>
            </li>
        </ul>
    </div>
    <!-- End Social Shares -->

    <!-- Blog Thumb v2 -->
    <div class="margin-bottom-50">
        <h2 class="title-v4">Recent News</h2>

        <div class="blog-thumb blog-thumb-circle margin-bottom-15">
            <div class="blog-thumb-hover">
                <img class="rounded-x" src="assets/img/blog/img1.jpg" alt="">
                <a class="hover-grad" href="blog_single.html"><i class="fa fa-link"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="blog_single.html">Misused words and how to use them correctly</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>

        <div class="blog-thumb blog-thumb-circle margin-bottom-15">
            <div class="blog-thumb-hover">
                <img class="rounded-x" src="assets/img/blog/img22.jpg" alt="">
                <a class="hover-grad" href="blog_single.html"><i class="fa fa-link"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="blog_single.html">8 health benefits and drawbacks of coffee</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>

        <div class="blog-thumb blog-thumb-circle margin-bottom-15">
            <div class="blog-thumb-hover">
                <img class="rounded-x" src="assets/img/blog/img2.jpg" alt="">
                <a class="hover-grad" href="blog_single.html"><i class="fa fa-link"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="blog_single.html">What are the top five books you must read?</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>

        <div class="blog-thumb blog-thumb-circle">
            <div class="blog-thumb-hover">
                <img class="rounded-x" src="assets/img/blog/img21.jpg" alt="">
                <a class="hover-grad" href="blog_single.html"><i class="fa fa-link"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="blog_single.html">Stylish things to do, see and buy this week</a></h3>
                <ul class="blog-thumb-info">
                    <li>Mar 6, 2015</li>
                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- End Blog Thumb v2 -->
</div>
</div><!--/end row-->
</div>
<!--=== End Container Part ===-->
