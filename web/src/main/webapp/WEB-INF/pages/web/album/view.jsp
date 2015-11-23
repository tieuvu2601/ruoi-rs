<%@ include file="/common/taglibs.jsp"%>
<c:set var="itemDataXML" value="${portal:parseContentXML(item.xmlData)}"/>
<style>

</style>
<div class="content container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemDataXML.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="index.html"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategory.name}</span></li>
                </ul>
            </div>
        </header>

        <div class="page-content">
            <p>${itemDataXML.description[0]}</p>
            <div class="row page-row">
                <c:forEach var="imageUrl" items="${itemDataXML.imageUrls}">
                    <c:url var="imgUrl" value="/repository${imageUrl}"/>
                    <a class="prettyphoto col-md-3 col-sm-3 col-xs-6" rel="prettyPhoto[gallery]" href="${imgUrl}">
                        <span class="pretty-photo-container">
                            <span class="pretty-photo-bg"></span>
                            <img class="img-responsive img-thumbnail" src="${imgUrl}?w=280=280=2" alt="" />
                        </span>
                    </a>
                </c:forEach>
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
