<%@ include file="/common/taglibs.jsp"%>
<div class="contentEntity container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${currentCategoryEntity.name}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryEntityObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategoryEntity.name}</span></li>
                </ul>
            </div>
        </header>
        <div class="page-contentEntity">
            <div class="page-row">
                <p><fmt:message key="site.gallery.description"/></p>
            </div>
            <div class="row page-row">
                <div>
                    <c:forEach var="item" items="${items}">
                        <c:set var="itemData" value="${portal:parseContentXML(item.xmlData)}"/>
                        <seo:url value="${item.title}" var="seoURL" prefix="/${item.authoringTemplateEntity.prefixUrl}/${portal:convertStringToUrl(item.categoryEntity.code)}/"/>
                        <div class="col-md-4 col-sm-4 col-xs-12 text-center">
                            <div class="album-cover">
                                <a href="${seoURL}" class="album-cover-thumbnails"><img class="img-responsive" src="<c:url value="/repository${item.thumbnail}"/>" alt=""></a>
                                <div class="desc">
                                    <h4><small><a href="${seoURL}">${itemData.header[0]}</a></small></h4>
                                    <p>${itemData.description[0]}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
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


