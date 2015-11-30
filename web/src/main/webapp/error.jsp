<%@ page language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title><fmt:message key="errorPage.title"/></title>
    <link rel="stylesheet" type="text/css" media="all" href="<c:url value='/styles/${appConfig["csstheme"]}/theme.css'/>" />
</head>

<body id="error">
    <div id="page">
        <div class="pathway"><h1><fmt:message key="errorPage.heading"/></h1></div>
        <div id="content" class="clearfix">
            <div id="main">

                <fmt:message key="errorPage.unexpectedMessage"></fmt:message>
                <%@include file="/common/messages.jsp" %>
                <%=exception.getMessage()%>
            </div>
        </div>
    </div>
</body>
</html>
