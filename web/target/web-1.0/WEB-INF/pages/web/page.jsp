<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>Home</title>
    <meta name="heading" content="Home Page"/>
</head>
<oscache:cache key="page_home" duration="1800">
<body>
    <div class="col w_2-3">
        <div id="component-1" class="row">
            <div class="large_blue_skin">
                <div class="header">
                    <a href="<c:url value="/trang-chu.html"/>"><img src="<c:url value="/themes/vms/images/home_ico.png"/>" class="home_icon"/></a>
                    &raquo; ${currentAuthoringTemplate.name}
                    <c:if test="${not empty currentCategory}">
                        &raquo; <a href="<c:url value="/${param.authoringTemplate}/${currentCategory.code}.html"/>">${currentCategory.name}</a>
                        <c:set var="categoryPath" value="${currentCategory.code}/"/>
                    </c:if>
                </div>
                <div class="body myCorner" data-corner="bottom 5px">
                    <div class="body_content">
                        <c:set var="firstItem" value="${contentItems[0]}"/>
                        <oscache:cache key="p_${firstItem.contentID}_${firstItem.modifiedDate}" duration="1800">
                        <c:set var="firstItemContent" value="${portal:parseContentXML(firstItem.xmlData)}"/>
                        <div class="first_item">
                            <rep:href var="imgURL" value="${firstItem.thumbnail}"/>
                            <seo:url prefix="/tin-tuc/${categoryPath}${firstItem.contentID}/" value="${firstItem.title}" var="seoURL"/>
                            <img src="${imgURL}?w=685&h=300" width="685" height="300"/>
                            <div class="title">
                                <a href="<c:url value="${seoURL}"/>">${firstItem.title}</a> <span class="modified_date"><fmt:formatDate value="${firstItem.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                            </div>
                            <div class="text">
                                ${firstItemContent['brief'][0]}
                            </div>
                        </div>
                        </oscache:cache>
                        <div class="more_items">
                            <ul>
                                <c:forEach items="${contentItems}" var="contentItem" varStatus="statusIndex">
                                    <oscache:cache key="p_${contentItems.contentID}_${contentItems.modifiedDate}" duration="1800">
                                    <c:set var="contentItemContent" value="${portal:parseContentXML(contentItem.xmlData)}"/>
                                    <c:if test="${statusIndex.index >= 1}">
                                        <seo:url prefix="/tin-tuc/${categoryPath}${contentItem.contentID}/" value="${contentItem.title}" var="seoURL"/>
                                        <rep:href var="imgURL" value="${contentItem.thumbnail}"/>
                                        <li>
                                            <div class="title">
                                                <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                                <span class="modified_date"><fmt:formatDate value="${contentItem.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                            </div>
                                            <div class="text">
                                                <div class="thumbnail">
                                                    <img src="${imgURL}?w=120&h=80"/>
                                                </div>
                                                <div class="brief">
                                                    ${contentItemContent['brief'][0]}
                                                </div>
                                            </div>
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                    </oscache:cache>
                                </c:forEach>

                            </ul>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
               <div class="footer"></div>
            </div>
            <div class="clear"></div>
        </div>


    </div>
    <div class="col w_1-3" style="margin-left:5px;">
        <div id="component-3">
            <div class="no_skin">
                <div class="header"></div>
                <div class="body">
                    <img src="<c:url value="/upload/images/quangcao.png"/>"/>
                </div>
               <div class="footer"></div>
            </div>
        </div>
        <div id="component-4">
           <div class="no_skin">
                <div class="header"></div>
                <div class="body">
                    <img src="<c:url value="/upload/images/app_menu_bk1.png"/>"/>
                    <img src="<c:url value="/upload/images/app_menu_bk2.png"/>"/>
                    <img src="<c:url value="/upload/images/app_menu_bk3.png"/>"/>
                    <img src="<c:url value="/upload/images/app_menu_bk4.png"/>"/>
                    <img src="<c:url value="/upload/images/app_menu_bk5.png"/>"/>
                </div>
               <div class="footer"></div>
            </div>
        </div>

        <div id="component-6">
           <div class="no_skin">
                <div class="header"></div>
                <div class="body">
                    <img src="<c:url value="/upload/images/calendar_link_bk.png"/>"/>
                    <img src="<c:url value="/upload/images/forum_link_bk.png"/>"/>
                    <img src="<c:url value="/upload/images/thongbao_link_bk.png"/>"/>
                    <img src="<c:url value="/upload/images/thungo_lanhdao_link_bk.png"/>"/>
                </div>
               <div class="footer"></div>
            </div>
        </div>
        <div id="component-7">
           <div class="document_skin">
                <div class="header"></div>
                <div class="body">
                    <ul>
                        <c:forEach items="${tailieu}" var="contentItem">
                        <seo:url value="${contentItem.title}" var="seoURL" prefix="/tai-lieu/${contentItem.contentID}/"/>
                        <li>
                            <div class="text">
                                <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                            </div>
                            <div class="icon">
                                <img src="/images/pdf.png"/>
                            </div>
                            <div class="clear"></div>
                        </li>
                        </c:forEach>

                    </ul>
                </div>
               <div class="footer"></div>
            </div>
        </div>
        <div id="component-8">
           <div class="no_skin">
                <div class="header"></div>
                <div class="body">
                    <div class="online_statistic">
                        Online: ${userOnlineCounter}<br/>
                        Visited: ${totalVisitors}
                        Views: ${tracking.views}
                    </div>
                </div>
               <div class="footer"></div>
            </div>
        </div>

    </div>
</body>
</oscache:cache>