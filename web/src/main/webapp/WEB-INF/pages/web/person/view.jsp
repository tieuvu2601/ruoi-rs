<%@ include file="/common/taglibs.jsp"%>
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
                <div class="jobs-wrapper col-md-8 col-sm-7">
                    <%--<h3 class="title">${itemXMLData.header[0]}</h3>--%>
                    <div class="box box-border page-row person-info" style="width: 100%">
                        <div class="col-md-8 col-xs-6">
                            <ul class="list-unstyled">
                                <li><h3 class="title">${itemXMLData.header[0]}</h3></li>
                                <li><strong><fmt:message key="site.roleEntity"/>:</strong> ${itemXMLData.roleEntity[0]}</li>
                                <li><strong><fmt:message key="site.degree"/>:</strong> ${itemXMLData.degree[0]}</li>
                                <li><strong><fmt:message key="site.email"/>:</strong> <a href="mailto:${itemXMLData.email[0]}">${itemXMLData.email[0]}</a></li>
                                <c:if test="${not empty itemXMLData.phonenumb[0]}">
                                    <li><strong><fmt:message key="site.phone.number"/>:</strong> ${itemXMLData.phonenumb[0]}</li>
                                </c:if>
                            </ul>
                        </div>
                        <div class="thumbnails col-md-4 col-xs-6">
                            <c:set var="avatar" value="/themes/site/images/avatar/anonymous.png"/>
                            <c:if test="${not empty item.thumbnail}">
                                <c:set var="avatar" value="/repository${item.thumbnail}"/>
                            </c:if>
                            <img class="img-responsive" src="${avatar}" alt=""/>
                        </div>
                    </div>
                    <div>
                        ${itemXMLData.about[0]}
                    </div>
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


