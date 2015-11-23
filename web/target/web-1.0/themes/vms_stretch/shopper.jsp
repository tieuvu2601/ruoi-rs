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
          href="<c:url value='/themes/vms_stretch/theme_v.1.0.css'/>"/>
    <link rel="stylesheet" type="text/css" media="print"
          href="<c:url value='/themes/vms_stretch/print.css'/>"/>
    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/themes/vms_stretch/jquery.alerts.css'/>"/>
    <link rel="stylesheet" type="text/css" media="all"
          						href="<c:url value='/themes/vms_stretch/jquery-ui.css'/>"/>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/jquery/jquery-ui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.alerts.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.corner.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/global.js'/>"></script>
    <style type="text/css">
    	#btSearch{
    		cursor: pointer;
    		height: 22px;
		    left: 1052px;
		    position: absolute;
		    top: 10px;
		    width: 24px; 
    	}
    </style>
    <decorator:head/>
</head>
<body id="shopper" <decorator:getProperty property="body.class" writeEntireProperty="true"/>>
    <c:set var="currPage" scope="request"><decorator:getProperty property="body.id"/></c:set>
    <div class="top_navigation">
        <div class="top_navigation_text">
            <div style="float:left" class="site_title"><fmt:message key="home.title"/></div>
            <div style="float:right">

                <div class="search_box">

                </div>
                <div style="float:left;line-height:40px;padding-left:20px;">
                    <security:authorize ifNotGranted="LOGON">
                        <a href="<c:url value="/login.jsp"/>" style="text-decoration: underline;">
                            <fmt:message key="login.title"/>
                        </a>
                    </security:authorize>
                    <security:authorize ifAllGranted="LOGON">
                        <a href="<c:url value="/mysite/home.html"/>" style="text-decoration: underline;">
                            <fmt:message key="login.mysite"/>
                        </a>
                    </security:authorize>
                </div>

            </div>
        </div>
    </div>
    <div id="navigation">
        <div class="navigation_text">
        <jsp:include page="/themes/vms_stretch/include/shopper_navigation.jsp"/>
        <div class="clear"></div>
        </div>
    </div>
    <div id="page_wrapper">
        <div id="maincontent">
                <decorator:body/>
                <div class="clear"></div>
            <div class="clear"></div>
        </div>


    </div>
    <div id="footer" class="clearfix">
        <jsp:include page="/themes/vms_stretch/include/shopperfooter.jsp"/>
    </div>
    <div class="facebook_control">
        <a href="<c:url value="https://www.facebook.com/mobifonesaigon?fref=ts"/>" class="btn_feedback">&nbsp;</a>
    </div>
    <div class="feedback_control">
        <a href="<c:url value="/phan-hoi.html"/>" class="btn_feedback">&nbsp;</a>
    </div>
</body>
</html>

