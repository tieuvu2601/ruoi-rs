<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp" %>
<nav class="main-nav" roleEntity="navigation">
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
                <contentEntity:getLocale var="locale"/>
                <c:if test="${locale == 'vi'}">
                    <li class="nav-item" id="home"><a href="/index.html"><fmt:message key="site.home"/></a></li>
                </c:if>
                <c:if test="${locale == 'en'}">
                    <li class="nav-item"><a href="/?locale=en"><fmt:message key="site.home"/></a></li>
                </c:if>
                <contentEntity:findCategoryForBuildMenu nodeLevel="2" var="menuItems"/>
                <oscache:cache key="menu_items_${menuItems[0].categoryID}_${menuItems[0].categoryID}" duration="1">
                    <c:set var="currentNode" value="0"/>
                    <c:forEach var="categoryEntity" items="${menuItems}">
                        <c:set var="ulClass" value="dropdown-menu"/>
                        <c:set var="liId" value="${portal:convertStringToUrl(categoryEntity.code)}"/>
                        <c:set var="liClass" value="nav-item dropdown"/>
                        <c:url var="menuUrl" value="#"/>

                        <c:choose>
                            <c:when test="${categoryEntity.nodeLevel == 0}">
                                <c:set var="menuUrl" value="#"/>
                            </c:when>

                            <c:when test="${categoryEntity.nodeLevel > 0}">
                                <c:choose>
                                    <c:when test="${categoryEntity.childrenSize > 0}">
                                        <c:set var="liClass" value="dropdown-submenu"/>
                                        <c:set var="menuUrl" value="#"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="liClass" value=""/>
                                        <c:choose>
                                            <c:when test="${! empty categoryEntity.prefixUrl}">
                                                <seo:url value="${categoryEntity.code}" var="menuUrl" prefix="/${categoryEntity.prefixUrl}/${portal:convertStringToUrl(categoryEntity.parent.code)}/"/>
                                            </c:when>
                                            <c:otherwise>
                                                <seo:url value="${categoryEntity.code}" var="menuUrl" prefix="/${portal:convertStringToUrl(categoryEntity.parent.code)}/"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>


                        <c:choose>
                            <c:when test="${currentNode < categoryEntity.nodeLevel}">
                                <ul class="dropdown-menu">
                                    <li class="${liClass}" id="${liId}">
                                        <c:choose>
                                            <c:when test="${categoryEntity.nodeLevel == 0}">
                                                <a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${categoryEntity.name}&nbsp;<i class="fa fa-angle-down"></i></a>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${categoryEntity.childrenSize > 0}">
                                                        <a class="trigger" tabindex="-1" href="${menuUrl}">${categoryEntity.name}<i class="fa fa-angle-right"></i></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${menuUrl}">${categoryEntity.name}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                <c:set var="currentNode" value="${categoryEntity.nodeLevel}"/>
                            </c:when>
                            <c:when test="${currentNode == categoryEntity.nodeLevel}">
                                </li>
                                <li class="${liClass}" id="${liId}">
                                    <c:choose>
                                        <c:when test="${categoryEntity.nodeLevel == 0}">
                                            <a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${categoryEntity.name}&nbsp;<i class="fa fa-angle-down"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${categoryEntity.childrenSize > 0}">
                                                    <a class="trigger" tabindex="-1" href="${menuUrl}">${categoryEntity.name}<i class="fa fa-angle-right"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${menuUrl}">${categoryEntity.name}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="nodeLevel" begin="${categoryEntity.nodeLevel}" end="${currentNode - 1}">
                                        </li>
                                    </ul>
                                </c:forEach>
                                <c:set var="currentNode" value="${categoryEntity.nodeLevel}"/>
                                <li class="${liClass}" id="${liId}">
                                    <c:choose>
                                        <c:when test="${categoryEntity.nodeLevel == 0}">
                                            <a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false" href="${menuUrl}">${categoryEntity.name}&nbsp;<i class="fa fa-angle-down"></i></a>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${categoryEntity.childrenSize > 0}">
                                                    <a class="trigger" tabindex="-1" href="${menuUrl}">${categoryEntity.name}<i class="fa fa-angle-right"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${menuUrl}">${categoryEntity.name}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                            </c:otherwise>
                        </c:choose>

                    </c:forEach>
                    <c:if test="${currentNode > 0}">
                        <c:forEach var="nodeLvl" begin="0" end="${currentNode}">
                                </li>
                            </ul>
                        </c:forEach>
                    </c:if>
            </oscache:cache>
            </ul>
        </div>
    </div>
</nav>