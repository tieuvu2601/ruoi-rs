<%@ include file="/common/taglibs.jsp"%>
<div class="mysite_navigation">
<ul>
    <li><a href="<c:url value="/mysite/home.html"/>"><fmt:message key="mysite.document"/></a></li>
    <li><a href="<c:url value="/admin/content/list.html"/>"><fmt:message key="mysite.content"/></a></li>
    <li><a href="<c:url value="/mysite/profile.html"/>"><fmt:message key="mysite.profile"/></a></li>
    <li><a href="<c:url value="/logout.jsp"/>"><fmt:message key="logout"/></a></li>
</ul>
</div>
