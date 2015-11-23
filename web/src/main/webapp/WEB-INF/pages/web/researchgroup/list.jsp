<%@ include file="/common/taglibs.jsp"%>
<div class="content container content-container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${currentCategory.name}</h1>
            <div class="breadcrumbs pull-right">
                <div class="breadcrumbs pull-right">
                    <ul class="breadcrumbs-list">
                        <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                        <li style="text-transform: capitalize;"><span>${categoryObj.name}</span><i class="fa fa-angle-right"></i></li>
                        <li class="current" style="text-transform: capitalize;"><span>${currentCategory.name}</span></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="page-content">
            <div class="row page-row">
                <div class="news-wrapper col-md-8 col-sm-7">
                    <c:forEach var="item" items="${items}">
                        <c:set var="itemData" value="${portal:parseContentXML(item.xmlData)}"/>

                        <article class="news-item page-row has-divider clearfix row">
                            <figure class="thumb col-md-2 col-sm-3 col-xs-4">
                                <c:set var="thumbnailUrl" value="/themes/site/images/images_not_available.png"/>
                                <c:if test="${not empty item.thumbnail}">
                                    <c:set var="thumbnailUrl" value="/repository${item.thumbnail}?w=100&h=100&f=2"/>
                                </c:if>
                                <img class="img-responsive" src="${thumbnailUrl}" alt=""/>
                            </figure>

                            <div class="details col-md-10 col-sm-9 col-xs-8">
                                <h3 class="title">
                                    <seo:url value="${item.title}" var="researchGroupUrl" prefix="/${item.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(item.category.code)}/"/>
                                    <a href="${researchGroupUrl}">${itemData.header[0]}</a>
                                </h3>
                                <p>${itemData.introduce[0]}</p>

                                <%-- Get all project of Research Group--%>
                                <c:forEach var="projectTitle" items="${itemData.researchProjects}">
                                    <c:set var="projectObj" value="${researchProjects[fn:toLowerCase(projectTitle)]}"/>

                                    <c:if test="${not empty projectObj && projectObj.contentID > 0}">
                                        <seo:url value="${projectObj.title}" var="projectUrl" prefix="/${projectObj.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(currentCategory.code)}/"/>
                                        <c:set var="projectObjData" value="${portal:parseContentXML(projectObj.xmlData)}"/>
                                        <span class="research-project"><a href="${projectUrl}">${projectObjData.header[0]}</a></span>
                                    </c:if>

                                </c:forEach>
                                <br />
                                <a class="btn btn-theme read-more" href="${researchGroupUrl}"><fmt:message key="read.more.label"/><i class="fa fa-chevron-right"></i></a>
                            </div>
                        </article>
                    </c:forEach>
                    <jsp:include page="../static/paginationlistitem.jsp"/>
                </div>
                <jsp:include page="../static/rightmenuinsinglepage.jsp"/>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryObj.code)}'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>