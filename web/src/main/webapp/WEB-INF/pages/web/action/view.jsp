<%@ include file="/common/taglibs.jsp"%>
<style>
    .news-wrapper  .box ul.custom-list-style{
        padding-left: 0px;
    }
    .news-wrapper  .box ul.custom-list-style li{
        padding: 4px;
    }
</style>
<div class="contentEntity container contentEntity-container">
    <div class="page-wrapper">
        <c:set var="itemXMLData" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemXMLData.header[0]}</h1>
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
                <div class="news-wrapper col-md-8 col-sm-7">
                    <article class="news-item">
                        <p class="meta text-muted">Posted on: <fmt:formatDate value="${item.publishedDate}" pattern="dd-MM-yyyy"/></p>
                        <p>
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
                        </p>
                        ${itemXMLData.contentEntity[0]}
                        <c:if test="${not empty itemXMLData.attachFiles && fn:length(itemXMLData.attachFiles) > 0}">
                            <div class="box attach-file-container">
                                <h3 class="no-margin-top has-divider text-highlight">Attach Files:</h3>
                                <ul class="custom-list-style">
                                    <c:forEach var="attachFile" items="${itemXMLData.attachFiles}" varStatus="attachFileStatus">
                                        <li><a href="<c:url value="/repository${attachFile}"/>"><i class="fa fa-check"></i> Attach File ${attachFileStatus.count}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </article>
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


