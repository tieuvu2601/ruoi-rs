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
                        <a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a>
                    </li>
                    <content:getBuildingMenu var="menuItems"/>
                    <oscache:cache key="menu_items_top_menu" duration="1">
                        <c:forEach var="menuItem" items="${menuItems}">
                            <c:choose>
                                <c:when test="${menuItem.children != null && fn:length(menuItem.children) > 0}">
                                    <li class="dropdown home active">
                                        <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">${menuItem.name}</a>
                                        <ul class="dropdown-menu">
                                            <c:forEach var="child" items="${menuItem.children}">
                                                <seo:url value="${child.code}" var="menuUrl" prefix="/${child.prefixUrl}/"/>
                                                <li><a href="${menuUrl}">${child.name}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <seo:url value="${menuItem.code}" var="menuUrl" prefix="/${menuItem.prefixUrl}/"/>
                                        <li><a href="${menuUrl}">${menuItem.name}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </oscache:cache>
                </ul>

            </div><!--/responsive container-->
        </div><!--/navbar-collapse-->
    </div><!--/end contaoner-->
</div>
<!-- End Navbar -->
