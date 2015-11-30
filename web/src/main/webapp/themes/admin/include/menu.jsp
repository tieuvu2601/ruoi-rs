<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<aside id="menu">
    <div id="navigation">
        <ul class="nav" id="side-menu">
            <li><a class="first" href="<c:url value="/admin/authoringtemplate/list.html"/>"><span class="nav-label"><fmt:message key="menu.authoringtemplate"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/category/list.html"/>" ><span class="nav-label"><fmt:message key="menu.category"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/usergroup/list.html"/>" ><span class="nav-label"><fmt:message key="menu.usergroup"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/user/list.html"/>" ><span class="nav-label"><fmt:message key="menu.user"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/role/list.html"/>" ><span class="nav-label"><fmt:message key="menu.role"/></span></a></li>
            <li><a class="first" href="<c:url value="/admin/content/list.html"/>" ><span class="nav-label"><fmt:message key="menu.content"/></span></a></li>
        </ul>
    </div>
</aside>
