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

<div class="container content-sm">
    <div class="row">
        <div class="col-md-9 md-margin-bottom-50">
            <c:forEach var="product" items="${items}">
                <seo:url value="${product.title}" var="productUrl" prefix="/${product.category.prefixUrl}/${product.contentId}/"/>
                <c:set var="productThumbnailUrl" value="/repository${product.thumbnails}"/>
                <div class="row margin-bottom-30">
                    <div class="col-sm-4 sm-margin-bottom-20">
                        <img class="img-responsive" src="${productThumbnailUrl}" alt="${product.title}">
                    </div>
                    <div class="col-sm-8">
                        <div class="blog-grid">
                            <h3>
                                <a href="${productUrl}">${product.header}</a>
                            </h3>
                            <ul class="blog-grid-info">
                                <li>${product.createdBy.displayName}</li>
                                <li><fmt:formatDate pattern="dd-MM-yyyy" value="${product.publishedDate}"/></li>
                                <c:if test="${product.authoringTemplate.areProduct == 1}">
                                    <li class="product-cost">
                                        <span>
                                            ${portal:getNumberOfCost(product.cost)}${' '}
                                            <c:choose>
                                                <c:when test="${product.cost >= 1000}">
                                                    <fmt:message key="site.content.cost.billion"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:message key="site.content.cost.million"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </li>
                                </c:if>
                            </ul>
                            <p>${product.description}</p>
                            <a class="r-more" href="${productUrl}"><fmt:message key="site.read.more"/></a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <jsp:include page="../common/pagination.jsp"></jsp:include>
        </div>

        <div class="col-md-3">
            <jsp:include page="../common/hotproduct.jsp"/>

            <jsp:include page="../common/recentnew.jsp"/>

            <jsp:include page="../common/social.jsp"/>
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
