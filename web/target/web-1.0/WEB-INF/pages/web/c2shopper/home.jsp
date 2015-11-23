<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
﻿
<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="home.home"/></title>
    <meta name="heading" content="<fmt:message key="home.home"/>"/>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js' />"></script>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/sexyalertbox.v1.2.jquery.js' />"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/themes/vms_stretch/sexyalertbox.css'/>" media="screen" />

    <link rel="stylesheet" type="text/css" href="<c:url value='/themes/vms_stretch/slider_box.css'/>" media="screen" />

    <!-- include jQuery + carouFredSel plugin -->
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.carouFredSel-6.1.0-packed.js'/>"></script>

    <!-- optionally include helper plugins -->
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.mousewheel.min.js'/>"></script>
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.touchSwipe.min.js'/>"></script>
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.ba-throttle-debounce.min.js'/>"></script>
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.roundabout2.js'/>"></script>
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/jquery/jquery.easing.js'/>"></script>
    <script type="text/javascript" language="javascript" src="<c:url value='/scripts/vote.js'/>"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#accordion > li')
                    .bind({
                        "reposition": function() {
                            var degrees = $(this).data('roundabout').degrees,
                                    roundaboutBearing = $(this).parent().data('roundabout').bearing,
                                    rotateY = Math.round(roundaboutBearing - degrees);

                            $(this).css({
                                "-webkit-transform": "perspective(2000) rotateY(" + rotateY + "deg)",
                                "-moz-transform": "perspective(2000) rotateY(" + rotateY + "deg)",
                                "transform": "perspective(2000) rotateY(" + rotateY + "deg)"
                            });
                        }
                    })

            $('#accordion').roundabout({
                minScale: 0.7,
                /*easing: 'easeOutElastic', */
                /*duration: 1600, */
                autoplay:true,
                autoplayDuration:2500,
                autoplayPauseOnHover:true
            });
        });

    </script>
</head>
<oscache:cache key="home_c2_shopper" duration="1800">
<body class="home sub_page">
<div id="flash_news_box_container">
    <div id='wrapper' class="box_wrapper">
        <div id='main_teaser_slide_box_container' class="hot_news_skin">
            <div id="content" class="body">
                <ul id="main_teaser_items">
                    <li class="item">
                        <content:findByAuthoringTemplate authoringCode="quang-cao-vms" begin="0" pageSize="1" var="quangcaovms"/>
                        <c:if test="${not empty quangcaovms}">
                            <c:set var="vmsAdvItem" value="${portal:parseContentXML(quangcaovms[0].xmlData)}"/>
                            <embed width="950" height="340" flashvars="<c:forEach items="${vmsAdvItem['flashUrls']}" var="url" varStatus="status">banner${status.index+1}=${url}&amp;</c:forEach>" wmode="transparent" quality="high" bgcolor="none" name="main" id="main" src="${vmsAdvItem['mainFlash'][0]}" type="application/x-shockwave-flash">
                        </c:if>
                    </li>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
</oscache:cache>
<c:set var="prefixDepartmentURL" value="daily/chi-nhanh"/>
<div>
    <div class="box_wrapper shopper_panel myCorner" data-corner="10px">
        <div class="sub_page_content">
        <div class="col w_2-3">
            <div id="component-1" class="row">
                <div class="detail_two_cols_skin">
                    <div class="header">
                        <a href="<c:url value="/daily/index.html"/>"><fmt:message key="home.home"/></a>
                        <c:if test="${not empty department}">
                            <seo:url var="departmentURL" prefix="/${prefixDepartmentURL}/${department.departmentID}/" value="${department.name}"/>
                            &raquo; <a href="${departmentURL}">${department.name}</a>
                        </c:if>
                        &raquo; ${currentAuthoringTemplate.name}
                        <c:if test="${not empty currentCategory}">
                            &raquo; <a href="<c:url value="/${param.authoringTemplate}/${currentCategory.code}.html"/>">${currentCategory.name}</a>
                            <c:set var="categoryPath" value="${currentCategory.code}/"/>
                        </c:if>
                    </div>
                    <div class="body myCorner max_image_550" data-corner="bottom 5px">
                        <div class="body_content">
                            <c:choose>
                                <c:when test="${permissionDined}">
                                    Bạn không có quyền truy cập chuyên mục này.
                                </c:when>
                                <c:when test="${item.totalItems > 0}">
                                    <c:set var="departmentID" value="${param.departmentID}"/>
                                    <c:if test="${empty departmentID}">
                                        <c:set var="departmentID" value="${department.departmentID}"/>
                                    </c:if>
                                    <seo:url var="url" prefix="/${prefixDepartmentURL}/${departmentID}/" value="${department.name}"/>
                                    <display:table name="contentItems" cellspacing="0" cellpadding="0" style="margin-bottom: 2.5em;" requestURI="${url}"
                                                   excludedParams="category authoringTemplate" size="${item.totalItems}" sort="external" uid="tableList" partialList="true" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">
                                        <display:column style="vertical-align:top;padding:5px;">
                                            ${tableList.contentID}
                                        </display:column>
                                        <display:column>
                                            <c:set var="contentItemContent" value="${portal:parseContentXML(tableList.xmlData)}"/>
                                            <seo:url prefix="/${prefixDepartmentURL}/${departmentID}/${tableList.contentID}/" value="${tableList.title}" var="seoURL"/>
                                            <div>
                                                <div class="title">
                                                    <a href="<c:url value="${seoURL}"/>">${tableList.title}</a>
                                                    <span class="modified_date"><fmt:formatDate value="${tableList.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                                    <c:if test="${fn:length(contentItemContent['attachments']) > 0}">
                                                        <img src="<c:url value="/themes/vms_stretch/images/attachtb.gif"/>"/>
                                                    </c:if>
                                                </div>
                                                <div class="text">
                                                    <div class="brief">
                                                            ${contentItemContent['content'][0]}
                                                    </div>
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
                                </c:when>
                                <c:otherwise>

                                </c:otherwise>
                            </c:choose>


                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="footer"></div>
                </div>
                <div class="clear"></div>
            </div>


        </div>
        <div class="col w_1-3 right_column">
            <oscache:cache key="home_c2_shopper_right_quangcao" duration="1800">
            <div id="component-3">
                <content:findByAuthoringTemplate authoringCode="quang-cao" begin="0" pageSize="2" var="quangcaos"/>
                <div class="small_light_skin">
                    <div class="header">Quảng Cáo</div>
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
            </oscache:cache>
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
            <oscache:cache key="home_c2_shopper_link" duration="1800">
            <div id="component-8">
                <div class="document_skin">
                    <div class="header">Liên kết web</div>
                    <div class="body myCorner" data-corner="tr br 5px">
                        <content:findByAuthoringTemplate authoringCode="lien-ket-web" begin="0" pageSize="10" var="lienketwebs"/>
                        <div align="center">
                            <select id="webLink" onchange="launchExternalSite(this.value)" class="cboWebLink">
                                <option value="">Liên kết website</option>
                                <c:forEach items="${lienketwebs}" var="lienket">
                                    <c:set var="lienketContent" value="${portal:parseContentXML(lienket.xmlData)}"/>
                                    <option value="${lienketContent['link'][0]}">${lienket.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            </oscache:cache>
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

        </div>
        </div>
        <div class="clear"></div>
    </div>

</div>
<div class="clear"></div>
</body>