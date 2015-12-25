<%@ include file="/common/taglibs.jsp"%>
<c:forEach var="content" items="${items}">
    <tr>
        <td class="display-order">
                ${content.displayOrder}
        </td>
        <td>
            <c:if test="${not empty content.thumbnails}">
                <rep:href value="${content.thumbnails}" var="imgURL"/>
                <img src="<c:url value="${imgURL}?w=120"/>" style="max-width: 100px;max-height: 100px;" />
            </c:if>
        </td>
        <td>
            ${content.title}
            <input type="hidden" name="checkList" class="content-slide-select" value="${content.contentId}">
        </td>
        <td>
            <c:if test="${content.slide == 1}">
                <fmt:message key="content.slider"/>
            </c:if>
        </td>
        <td>
            <c:if test="${content.hotItem == 1}">
                <fmt:message key="content.is.hot.product"/>
            </c:if>
        </td>
        <td>
            <fmt:formatDate value="${content.publishedDate}" pattern="dd-mm-yyyy"/>
        </td>
        <td><a class="btn btn-success btn-add"><i class="fa fa-plus"></i></a></td>
    </tr>
</c:forEach>
