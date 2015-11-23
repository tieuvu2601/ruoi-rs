<%@ include file="/common/taglibs.jsp"%>
<style>
    .news-wrapper  .box ul.custom-list-style{
        padding-left: 0px;
    }
    .news-wrapper  .box ul.custom-list-style li{
        padding: 4px;
    }
</style>
<div class="content container content-container">
    <div class="page-wrapper">
        <c:set var="itemXMLData" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemXMLData.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <c:if test="${ not empty currentCategory && currentCategory.categoryID > 0}">
                        <li class="current" style="text-transform: capitalize;"><span>${currentCategory.name}</span></li>
                    </c:if>
                </ul>
            </div>
        </header>
        <div class="page-content">
            <div class="row page-row">
                <div class="news-wrapper col-md-8 col-sm-7">
                    <article class="news-item">
                        <p class="meta text-muted">Posted on: <fmt:formatDate value="${item.publishedDate}" pattern="dd-MM-yyyy"/></p>
                        ${itemXMLData.content[0]}
                        <c:if test="${not empty itemXMLData.attachFiles && fn:length(itemXMLData.attachFiles) > 0}">
                            <div class="box">
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
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryObj.code)}'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>


