<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>
<!-- Master Slider -->
<div class="blog-ms-v1 content-sm bg-color-darker margin-bottom-60">
    <div class="master-slider ms-skin-default" id="masterslider">
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img9.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Fashion</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Is this the end for fashion police?</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img52.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Hi-Tech</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Learning as you're earning: The alternative to a degree</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img5.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Sport</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Brady handed his place in history</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img16.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Fashion</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Nadège Vanhee-Cybulski makes Hermès debut</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img35.jpg"
                 alt="lorem ipsum dolor sit"/>
            <a href="http://player.vimeo.com/video/53914149" data-type="video"> vimeo video </a>
            <span class="blog-slider-badge">Travel</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Our favourite images of the week</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img41.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Travel</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Must be visited places in the world</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img48.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Health</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">5 Facts about Coca-Cola</a></h2>
            </div>
        </div>
        <div class="ms-slide blog-slider">
            <img src="assets/plugins/master-slider/masterslider/style/blank.gif" data-src="assets/img/blog/img53.jpg"
                 alt="lorem ipsum dolor sit"/>
            <span class="blog-slider-badge">Community</span>

            <div class="ms-info"></div>
            <div class="blog-slider-title">
                <span class="blog-slider-posted">Mar 6, 2015</span>

                <h2><a href="#">Minimalism gives way to embroidery and crystals</a></h2>
            </div>
        </div>
    </div>
</div>
<!-- End Master Slider -->

<!--=== Container Part ===-->
<div class="container margin-bottom-40">
    <div class="row">
        <!-- Main Content -->
        <div class="col-md-9">
            <!-- Tab v4 -->
            <content:findByCategoryWithMaxItem category="tin tuc" begin="0" pageSize="6" var="newItems"/>
            <oscache:cache key="hot_news_item" duration="1">
                <c:set var="firstNew" value="${newItems[0]}"/>
                <c:set var="firstNewData" value="${portal:parseContentXML(firstNew.xmlData)}"/>
                <c:set var="thumbnailsImg" value="/repository${firstNew.thumbnails}?w=650"/>
                    <div class="margin-bottom-30">
                        <h2 class="title-v4">${firstNew.category.name}</h2>
                        <div class="row margin-bottom-20">
                            <div class="col-sm-7">
                                <!-- Blog Grid -->
                                <div class="blog-grid margin-bottom-20">
                                    <img class="img-responsive" src="${thumbnailsImg}" alt="${firstNew.title}">
                                    <seo:url value="${firstNew.title}" var="seoURL" prefix="/${firstNew.category.prefixUrl}/${firstNew.contentId}/"/>
                                    <h3><a href="${seoURL}">${firstNewData.header[0]}</a></h3>
                                    <ul class="blog-grid-info">
                                        <li>${firstNew.createdBy.displayName}</li>
                                        <li><fmt:formatDate pattern="dd-MM-yyyy" value="${firstNew.publishedDate}"/></li>
                                    </ul>
                                    <p>${firstNew.description}</p>
                                    <a class="r-more" href="${seoURL}"><fmt:message key="site.read.more"/></a>
                                </div>
                                <!-- End Blog Grid -->
                            </div>
                            <div class="col-sm-5">
                                <c:forEach var="index" begin="1" end="${fn:length(newItems) - 1}">
                                    <c:set var="news" value="${newItems[index]}"/>
                                    <c:set var="newsXMLData" value="${portal:parseContentXML(news.xmlData)}"/>
                                    <seo:url value="${news.title}" var="newUrl" prefix="/${news.category.prefixUrl}/${news.contentId}/"/>
                                    <div class="blog-thumb margin-bottom-20">
                                        <div class="blog-thumb-hover">
                                            <c:set var="thumbnailsImg" value="/repository${news.thumbnails}?w=120"/>
                                            <img src="${thumbnailsImg}" alt="${news.title}">
                                            <a class="hover-grad" href="${newUrl}"><i class="fa fa-photo"></i></a>
                                        </div>
                                        <div class="blog-thumb-desc">
                                            <h3><a href="${newUrl}">${newsXMLData.header[0]}</a></h3>
                                            <ul class="blog-thumb-info">
                                                <li><fmt:formatDate pattern="dd-MM-yyyy" value="${news.publishedDate}"/></li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div><!--/end row-->
                    </div>
            <!-- End Tab v4 -->
            </oscache:cache>

            <%--@TODO ADD CAN HO--%>

            <!-- Blog Carousel Heading -->
            <div class="blog-cars-heading">
                <a href="<c:url value="/products/1/category.html"/>"><h2>CAN HO<small>(10 Products)</small></h2></a>

                <div class="owl-navigation">
                    <div class="customNavigation">
                        <a class="owl-btn prev-v3 btn-prev-v1"><i class="fa fa-angle-left"></i></a>
                        <a class="owl-btn next-v3 btn-next-v1"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <!--/navigation-->
            </div>
            <!-- End Blog Carousel Heading -->
            <!-- Blog Carousel -->
            <div class="blog-carousel carousel_v1">
                <c:forEach var="idx" begin="0" end="5">
                    <!-- Blog Grid -->
                    <div class="row margin-bottom-50">
                        <div class="col-sm-4 sm-margin-bottom-50">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img46.jpg"/>" alt="">

                                <h3><a href="blog_single.html">9 Most visited Mountains in the world</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img50.jpg"/>" alt="">

                                <h3><a href="blog_single.html">10 Most beautiful beaches so ${idx}</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img50.jpg"/>" alt="">

                                <h3><a href="blog_single.html">10 Most beautiful beaches so ${idx}</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--/end row-->
                    <!-- End Blog Grid -->
                </c:forEach>
            </div>
            <!-- End Blog Carousel -->

            <%--@TODO ADD SHOP HOUSE & OFFICETEL--%>

            <!-- Blog Carousel Heading -->
            <div class="blog-cars-heading">
                <a href="<c:url value="/products/1/category.html"/>"><h2>SHOP HOUSE & OFFICETEL<small>(10 Products)</small></h2></a>
                <div class="owl-navigation">
                    <div class="customNavigation">
                        <a class="owl-btn prev-v3 btn-prev-v2"><i class="fa fa-angle-left"></i></a>
                        <a class="owl-btn next-v3 btn-next-v2"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <!--/navigation-->
            </div>
            <!-- End Blog Carousel Heading -->
            <!-- Blog Carousel -->
            <div class="blog-carousel carousel_v2">
                <c:forEach var="idx" begin="0" end="5">
                    <!-- Blog Grid -->
                    <div class="row margin-bottom-50">
                        <div class="col-sm-6 sm-margin-bottom-50">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img46.jpg"/>" alt="">

                                <h3><a href="blog_single.html">9 Most visited Mountains in the world so ${idx}</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img50.jpg"/>" alt="">

                                <h3><a href="blog_single.html">10 Most beautiful beaches</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--/end row-->
                    <!-- End Blog Grid -->
                </c:forEach>
            </div>
            <!-- End Blog Carousel -->

            <%--@TODO ADD ĐẤT NỀN--%>

            <!-- Blog Carousel Heading -->
            <div class="blog-cars-heading">
                <a href="<c:url value="/products/1/category.html"/>"><h2>DAT NEN<small>(10 Products)</small></h2></a>
                <div class="owl-navigation">
                    <div class="customNavigation">
                        <a class="owl-btn prev-v3 btn-prev-v3"><i class="fa fa-angle-left"></i></a>
                        <a class="owl-btn next-v3 btn-next-v3"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <!--/navigation-->
            </div>
            <!-- End Blog Carousel Heading -->
            <!-- Blog Carousel -->
            <div class="blog-carousel carousel_v3">
                <c:forEach var="idx" begin="0" end="5">
                    <!-- Blog Grid -->
                    <div class="row margin-bottom-50">
                        <div class="col-sm-6 sm-margin-bottom-50">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img46.jpg"/>" alt="">

                                <h3><a href="blog_single.html">9 Most visited Mountains in the world so ${idx}</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="blog-grid">
                                <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img50.jpg"/>" alt="">

                                <h3><a href="blog_single.html">10 Most beautiful beaches</a></h3>
                                <ul class="blog-grid-info">
                                    <li>Richard Garner</li>
                                    <li>Mar 6, 2015</li>
                                    <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--/end row-->
                    <!-- End Blog Grid -->
                </c:forEach>
            </div>
            <!-- End Blog Carousel -->

            <!-- Blog Grid -->
            <div class="margin-bottom-50">
                <h2 class="title-v4">Monthly News</h2>
                <!-- Blog Grid -->
                <div class="row margin-bottom-50">
                    <div class="col-sm-6 sm-margin-bottom-50">
                        <div class="blog-grid">
                            <img class="img-responsive" src="assets/img/blog/img42.jpg" alt="">

                            <h3><a href="blog_single.html">6 Facts about dogs</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="blog-grid">
                            <img class="img-responsive" src="assets/img/blog/img49.jpg" alt="">

                            <h3><a href="blog_single.html">Why we love watermelon...</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--/end row-->
                <!-- End Blog Grid -->

                <!-- Blog Grid -->
                <div class="row margin-bottom-50">
                    <div class="col-sm-6 sm-margin-bottom-50">
                        <div class="blog-grid">
                            <img class="img-responsive" src="assets/img/blog/img48.jpg" alt="">

                            <h3><a href="blog_single.html">5 Facts about Coca-Cola</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="blog-grid">
                            <img class="img-responsive" src="assets/img/blog/img47.jpg" alt="">

                            <h3><a href="blog_single.html">7 tips of writing that you didn't know</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--/end row-->
                <!-- End Blog Grid -->
            </div>
            <!-- End Blog Grid -->
        </div>
        <!-- Right Sidebar -->
        <div class="col-md-3">
        <!-- Blog Thumb v3 -->
        <div class="margin-bottom-50">
            <h2 class="title-v4">ABOUT ME</h2>

            <div class="blog-thumb-v3">
                <small><a href="#">Evan Bartlett</a></small>
                <h3><a href="#">Cameron's silence on defence is shameful</a></h3>
            </div>

            <div class="blog-thumb-v3">
                <small><a href="#">Jonathan Owen</a></small>
                <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
            </div>

            <div class="blog-thumb-v3">
                <small><a href="#">Jonathan Owen</a></small>
                <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
            </div>

            <div class="blog-thumb-v3">
                <small><a href="#">Jonathan Owen</a></small>
                <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
            </div>
            <hr class="hr-xs">
        </div>
        <!-- End Blog Thumb v3 -->

        <!-- Blog Thumb v2 -->
        <div class="margin-bottom-50">
            <h2 class="title-v4">Recent News</h2>

            <c:forEach var="new_index" begin="0" end="6">
                <div class="blog-thumb blog-thumb-circle margin-bottom-15">
                    <div class="blog-thumb-hover">
                        <img class="rounded-x" src="<c:url value="/themes/site/img/blog/img1.jpg"/>" alt="">
                        <a class="hover-grad" href="blog_single.html"><i class="fa fa-link"></i></a>
                    </div>
                    <div class="blog-thumb-desc">
                        <h3><a href="blog_single.html">Tieu de cua tin tuc so ${new_index}</a></h3>
                        <ul class="blog-thumb-info">
                            <li>Mar 6, 2015</li>
                            <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                        </ul>
                    </div>
                </div>
            </c:forEach>

        </div>
        <!-- End Blog Thumb v2 -->

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

        <!-- Tab v5 -->
        <div class="tab-v5 margin-bottom-50">
            <ul class="nav nav-tabs" role="tablist">
                <li class="home active">
                    <a href="#tab-v5-a1" role="tab" data-toggle="tab">Hi-Tech</a>
                </li>
                <li>
                    <a href="#tab-v5-a2" role="tab" data-toggle="tab">Other News</a>
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane in active" id="tab-v5-a1">
                    <!-- Blog Grid -->
                    <div class="blog-grid margin-bottom-30">
                        <h3><a href="blog_single.html">Audio Recorder AR-T7 explained</a></h3>
                        <ul class="blog-grid-info">
                            <li>Mar 6, 2015</li>
                            <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                        </ul>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec imperdiet sed eros sed tincidunt.</p>
                    </div>
                    <!-- End Blog Grid -->

                    <!-- Blog Thumb -->
                    <div class="blog-thumb margin-bottom-20">
                        <div class="blog-thumb-hover">
                            <img src="assets/img/blog/img44.jpg" alt="">
                            <a class="hover-grad" href="blog_single.html"><i class="fa fa-video-camera"></i></a>
                        </div>
                        <div class="blog-thumb-desc">
                            <h3><a href="blog_single.html">Apple iPad review</a></h3>
                        </div>
                    </div>
                    <!-- End Blog Thumb -->

                    <!-- Blog Thumb -->
                    <div class="blog-thumb">
                        <div class="blog-thumb-hover">
                            <img src="assets/img/blog/img8.jpg" alt="">
                            <a class="hover-grad" href="blog_single.html"><i class="fa fa-photo"></i></a>
                        </div>
                        <div class="blog-thumb-desc">
                            <h3><a href="blog_single.html">The new MacBook Air Impressions!</a></h3>
                        </div>
                    </div>
                    <!-- End Blog Thumb -->
                </div>
                <div class="tab-pane" id="tab-v5-a2">
                    <div class="blog-thumb-v3">
                        <small>Mar 6, 2015</small>
                        <h3><a href="#">Cameron's silence on defence is shameful</a></h3>
                    </div>

                    <hr class="hr-xs">

                    <div class="blog-thumb-v3">
                        <small>Mar 7, 2015</small>
                        <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
                    </div>

                    <hr class="hr-xs">

                    <div class="blog-thumb-v3">
                        <small>Mar 9, 2015</small>
                        <h3><a href="#">Fashion's first selfies: It was a 16th-century German accountant who started the trend
                            for style blogging</a></h3>
                    </div>

                    <hr class="hr-xs">

                    <div class="blog-thumb-v3">
                        <small>Mar 12, 2015</small>
                        <h3><a href="#">How to run a country: A 10 point manifesto for leaders who stand – and want to
                            deliver</a></h3>
                    </div>

                    <hr class="hr-xs">

                    <div class="blog-thumb-v3">
                        <small>Mar 23, 2015</small>
                        <h3><a href="#">Controversial plan to test new primary school pupils infuriates teachers</a></h3>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Tab v5 -->

        </div>
        <!-- End Right Sidebar -->
    </div>
</div>
<!--=== End Container Part ===-->

