<%@ include file="/common/taglibs.jsp"%>
<aside class="page-sidebar  col-md-3 col-md-offset-1 col-sm-4 col-sm-offset-1">
    <section class="widget has-divider">
        <h3 class="title">${categoryEntityObj.name}</h3>
        <ul class="right-menu">
            <li>
                <c:set var="currentNode" value="-1"/>
                <c:set var="isCurrentCategory" value=""/>

                <c:forEach var="categoryEntity" items="${categories}">
                    <c:set var="categoryUrl" value="#"/>

                    <c:if test="${empty categoryEntity.childrenSize || categoryEntity.childrenSize == 0}">
                        <c:choose>
                            <c:when test="${not empty categoryEntity.prefixUrl}">
                                <seo:url value="${categoryEntity.code}" var="categoryUrl" prefix="/${portal:convertStringToUrl(categoryEntity.prefixUrl)}/${portal:convertStringToUrl(categoryEntityObj.code)}/"/>
                            </c:when>
                            <c:otherwise>
                                <seo:url value="${categoryEntity.code}" var="categoryUrl" prefix="/${portal:convertStringToUrl(categoryEntityObj.code)}/"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <c:choose>
                        <c:when test="${categoryEntity.categoryID == currentCategoryEntity.categoryID}">
                            <c:set var="isCurrentCategory" value="current"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="isCurrentCategory" value=""/>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${currentNode < categoryEntity.nodeLevel}">
                            <ul>
                                <li class="${isCurrentCategory}">
                                <span><i class="fa fa-caret-right"></i> <a href="${categoryUrl}">${categoryEntity.name}</a></span>
                                <c:set var="currentNode" value="${categoryEntity.nodeLevel}"/>
                        </c:when>

                        <c:when test="${currentNode == categoryEntity.nodeLevel}">
                            </li>
                            <li class="${isCurrentCategory}">
                                <span><i class="fa fa-caret-right"></i> <a href="${categoryUrl}">${categoryEntity.name}</a></span>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="nodeLevel" begin="${categoryEntity.nodeLevel}" end="${currentNode - 1}">
                                    </li>
                                </ul>
                            </c:forEach>
                            <c:set var="currentNode" value="${categoryEntity.nodeLevel}"/>
                            <li class="${isCurrentCategory}">
                                <span><i class="fa fa-caret-right"></i> <a href="${categoryUrl}">${categoryEntity.name}</a></span>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentNode > 0}">
                    <c:forEach var="nodeLvl" begin="0" end="${currentNode}">
                            </li>
                        </ul>
                    </c:forEach>
                </c:if>
            </li>
        </ul>
    </section>
    <c:if test="${not empty relations && fn:length(relations) > 1}">
        <section class="widget has-divider">
            <h3 class="title">Relations</h3>
            <c:forEach var="relation" items="${relations}">
                <c:if test="${relation.contentID != item.contentID}">
                    <c:set var="relationData" value="${portal:parseContentXML(relation.xmlData)}"/>

                    <article class="news-item row">
                        <c:choose>
                            <c:when test="${not empty relation.authoringTemplateEntity.hasThumbnail && relation.authoringTemplateEntity.hasThumbnail == 'Y'}">
                                <figure class="thumb col-md-2">
                                    <c:set var="thumbnailUrl" value="/themes/site/images/images_not_available.png"/>
                                    <c:if test="${not empty relation.thumbnail}">
                                        <c:set var="thumbnailUrl" value="/repository${relation.thumbnail}"/>
                                    </c:if>
                                    <img src="${thumbnailUrl}" alt=""/>
                                </figure>
                                <div class="details col-md-10">
                                    <seo:url value="${relation.title}" var="relationURL" prefix="/${relation.authoringTemplateEntity.prefixUrl}/${portal:convertStringToUrl(relation.categoryEntity.code)}/"/>
                                    <h4 class="title"><a href="${relationURL}">${relationData.header[0]}</a></h4>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="details col-md-12">
                                    <seo:url value="${relation.title}" var="relationURL" prefix="/${relation.authoringTemplateEntity.prefixUrl}/${portal:convertStringToUrl(relation.categoryEntity.code)}/"/>
                                    <h4 class="title"><a href="${relationURL}">${relationData.header[0]}</a></h4>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </article>
                </c:if>
            </c:forEach>
        </section>
    </c:if>
    <c:if test="${not empty eventRelations && fn:length(eventRelations) > 1}">
        <section class="widget has-divider">
            <h3 class="title">Upcoming Events</h3>
            <c:forEach var="eventRelation" items="${eventRelations}">
                <c:if test="${eventRelation.contentID != item.contentID}">

                    <c:set var="eventRelationData" value="${portal:parseContentXML(eventRelation.xmlData)}"/>
                    <fmt:formatDate var="eventRelationBeginDate" value="${eventRelation.beginDate}" pattern="dd-MM-yyyy"/>

                    <article class="events-item row page-row">
                        <div class="date-label-wrapper col-md-3 col-sm-4 col-xs-4">
                            <p class="date-label">
                                <span class="month">${portal:getDateVariableByIndexAndParameter(eventRelationBeginDate, 1, "-")}</span>
                                <span class="date-number">${portal:getDateVariableByIndexAndParameter(eventRelationBeginDate, 0, "-")}</span>
                            </p>
                        </div>
                        <div class="details col-md-9 col-sm-8 col-xs-8">
                            <seo:url value="${eventRelation.title}" var="eventRelationURL" prefix="/${eventRelation.authoringTemplateEntity.prefixUrl}/${portal:convertStringToUrl(eventRelation.categoryEntity.code)}/"/>
                            <h5 class="title"><a href="${eventRelationURL}">${eventRelationData.header[0]}</a></h5>
                            <p class="time text-muted">${eventRelationData.beginTime[0]} - ${eventRelationData.endTime[0]}
                                <br>${eventRelationData.location[0]}</p>
                        </div>
                    </article>
                </c:if>
            </c:forEach>
        </section>
    </c:if>
</aside>