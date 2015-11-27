<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" contentEntity="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" contentEntity="IE=edge">
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/fontawesome/css/font-awesome.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/metisMenu/dist/metisMenu.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/animate.css/animate.css"/>"/>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/css/bootstrap.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/bootstrap-datepicker-master/dist/css/bootstrap-datepicker3.min.css"/>"/>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/fonts/pe-icon-7-stroke/css/helper.css"/>"/>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/styles/style.css"/>"/>

    <script src="<c:url value="/themes/themeadmin/vendor/jquery/dist/jquery.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/jquery-ui/jquery-ui.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/moment/moment.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"/>"></script>
    <script src="<c:url value="/ckeditor/ckeditor.js"/>"></script>
<decorator:head/>

<body>
    <!-- Header -->
    <jsp:include page="/themes/themeadmin/include/header.jsp"/>
    <!-- Navigation -->
    <jsp:include page="/themes/themeadmin/include/menu.jsp"/>
    <!-- Main Wrapper -->

    <div id="wrapper">
        <decorator:body/>
    <!-- Right sidebar -->
        <jsp:include page="/themes/themeadmin/include/rightslidebar.jsp"/>
        <!-- Footer-->
        <jsp:include page="/themes/themeadmin/include/footer.jsp"/>
</div>
    <!-- Vendor scripts -->
    <script src="<c:url value="/themes/themeadmin/vendor/metisMenu/dist/metisMenu.min.js"/>"></script>
    <script src="<c:url value='/scripts/global.js'/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/slimScroll/jquery.slimscroll.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/jquery-flot/jquery.flot.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/jquery-flot/jquery.flot.resize.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/jquery-flot/jquery.flot.pie.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/flot.curvedlines/curvedLines.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/jquery.flot.spline/index.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/iCheck/icheck.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/peity/jquery.peity.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/sparkline/index.js"/>"></script>
    <script src="<c:url value="/scripts/bootbox.min.js"/>"></script>
    <!-- App scripts -->
    <script src="<c:url value="/themes/themeadmin/scripts/homer.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/scripts/charts.js"/>"></script>
</body>
</html>