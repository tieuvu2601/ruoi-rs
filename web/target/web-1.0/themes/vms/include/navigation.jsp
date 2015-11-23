<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="navigation">
    <ul>
        <li><a href="<c:url value="/trang-chu.html"/>" <c:if test="${empty currentCategory}">class="selected"</c:if>><fmt:message key="home.home"/></a></li>
        <li style="width:120px;"><a href="<c:url value="/tin-tuc/tin-trung-tam.html"/>"  <c:if test="${currentCategory.code ==  'tin-trung-tam'}">class="selected"</c:if>><fmt:message key="home.company"/></a></li>
        <li style="width:120px;"><a href="<c:url value="/tin-tuc/phong-ban.html"/>"  <c:if test="${currentCategory.code ==  'phong-ban'}">class="selected"</c:if>><fmt:message key="home.department"/></a></li>
        <li><a href="<c:url value="/tin-tuc/tin-kinh-doanh.html"/>" <c:if test="${currentCategory.code ==  'tin-kinh-doanh'}">class="selected"</c:if>><fmt:message key="home.business"/></a></li>
        <li style="width:138px;"><a href="<c:url value="/tin-tuc/cong-nghe-ky-thuat.html"/>" style="width:138px;" <c:if test="${currentCategory.code ==  'cong-nghe-ky-thuat'}">class="selected"</c:if>><fmt:message key="home.it"/></a></li>
        <li style="width:106px;"><a href="<c:url value="/tin-tuc/cham-soc-khach-hang.html"/>" style="width:106px;"  <c:if test="${currentCategory.code ==  'cham-soc-khach-hang'}">class="selected"</c:if>><fmt:message key="home.care"/></a></li>
        <li><a href="<c:url value="/tin-tuc/chi-nhanh.html"/>"  <c:if test="${currentCategory.code ==  'chi-nhanh'}">class="selected"</c:if>><fmt:message key="home.agent"/></a></li>
        <li><a href="/dien-dan" ><fmt:message key="home.forum"/></a></li>
    </ul>
</div>
