<%@ include file="/common/taglibs.jsp"%>
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
            <c:forEach var="i" begin="1" end="10">
                <!-- Blog Grid -->
                <div class="row margin-bottom-50">
                    <div class="col-sm-4 sm-margin-bottom-20">
                        <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img${i}.jpg"/>" alt="">
                    </div>
                    <div class="col-sm-8">
                        <div class="blog-grid">
                            <h3><a href="blog_single.html">New winter fashion style</a></h3>
                            <ul class="blog-grid-info">
                                <li>Evan Bartlett</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                            <p>Pellentesque turpis lacus, tempus et fermentum vitae, dignissim ornare purus. Nulla facilisi. Suspendisse potenti. Aenean vitae lacus lobortis lacus finibus volutpat eu nec sem. Sed ultrices velit vitae tortor posuere ultrices.</p>
                            <a class="r-more" href="blog_single.html">Read More</a>
                        </div>
                    </div>
                </div>
                <!-- End Blog Grid -->
            </c:forEach>

            <!-- Pager v4 -->
            <ul class="pager pager-v4">
                <li class="previous"><a class="rounded-3x" href="#">&larr; Older</a></li>
                <li class="page-amount">1 of 7</li>
                <li class="next"><a class="rounded-3x" href="#">Newer &rarr;</a></li>
            </ul>
            <!-- End Pager v4 -->
        </div>

    <jsp:include page="../common/rightpanel.jsp"/>
    </div><!--/end row-->
</div>
<!--=== End Container Part ===-->
