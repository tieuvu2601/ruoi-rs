<%@ include file="/common/taglibs.jsp"%>
<content:findByAuthoringTemplate authoringCode="quang-cao" begin="0" pageSize="2" var="quangcaos"/>
<div id="component-3">
    <div class="small_light_skin">
        <div class="header">Quảng Cáo</div>
        <div class="body">
            <ul>
                <c:forEach items="${quangcaos}" var="contentItem">
                    <oscache:cache key="${contentItem.contentID}_${contentItem.modifiedDate}" duration="1800">
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
                                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="280" id="FLVPlayer">
                                  <param name="movie" value="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" />
                                  <param name="salign" value="lt" />
                                  <param name="quality" value="high" />
                                  <param name="scale" value="exactfit" />
                                  <param name="FlashVars" value="&MM_ComponentVersion=1&skinName=/js/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" />
                                  <embed src="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" flashvars="&MM_ComponentVersion=1&skinName=/scripts/flash/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" quality="high" scale="exactfit" width="280" name="FLVPlayer" salign="LT" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
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
                                        <a href="${contentItemContent['url'][0]}" target="_blank"><img src="${itemURL}" width="280" alt="${contentItem.title}"/></a>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${itemURL}" width="280" alt="${contentItem.title}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </li>
                    </oscache:cache>
                </c:forEach>
            </ul>
        </div>
       <div class="footer"></div>
    </div>
</div>
<security:authorize ifAllGranted="LOGON">
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
</security:authorize>
<div id="component-7">
   <div class="document_skin">
        <div class="header">Tài Liệu Hướng Dẫn</div>
        <div class="body myCorner" data-corner="tr br 5px">
            <ul>
                <content:findByAuthoringTemplate authoringCode="tai-lieu" begin="0" pageSize="10" var="tailieu"/>
                <c:forEach items="${tailieu}" var="contentItem">
                <oscache:cache key="r_${contentItem.contentID}_${contentItem.modifiedDate}" duration="1800">
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
                </oscache:cache>
                </c:forEach>

            </ul>
        </div>
       <div class="footer"></div>
    </div>
</div>
<div id="component-8">
    <div class="document_skin">
        <div class="header">Liên kết web</div>
        <div class="body myCorner" data-corner="tr br 5px">
            <content:findByAuthoringTemplate authoringCode="lien-ket-web" begin="0" pageSize="10" var="lienketwebs"/>
            <div align="center">
                <select id="webLink" onchange="launchExternalSite(this.value)" class="cboWebLink">
                    <option value="">Liên kết website</option>
                    <c:forEach items="${lienketwebs}" var="lienket">
                    <oscache:cache key="${lienket.contentID}_${lienket.modifiedDate}" duration="1800">
                        <c:set var="lienketContent" value="${portal:parseContentXML(lienket.xmlData)}"/>
                        <option value="${lienketContent['link'][0]}">${lienket.title}</option>
                    </oscache:cache>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="footer"></div>
    </div>
</div>
<div id="component-9">
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