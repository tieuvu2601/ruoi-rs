<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>Home</title>
    <meta name="heading" content="Home Page"/>
</head>
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
                        <c:url var="url" value="/${param.authoringTemplate}/${currentCategory.code}.html"/>
                        <display:table name="contentItems" cellspacing="0" cellpadding="0" style="margin-bottom: 2.5em;" requestURI="${url}"
                             excludedParams="category authoringTemplate" size="${item.totalItems}" sort="external" uid="tableList" partialList="true" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">
                             <display:column>
                                <c:set var="firstItem" value="${tableList}"/>
                                <c:set var="firstItemContent" value="${portal:parseContentXML(firstItem.xmlData)}"/>
                                <div class="first_item">
                                    <rep:href var="imgURL" value="${firstItem.thumbnail}"/>
                                    <seo:url prefix="/chan-dung/${categoryPath}${firstItem.contentID}/" value="${firstItem.title}" var="seoURL"/>
                                    <img src="${imgURL}?w=685&h=300" width="685" height="300"/>
                                    <div class="title">
                                        <a href="<c:url value="${seoURL}"/>">${firstItem.title}</a> <span class="modified_date"><fmt:formatDate value="${firstItem.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div class="text">
                                        ${firstItemContent['brief'][0]}
                                    </div>
                                </div>
                             </display:column>

                            <div class="clear"></div>
                            <display:setProperty name="paging.banner.item_name"><fmt:message key="content"/></display:setProperty>
                            <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
                            <display:setProperty name="paging.banner.placement" value="bottom"/>
                            <display:setProperty name="paging.banner.all_items_found" value=""/>
                            <display:setProperty name="paging.banner.some_items_found" value=""/>
                            <display:setProperty name="paging.banner.no_items_found" value=""/>
                            <display:setProperty name="paging.banner.onepage" value=""/>
                        </display:table>


                        <div class="clear"></div>
                    </div>
                </div>
               <div class="footer"></div>
            </div>
            <div class="clear"></div>
        </div>


    </div>
    <div class="col w_1-3" style="margin-left:5px;">
        <content:findByAuthoringTemplate authoringCode="quang-cao" begin="0" pageSize="2" var="quangcaos"/>
        <div id="component-3">
            <div class="no_skin">
                <div class="header"></div>
                <div class="body">
                    <ul>
                        <c:forEach items="${quangcaos}" var="contentItem">
                            <c:set var="contentItemContent" value="${portal:parseContentXML(contentItem.xmlData)}"/>
                            <c:choose>
                                <c:when test="${not empty contentItemContent['file'][0]}">
                                    <rep:href value="${contentItemContent['file'][0]}" var="imgURL" />
                                    <c:url value="${imgURL}" var="itemURL"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="itemURL" value="${contentItemContent['url'][0]}"/>
                                </c:otherwise>
                            </c:choose>
                            <li>
                                <c:choose>
                                    <c:when test="${contentItemContent['dataType'][0] == 'Video'}">
                                        <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="280" height="190" id="FLVPlayer">
                                          <param name="movie" value="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" />
                                          <param name="salign" value="lt" />
                                          <param name="quality" value="high" />
                                          <param name="scale" value="exactfit" />
                                          <param name="FlashVars" value="&MM_ComponentVersion=1&skinName=/js/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" />
                                          <embed src="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" flashvars="&MM_ComponentVersion=1&skinName=/scripts/flash/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" quality="high" scale="exactfit" width="280" height="190" name="FLVPlayer" salign="LT" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
                                        </object>
                                    </c:when>
                                    <c:when test="${contentItemContent['dataType'][0] == 'Flash'}">
                                        <object width="280" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
                                          <param value="${itemURL}" name="movie">
                                          <param value="high" name="quality">
                                          <param value="transparent" name="wmode">
                                          <embed width="280" allowscriptaccess="crossDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" quality="high" src="${itemURL}" wmode="transparent">
                                        </object>
                                    </c:when>
                                    <c:when test="${contentItemContent['dataType'][0] == 'Image'}">
                                        <img src="${itemURL}" width="280"/>
                                    </c:when>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
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
                    <a href="/lich-cong-tac.html"><img src="<c:url value="/upload/images/calendar_link_bk.png"/>"/></a>
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
                        <c:set var="iconTaiLieu" value="${portal:parseContentXML(contentItem.xmlData)}"/>
                        <rep:href value="${iconTaiLieu['file'][0]}" var="download" />
                        <li>
                            <div class="text">
                                <a href="<c:url value="${download}"/>">${contentItem.title}</a>
                            </div>
                            <div class="icon">
                                <c:choose>
                                    <c:when test="${fn:contains(iconTaiLieu['file'][0],'.pdf') }">
                                        <img src="<c:url value="/themes/vms/images/pdf.gif" />" alt="">
                                    </c:when>
                                    <c:when test="${fn:contains(iconTaiLieu['file'][0],'.doc') }">
                                        <img src="<c:url value="/themes/vms/images/word.gif" />" alt="">
                                    </c:when>
                                    <c:when test="${fn:contains(iconTaiLieu['file'][0],'.xls') }">
                                        <img src="<c:url value="/themes/vms/images/excel.gif" />" alt="">
                                    </c:when>
                                    <c:otherwise>
                                            <img src="<c:url value="/themes/vms/images/attachment.gif" />" alt="">
                                    </c:otherwise>
                                </c:choose>
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

                    </div>
                </div>
               <div class="footer"></div>
            </div>
        </div>

    </div>
</body>