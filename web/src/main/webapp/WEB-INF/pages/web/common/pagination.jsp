<%@ include file="/common/taglibs.jsp"%>
<ul class="pager pager-v4 pager-pagination">
    <seo:url value="${category.code}" var="seoURL" prefix="/${category.prefixUrl}/"/>
    <c:set var="currentPagerNumber" value="${pageNumber}"/>
    <c:choose>
        <c:when test="${pageNumber > 3}">
            <li class="previous"><a href="${seoURL}?pg=1"><i class="fa fa-angle-double-left"></i></a></li>

            <c:forEach begin="${pageNumber - 2}" end="${pageNumber + 2}" step="1" var="pageNumb">
                <c:if test="${pageNumb <= maxPageNumber}">
                    <c:choose>
                        <c:when test="${pageNumb == pageNumber}">
                            <li class="active"><a href="#">${pageNumb}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${seoURL}?pg=${pageNumb}">${pageNumb}</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:set var="currentPagerNumber" value="${pageNumb}"/>
                </c:if>
            </c:forEach>

            <c:if test="${maxPageNumber > currentPagerNumber}">
                <li class="next"><a href="${seoURL}?pg=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
            </c:if>
        </c:when>

        <c:otherwise>
            <c:forEach begin="1" end="5" step="1" var="pageNumb">
                <c:if test="${pageNumb <= maxPageNumber}">
                    <c:choose>
                        <c:when test="${pageNumb == pageNumber}">
                            <li class="active"><a href="#">${pageNumb}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${seoURL}?pg=${pageNumb}">${pageNumb}</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:set var="currentPagerNumber" value="${pageNumb}"/>
                </c:if>
            </c:forEach>
            <c:if test="${maxPageNumber > currentPagerNumber}">
                <li class="next"><a href="${seoURL}?pg=${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
            </c:if>
        </c:otherwise>
    </c:choose>
</ul>