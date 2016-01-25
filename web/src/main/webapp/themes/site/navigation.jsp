<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="navbar mega-menu" role="navigation">
    <div class="container">
        <div class="res-container">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <div class="navbar-brand">
                <a href="<c:url value="/index.html"/>">
                    <img src="<c:url value="/themes/site/logo-rel.png"/>" alt="<fmt:message key="webapp.name"/>">
                </a>
            </div>
        </div>

        <div class="collapse navbar-collapse navbar-responsive-collapse">
            <div class="res-container">
                <ul class="nav navbar-nav" id="top-navigation-container">
                    <li class="home active">
                        <a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a>
                    </li>
                    <content:getBuildingMenu var="menuItems"/>
                    <oscache:cache key="menu_items_top_menu" duration="3600">
                        <c:forEach var="menuItem" items="${menuItems}">
                            <c:choose>
                                <c:when test="${menuItem.children != null && fn:length(menuItem.children) > 0}">
                                    <li class="dropdown" id="menu-index-${menuItem.categoryId}">
                                        <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">${menuItem.name}</a>
                                        <ul class="dropdown-menu">
                                            <c:forEach var="child" items="${menuItem.children}">
                                                <seo:url value="${child.code}" var="menuUrl" prefix="/${child.prefixUrl}/"/>
                                                <li id="menu-sub-index-${child.categoryId}"><a href="${menuUrl}">${child.name}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <seo:url value="${menuItem.code}" var="menuUrl" prefix="/${menuItem.prefixUrl}/"/>
                                        <li id="menu-index-${menuItem.categoryId}"><a href="${menuUrl}">${menuItem.name}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <li class="sitemap">
                            <a href="<c:url value="/sitemap.html"/>"><fmt:message key="site.sitemap"/></a>
                        </li>
                    </oscache:cache>
                </ul>
            </div>
        </div>
    </div>
</div>

