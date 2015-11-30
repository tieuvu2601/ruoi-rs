<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>
<nav class="main-nav" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <div class="navbar-collapse collapse" id="navbar-collapse">
            <ul class="nav navbar-nav">
                <%--<content:getLocale var="locale"/>--%>
                <%--<c:if test="${locale == 'vi'}">--%>
                    <%--<li class="nav-item" id="home"><a href="/index.html"><fmt:message key="site.home"/></a></li>--%>
                <%--</c:if>--%>
                <%--<c:if test="${locale == 'en'}">--%>
                    <%--<li class="nav-item"><a href="/?locale=en"><fmt:message key="site.home"/></a></li>--%>
                <%--</c:if>--%>
                <%--<content:findCategoryForBuildMenu nodeLevel="2" var="menuItems"/>--%>
                <%--<oscache:cache key="menu_items_${menuItems[0].categoryID}_${menuItems[0].categoryID}" duration="1">--%>
                    <%--<c:set var="currentNode" value="0"/>--%>
                    <%--<c:forEach var="category" items="${menuItems}">--%>
                        <%--<c:set var="ulClass" value="dropdown-menu"/>--%>
                        <%--<c:set var="liId" value="${portal:convertStringToUrl(category.code)}"/>--%>
                        <%--<c:set var="liClass" value="nav-item dropdown"/>--%>
                        <%--<c:url var="menuUrl" value="#"/>--%>

                        <%--<c:choose>--%>
                            <%--<c:when test="${category.nodeLevel == 0}">--%>
                                <%--<c:set var="menuUrl" value="#"/>--%>
                            <%--</c:when>--%>

                            <%--<c:when test="${category.nodeLevel > 0}">--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${category.childrenSize > 0}">--%>
                                        <%--<c:set var="liClass" value="dropdown-submenu"/>--%>
                                        <%--<c:set var="menuUrl" value="#"/>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<c:set var="liClass" value=""/>--%>
                                        <%--<c:choose>--%>
                                            <%--<c:when test="${! empty category.prefixUrl}">--%>
                                                <%--<seo:url value="${category.code}" var="menuUrl" prefix="/${category.prefixUrl}/${portal:convertStringToUrl(category.parent.code)}/"/>--%>
                                            <%--</c:when>--%>
                                            <%--<c:otherwise>--%>
                                                <%--<seo:url value="${category.code}" var="menuUrl" prefix="/${portal:convertStringToUrl(category.parent.code)}/"/>--%>
                                            <%--</c:otherwise>--%>
                                        <%--</c:choose>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            <%--</c:when>--%>
                        <%--</c:choose>--%>


                        <%--<c:choose>--%>
                            <%--<c:when test="${currentNode < category.nodeLevel}">--%>
                                <%--<ul class="dropdown-menu">--%>
                                    <%--<li class="${liClass}" id="${liId}">--%>
                                        <%--<c:choose>--%>
                                            <%--<c:when test="${category.nodeLevel == 0}">--%>
                                                <%--<a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${category.name}&nbsp;<i class="fa fa-angle-down"></i></a>--%>
                                            <%--</c:when>--%>
                                            <%--<c:otherwise>--%>
                                                <%--<c:choose>--%>
                                                    <%--<c:when test="${category.childrenSize > 0}">--%>
                                                        <%--<a class="trigger" tabindex="-1" href="${menuUrl}">${category.name}<i class="fa fa-angle-right"></i></a>--%>
                                                    <%--</c:when>--%>
                                                    <%--<c:otherwise>--%>
                                                        <%--<a href="${menuUrl}">${category.name}</a>--%>
                                                    <%--</c:otherwise>--%>
                                                <%--</c:choose>--%>
                                            <%--</c:otherwise>--%>
                                        <%--</c:choose>--%>
                                <%--<c:set var="currentNode" value="${category.nodeLevel}"/>--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${currentNode == category.nodeLevel}">--%>
                                <%--</li>--%>
                                <%--<li class="${liClass}" id="${liId}">--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${category.nodeLevel == 0}">--%>
                                            <%--<a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${category.name}&nbsp;<i class="fa fa-angle-down"></i></a>--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--<c:choose>--%>
                                                <%--<c:when test="${category.childrenSize > 0}">--%>
                                                    <%--<a class="trigger" tabindex="-1" href="${menuUrl}">${category.name}<i class="fa fa-angle-right"></i></a>--%>
                                                <%--</c:when>--%>
                                                <%--<c:otherwise>--%>
                                                    <%--<a href="${menuUrl}">${category.name}</a>--%>
                                                <%--</c:otherwise>--%>
                                            <%--</c:choose>--%>
                                        <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                                <%--<c:forEach var="nodeLevel" begin="${category.nodeLevel}" end="${currentNode - 1}">--%>
                                        <%--</li>--%>
                                    <%--</ul>--%>
                                <%--</c:forEach>--%>
                                <%--<c:set var="currentNode" value="${category.nodeLevel}"/>--%>
                                <%--<li class="${liClass}" id="${liId}">--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${category.nodeLevel == 0}">--%>
                                            <%--<a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${category.name}&nbsp;<i class="fa fa-angle-down"></i></a>--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--<c:choose>--%>
                                                <%--<c:when test="${category.childrenSize > 0}">--%>
                                                    <%--<a class="trigger" tabindex="-1" href="${menuUrl}">${category.name}<i class="fa fa-angle-right"></i></a>--%>
                                                <%--</c:when>--%>
                                                <%--<c:otherwise>--%>
                                                    <%--<a href="${menuUrl}">${category.name}</a>--%>
                                                <%--</c:otherwise>--%>
                                            <%--</c:choose>--%>
                                        <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                            <%--</c:otherwise>--%>
                        <%--</c:choose>--%>

                    <%--</c:forEach>--%>
                    <%--<c:if test="${currentNode > 0}">--%>
                        <%--<c:forEach var="nodeLvl" begin="0" end="${currentNode}">--%>
                                <%--</li>--%>
                            <%--</ul>--%>
                        <%--</c:forEach>--%>
                    <%--</c:if>--%>
            <%--</oscache:cache>--%>
            </ul>
        </div>
    </div>
</nav>