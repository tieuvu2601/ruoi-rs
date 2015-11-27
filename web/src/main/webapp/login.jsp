﻿<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" contentEntity="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" contentEntity="IE=edge">

    <title><fmt:message key="login.title"/></title>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/fontawesome/css/font-awesome.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/metisMenu/dist/metisMenu.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/animate.css/animate.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/css/bootstrap.css"/>"/>

    <!-- App styles -->
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/fonts/pe-icon-7-stroke/css/helper.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/styles/style.css"/>"/>

</head>
<body class="blank">

<!-- Simple splash screen-->
<div class="splash"> <div class="color-line"></div><div class="splash-title"><h1>Homer - Responsive Admin Theme</h1><p>Special AngularJS Admin Theme for small and medium webapp with very clean and aesthetic style and feel. </p><img src="images/loading-bars.svg" width="64" height="64" /> </div> </div>
<!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->

<div class="color-line"></div>

<div class="login-container">
    <div class="row">
        <div class="col-md-12">
            <div class="text-center m-b-md">
                <h3>PLEASE LOGIN TO APP</h3>
                <small>This is the best app ever!</small>
            </div>
            <div class="hpanel">
                <div class="panel-body">
                    <form name="loginForm" action="<c:url value="/j_security_check"/>" method="post" id="loginForm">
                        <div class="form-group">
                            <label class="control-label" for="username">Username</label>
                            <input type="text" placeholder="example@gmail.com" title="Please enter you username" required="" name="j_username" id="username" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="password">Password</label>
                            <input type="password" title="Please enter your password" placeholder="******" required=""  name="j_password" id="password" class="form-control">
                        </div>
                        <div class="checkbox">
                            <input type="checkbox" class="i-checks" checked> Remember login
                        </div>
                        <button class="btn btn-success btn-block">Login</button>
                        <c:if test="${not empty param.error}">
                            <tr>
                                <td colspan="2" style="color:red;">
                                    <c:choose>
                                        <c:when test="${param.error == 1}">
                                            Tên đăng nhập và mật khẩu không đúng. Xin vui lòng thử lại.
                                        </c:when>
                                        <c:when test="${param.error == 2}">
                                            Phiên làm việc của bạn đã kết thúc. Xin vui lòng đăng nhập lại để tiếp tục.
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-center">
            <strong>HOMER</strong> - NTT Responsive WebApp <br/> 2015 Copyright BanVien Company
        </div>
    </div>
</div>
<script src="<c:url value="/themes/themeadmin/vendor/jquery/dist/jquery.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/jquery-ui/jquery-ui.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/slimScroll/jquery.slimscroll.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/metisMenu/dist/metisMenu.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/iCheck/icheck.min.js"/>"></script>
<script src="<c:url value="/themes/themeadmin/vendor/sparkline/index.js"/>"></script>

<script src="<c:url value="/themes/themeadmin/scripts/homer.js"/>"></script>


</body>

</html>