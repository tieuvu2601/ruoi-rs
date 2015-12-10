<%@ include file="/common/taglibs.jsp"%>

<div class="col-md-3">
    <!-- Blog Thumb v3 -->
    <div class="margin-bottom-50">
        <h2 class="title-v4">Same Product / Relation Product</h2>
        <c:forEach var="i" begin="1" end="5">
            <div class="blog-thumb margin-bottom-20">
                <div class="blog-thumb-hover">
                    <img src="<c:url value="/themes/site/img/blog/img${i}.jpg"/>" alt="">
                    <a class="hover-grad" href="blog_single.html"><i class="fa fa-video-camera"></i></a>
                </div>
                <div class="blog-thumb-desc">
                    <h3><a href="blog_single.html">8 health benefits and drawbacks of coffee</a></h3>
                    <ul class="blog-thumb-info">
                        <li>Mar 6, 2015</li>
                        <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- End Blog Thumb v3 -->

    <!-- Blog Thumb v2 -->
    <div class="margin-bottom-50">
        <h2 class="title-v4">Recent News</h2>
        <c:forEach var="i" begin="1" end="5">
            <div class="blog-thumb blog-thumb-circle margin-bottom-15">
                <div class="blog-thumb-hover">
                    <img class="rounded-x" src="<c:url value="/themes/site/img/blog/img1${i}.jpg"/>" alt="">
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
        </c:forEach>
    </div>
    <!-- End Blog Thumb v2 -->
</div>

