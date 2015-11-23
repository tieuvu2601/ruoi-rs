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
                                <c:set var="contentItemContent" value="${portal:parseContentXML(tableList.xmlData)}"/>

                                <seo:url prefix="/lich-cong-tac/${tableList.contentID}/" value="${tableList.title}" var="seoURL"/>
                                <div>
                                    <div class="title">
                                        <a href="<c:url value="${seoURL}"/>">${tableList.title}</a>
                                        <span class="modified_date"><fmt:formatDate value="${tableList.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div class="clear"></div>
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
    <div class="col w_1-3 right_column">
        <div id="component-3">
            <content:findByAuthoringTemplate authoringCode="quang-cao" begin="0" pageSize="2" var="quangcaos"/>
            <div class="small_light_skin">
                <div class="header">Quảng Cáo</div>
                <div class="body">
                    <ul>
                        <c:forEach items="${quangcaos}" var="contentItem">
                            <c:set var="contentItemContent" value="${portal:parseContentXML(contentItem.xmlData)}"/>
                            <c:choose>
                                <c:when test="${not empty contentItemContent['image'][0]}">
                                    <rep:href value="${contentItemContent['image'][0]}" var="itemURL" />
                                    <c:url value="${itemURL}" var="itemURL"/>
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
                                        <c:choose>
                                            <c:when test="${!empty contentItemContent['url'][0]}">
                                                <a href="${contentItemContent['url'][0]}" target="_blank"><img src="${itemURL}" width="280"/></a>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${itemURL}" width="280"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
               <div class="footer"></div>
            </div>
        </div>
        <div id="component-6">
           <div class="thongbao_skin">
                <div class="header">Thông báo</div>
                <div class="body myCorner" data-corner="tr br 5px">
                    <ul>
                        <content:findByAuthoringTemplate authoringCode="thong-bao" begin="0" pageSize="10" var="thongbaos"/>
                        <c:forEach items="${thongbaos}" var="contentItem">
                        <seo:url prefix="/thong-bao/${contentItem.contentID}/" value="${contentItem.title}" var="seoURL"/>
                        <li>
                            <div class="calendar">
                                <fmt:formatDate value="${contentItem.modifiedDate}" pattern="dd"/><br/>
                                <fmt:formatDate value="${contentItem.modifiedDate}" pattern="MM"/>
                            </div>
                            <div class="text">
                                <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                            </div>
                            <div class="clear"></div>
                        </li>
                        </c:forEach>

                    </ul>
                </div>
               <div class="footer"></div>
            </div>
        </div>
        <div id="component-7">
           <div class="document_skin">
                <div class="header">Tài Liệu Hướng Dẫn</div>
                <div class="body myCorner" data-corner="tr br 5px">
                    <ul>
                        <content:findByAuthoringTemplate authoringCode="tai-lieu" begin="0" pageSize="10" var="tailieu"/>
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
                        Đang trực tuyến: ${userOnlineCounter}<br/>
                        Lượt truy cập: ${totalVisitors}

                    </div>
                </div>
               <div class="footer"></div>
            </div>
        </div>

    </div>
</body>