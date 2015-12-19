<%@ include file="/common/taglibs.jsp"%>

<div class="margin-bottom-30">
    <h2 class="title-v4"><fmt:message key="site.hot.product"/> </h2>
    <c:forEach var="product" items="${hotProducts}">
        <c:set var="productThumbnails" value="/repository${product.thumbnails}"/>
        <seo:url value="${product.title}" var="productUrl" prefix="/${product.category.prefixUrl}/${product.contentId}/"/>
        <c:set var="productXMLData" value="${portal:parseContentXML(product.xmlData)}"/>

        <div class="blog-thumb margin-bottom-20">
            <div class="blog-thumb-hover">
                <img src="${productThumbnails}" alt="${product.title}">
                <a class="hover-grad" href="${productUrl}"><i class="fa fa-home"></i></a>
            </div>
            <div class="blog-thumb-desc">
                <h3><a href="${productUrl}">${productXMLData.header[0]}</a></h3>
            </div>
        </div>
    </c:forEach>
</div>

