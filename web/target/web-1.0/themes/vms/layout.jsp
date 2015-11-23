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
          href="<c:url value='/themes/vms/theme.css'/>"/>
    <link rel="stylesheet" type="text/css" media="print"
          href="<c:url value='/themes/vms/print.css'/>"/>
    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/themes/vms/jquery.alerts.css'/>"/>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.alerts.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.corner.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/global.js'/>"></script>
    <decorator:head/>
</head>
<body<decorator:getProperty property="body.id" writeEntireProperty="true"/><decorator:getProperty property="body.class"
                                                                                                  writeEntireProperty="true"/>>
    <c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
    <div class="top_navigation">
        <div class="top_navigation_text">
            <div style="float:left"><fmt:message key="home.title"/></div>
            <div style="float:right">
                <div style="float:left">
                    <security:authorize ifNotGranted="LOGON">
                        <a href="<c:url value="/login.jsp"/>">
                            <fmt:message key="login.title"/>
                        </a>
                    </security:authorize>
                    <security:authorize ifAllGranted="LOGON">
                        <a href="<c:url value="/mysite/home.html"/>">
                            <fmt:message key="login.mysite"/>
                        </a>
                    </security:authorize>
                </div>
                <div class="search_box">
                    <input type="text" name="keyword"/>
                </div>


            </div>
        </div>
    </div>
    <div id="page_wrapper">
        <div id="page">

            <div id="header">
                <jsp:include page="/themes/vms/include/header.jsp"/>
            </div>
            <div id="navgiation">
               <jsp:include page="/themes/vms/include/navigation.jsp"/>
                <div class="clear"></div>
            </div>
            <div id="maincontent">
                <div id="mainpane" class="myCorner" data-corner="5px">
                    <decorator:body/>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>

        </div>

    </div>
    <div id="footer" class="clearfix">
        <jsp:include page="/themes/vms/include/footer.jsp"/>
    </div>
</body>
</html>
