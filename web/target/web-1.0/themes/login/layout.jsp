<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <%@ include file="/common/meta.jsp" %>
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" type="text/css" media="all"
          href="<c:url value='/themes/login/theme.css'/>"/>
    <link rel="stylesheet" type="text/css" media="print"
          href="<c:url value='/themes/login/print.css'/>"/>

    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/themes/login/jquery.alerts.css'/>"/>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.alerts.js'/>"></script>

    <decorator:head/>
</head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class"
                                                                                                  writeEntireProperty="true"/>>
<c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
<div id="page_wrapper">
    <div id="page">

        <div id="header">
            <jsp:include page="/themes/login/include/login_header.jsp"/>
        </div>

        <div id="maincontent">
            <decorator:body/>
        </div>
        <div id="footer" class="clearfix">
            <jsp:include page="/themes/login/include/footer.jsp"/>
        </div>

    </div>
</div>
</body>
</html>
