<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<aside id="menu">
    <div id="navigation">
        <ul class="nav" id="side-menu">
            <li><a class="first" href="<c:url value="/admin/role/list.html"/>" ><span class="nav-label"><fmt:message key="menu.role"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/usergroup/list.html"/>" ><span class="nav-label"><fmt:message key="menu.user.group"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/user/list.html"/>" ><span class="nav-label"><fmt:message key="menu.user"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/authoringtemplate/list.html"/>"><span class="nav-label"><fmt:message key="menu.authoring.template"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/category-type/list.html"/>" ><span class="nav-label"><fmt:message key="menu.category.type"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/category/list.html"/>"><span class="nav-label"><fmt:message key="menu.category"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/location/list.html"/>"><span class="nav-label"><fmt:message key="menu.location"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/content/list.html"/>"><span class="nav-label"><fmt:message key="menu.content"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/customer/list.html"/>"><span class="nav-label"><fmt:message key="menu.customer"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/configuration/edit.html"/>"><span class="nav-label"><fmt:message key="menu.configuration"/></span></a></li>
        </ul>
    </div>
</aside>
