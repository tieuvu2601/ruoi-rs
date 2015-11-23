<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <script type="text/javascript">
        var preUrl = '<c:url value="/"/>';
    </script>
    <%@ include file="/common/meta.jsp" %>
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" type="text/css" media="all"
          href="<c:url value='/themes/admin/theme.css'/>"/>
    <link rel="stylesheet" type="text/css" media="print"
          href="<c:url value='/themes/admin/print.css'/>"/>
    <link rel="stylesheet" type="text/css"
          href="<c:url value='/themes/admin/redmond/jquery-ui.min.css'/>"/>
    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/themes/admin/jquery.alerts.css'/>"/>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jcroplibs/jquery.color.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jcroplibs/jquery.Jcrop.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jcroplibs/jquery.Jcrop.min.js"/>"></script>

    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.alerts.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/global.js'/>"></script>

    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js' />"></script>
    <script type="text/javascript" src="<c:url value='/scripts/fancybox/jquery.fancybox.js' />"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/scripts/fancybox/jquery.fancybox.css'/>" media="screen" />

	<script type="text/javascript" src="<c:url value="/ckeditor/ckeditor.js"/>"></script>

    <decorator:head/>
</head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class"
                                                                                                  writeEntireProperty="true"/>>
<c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
<div id="page_wrapper">
    <div id="page">

        <div id="header">
            <jsp:include page="/themes/admin/include/header.jsp"/>
        </div>
        <div id="navigation">
            <jsp:include page="/themes/admin/include/menu.jsp"/>
            <div class="clear"></div>
        </div>
        <div id="maincontent">
            <decorator:body/>
            <div class="clear"></div>
        </div>
        <div id="footer" class="clearfix">
            <jsp:include page="/themes/admin/include/footer.jsp"/>
        </div>

    </div>
</div>
</body>
</html>
