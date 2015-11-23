<%@ page import="com.banvien.portal.vms.security.SecurityUtils" %>
<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="center">
    <div class="left" onclick="document.location.href='<c:url value="/"/>';" style="cursor:pointer;">
        <img src="<c:url value='/themes/admin/images/logo.png'/>" style="padding-left:10px;"/>
    </div>
    <div style="float:right;margin-top: 10px;margin-right: 10px;color:#ffffff;">
        <%pageContext.setAttribute("onlineUser", SecurityUtils.getPrincipal() != null ? SecurityUtils.getPrincipal().getDisplayName() : "");%>
        <fmt:message key="welcome.user">
            <fmt:param value="${onlineUser}"/>
        </fmt:message>
        | <a href="<c:url value="/logout.jsp"/>">Logout</a>
    </div>
    <div class="clear"></div>
</div>

