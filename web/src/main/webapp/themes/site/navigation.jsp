<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>
<!-- Navbar -->
<div class="navbar mega-menu" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="res-container">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <div class="navbar-brand">
                <a href="index.html">
                    <img src="assets/img/themes/logo-news-dark-default.png" alt="Logo">
                </a>
            </div>
        </div><!--/end responsive container-->

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-responsive-collapse">
            <div class="res-container">
                <ul class="nav navbar-nav">
                    <li class="home active">
                        <a href="<c:url value="/index.html"/>">HOME</a>
                    </li>
                    <content:getBuildingMenu var="menuItems"/>
                    <oscache:cache key="menu_items_top_menu" duration="3600">
                        <c:forEach var="menuItem" items="${menuItems}">
                            <li class="">
                                <seo:url value="${menuItem.code}" var="menuUrl" prefix="/${menuItem.prefixUrl}"/>
                                <a href="${menuUrl}">${menuItem.name}</a>
                            </li>
                        </c:forEach>
                    </oscache:cache>
                </ul>

            </div><!--/responsive container-->
        </div><!--/navbar-collapse-->
    </div><!--/end contaoner-->
</div>
<!-- End Navbar -->
