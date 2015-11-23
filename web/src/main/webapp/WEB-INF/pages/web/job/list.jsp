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
                <div class="jobs-wrapper col-md-8 col-sm-7">
                    <c:forEach var="item" items="${items}">
                        <c:set var="itemData" value="${portal:parseContentXML(item.xmlData)}"/>
                        <fmt:formatDate var="eventBeginDate" value="${item.beginDate}" dateStyle="medium"/>
                        <fmt:formatDate var="eventEndDate" value="${item.endDate}" dateStyle="medium"/>

                        <div class="panel panel-default page-row">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <seo:url value="${item.title}" var="seoURL" prefix="/${item.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(item.category.code)}/"/>
                                    <a href="${seoURL}">${itemData.header[0]}</a>
                                    <fmt:formatDate value="${item.endDate}" var="endDate" pattern="dd-MM-yyyy"/>
                                    <span class="text-danger pull-right" style="font-weight: 600">${endDate}</span>
                                </h3>
                            </div>
                            <div class="panel-body">
                                    ${itemData.description[0]}
                            </div>
                            <ul class="list-group">
                                <li class="list-group-item"><strong><fmt:message key="site.company"/>:</strong> ${itemData.company[0]}</li>
                                <li class="list-group-item"><strong><fmt:message key="site.location"/>:</strong> ${itemData.location[0]}</li>
                                <li class="list-group-item"><strong><fmt:message key="site.salary"/>:</strong> ${itemData.salary[0]}</li>
                            </ul>
                            <div class="panel-footer">
                                <div class="row">
                                    <ul class="list-inline col-md-8 col-sm-6 col-xs-6">
                                        <li><a href="${seoURL}"><fmt:message key="site.more.details"/></a></li>
                                    </ul>
                                    <div class="meta col-md-4 col-sm-6 col-xs-6 text-right">
                                        <c:set var="jobTypeClass" value="label-warning"/>
                                        <c:if test="${fn:toLowerCase(itemData.jobType[0]) eq 'full time'}">
                                            <c:set var="jobTypeClass" value="label-success"/>
                                        </c:if>
                                        <span class="label ${jobTypeClass} pull-right">${itemData.jobType[0]}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
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
