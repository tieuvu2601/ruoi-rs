<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
    <title>${category.title}</title>
    <meta name="description" content="${category.description}">
    <meta name="keywords" content="${category.keyword}">
</head>
<body>

<div class="breadcrumbs breadcrumbs-light">
    <div class="container">
        <h1 class="pull-left">${category.title}</h1>
        <ul class="pull-right breadcrumb">
            <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a></li>
            <c:choose>
                <c:when test="${not empty category.parent}">
                    <li><a href="#">${category.parent.name}</a></li>
                    <li class="active">${category.name}</li>
                </c:when>
                <c:otherwise>
                    <li class="active">${category.name}</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>

<div class="container content-sm">
    <div class="row">
        <div class="col-md-9 md-margin-bottom-50">
            <c:forEach var="product" items="${items}">
                <seo:url value="${product.title}" var="productUrl" prefix="/${product.category.prefixUrl}/${product.contentId}/"/>
                <c:set var="productThumbnailUrl" value="/repository${product.thumbnails}"/>
                <c:set var="productXMLData" value="${portal:parseContentXML(product.xmlData)}"/>
                <div class="row margin-bottom-50">
                    <div class="col-sm-4 sm-margin-bottom-20">
                        <img class="img-responsive" src="${productThumbnailUrl}" alt="${product.title}">
                    </div>
                    <div class="col-sm-8">
                        <div class="blog-grid">
                            <h3><a href="${productUrl}">${productXMLData.header[0]}</a></h3>
                            <ul class="blog-grid-info">
                                <li>${product.createdBy.displayName}</li>
                                <li><fmt:formatDate pattern="dd-MM-yyyy" value="${product.publishedDate}"/></li>
                            </ul>
                            <p>${product.description}</p>
                            <a class="r-more" href="${productUrl}"><fmt:message key="site.read.more"/></a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <ul class="pager pager-v4">
                <li class="previous"><a class="rounded-3x" href="#">&larr; Older</a></li>
                <li class="page-amount">1 of 7</li>
                <li class="next"><a class="rounded-3x" href="#">Newer &rarr;</a></li>
            </ul>
        </div>


        <div class="col-md-3">
            <jsp:include page="../common/hotproduct.jsp"/>

            <jsp:include page="../common/recentnew.jsp"/>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $(document).ready(function(){
            <c:choose>
                <c:when test="${not empty category.parent && category.parent.categoryId > 0}">
                    setCurrentSelectedMenu($('#menu-index-${category.parent.categoryId}'), $('#menu-sub-index-${category.categoryId}'));
                </c:when>
                <c:otherwise>
                    setCurrentSelectedMenu($('#menu-index-${category.categoryId}'), null);
                </c:otherwise>
            </c:choose>
        });

        function setCurrentSelectedMenu(menu, subMenu){
            console.dir('sssssssssss');
            $('#top-navigation-container').find('li').removeClass('active');
            if($(menu != null && menu != undefined)){
                $(menu).addClass('active');
                if($(subMenu) != null && $(subMenu) != undefined){
                    $(subMenu).addClass('active');
                }
            }
        }
    });
</script>
</body>
</html>
