<%@ include file="/common/taglibs.jsp"%>
<div class="contentEntity container contentEntity-container">
    <div class="page-wrapper">
        <c:set var="itemData" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemData.header[0]}</h1>
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
                <article class="event-container col-md-8 col-sm-7">
                    <div class="event-header">
                        <fmt:formatDate var="eventBeginDate" value="${item.beginDate}" dateStyle="medium"/>
                        <fmt:formatDate var="eventEndDate" value="${item.endDate}" dateStyle="medium"/>

                        <c:choose>
                            <c:when test="${eventBeginDate eq eventEndDate}">
                                <span class="date"><i class="fa fa-fw fa-calendar"></i> <strong>${eventBeginDate}</strong></span><br />
                            </c:when>
                            <c:otherwise>
                                <span class="date"><i class="fa fa-fw fa-calendar"></i> From: <strong>${eventBeginDate}</strong> to <strong>${eventEndDate}</strong></span><br />
                            </c:otherwise>
                        </c:choose>
                        <span class="time"><i class="fa fa-clock-o"></i>${itemData.beginTime[0]} - ${itemData.endTime[0]}</span><br />
                        <span class="location"><i class="fa fa-map-marker"></i><a>${itemData.location[0]}</a></span>
                    </div>
                    ${itemData.contentEntity[0]}
                </article>

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


