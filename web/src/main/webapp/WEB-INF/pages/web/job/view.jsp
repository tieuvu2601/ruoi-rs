<%@ include file="/common/taglibs.jsp"%>
<div class="contentEntity container contentEntity-container">
    <div class="page-wrapper">
        <c:set var="itemData" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${currentCategoryEntity.name}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryEntityObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <c:if test="${ not empty currentCategoryEntity && currentCategoryEntity.categoryID > 0}">
                        <li class="current" style="text-transform: capitalize;"><span>${currentCategoryEntity.name}</span></li>
                    </c:if>
                </ul>
            </div>
        </header>
        <div class="page-contentEntity">
            <div class="row page-row">
                <div class="jobs-wrapper col-md-8 col-sm-7">
                    <h3 class="title">${itemData.header[0]}</h3>
                    <div class="box box-border page-row">
                        <ul class="list-unstyled">
                            <li><strong><fmt:message key="site.company"/>:</strong> ${itemData.company[0]}</li>
                            <li><strong><fmt:message key="site.location"/>:</strong> ${itemData.location[0]}</li>
                            <li><strong><fmt:message key="site.salary"/>:</strong> ${itemData.salary[0]}</li>
                            <li><strong><fmt:message key="site.hours"/>:</strong> ${itemData.jobType[0]}</li>

                            <fmt:formatDate value="${item.beginDate}" var="beginDate" pattern="dd-MM-yyyy"/>
                            <li><strong><fmt:message key="site.begin.date"/>:</strong> ${beginDate}</li>

                            <fmt:formatDate value="${item.endDate}" var="endDate" pattern="dd-MM-yyyy"/>
                            <li><strong><fmt:message key="site.closing.date"/>:</strong> ${endDate}</li>

                            <c:if test="${not empty itemData.applicationForm && fn:length(itemData.applicationForm) > 0}">
                                <li><strong><fmt:message key="site.application.form"/>:</strong>
                                    <c:forEach var="application" items="${itemData.applicationForm}">
                                        <a href="<c:url value="/repository${application}"/>">Download</a>&nbsp;
                                    </c:forEach>
                                </li>
                            </c:if>

                        </ul>
                    </div>
                    ${itemData.contentEntity[0]}
                </div>

                <jsp:include page="../static/rightmenuinsinglepage.jsp"/>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryEntityObj.code)}'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>


