<%@ include file="/common/taglibs.jsp"%>
<div class="content container content-container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${currentCategory.name}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategory.name}</span></li>
                </ul>
            </div>
        </header>
        <div class="page-content">
            <div class="row page-row">
                <div class="team-wrapper col-md-8 col-sm-7">
                    <c:if test="${fn:length(items) > 0}">
                        <c:forEach var="person" items="${items}">
                            <c:set var="personData" value="${portal:parseContentXML(person.xmlData)}"/>
                            <seo:url value="${person.title}" var="personUrl" prefix="/${person.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(person.category.code)}/"/>

                            <div class="row page-row">
                                <figure class="thumb col-md-3 col-sm-4 col-xs-6">
                                    <c:set var="avatar" value="/themes/site/images/avatar/anonymous.png"/>
                                    <c:if test="${not empty person.thumbnail}">
                                        <c:set var="avatar" value="/repository${person.thumbnail}"/>
                                    </c:if>
                                    <a href="${personUrl}"><img class="img-responsive" src="${avatar}" alt=""/></a>
                                </figure>

                                <div class="details col-md-9 col-sm-8 col-xs-6">
                                    <h4 class="title"><a href="${personUrl}">${personData.header[0]}</a></h4>
                                    <h5><strong><fmt:message key="site.role"/></strong>: ${personData.role[0]}</h5>
                                    <h6><strong><fmt:message key="site.degree"/></strong>: ${personData.degree[0]}</h6>
                                    <h6><strong><fmt:message key="site.email"/></strong>: <a href="mailto:${personData.email[0]}">${personData.email[0]}</a></h6>
                                    <c:if test="${not empty personData.phonenumb[0]}">
                                        <h6><strong><fmt:message key="site.phone.number"/></strong>: ${personData.phonenumb[0]}</h6>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>

                        <ul class="pagination">
                            <c:choose>
                                <c:when test="${not empty currentCategory.prefixUrl}">
                                    <seo:url value="${currentCategory.code}" var="seoURL" prefix="/${currentCategory.prefixUrl}/${portal:convertStringToUrl(categoryObj.code)}/"/>
                                </c:when>
                                <c:otherwise>
                                    <seo:url value="${currentCategory.code}" var="seoURL" prefix="/${portal:convertStringToUrl(categoryObj.code)}/"/>
                                </c:otherwise>
                            </c:choose>

                            <c:set var="currentPagerNumber" value="${pageNumber}"/>
                            <c:choose>
                                <c:when test="${pageNumber > 2}">
                                    <li><a href="${seoURL}?page=1"><i class="fa fa-angle-double-left"></i></a></li>

                                    <c:forEach begin="${pageNumber - 2}" end="${pageNumber + 2}" step="1" var="pageNumb">
                                        <c:if test="${pageNumb <= maxPageNumber}">
                                            <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>><a href="${seoURL}?page=${pageNumb}">${pageNumb}</a></li>
                                            <c:set var="currentPagerNumber" value="${pageNumb}"/>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${maxPageNumber > currentPagerNumber}">
                                        <li><a href="${seoURL}?page=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
                                    </c:if>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach begin="1" end="5" step="1" var="pageNumb">
                                        <c:if test="${pageNumb <= maxPageNumber}">
                                            <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>><a href="${seoURL}?page=${pageNumb}">${pageNumb}</a></li>
                                            <c:set var="currentPagerNumber" value="${pageNumb}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${(maxPageNumber - 1) > currentPagerNumber}">
                                        <li><a href="${seoURL}?page=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </c:if>
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


