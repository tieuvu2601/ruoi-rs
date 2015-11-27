<%@ include file="/common/taglibs.jsp"%>
<ul class="pagination">
    <c:choose>
        <c:when test="${not empty currentCategoryEntity.prefixUrl}">
            <seo:url value="${currentCategoryEntity.code}" var="seoURL" prefix="/${currentCategoryEntity.prefixUrl}/${portal:convertStringToUrl(categoryEntityObj.code)}/"/>
        </c:when>
        <c:otherwise>
            <seo:url value="${currentCategoryEntity.code}" var="seoURL" prefix="/${portal:convertStringToUrl(categoryEntityObj.code)}/"/>
        </c:otherwise>
    </c:choose>

    <c:set var="currentPagerNumber" value="${pageNumber}"/>
    <c:choose>
        <c:when test="${pageNumber > 3}">
            <li><a href="${seoURL}?page=1"><i class="fa fa-angle-double-left"></i></a></li>

            <c:forEach begin="${pageNumber - 2}" end="${pageNumber + 2}" step="1" var="pageNumb">
                <c:if test="${pageNumb <= maxPageNumber}">
                    <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>><a href="${seoURL}?page=${pageNumb}">${pageNumb}</a></li>
                    <c:set var="currentPagerNumber" value="${pageNumb}"/>
                </c:if>
            </c:forEach>

            <c:if test="${maxPageNumber > currentPagerNumber}">
                <li><a href="${seoURL}?page=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
            </c:if>
        </c:when>

        <c:otherwise>
            <c:forEach begin="1" end="5" step="1" var="pageNumb">
                <c:if test="${pageNumb <= maxPageNumber}">
                    <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>><a href="${seoURL}?page=${pageNumb}">${pageNumb}</a></li>
                    <c:set var="currentPagerNumber" value="${pageNumb}"/>
                </c:if>
            </c:forEach>
            <c:if test="${maxPageNumber > currentPagerNumber}">
                <li><a href="${seoURL}?page=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
            </c:if>
        </c:otherwise>
    </c:choose>
</ul>