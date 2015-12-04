<%--<%@ page import="com.banvien.portal.vms.security.SecurityUtils" %>--%>
<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<div id="header">
    <div id="logo" class="light-version">
        <span>
            <fmt:message key="webapp.name"/>
        </span>
    </div>

    <nav role="navigation">
        <div class="header-link hide-menu"><i class="fa fa-bars"></i></div>
        <div class="small-logo">
            <span class="text-primary"><fmt:message key="webapp.name"/></span>
        </div>

        <div class="navbar-right">
            <ul class="nav navbar-nav no-borders">
                <li class="dropdown">
                    <a href="/login.jsp?action=logout">
                        <i class="pe-7s-upload pe-rotate-90"></i>
                    </a>
                </li>
            </ul>
        </div>
    </nav>

</div>
