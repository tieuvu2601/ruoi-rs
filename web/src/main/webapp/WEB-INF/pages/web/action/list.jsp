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
                        <fmt:formatDate var="eventBeginDate" value="${item.beginDate}" dateStyle="medium"/>
                        <fmt:formatDate var="eventEndDate" value="${item.endDate}" dateStyle="medium"/>

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
                                    <seo:url value="${item.title}" var="seoURL" prefix="/${item.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(item.category.code)}/"/>
                                    <a href="${seoURL}">${itemData.header[0]}</a>
                                </h3>
                                <p class="meta">
                                    <c:choose>
                                        <c:when test="${eventBeginDate eq eventEndDate}">
                                            <span class="date"><i class="fa fa-fw fa-calendar"></i><strong>${eventBeginDate}</strong></span><br />
                                        </c:when>
                                        <c:otherwise>
                                            <span class="date"><i class="fa fa-fw fa-calendar"></i><fmt:message key="site.from"/>: <strong>${eventBeginDate}</strong> <fmt:message key="site.to"/> <strong>${eventEndDate}</strong></span><br />
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p>${itemData.description[0]}</p>
                                <a class="btn btn-theme read-more" href="${seoURL}"><fmt:message key="read.more.label"/><i class="fa fa-chevron-right"></i></a>
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