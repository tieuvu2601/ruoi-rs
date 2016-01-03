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
            <div class="row margin-bottom-50">
                <div class="col-sm-12">
                    <c:forEach var="news" varStatus="newsStatus" items="${items}">
                        <c:if test="${newsStatus.index % 2 == 0}">
                            <div class="row margin-bottom-20">
                        </c:if>
                            <seo:url value="${news.title}" var="newsUrl" prefix="/${news.category.prefixUrl}/${news.contentId}/"/>
                            <c:set var="newsThumbnailUrl" value="/repository${news.thumbnails}"/>

                            <div class="col-sm-6">
                                <div class="blog-thumb margin-bottom-20">
                                    <div class="blog-thumb-hover">
                                        <img src="${newsThumbnailUrl}" alt="${news.title}">
                                        <a class="hover-grad" href="${newsUrl}"><i class="fa fa-photo"></i></a>
                                    </div>
                                    <div class="blog-thumb-desc">
                                        <h3><a href="${newsUrl}">${news.header}</a></h3>
                                        <ul class="blog-thumb-info">
                                            <li>${news.createdBy.displayName}</li>
                                            <li><fmt:formatDate pattern="dd-MM-yyyy" value="${news.publishedDate}"/></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        <c:if test="${newsStatus.index % 2 == 1 || newsStatus.index == (fn:length(items) - 1)}">
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <jsp:include page="../common/pagination.jsp"></jsp:include>

        </div>

        <div class="col-md-3">
            <jsp:include page="../common/aboutme.jsp"/>

            <jsp:include page="../common/hotproduct.jsp"/>

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

