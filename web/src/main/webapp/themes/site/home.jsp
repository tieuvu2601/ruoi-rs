<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" contentEntity="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" contentEntity="">
    <meta name="author" contentEntity="">

    <title><fmt:message key="main.faculty"/> - <fmt:message key="main.school"/></title>
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" contentEntity="IE=edge">
    <meta name="viewport" contentEntity="width=device-width, initial-scale=1.0">
    <meta name="description" contentEntity="">
    <meta name="author" contentEntity="">
    <link rel="shortcut icon" href="<c:url value="/themes/site/images/favicon.ico"/>">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>

    <!-- Global CSS -->
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/bootstrap/css/bootstrap.min.css"/>"/>
    <!-- Plugins CSS -->
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/font-awesome/css/font-awesome.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/flexslider/flexslider.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/pretty-photo/css/prettyPhoto.css"/>">
    <link rel="stylesheet" href="<c:url value="/themes/site/plugins/mediaplayer/mediaelementplayer.min.css"/>">
    <!-- Theme CSS -->
    <link id="theme-style" rel="stylesheet" href="<c:url value="/themes/site/css/styles.css"/>">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script> -->
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/jquery-1.11.2.min.js"/>"></script>
<decorator:head/>

<body class="home-page">
    <div class="wrapper">
        <jsp:include page="/themes/site/header.jsp"></jsp:include>
        <jsp:include page="/themes/site/navigation.jsp"></jsp:include>

        <decorator:body></decorator:body>
    </div>

    <jsp:include page="/themes/site/footer.jsp"></jsp:include>

    <script type="text/javascript" src="<c:url value="/themes/site/plugins/jquery-migrate-1.2.1.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/bootstrap/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/bootstrap-hover-dropdown.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/back-to-top.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/jquery-placeholder/jquery.placeholder.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/pretty-photo/js/jquery.prettyPhoto.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/flexslider/jquery.flexslider-min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/jflickrfeed/jflickrfeed.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/js/main.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/themes/site/plugins/mediaplayer/mediaelement-and-player.min.js"/>"></script>
</body>
</html>

