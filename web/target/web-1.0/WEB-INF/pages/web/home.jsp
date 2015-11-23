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
<oscache:cache key="page_home_page" duration="900">
<content:findByCategory category="tin-trung-tam" begin="0" pageSize="5" var="tincongty"/>
<content:findByCategory category="phong-ban" begin="0" pageSize="5" var="tinphongban"/>
<content:findByCategory category="tin-kinh-doanh" begin="0" pageSize="5" var="tinkinhdoanh"/>
<content:findByCategory category="cong-nghe-ky-thuat" begin="0" pageSize="5" var="congnghekythuat"/>
<content:findByCategory category="cham-soc-khach-hang" begin="0" pageSize="5" var="chamsockhachhang"/>
<content:findByCategory category="dang-uy" begin="0" pageSize="5" var="danguy"/>
<body class="home">
    <div id="flash_news_box_container">
        <div id='wrapper' class="box_wrapper">
            <div id='main_teaser_slide_box_container' class="hot_news_skin">
                <div id="content" class="body">
                    <ul id="main_teaser_items">
                        <li class="item">
                            <div id="flash_items">
                                <ul id="accordion" class="accordion">
                                    <c:set var="status" value="0"/>
                                    <c:if test="${fn:length(tincongty) > 0}">
                                        <c:set var="hotItem" value="${tincongty[0]}"/>
                                        <oscache:cache key="hot_tincongty_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                    <c:if test="${fn:length(tinphongban) > 0}">
                                        <c:set var="hotItem" value="${tinphongban[0]}"/>
                                        <oscache:cache key="hot_tinphongban_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                    <c:if test="${fn:length(tinkinhdoanh) > 0}">
                                        <c:set var="hotItem" value="${tinkinhdoanh[0]}"/>
                                        <oscache:cache key="hot_tinkinhdoanh_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                    <c:if test="${fn:length(congnghekythuat) > 0}">
                                        <c:set var="hotItem" value="${congnghekythuat[0]}"/>
                                        <oscache:cache key="hot_congnghekythuat_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                    <c:if test="${fn:length(chamsockhachhang) > 0}">
                                        <c:set var="hotItem" value="${chamsockhachhang[0]}"/>
                                        <oscache:cache key="hot_chamsockhachhang_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                    <c:if test="${fn:length(danguy) > 0}">
                                        <c:set var="hotItem" value="${danguy[0]}"/>
                                        <oscache:cache key="hot_danguy_${hotItem.contentID}_${hotItem.modifiedDate}" duration="1800">
                                            <c:set var="hotItemContent" value="${portal:parseContentXML(hotItem.xmlData)}"/>
                                            <rep:href value="${hotItem.thumbnail}" var="thumbnailURL"/>
                                            <seo:url value="${hotItem.title}" var="seoURL" prefix="/tin-nong/${hotItem.contentID}/"/>
                                            <li id="itemIndexLi${status}">
                                                <img src="<c:url value="${thumbnailURL}?w=410&h=340&f=1"/>"/>
                                                <div class="description">
                                                    <div class="heading"><a href="${seoURL}">${hotItem.title}</a></div>
                                                </div>
                                            </li>
                                        </oscache:cache>
                                        <c:set var="status" value="${status + 1}"/>
                                    </c:if>
                                </ul>

                            </div>
                        </li>
                        <li class="item">
                            <content:findByAuthoringTemplate authoringCode="quang-cao-vms" begin="0" pageSize="1" var="quangcaovms"/>
                            <c:if test="${not empty quangcaovms}">
                                <oscache:cache key="${quangcaovms[0].contentID}_${quangcaovms[0].modifiedDate}" duration="1800">
                                    <c:set var="vmsAdvItem" value="${portal:parseContentXML(quangcaovms[0].xmlData)}"/>
                                    <embed width="950" height="340" flashvars="<c:forEach items="${vmsAdvItem['flashUrls']}" var="url" varStatus="status">banner${status.index+1}=${url}&amp;</c:forEach>" wmode="transparent" quality="high" bgcolor="none" name="main" id="main" src="${vmsAdvItem['mainFlash'][0]}" type="application/x-shockwave-flash">
                                </oscache:cache>
                            </c:if>
                        </li>
                    </ul>
                    <div class="main_teaser_navs">
                        <ul>
                            <li><a href="#" id="prevMainTeaserItems">&nbsp;</a></li>
                            <li><a href="#" id="nextMainTeaserItems">&nbsp;</a></li>
                        </ul>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
       </div>
    </div>
    <script language="javascript" type="text/javascript">
        $('#main_teaser_items').carouFredSel({
                width: 978,
                prev: '#prevMainTeaserItems',
                next: '#nextMainTeaserItems',
                auto: {play: true, timeoutDuration: 17000},
                scroll: {pauseOnHover: true}


            });
    </script>
    <div class="box_wrapper" id="tabs_news_boxes_container">
        <div id="tabs_news_boxes">
            <ul>
                <li><a href="#tabs_news_boxes-1">Tin trung tâm</a></li>
                <li><a href="#tabs_news_boxes-2">Tin phòng ban</a></li>
                <li><a href="#tabs_news_boxes-3">Tin kinh doanh</a></li>
                <li><a href="#tabs_news_boxes-4">Tin kỹ thuật</a></li>
                <li><a href="#tabs_news_boxes-5">Tin chăm sóc khách hàng</a></li>
                <li><a href="#tabs_news_boxes-6">Tin Đảng - Công đoàn</a></li>
            </ul>
            <content:findByCategory category="tin-trung-tam" begin="0" pageSize="5" var="tincongty"/>
            <content:findByCategory category="phong-ban" begin="0" pageSize="5" var="tinphongban"/>
            <content:findByCategory category="tin-kinh-doanh" begin="0" pageSize="5" var="tinkinhdoanh"/>
            <content:findByCategory category="cong-nghe-ky-thuat" begin="0" pageSize="5" var="congnghekythuat"/>
            <content:findByCategory category="cham-soc-khach-hang" begin="0" pageSize="5" var="chamsockhachhang"/>
            <content:findByCategory category="dang-uy" begin="0" pageSize="5" var="danguy"/>
            <div id="tabs_news_boxes-1">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(tincongty) > 0}">
                        <c:set var="firstItemChannel" value="${tincongty[0]}"/>
                        <oscache:cache key="tincongty_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                            <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                            <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/tin-trung-tam/${firstItemChannel.contentID}/"/>
                            <div class="first_item">
                                <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                <div class="thumb">
                                    <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                    <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                </div>
                                <div class="text">
                                    <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                    <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                </div>
                            </div>
                        </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${tincongty}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/tin-trung-tam/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                </c:forEach>

                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/tin-trung-tam.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <div id="tabs_news_boxes-2">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(tinphongban) > 0}">
                        <c:set var="firstItemChannel" value="${tinphongban[0]}"/>
                        <oscache:cache key="tinphongban_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                            <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                            <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/phong-ban/${firstItemChannel.contentID}/"/>
                            <div class="first_item">
                                <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                <div class="thumb">
                                    <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                    <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                </div>
                                <div class="text">
                                    <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                    <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                </div>
                            </div>
                        </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${tinphongban}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/phong-ban/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>

                                </c:forEach>

                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/phong-ban.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <div id="tabs_news_boxes-3">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(tinkinhdoanh) > 0}">
                        <c:set var="firstItemChannel" value="${tinkinhdoanh[0]}"/>
                            <oscache:cache key="tinkinhdoanh_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                                <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                                <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/tin-kinh-doanh/${firstItemChannel.contentID}/"/>
                                <div class="first_item">
                                    <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                    <div class="thumb">
                                        <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                        <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                    </div>
                                    <div class="text">
                                        <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                        <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                    </div>
                                </div>
                            </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${tinkinhdoanh}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/tin-kinh-doanh/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                </c:forEach>

                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/tin-kinh-doanh.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <div id="tabs_news_boxes-4">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(congnghekythuat) > 0}">
                        <c:set var="firstItemChannel" value="${congnghekythuat[0]}"/>
                            <oscache:cache key="congnghekythuat_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                                <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                                <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/cong-nghe-ky-thuat/${firstItemChannel.contentID}/"/>
                                <div class="first_item">
                                    <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                    <div class="thumb">
                                        <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                        <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                    </div>
                                    <div class="text">
                                        <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                        <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                    </div>
                                </div>
                            </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${congnghekythuat}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/cong-nghe-ky-thuat/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                </c:forEach>

                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/cong-nghe-ky-thuat.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <div id="tabs_news_boxes-5">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(chamsockhachhang) > 0}">
                        <c:set var="firstItemChannel" value="${chamsockhachhang[0]}"/>
                        <oscache:cache key="chamsockhachhang_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                            <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                            <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/cham-soc-khach-hang/${firstItemChannel.contentID}/"/>
                            <div class="first_item">
                                <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                <div class="thumb">
                                    <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                    <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                </div>
                                <div class="text">
                                    <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                    <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                </div>
                            </div>
                        </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${chamsockhachhang}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/cham-soc-khach-hang/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                </c:forEach>

                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/cham-soc-khach-hang.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <div id="tabs_news_boxes-6">
                <div class="tabs_skin">
                    <div class="body">
                        <c:if test="${fn:length(danguy) > 0}">
                        <c:set var="firstItemChannel" value="${danguy[0]}"/>
                        <oscache:cache key="danguy_${firstItemChannel.contentID}_${firstItemChannel.modifiedDate}" duration="1800">
                            <c:set var="firstItemChannelContent" value="${portal:parseContentXML(firstItemChannel.xmlData)}"/>
                            <seo:url value="${firstItemChannel.title}" var="seoURL" prefix="/tin-tuc/dang-uy/${firstItemChannel.contentID}/"/>
                            <div class="first_item">
                                <div class="title"><a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="40" upper="45" appendToEnd="...">${firstItemChannel.title}</str:truncateNicely></a></div>
                                <div class="thumb">
                                    <rep:href var="imgURL" value="${firstItemChannel.thumbnail}"/>
                                    <img src="<c:url value="${imgURL}?w=260&h=158"/>" width="260" height="158"/>

                                </div>
                                <div class="text">
                                    <str:truncateNicely lower="200" upper="300" appendToEnd="...">${portal:cleanHtmlTags(firstItemChannelContent['brief'][0])}</str:truncateNicely>
                                    <p style="margin-top:5px"><a href="<c:url value="${seoURL}"/>" class="button_brown_small">Chi tiết</a></p>
                                </div>
                            </div>
                        </oscache:cache>
                        <div class="more">
                            <ul>
                                <c:forEach items="${danguy}" var="contentItem" varStatus="status">
                                    <c:if test="${status.index >= 1}">
                                        <li>
                                            <seo:url value="${contentItem.title}" var="seoURL" prefix="/tin-tuc/dang-uy/${contentItem.contentID}/"/>
                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                                            (<span style="color:#8e8e8e; font-size: 11px; font-weight: normal; font-style: italic; margin-right: 1px;"><fmt:formatDate value="${contentItem.createdDate}" pattern="dd/MM/yyyy"/></span>  )
                                            <div class="clear"></div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                            <div class="link_all"><a href="<c:url value="/tin-tuc/dang-uy.html"/>" class="button_brown_small">Xem tất cả</a></div>
                        </div>
                        </c:if>
                    </div>
                    <div class="footer"></div>
                </div>
            </div>
            <script type="text/javascript" language="javascript">
                $(document).ready(function(){
                    $(function() {
                        $( "#tabs_news_boxes" ).tabs();
                    });
                });
            </script>
        </div>
    </div>
    <div class="box_wrapper mobi8_box">
        <div id="mobi8_container">
            <div class="mobi8_skin">
                <div class="header">
                    <div class="icon"><img src="<c:url value="/themes/vms_stretch/images/mobi8_icon.png"/>"/></div>
                    <div class="navigator">
                        <ul>
                            <li><a href="#" id="prevMobi8" class="button_prev">Lùi</a></li>
                            <li><a href="#" id="nextMobi8" class="button_next">Tới</a></li>
                            <li><a href="${appConfig['mobi8url']}" class="view_all">Xem tất cả</a></li>
                        </ul>

                    </div>
                </div>
                <div class="body">
                    <div class="body_content">
                        <div class="mobi8">
                            <ul id="sliderMobi8">
                                <oscache:cache key="Home_Mobi8_Cache_Key" duration="900">
                                <c:forEach items="${threadMobi8}" var="thread" varStatus="status">

                                    <li>
                                    <div class="avatar myCorner" data-corner="2px">
                                        <c:if test="${not empty thread.avatar}">
                                            <img src="<c:url value="${thread.avatar}"/>"/>
                                        </c:if>
                                        <c:if test="${empty thread.avatar}">
                                            <img src="<c:url value="/themes/vms_stretch/images/panda_avatar.png"/>"/>
                                        </c:if>
                                    </div>
                                    <div class="text">
                                        <a href="${thread.link}"><str:truncateNicely lower="20" upper="32" appendToEnd="...">${thread.title}</str:truncateNicely>  - <span class="modified_date">${thread.pubDate}</span></a>

                                    </div>
                                    <div class="text">
                                        <span class="myspan"> ${thread.viewCount} </span>  <img src="<c:url value="/themes/vms_stretch/images/stats.png"/>">  &nbsp;&nbsp; <span class="myspan"> ${thread.replyCount} </span>  <img src="<c:url value="/themes/vms_stretch/images/comment_icon.png"/>">
                                    </div>
                                    <div class="clear"></div>
                                    </li>
                                    <li class="space"></li>
                                </c:forEach>
                                </oscache:cache>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="footer"></div>
            </div>
        </div>
        <script type="text/javascript" language="javascript">

            $('#sliderMobi8').carouFredSel({
                width: 687,
                prev: '#prevMobi8',
                next: '#nextMobi8',
                auto: false
            });

        </script>
        <content:findByAuthoringTemplate authoringCode="poll" begin="0" pageSize="1" var="polls"/>
        <oscache:cache key="${polls[0].contentID}_${polls[0].modifiedDate}" duration="1800">
        <div id="poll_container">
            <div class="poll_skin">
                <div class="header">Thăm dò ý kiến</div>
                <div class="body">

                    <div id="pollDiv">

                        <c:set var="pollContent" value="${portal:parseContentXML(polls[0].xmlData)}"/>
                        <div class="title">${pollContent['content'][0]}</div>
                        <ul>
                            <c:forEach items="${pollContent['options']}" var="option" varStatus="status">
                                <li><input type="radio" name="options" value="${status.index}"/>${option}</li>
                            </c:forEach>
                            <input type="hidden" id="pollID" value="${polls[0].contentID}"  />
                        </ul>
                        <a class="fancybox-thumbs button_brown_small italic" data-fancybox-group="thumb" href="javascript:submitPoll();">Đánh giá</a>
                            <a class="fancybox-thumbs button_brown_medium italic" data-fancybox-group="thumb" href="javascript:showPoll();">Xem kết quả </a>

                    </div>
                </div>
                <div class="footer"></div>
            </div>
        </div>
        </oscache:cache>
    </div>
    <div class="clear"></div>
    <content:findByAuthoringTemplate authoringCode="thong-diep-giam-doc" begin="0" pageSize="1" var="infoFromManager"/>
    <content:findByAuthoringTemplate authoringCode="thong-bao" begin="0" pageSize="1" var="thong-bao-chung"/>
    <content:findByAuthoringTemplate authoringCode="tin-quan-trong" begin="0" pageSize="1" var="importantNews"/>
    <div id="thongdiep_container">
        <div class="box_wrapper">
            <div class="simple_skin">
                <div class="header"></div>
                <div class="body">
                    <ul>
                        <li>
                            <c:if test="${not empty infoFromManager && fn:length(infoFromManager) > 0}">
                                <oscache:cache key="${infoFromManager[0].contentID}_${infoFromManager[0].modifiedDate}" duration="1800">
                                    <div class="title">
                                        <img src="<c:url value="/themes/vms_stretch/images/thongtin_icon.png"/>"/>
                                        <str:truncateNicely lower="20" upper="32" appendToEnd="...">${infoFromManager[0].title}</str:truncateNicely>
                                    </div>
                                    <div class="text">
                                        <c:set var="itemContent" value="${portal:parseContentXML(infoFromManager[0].xmlData)}"/>
                                        <p style="text-align:justify;"><str:truncateNicely lower="180" upper="190" appendToEnd="...">${portal:cleanHtmlTags(itemContent['content'][0])}</str:truncateNicely></p>
                                        <seo:url value="${infoFromManager[0].title}" var="infoFromManagerURL" prefix="/thong-diep-giam-doc/${infoFromManager[0].contentID}/"/>
                                        <p style="margin-top:20px;"><a href="${infoFromManagerURL}" class="button_brown_small">Xem thêm</a></p>
                                    </div>
                                </oscache:cache>
                            </c:if>
                        </li>
                        <li class="space"></li>
                        <li>
                            <c:if test="${not empty importantNews && fn:length(importantNews) > 0}">
                                <oscache:cache key="${importantNews[0].contentID}_${importantNews[0].modifiedDate}" duration="1800">
                                    <div class="title">
                                        <img src="<c:url value="/themes/vms_stretch/images/news_icon.png"/>"/>
                                        <str:truncateNicely lower="20" upper="32" appendToEnd="...">${importantNews[0].title}</str:truncateNicely>
                                    </div>
                                    <div class="text">
                                        <c:set var="itemContent" value="${portal:parseContentXML(importantNews[0].xmlData)}"/>
                                        <p style="text-align:justify;"><str:truncateNicely lower="180" upper="190" appendToEnd="...">${portal:cleanHtmlTags(itemContent['brief'][0])}</str:truncateNicely></p>
                                        <seo:url value="${importantNews[0].title}" var="importantNewsURL" prefix="/tin-quan-trong/${importantNews[0].contentID}/"/>
                                        <p style="margin-top:20px;"><a href="${importantNewsURL}" class="button_brown_small">Xem thêm</a></p>
                                    </div>
                                </oscache:cache>
                            </c:if>
                        </li>
                        <li class="space"></li>
                        <li>
                            <c:if test="${not empty thongbao && fn:length(thongbao) > 0}">
                                <oscache:cache key="${thongbao[0].contentID}_${thongbao[0].modifiedDate}" duration="1800">
                                    <div class="title">
                                        <img src="<c:url value="/themes/vms_stretch/images/thongbao_icon.png"/>"/>
                                            <str:truncateNicely lower="20" upper="32" appendToEnd="...">${thongbao[0].title}</str:truncateNicely>
                                    </div>
                                    <div class="text">
                                        <c:set var="itemContent" value="${portal:parseContentXML(thongbao[0].xmlData)}"/>
                                        <p style="text-align:justify;"><str:truncateNicely lower="180" upper="190" appendToEnd="...">${portal:cleanHtmlTags(itemContent['content'][0])}</str:truncateNicely></p>
                                        <seo:url value="${thongbao[0].title}" var="thongbaoURL" prefix="/thong-bao/${thongbao[0].contentID}/"/>

                                        <p style="margin-top:20px;"><a href="${thongbaoURL}" class="button_brown_small">Xem thêm</a></p>
                                    </div>
                                </oscache:cache>
                            </c:if>
                        </li>
                    </ul>

                </div>
                <div class="footer"></div>
            </div>

        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <content:findByAuthoringTemplate authoringCode="chan-dung" begin="0" pageSize="30" var="chandung"/>

    <div id="chandung_container">
        <div class="box_wrapper">
            <div class="chandung_skin">
                <div class="header">GÓC NHÌN MOBIFONE</div>
                <div class="body">
                    <div class="list_carousel">
                        <a id="prevChandung" class="prev" href="#"><img src="<c:url value="/themes/vms_stretch/images/chandung_prev.png"/>"/></a>
                        <a id="nextChandung" class="next" href="#"><img src="<c:url value="/themes/vms_stretch/images/chandung_next.png"/>"/></a>
                        <ul id="sliderChandung">
                            <c:forEach items="${chandung}" var="chandungItem" varStatus="status">
                                <oscache:cache key="${chandungItem.contentID}_${chandungItem.modifiedDate}" duration="1800">
                                <c:set var="chandungItemContent" value="${portal:parseContentXML(chandungItem.xmlData)}"/>
                                <rep:href value="${chandungItemContent['image'][0]}" var="thumbnailURL"/>
                                <seo:url value="${chandungItem.title}" var="seoURL" prefix="/chan-dung/${chandungItem.contentID}/"/>
                                <li>
                                    <div class="box_image myCorner" data-corner="2px">
                                        <a href="${seoURL}"><img src="<c:url value="${thumbnailURL}?w=200&h=140" />"></a>
                                    </div>
                                    <div class="description">
                                        <a href="${seoURL}">${chandungItemContent['fullname'][0]}</a>
                                    </div>


                                </li>
                                </oscache:cache>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="footer"></div>
            </div>
            <script type="text/javascript" language="javascript">

                $('#sliderChandung').carouFredSel({
                    width: 920,
                    prev: '#prevChandung',
                    next: '#nextChandung',
                    auto: false
                });

            </script>
        </div>
    </div>

</body>
</oscache:cache>