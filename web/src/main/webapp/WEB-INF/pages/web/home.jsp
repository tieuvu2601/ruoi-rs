<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>

<content:buildSliderHomePage pageSize="5" var="sliderItems"/>
<oscache:cache key="home_page_slider_item" duration="1">
    <c:if test="${fn:length(sliderItems) > 0}">
        <div class="blog-ms-v1 content-sm bg-color-darker margin-bottom-60">
            <div class="master-slider ms-skin-default" id="masterslider">
                <c:forEach var="slider" items="${sliderItems}">
                    <div class="ms-slide blog-slider">
                        <seo:url value="${slider.title}" var="sliderUrl" prefix="/${slider.category.prefixUrl}/${slider.contentId}/"/>
                        <c:set var="sliderThumbnailsUrl" value="/repository${slider.thumbnails}"/>
                        <c:set var="sliderXMLData" value="${portal:parseContentXML(slider.xmlData)}"/>

                        <img src="<c:url value="/themes/site/plugins/master-slider/masterslider/style/blank.gif"/>" data-src="${sliderThumbnailsUrl}" alt="${slider.title}"/>
                        <c:if test="${not empty slider.categoryType && not empty slider.categoryType.name}">
                            <span class="blog-slider-badge">${slider.categoryType.name}</span>
                        </c:if>

                        <div class="ms-info"></div>
                        <div class="blog-slider-title">
                                <%--<span class="blog-slider-posted">Mar 6, 2015</span>--%>
                            <h2><a href="${sliderUrl}">${sliderXMLData.header[0]}</a></h2>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</oscache:cache>

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
                                        <fmt:message key="site.content.cost"/>:
                                        <span>
                                            ${portal:getNumberOfCost(project.cost)}
                                            <c:choose>
                                                <c:when test="${project.cost >= 1000}">
                                                    <fmt:message key="site.content.cost.billion"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:message key="site.content.cost.million"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </h5>
                                    <ul class="product-grid-info">
                                        <c:if test="${not empty project.locationText}">
                                            <li class="product-location"><fmt:message key="site.content.address"/>: <span>${project.locationText}</span></li>
                                        </c:if>

                                        <c:if test="${not empty project.area || not empty project.totalArea}">
                                            <c:choose>
                                                <c:when test="${not empty project.area}">
                                                    <li class="product-area">
                                                        <fmt:message key="site.content.area"/>:
                                                        <span>
                                                            ${project.area}&nbsp;
                                                            <c:choose>
                                                                <c:when test="${project.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                                                <c:when test="${project.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                                                <c:when test="${project.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                                            </c:choose>
                                                        </span>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="product-area">
                                                        <fmt:message key="site.content.area"/>:
                                                        <span>
                                                            ${project.totalArea}&nbsp;
                                                            <c:choose>
                                                                <c:when test="${project.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                                                <c:when test="${project.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                                                <c:when test="${project.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                                            </c:choose>
                                                        </span>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>

                                        <c:if test="${not empty project.areaRatio}">
                                            <li class="product-area-ratio"><fmt:message key="site.content.area.ratio"/> <span>${project.areaRatio}</span></li>
                                        </c:if>

                                        <c:if test="${not empty project.numberOfBlock}">
                                            <li class="product-number-of-block"><fmt:message key="site.content.number.of.block"/> <span>${project.numberOfBlock}</span></li>
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
                            <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img42.jpg"/>" alt="">

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
                            <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img46.jpg"/>" alt="">

                            <h3><a href="blog_single.html">Why we love watermelon...</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row margin-bottom-50">
                    <div class="col-sm-6 sm-margin-bottom-50">
                        <div class="blog-grid">
                            <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img48.jpg"/>" alt="">

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
                            <img class="img-responsive" src="<c:url value="/themes/site/img/blog/img47.jpg"/>" alt="">

                            <h3><a href="blog_single.html">7 tips of writing that you didn't know</a></h3>
                            <ul class="blog-grid-info">
                                <li>Richard Garner</li>
                                <li>Mar 6, 2015</li>
                                <li><a href="#"><i class="fa fa-comments"></i> 0</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <jsp:include page="../web/common/aboutme.jsp"></jsp:include>

            <jsp:include page="../web/common/hotproduct.jsp"></jsp:include>

            <jsp:include page="../web/common/recentnew.jsp"></jsp:include>

            <jsp:include page="../web/common/social.jsp"></jsp:include>
        </div>
    </div>
</div>


