<%@ include file="/common/taglibs.jsp"%>

<div class="margin-bottom-30">
    <h2 class="title-v4"><fmt:message key="site.hot.product"/></h2>
    <content:getHotProducts pageSize="10" var="hotProducts"/>
    <oscache:cache key="site_hot_products_cache" duration="3600">
        <c:forEach var="product" items="${hotProducts}">
            <c:set var="productThumbnails" value="/repository${product.thumbnails}"/>
            <seo:url value="${product.title}" var="productUrl" prefix="/${product.category.prefixUrl}/${product.contentId}/"/>

            <div class="blog-thumb margin-bottom-20">
                <div class="blog-thumb-hover">
                    <img src="${productThumbnails}" alt="${product.title}">
                    <a class="hover-grad" href="${productUrl}"><i class="fa fa-home"></i></a>
                </div>
                <div class="blog-thumb-desc">
                    <h3><a href="${productUrl}">${product.header}</a></h3>
                    <p class="product-cost">
                        <span>
                            ${portal:getNumberOfCost(product.cost)}${' '}
                            <c:choose>
                                <c:when test="${product.cost >= 1000}">
                                    <fmt:message key="site.content.cost.billion"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="site.content.cost.million"/>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </p>
                </div>
            </div>
        </c:forEach>
    </oscache:cache>
</div>

