<%@ include file="/common/taglibs.jsp"%>
<div class="content container content-container">
    <div class="page-wrapper">
        <c:set var="itemDataXML" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemDataXML.header[0]}</h1>
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
                <div class="courses-wrapper col-md-8 col-sm-7">
                    <div class="featured-courses tabbed-info page-row">
                        <ul class="nav nav-tabs">
                            <li class="active"><a style="font-size: 18px;" href="#tab1" data-toggle="tab"><fmt:message key="site.research.introduce"/></a></li>
                            <c:if test="${not empty researchGroups && fn:length(researchGroups) > 0}">
                                <li><a style="font-size: 18px;" href="#tab2" data-toggle="tab"><fmt:message key="site.research.member"/></a></li>
                            </c:if>
                            <c:if test="${not empty products && fn:length(products) > 0}">
                                <li><a style="font-size: 18px;" href="#tab3" data-toggle="tab"><fmt:message key="site.research.product"/></a></li>
                            </c:if>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane active" id="tab1">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12">
                                        ${itemDataXML.content[0]}
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty researchGroups && fn:length(researchGroups) > 0}">
                                <div class="tab-pane" id="tab2">
                                    <div class="row">
                                        <div class="courses-wrapper col-md-12">
                                            <c:forEach var="researchGroup" items="${researchGroups}">
                                                <c:set var="researchGroupData" value="${portal:parseContentXML(researchGroup.xmlData)}"/>
                                                <div class="row page-row">
                                                    <div class="details col-md-9 col-sm-8 col-xs-6">
                                                        <div class="row page-row">
                                                            <figure class="thumb col-md-3 col-sm-4 col-xs-6">
                                                                <c:set var="avatar" value="/themes/site/images/avatar/anonymous.png"/>
                                                                <c:if test="${not empty researchGroup.thumbnail}">
                                                                    <c:set var="avatar" value="/repository${researchGroup.thumbnail}"/>
                                                                </c:if>
                                                                <img class="img-responsive" src="${avatar}" alt=""/>
                                                            </figure>

                                                            <div class="details col-md-9 col-sm-8 col-xs-6">
                                                                <h3 class="title">
                                                                    <seo:url value="${researchGroup.title}" var="researchGroupUrl" prefix="/${researchGroupPrefixUrl}/${portal:convertStringToUrl(categoryObj.code)}/"/>
                                                                    <a href="${researchGroupUrl}">${researchGroupData.header[0]}</a>
                                                                </h3>
                                                                <p>${researchGroupData.introduce[0]}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty products && fn:length(products) > 0}">
                                <div class="tab-pane" id="tab3">
                                    <div class="row">
                                        <div class="courses-wrapper col-md-12 item ">
                                            <c:forEach var="product" items="${products}" varStatus="productStatus">
                                                <c:set var="productData" value="${portal:parseContentXML(product.xmlData)}"/>
                                                <seo:url value="${product.title}" var="productUrl" prefix="/product/${portal:convertStringToUrl(currentCategory.code)}/"/>

                                                <div class="row page-row">
                                                    <div class="details col-md-9 col-sm-8 col-xs-6">
                                                        <div class="row page-row">
                                                            <figure class="thumb col-md-3 col-sm-4 col-xs-6">
                                                                <c:set var="productThumbnails" value="/themes/site/images/avatar/anonymous.png"/>
                                                                <c:if test="${not empty product.thumbnail}">
                                                                    <c:set var="productThumbnails" value="/repository${product.thumbnail}"/>
                                                                </c:if>
                                                                <img class="img-responsive" src="${productThumbnails}" alt=""/>
                                                            </figure>

                                                            <div class="details col-md-9 col-sm-8 col-xs-6">
                                                                <h4 class="title"><a href="${productUrl}">${productData.header[0]}</a></h4>
                                                                <div>
                                                                    ${productData.description[0]}
                                                                </div>
                                                                <br />
                                                                <a class="btn btn-theme read-more" href="${productUrl}"><fmt:message key="read.more.label"/><i class="fa fa-chevron-right"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
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


