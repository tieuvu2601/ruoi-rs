<%@ page import="com.banvien.portal.vms.security.SecurityUtils" %>
<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="center">
    <div class="left">
        <img src="<c:url value='/themes/vms/images/logo.gif'/>"/>
    </div>
</div>
<div class="left">
    <div class="top_navigation">
        <div style="float:left"><a href="<c:url value="/"/>">Home</a>

        </div>

    </div>
</div>
<div style="float:right;margin-top: 10px;margin-right: 10px;">
    <%pageContext.setAttribute("onlineUser", SecurityUtils.getPrincipal() != null ? SecurityUtils.getPrincipal().getDisplayName() : "");%>
    <fmt:message key="welcome.user">
        <fmt:param value="${onlineUser}"/>
    </fmt:message>
    | <a href="<c:url value="/logout.jsp"/>"><fmt:message key="logout"/></a>
</div>
