<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <seo:url value="${item.title}" var="itemUrl" prefix="/${item.category.prefixUrl}/${item.contentId}/"/>
    <c:set var="itemThumbnailsUrl" value="/repository${item.thumbnails}"/>
    <c:set var="itemXMLData" value="${portal:parseContentXML(item.xmlData)}"/>
    <title>${item.title}</title>
    <meta name="description" content="${item.description}">
    <meta name="keywords" content="${item.keyword}">


    <meta property="og:url"           content="${itemUrl}" />
    <meta property="og:type"          content="${item.categoryType.name}"/>
    <meta property="og:title"         content="${item.title}" />
    <meta property="og:description"   content="${item.description}"/>

    <meta property="og:image"         content="${itemThumbnailsUrl}"/>

</head>
<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.5&appId=797480313696960";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>



<div class="breadcrumbs breadcrumbs-light">
    <div class="container">
        <h1 class="pull-left">${category.title}</h1>
        <ul class="pull-right breadcrumb">
            <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a></li>
            <c:choose>
                <c:when test="${not empty category.parent}">
                    <li><a href="#">${category.parent.name}</a></li>
                    <seo:url value="${category.code}" var="menuUrl" prefix="/${category.prefixUrl}/"/>
                    <li class="active"><a href="${menuUrl}">${category.name}</a></li>
                </c:when>
                <c:otherwise>
                    <seo:url value="${category.code}" var="menuUrl" prefix="/${category.prefixUrl}/"/>
                    <li class="active"><a href="${menuUrl}">${category.name}</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>

<div class="container content product-container">
    <div class="row">
        <div class="col-md-9">
            <!-- Blog Grid -->
            <div class="blog-grid margin-bottom-10">
                <h2 class="blog-grid-title-lg">${itemXMLData.header[0]}</h2>
                <div class="overflow-h margin-bottom-10">
                    <ul class="blog-grid-info pull-left">
                        <li>${item.createdBy.displayName}</li>
                        <li><fmt:formatDate pattern="dd-MM-yyyy" value="${item.publishedDate}"/></li>
                    </ul>
                    <div class="pull-right">
                        <div class="addthis_sharing_toolbox">
                            <div class="fb-like" data-href="${itemUrl}" data-layout="button" data-action="like" data-show-faces="false" data-share="true"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Blog Grid -->

            <div class="blog-grid margin-bottom-30">
                <img class="img-responsive img-product-thumbnail" src="${itemThumbnailsUrl}" alt="${item.title}">
                <div class="blog-grid-inner">
                    <h3><a href="${itemUrl}">${itemXMLData.header[0]}</a></h3>
                    <h4><fmt:message key="site.content.cost"/>:
                        ${portal:getNumberOfCost(item.cost)}
                        <c:choose>
                            <c:when test="${item.cost >= 1000}">
                                <fmt:message key="site.content.cost.billion"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="site.content.cost.million"/>
                            </c:otherwise>
                        </c:choose>
                    </h4>
                    <c:if test="${not empty item.locationText}">
                        <h5 class="product-location"><fmt:message key="site.content.address"/>: ${item.locationText}</h5>
                    </c:if>

                    <c:if test="${not empty item.area || not empty item.totalArea}">
                        <c:choose>
                            <c:when test="${not empty item.area}">
                                <h5 class="product-area">
                                    <fmt:message key="site.content.area"/>:  ${item.area}&nbsp;
                                    <c:choose>
                                        <c:when test="${item.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                        <c:when test="${item.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                        <c:when test="${item.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                    </c:choose>
                                </h5>
                            </c:when>
                            <c:otherwise>
                                <h5 class="product-area">
                                    <fmt:message key="site.content.area"/>:  ${item.totalArea}&nbsp;
                                    <c:choose>
                                        <c:when test="${item.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                        <c:when test="${item.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                        <c:when test="${item.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                    </c:choose>
                                </h5>
                            </c:otherwise>
                        </c:choose>

                    </c:if>

                    <c:if test="${not empty item.areaRatio}">
                        <h5 class="product-area-ratio"><fmt:message key="site.content.area.ratio"/> ${item.areaRatio}</h5>
                    </c:if>

                    <c:if test="${not empty item.numberOfBlock}">
                        <h5 class="product-number-of-block"><fmt:message key="site.content.number.of.block"/> ${item.numberOfBlock}</h5>
                    </c:if>
                </div>
            </div>
            <!-- End Blog Grid -->

            <p>${itemXMLData.shotDescription[0]}</p><br>

            <div class="row tab-v3">
                <div class="col-sm-3">
                    <ul class="nav nav-pills nav-stacked">
                        <c:if test="${not empty itemXMLData.description[0]}">
                            <li class="active">
                                <a href="#product-description" data-toggle="tab" aria-expanded="false">Thong tin</a></li>
                        </c:if>
                        <c:if test="${not empty itemXMLData.feature[0]}">
                            <li class="">
                                <a href="#product-feature" data-toggle="tab" aria-expanded="false">Tien ich</a></li>
                        </c:if>
                        <c:if test="${not empty itemXMLData.costAndPay[0]}">
                            <li class="">
                                <a href="#product-costAndPay" data-toggle="tab" aria-expanded="false">Gia ban va thanh toan</a></li>
                        </c:if>
                        <c:if test="${not empty itemXMLData.location[0]}">
                            <li class="">
                                <a href="#product-location" data-toggle="tab" aria-expanded="false">Vi tri </a></li>
                        </c:if>
                        <c:if test="${not empty itemXMLData.progress[0]}">
                            <li class="">
                                <a href="#product-progress" data-toggle="tab" aria-expanded="false">Tien do du an</a></li>
                        </c:if>
                        <c:if test="${not empty itemXMLData.gallery}">
                            <li class="">
                                <a href="#product-gallery" data-toggle="tab" aria-expanded="false">Hinh anh</a></li>
                        </c:if>
                    </ul>
                </div>
                <div class="col-sm-9">
                    <div class="tab-content">
                        <c:if test="${not empty itemXMLData.description[0]}">
                            <div class="tab-pane fade" id="product-description">
                                <h4>Thong tin du an</h4>
                                <div>
                                    ${itemXMLData.description[0]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty itemXMLData.feature[0]}">
                            <div class="tab-pane fade" id="product-feature">
                                <h4>Tien ich</h4>
                                <div>
                                    ${itemXMLData.feature[0]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty itemXMLData.costAndPay[0]}">
                            <div class="tab-pane fade" id="product-costAndPay">
                                <h4>Gia ban va thanh toan</h4>
                                <div>
                                    ${itemXMLData.costAndPay[0]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty itemXMLData.location[0]}">
                            <div class="tab-pane fade" id="product-location">
                                <h4>Vi tri</h4>
                                <div>
                                    ${itemXMLData.location[0]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty itemXMLData.progress[0]}">
                            <div class="tab-pane fade" id="product-progress">
                                <h4>Tien do du an</h4>
                                <div>
                                    ${itemXMLData.progress[0]}
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty itemXMLData.gallery}">
                            <div class="tab-pane fade" id="product-gallery">
                                <h4>Hinh anh</h4>
                                <div>
                                    ${itemXMLData.gallery[0]}
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Tab v5 -->
            <div class="tab-v5 margin-bottom-50">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="home active">
                        <a href="#tab-v5-a1" role="tab" data-toggle="tab">Thong tin</a>
                    </li>
                    <li>
                        <a href="#tab-v5-a2" role="tab" data-toggle="tab">Tien Ich</a>
                    </li>
                    <li>
                        <a href="#tab-v5-a3" role="tab" data-toggle="tab">Gia ban Thanh Toan</a>
                    </li>
                    <li>
                        <a href="#tab-v5-a4" role="tab" data-toggle="tab">Vi Tri</a>
                    </li>
                    <li>
                        <a href="#tab-v5-a5" role="tab" data-toggle="tab">Tien Do</a>
                    </li>
                    <li>
                        <a href="#tab-v5-a6" role="tab" data-toggle="tab">Hinh Anh</a>
                    </li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active" id="tab-v5-a1">
                        <!-- Blog Grid -->
                        <div class="blog-grid margin-bottom-30">
                            ${itemXMLData.description[0]}
                        </div>
                        <!-- End Blog Grid -->
                    </div>

                    <div class="tab-pane" id="tab-v5-a2">
                        <div class="blog-thumb-v3">
                            <div class="blog-grid margin-bottom-30">
                                ${itemXMLData.feature[0]}
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-v5-a3">
                        <div class="blog-thumb-v3">
                            <div class="blog-grid margin-bottom-30">
                                ${itemXMLData.costAndPay[0]}
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-v5-a4">
                        <div class="blog-thumb-v3">
                            <small>Mar 6, 2015</small>
                            <h3><a href="#">Cameron's silence on defence is shameful</a></h3>
                            <div>
                                ${itemXMLData.location[0]}
                            </div>
                        </div>

                        <hr class="hr-xs">

                        <div class="blog-thumb-v3">
                            <small>Mar 7, 2015</small>
                            <h3><a href="#">Architects plan to stop skyscrapers from blocking out sunlight</a></h3>
                            <div>
                                ${itemXMLData.progress[0]}
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tab-v5-a5">
                        <div class="blog-thumb-v3">
                            <small>Mar 6, 2015</small>
                            <h3><a href="#">Cameron's silence on defence is shameful</a></h3>
                            <div>
                                ${itemXMLData.gallery[0]}
                            </div>
                        </div>
                        <hr class="hr-xs">
                    </div>
                </div>
            </div>

            <c:if test="${not empty item.keyword}">
                <c:set var="keywords" value="${portal:generatorKeyword(item.keyword, ',')}"/>
                <c:if test="${fn:length(keywords) > 0}">
                    <ul class="blog-grid-tags">
                        <li class="head"><fmt:message key="site.keyword.tags"/></li>
                        <c:forEach var="keyword" items="${keywords}">
                            <li><a href="#">${keyword}</a></li>
                        </c:forEach>
                    </ul>
                </c:if>
            </c:if>

            <!-- Blog Thumb v4 -->
            <div class="margin-bottom-50">
                <h2 class="title-v4">Related Product</h2>
                <div class="row margin-bottom-50">
                    <c:forEach var="idx" begin="1" end="8">
                        <div class="col-sm-3 col-xs-6 sm-margin-bottom-30">
                            <!-- Blog Thumb v4 -->
                            <div class="blog-thumb-v4">
                                <div class="blog-thumb-item">
                                    <img class="img-responsive margin-bottom-10" src="<c:url value="/themes/site/img/blog/img40.jpg"/>" alt="">
                                    <div class="center-wrap">
                                        <div class="center-alignCenter">
                                            <div class="center-body">
                                                <a href="https://player.vimeo.com/video/74197060" class="fbox-modal fancybox.iframe video-play-btn" title="What will fashion be like in 25 years?">
                                                    <img class="video-play-btn" src="<c:url value="/themes/site/img/icons/video-play.png"/>" alt="">
                                                </a>
                                            </div>
                                        </div>
                                    </div><!--/end center wrap-->
                                </div>
                                <h3><a href="blog_single.html">What will fashion be like in 25 years?</a></h3>
                            </div>
                            <!-- End Blog Thumb v4 -->
                        </div>
                    </c:forEach>

                </div><!--/end row-->
            </div>
            <!-- End Blog Thumb v4 -->

            <div class="fb-comments" data-href="${itemUrl}" data-width="100%" data-numposts="10"></div>
        </div>


        <div class="col-md-3">
            <jsp:include page="../common/aboutme.jsp"></jsp:include>

            <jsp:include page="../common/recentnew.jsp"></jsp:include>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        <c:choose>
            <c:when test="${not empty category.parent}">
                setCurrentSelectedMenu($('#menu-index-${category.parent.categoryId}'), $('#menu-sub-index-${category.categoryId}'));
            </c:when>
            <c:otherwise>
                setCurrentSelectedMenu($('#menu-index-${category.categoryId}'), null);
            </c:otherwise>
        </c:choose>
    });

    function setCurrentSelectedMenu(menu, subMenu){
        $('#top-navigation-container').find('li').removeClass('active');
        if($(menu != null && menu != undefined)){
            $(menu).addClass('active');
            if($(subMenu != null && subMenu != undefined)){
                $(subMenu).addClass('active');
            }
        }
    }
</script>
</body>
</html>

