<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><fmt:message key="webapp.name"/>&trade;&nbsp;-&nbsp;<decorator:title/></title>

    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/fontawesome/css/font-awesome.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/metisMenu/dist/metisMenu.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/animate.css/animate.css"/>">

    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/bootstrap/dist/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/sweetalert/lib/sweet-alert.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/bootstrap-datepicker-master/dist/css/bootstrap-datepicker3.min.css"/>">

    <link rel="stylesheet" href="<c:url value="/themes/admin/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/admin/fonts/pe-icon-7-stroke/css/helper.css"/>">

    <link rel="stylesheet" href="<c:url value="/themes/admin/styles/style.css"/>">

    <script src="<c:url value="/themes/admin/vendor/jquery/dist/jquery.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/jquery-ui/jquery-ui.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/bootstrap/dist/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/moment/moment.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"/>"></script>
    <script src="<c:url value="/ckeditor442/ckeditor.js"/>"></script>
<decorator:head/>

<body>
    <!-- Header -->
    <jsp:include page="/themes/admin/include/header.jsp"/>
    <!-- Navigation -->
    <jsp:include page="/themes/admin/include/menu.jsp"/>
    <!-- Main Wrapper -->

    <div id="wrapper">
        <decorator:body/>
    <!-- Right sidebar -->
        <jsp:include page="/themes/admin/include/rightslidebar.jsp"/>
        <!-- Footer-->
        <jsp:include page="/themes/admin/include/footer.jsp"/>
</div>
    <!-- Vendor scripts -->
    <script src="<c:url value="/themes/admin/vendor/metisMenu/dist/metisMenu.min.js"/>"></script>
    <script src="<c:url value='/scripts/global.js'/>"></script>
    <script src="<c:url value="/themes/admin/vendor/slimScroll/jquery.slimscroll.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/jquery-flot/jquery.flot.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/jquery-flot/jquery.flot.resize.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/jquery-flot/jquery.flot.pie.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/flot.curvedlines/curvedLines.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/jquery.flot.spline/index.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/iCheck/icheck.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/peity/jquery.peity.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/sparkline/index.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"/>"></script>
    <script src="<c:url value="/themes/admin/vendor/sweetalert/lib/sweet-alert.min.js"/>"></script>
    <script src="<c:url value="/scripts/bootbox.min.js"/>"></script>
    <!-- App scripts -->
    <script src="<c:url value="/themes/admin/scripts/homer.js"/>"></script>
    <script src="<c:url value="/themes/admin/scripts/charts.js"/>"></script>
</body>
</html>