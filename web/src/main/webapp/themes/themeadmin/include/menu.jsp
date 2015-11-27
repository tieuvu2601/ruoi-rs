<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<aside id="menu">
    <div id="navigation">
        <ul class="nav" id="side-menu">
            <security:authorize ifAllGranted="AUTHORING_TEMPLATE">
                <li><a class="first" href="<c:url value="/admin/authoringtemplate/list.html"/>"><span class="nav-label"><fmt:message key="menu.authoringtemplate"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="CATEGORY">
                <li><a class="first" href="<c:url value="/admin/categoryEntity/list.html"/>" ><span class="nav-label"><fmt:message key="menu.categoryEntity"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="CONTENT">
                <li><a class="first" href="<c:url value="/admin/contentEntity/list.html"/>" ><span class="nav-label"><fmt:message key="menu.contentEntity"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="DEPARTMENT">
                <li><a class="first" href="<c:url value="/admin/department/list.html"/>" ><span class="nav-label"><fmt:message key="menu.department"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="RENDERING_TEMPLATE">
                <li><a class="first" href="<c:url value="/admin/renderingtemplate/list.html"/>" ><span class="nav-label"><fmt:message key="menu.renderingtemplate"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="ROLE">
                <li><a class="first" href="<c:url value="/admin/roleEntity/list.html"/>" ><span class="nav-label"><fmt:message key="menu.roleEntity"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="USER">
                <li><a class="first" href="<c:url value="/admin/user/list.html"/>" ><span class="nav-label"><fmt:message key="menu.userEntity"/></span></a></li>
            </security:authorize>

            <security:authorize ifAllGranted="USERGROUP">
                <li><a class="first" href="<c:url value="/admin/usergroup/list.html"/>" ><span class="nav-label"><fmt:message key="menu.usergroup"/></span></a></li>
            </security:authorize>

            <li><a class="first" href="<c:url value="/admin/opinion/list.html"/>" ><span class="nav-label"><fmt:message key="opinion"/></span></a></li>

            <%--<security:authorize ifAllGranted="CONTENT">--%>
                <%--<li>--%>
                    <%--<a class="first" href="#" ><span class="nav-label"><fmt:message key="menu.feedback"/></span><span class="fa arrow"></span></a>--%>
                    <%--<ul class="nav nav-second-level">--%>
                        <%--<li><a href="<c:url value="/admin/feedbackcategory/list.html"/>"><fmt:message key="menu.feedbackcategory"/></a></li>--%>
                        <%--<li><a href="<c:url value="/admin/feedback/list.html"/>"><fmt:message key="menu.feedback"/></a></li>--%>
                    <%--</ul>--%>
                <%--</li>--%>
            <%--</security:authorize>--%>
        </ul>
    </div>
</aside>
