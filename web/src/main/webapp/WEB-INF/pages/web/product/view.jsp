<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <c:set var="siteUrl" value="http://canhovabietthu.com"/>
    <title>${item.title}</title>
    <meta name="description" content="${item.description}">
    <meta name="keywords" content="${item.keyword}">

    <seo:url value="${item.title}" var="itemUrl" prefix="/${item.category.prefixUrl}/${item.contentId}/"/>
    <c:set var="itemThumbnailsUrl" value="/repository${item.thumbnails}"/>
    <c:set var="itemXMLData" value="${portal:parseContentXML(item.xmlData)}"/>


    <meta property="og:url"           content="${itemUrl}" />
    <meta property="og:type"          content="${item.categoryType.name}"/>
    <meta property="og:title"         content="${item.title}" />
    <meta property="og:description"   content="${item.description}"/>

    <meta property="fb:admins" content="100001895982023"/>
    <meta property="fb:app_id" content="1127660597245028" />
    <meta property="og:image"         content="${siteUrl}${itemThumbnailsUrl}"/>

</head>
<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.5&appId=1127660597245028";
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
            <div class="blog-grid margin-bottom-20">
                <h2 class="blog-grid-title-lg">${item.header}</h2>
                <div class="overflow-h margin-bottom-10">
                    <ul class="blog-grid-info pull-left">
                        <li>${item.createdBy.displayName}</li>
                        <li><fmt:formatDate pattern="dd-MM-yyyy" value="${item.publishedDate}"/></li>
                    </ul>
                    <div class="pull-right">
                        <div class="addthis_sharing_toolbox">
                            <div class="fb-like" data-href="${siteUrl}${itemUrl}" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="blog-grid margin-bottom-20">
                <img class="img-responsive img-product-thumbnail" src="${itemThumbnailsUrl}" alt="${item.title}">
                <div class="blog-grid-inner">
                    <h3><a href="${itemUrl}">${item.header}</a></h3>
                    <h4 class="product-cost"><fmt:message key="site.content.cost"/>:
                        <span>
                            ${portal:getNumberOfCost(item.cost)}${' '}
                            <c:choose>
                                <c:when test="${item.cost >= 1000}">
                                    <fmt:message key="site.content.cost.billion"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="site.content.cost.million"/>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </h4>
                    <c:if test="${not empty item.locationText}">
                        <h5 class="product-location"><fmt:message key="site.content.address"/>:&nbsp;
                            <span>${item.locationText}</span>
                        </h5>
                    </c:if>

                    <c:if test="${not empty item.area || not empty item.totalArea}">
                        <c:choose>
                            <c:when test="${not empty item.area}">
                                <h5 class="product-area">
                                    <fmt:message key="site.content.area"/>:
                                    <span>
                                        ${item.area}${' '}
                                        <c:choose>
                                            <c:when test="${item.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                            <c:when test="${item.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                            <c:when test="${item.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                        </c:choose>
                                    </span>
                                </h5>
                            </c:when>
                            <c:otherwise>
                                <h5 class="product-area">
                                    <fmt:message key="site.content.area"/>:
                                    <span>
                                        ${item.totalArea}${' '}
                                        <c:choose>
                                            <c:when test="${item.unit == 'm2'}"><fmt:message key="site.content.unit.m2"/></c:when>
                                            <c:when test="${item.unit == 'unit'}"><fmt:message key="site.content.unit.unit"/></c:when>
                                            <c:when test="${item.unit == 'hecta'}"><fmt:message key="site.content.unit.hecta"/></c:when>
                                        </c:choose>
                                    </span>
                                </h5>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <c:if test="${not empty item.areaRatio}">
                        <h5 class="product-area-ratio"><fmt:message key="site.content.area.ratio"/>:
                            <span>${item.areaRatio}</span>
                        </h5>
                    </c:if>

                    <c:if test="${not empty item.numberOfBlock}">
                        <h5 class="product-number-of-block"><fmt:message key="site.content.number.of.block"/>:
                            <span>${item.numberOfBlock}</span>
                        </h5>
                    </c:if>
                </div>
            </div>

            <c:if test="${not empty itemXMLData.headerContent[0]}">
                <div class="blog-grid margin-bottom-20 product-content">${itemXMLData.headerContent[0]}</div>
            </c:if>

            <div class="blog-grid margin-bottom-20">
                <div class="row ">
                    <div class="tab-v2">
                        <ul class="nav nav-tabs">
                            <c:forEach var="headerContent" varStatus="headerStatus" items="${itemXMLData.mapHeader}">
                                <li class="<c:if test="${headerStatus.index == 0}">active</c:if>">
                                    <a href="#product-content-${headerStatus.index}" data-toggle="tab" aria-expanded="false">${headerContent}</a></li>
                            </c:forEach>

                        </ul>
                        <div class="tab-content">
                            <c:forEach var="contentContent" varStatus="contentStatus" items="${itemXMLData.mapContent}">
                                <div class="tab-pane fade <c:if test="${contentStatus.index == 0}">active in</c:if>" id="product-content-${contentStatus.index}">
                                    <div class="product-content">
                                            ${contentContent}
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>

                    <%--<div class="tab-v3">--%>
                        <%--<div class="col-sm-3">--%>
                            <%--<ul class="nav nav-pills nav-stacked">--%>
                                <%--<c:forEach var="headerContent" varStatus="headerStatus" items="${itemXMLData.mapHeader}">--%>
                                    <%--<li class="<c:if test="${headerStatus.index == 0}">active</c:if>">--%>
                                        <%--<a href="#product-content-${headerStatus.index}" data-toggle="tab" aria-expanded="false">${headerContent}</a></li>--%>
                                <%--</c:forEach>--%>
                            <%--</ul>--%>
                        <%--</div>--%>
                        <%--<div class="col-sm-9">--%>
                            <%--<div class="tab-content">--%>
                                <%--<c:forEach var="contentContent" varStatus="contentStatus" items="${itemXMLData.mapContent}">--%>
                                    <%--<div class="tab-pane fade <c:if test="${contentStatus.index == 0}">active in</c:if>" id="product-content-${contentStatus.index}">--%>
                                        <%--<div class="product-content">--%>
                                                <%--${contentContent}--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</c:forEach>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </div>
            </div>

            <c:if test="${not empty itemXMLData.footerContent[0]}">
                <div class="blog-grid margin-bottom-20 product-content">${itemXMLData.footerContent[0]}</div>
            </c:if>

            <c:if test="${not empty item.keyword}">
                <c:set var="keywords" value="${portal:generatorKeyword(item.keyword, ',')}"/>
                <c:if test="${fn:length(keywords) > 0}">
                    <div class="blog-grid margin-bottom-20 product-content">
                        <ul class="blog-grid-tags">
                            <li class="head"><fmt:message key="site.keyword.tags"/></li>
                            <c:forEach var="keyword" items="${keywords}">
                                <li><a class="key-word-tag" keyword="${keyword}">${keyword}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </c:if>

            <div class="blog-grid margin-bottom-30">
                <div class="fb-comments" data-href="${siteUrl}${itemUrl}" data-width="100%" data-numposts="10"></div>
            </div>

            <%--<div class="margin-bottom-50">--%>
                <%--<h2 class="title-v4">Related Product</h2>--%>
                <%--<div class="row margin-bottom-50">--%>
                    <%--<c:forEach var="idx" begin="1" end="8">--%>
                        <%--<div class="col-sm-3 col-xs-6 sm-margin-bottom-30">--%>
                            <%--<!-- Blog Thumb v4 -->--%>
                            <%--<div class="blog-thumb-v4">--%>
                                <%--<div class="blog-thumb-item">--%>
                                    <%--<img class="img-responsive margin-bottom-10" src="<c:url value="/themes/site/img/blog/img40.jpg"/>" alt="">--%>
                                    <%--<div class="center-wrap">--%>
                                        <%--<div class="center-alignCenter">--%>
                                            <%--<div class="center-body">--%>
                                                <%--<a href="https://player.vimeo.com/video/74197060" class="fbox-modal fancybox.iframe video-play-btn" title="What will fashion be like in 25 years?">--%>
                                                    <%--<img class="video-play-btn" src="<c:url value="/themes/site/img/icons/video-play.png"/>" alt="">--%>
                                                <%--</a>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<h3><a href="blog_single.html">What will fashion be like in 25 years?</a></h3>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</c:forEach>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>

        <div class="col-md-3">
            <jsp:include page="../common/aboutme.jsp"></jsp:include>

            <jsp:include page="../common/hotproduct.jsp"></jsp:include>

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

