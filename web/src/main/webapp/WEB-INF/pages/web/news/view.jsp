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

    <meta property="fb:admins" content="100001895982023"/>
    <meta property="fb:app_id" content="1127660597245028" />
    <meta property="og:image"         content="http://canhovabietthu.com${itemThumbnailsUrl}"/>

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

<div class="container content">
    <div class="row">
        <div class="col-md-9">
            <!-- Blog Grid -->
            <div class="blog-grid margin-bottom-30">
                <h2 class="blog-grid-title-lg">${item.header}</h2>

                <div class="overflow-h margin-bottom-10">
                    <ul class="blog-grid-info pull-left">
                        <li>${item.createdBy.displayName}</li>
                        <li><fmt:formatDate pattern="dd-MM-yyyy" value="${item.publishedDate}"/></li>
                    </ul>
                    <div class="pull-right">
                        <div class="addthis_sharing_toolbox">
                            <div class="fb-like" data-href="http://<fmt:message key="webapp.url"/>${itemUrl}" data-layout="button" data-action="like" data-show-faces="false" data-share="true"></div>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty itemXMLData.headerContent[0]}">
                <div class="margin-bottom-30 new-content">${itemXMLData.headerContent[0]}</div>
            </c:if>

            <div class="margin-bottom-30 new-content">
                ${itemXMLData.content[0]}
            </div>

            <c:if test="${not empty itemXMLData.footerContent[0]}">
                <div class="margin-bottom-30 new-content">${itemXMLData.footerContent[0]}</div>
            </c:if>

            <%--<ul class="source-list">--%>
                <%--<li><strong>Source:</strong> <a href="#">The Next Web</a></li>--%>
                <%--<li><strong>Author:</strong> <a href="#">Evan Bartlett</a></li>--%>
            <%--</ul>--%>

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

            <div class="fb-comments" data-href="http://<fmt:message key="webapp.url"/>/${itemUrl}" data-width="100%" data-numposts="10"></div>
        </div>

        <div class="col-md-3">
            <jsp:include page="../common/aboutme.jsp"></jsp:include>

            <jsp:include page="../common/recentnew.jsp"></jsp:include>

            <jsp:include page="../common/hotproduct.jsp"></jsp:include>

            <jsp:include page="../common/social.jsp"></jsp:include>
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

