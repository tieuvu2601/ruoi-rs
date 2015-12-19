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
        <div class="col-md-9">
            <content:findByCategoryWithMaxItem category="tin tuc" begin="0" pageSize="6" var="newItems"/>
            <oscache:cache key="hot_news_item" duration="1">
                <c:set var="firstNew" value="${newItems[0]}"/>
                <c:set var="firstNewData" value="${portal:parseContentXML(firstNew.xmlData)}"/>
                <c:set var="thumbnailsImg" value="/repository${firstNew.thumbnails}?w=650"/>
                    <div class="margin-bottom-30">
                        <h2 class="title-v4"><a href="">${firstNew.category.name}</a></h2>
                        <div class="row margin-bottom-20">
                            <div class="col-sm-7">
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
                        </div>
                    </div>
            </oscache:cache>


            <content:findAllContentsByCategoryType begin="0" pageSize="6" var="productTypes"/>
            <oscache:cache key="product_type_items" duration="1">
                <c:forEach var="productType" varStatus="productTypeStatus" items="${productTypes}">
                    <div class="blog-cars-heading">
                        <seo:url value="${productType.categoryType.code}" var="productTypeUrl" prefix="/products/"/>
                        <a href="<c:url value="${productTypeUrl}"/>"><h2>${productType.categoryType.name}<small>(${productType.totalNumber}&nbsp;<fmt:message key="site.project"/>)</small></h2></a>

                        <div class="owl-navigation">
                            <div class="customNavigation">
                                <a class="owl-btn btn-prev-v${productTypeStatus.count}"><i class="fa fa-angle-left"></i></a>
                                <a class="owl-btn btn-next-v${productTypeStatus.count}"><i class="fa fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="blog-carousel carousel_v${productTypeStatus.count}">
                        <c:forEach var="project" varStatus="projectStatus" items="${productType.contents}">
                            <c:if test="${projectStatus.index%2 == 0}">
                                <div class="row margin-bottom-50">
                            </c:if>
                            <c:set var="projectXMLData" value="${portal:parseContentXML(project.xmlData)}"/>

                            <div class="col-sm-6 sm-margin-bottom-50">
                                <div class="blog-grid product-grid">
                                    <seo:url value="${project.title}" var="productUrl" prefix="/products/${project.contentId}/"/>
                                    <div class="blog-grid-hover">
                                        <c:set var="thumbnailsImg" value="/repository${project.thumbnails}"/>
                                        <img class="img-responsive" src="<c:url value="${thumbnailsImg}?w=650"/>" alt="">
                                        <a class="hover-grad" href="${productUrl}"><fmt:message key="site.view.detail"/></a>
                                    </div>

                                    <h4><a href="${productUrl}">${projectXMLData.header[0]}</a></h4>
                                    <h5 class="product-cost">
                                        ${portal:getNumberOfCost(project.cost)}
                                        <c:choose>
                                            <c:when test="${project.cost >= 1000}">
                                                <fmt:message key="site.content.cost.billion"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:message key="site.content.cost.million"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </h5>
                                    <ul class="product-grid-info">
                                        <c:if test="${not empty project.locationText}">
                                            <li class="product-location"><fmt:message key="site.content.address"/>: ${project.locationText}</li>
                                        </c:if>

                                        <c:if test="${not empty project.area || not empty project.totalArea}">
                                            <c:choose>
                                                <c:when test="${not empty project.area}">
                                                    <li class="product-area">
                                                        <fmt:message key="site.content.area"/>:  ${project.area}&nbsp;
                                                        <c:choose>
                                                            <c:when test="${project.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                                            <c:when test="${project.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                                            <c:when test="${project.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                                        </c:choose>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="product-area">
                                                        <fmt:message key="site.content.area"/>:  ${project.totalArea}&nbsp;
                                                        <c:choose>
                                                            <c:when test="${project.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                                            <c:when test="${project.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                                            <c:when test="${project.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                                        </c:choose>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>

                                        </c:if>

                                        <c:if test="${not empty project.areaRatio}">
                                            <li class="product-area-ratio"><fmt:message key="site.content.area.ratio"/> ${project.areaRatio}</li>
                                        </c:if>

                                        <c:if test="${not empty project.numberOfBlock}">
                                            <li class="product-number-of-block"><fmt:message key="site.content.number.of.block"/> ${project.numberOfBlock}</li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>

                            <c:if test="${projectStatus.index%2 == 1 || projectStatus.index == (fn:length(productType.contents) - 1)}">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>
            </oscache:cache>



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
            <jsp:include page="../web/common/aboutme.jsp"></jsp:include>

            <jsp:include page="../web/common/hotproduct.jsp"></jsp:include>

            <jsp:include page="../web/common/recentnew.jsp"></jsp:include>

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
        </div>
        <!-- End Right Sidebar -->
    </div>
</div>
<!--=== End Container Part ===-->

