<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>${currentContentItem.title}</title>
    <meta name="heading" content="${currentContentItem.title}"/>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js' />"></script>
    <script type="text/javascript">
        $("#commentDivForm").ajaxForm({
            target: "commentDiv"
        });
        $("#trackingDivForm").ajaxForm({
            target: "trackingDiv"
        });
        function submitComment(){
            <security:authorize ifNotGranted="LOGON">
                jAlert("Xin vui lòng <a href='/login.jsp'>đăng nhập</a> để thêm bình luận.", "Thông báo");
                return;
            </security:authorize>
            if ($("#commentText").val() == '') {
                jAlert("Nhập nội dung bình luận của bạn.", "Thông báo");
                return;
            }
            $("#commentDivForm").submit();
            $("#commentText").val('');
            jAlert("Bình luận của bạn đã được gửi thành công", "Thông báo");
        }

        function submitTracking(isLiked){
            $("#isLiked").val(isLiked);
            $("#trackingDivForm").submit();
            if($("#likeLink").css('display') == 'none'){
                $("#likeLink").css('display','block');
            } else {
                $("#likeLink").css('display','none');
            }
            if($("#dislikeLink").css('display') == 'none'){
                $("#dislikeLink").css('display','block');
            } else {
                $("#dislikeLink").css('display','none');
            }
        }

        function toggleComment(){
            <security:authorize ifNotGranted="LOGON">
                jAlert("Xin vui lòng <a href='/login.jsp'>đăng nhập</a> để thêm bình luận.", "Thông báo");

            </security:authorize>
            if($("#commentDiv").css('display') == 'none'){
                $("#commentDiv").css('display','block');
            } else {
                $("#commentDiv").css('display','none');
            }
        }

    </script>
</head>
<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title">${currentContentItem.title} </div>
            <div class="sub_page_content">
                <div class="col w_2-3">
                    <div id="component-1" class="row">
                        <div class="detail_two_cols_skin">
                            <div class="header">
                                <a href="<c:url value="/trang-chu.html"/>"><fmt:message key="home.home"/></a>
                                &raquo; ${currentAuthoringTemplate.name}
                                <c:if test="${not empty currentCategory}">
                                    &raquo; <a href="<c:url value="/${param.authoringTemplate}/${currentCategory.code}.html"/>">${currentCategory.name}</a>
                                </c:if>
                            </div>
                            <div class="body  myCorner" data-corner="bottom 5px">
                                <div class="body_content">
                                    <div class="content_item">
                                        <rep:href value="${currentContentItem.thumbnail}" var="imgURL"/>
                                        <oscache:cache key="${currentContentItem.contentID}_${currentContentItem.modifiedDate}" duration="1800">
                                        <c:set var="currentContentItemContent" value="${portal:parseContentXML(currentContentItem.xmlData)}"/>
                                        <div class="text">
                                            <c:forEach items="${currentContentItemContent}" var="itemContent">
                                                ${itemContent.key} - ${currentContentItemContent['${itemContent.key}'][0]}
                                            </c:forEach>
                                        </div>
                                        </oscache:cache>
                                    </div>
                                    <div id="trackingDiv" style="float: right;">
                                        <form action="/detail/tracking.html" id="trackingDivForm" method="POST">
                                            <a href="javascript:submitTracking('true');" id="likeLink" style="display: block"><img src="<c:url value="/themes/vms_stretch/images/like_icon2.png"/>"/></a>
                                            <input type="hidden" name="isLiked" id="isLiked" value="true"/>
                                            <input type="hidden" name="pojo.content.contentID" value="${currentContentItem.contentID}" />
                                        </form>
                                    </div>

                                    <div class="related_items">
                                        <div class="title">
                                            Bài Liên Quan
                                        </div>
                                        <ul>
                                            <c:forEach items="${relatedItems}" var="contentItem">
                                                <c:set var="prefix" value="/${param.authoringTemplate}/"/>
                                                <c:if test="${not empty $param.category}">
                                                    <c:set var="prefix" value="${prefix}${param.category}/"/>
                                                </c:if>
                                                <c:set var="prefix" value="${prefix}${contentItem.contentID}/"/>
                                                <seo:url prefix="${prefix}" value="${contentItem.title}" var="seoURL"/>
                                                <li>
                                                    <div class="more">
                                                        <a href="<c:url value="${seoURL}"/>"><span class="text_red">&#9744;</span> ${contentItem.title}</a>
                                                        <span class="modified_date"><fmt:formatDate value="${contentItem.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                                    </div>
                                                    <div class="clear"></div>
                                                </li>
                                            </c:forEach>

                                        </ul>
                                        <c:if test="${currentAuthoringTemplate.status == 'Y'}">
                                        <div class="title">
                                            Bình Luận
                                        </div>
                                        <c:if test="${not empty item.listResults && fn:length(item.listResults) > 0}">
	                                        <div class="comment_items">
	                                        	<seo:url prefix="/${param.authoringTemplate}/${param.contentID}/" value="${currentContentItem.title}" var="url"/> 
	                                        	<form:form method="post" commandName="item" action="${url }" id="frmSearch">
		                                            <ul>
		                                            <display:table name="item.listResults" cellspacing="0" cellpadding="0" style="margin-bottom: 2.5em;" requestURI="${url}" excludedParams="*"
	                                                 	size="${item.totalItems}" partialList="true" sort="external" uid="tableList" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">
	                                                 	<display:column>
			                                                <li>
				                                                <div class="avatar">
				                                                    <c:choose>
				                                                        <c:when test="${!empty tableList.createdBy.avatar }">
				                                                            <rep:href value="${tableList.createdBy.avatar}" var="thumbnailURL"/>
				                                                            <c:url var="thumbnailURL" value="${thumbnailURL}"/>
				                                                            <c:if test="${fn:indexOf(tableList.createdBy.avatar, '/') lt 0 }">
				                                                                <c:url var="thumbnailURL" value="/themes/vms/images/avatar/${tableList.createdBy.avatar}"/>
				                                                            </c:if>
				                                                            <img id="img" src="${thumbnailURL}?w=40&h=44&f=1" style="max-width: 40px;max-height: 44px;" />
				                                                        </c:when>
																		<c:otherwise>
																			<img id="img" src="<c:url value='/themes/vms/images/avatar/no_picture.gif'/>?w=40&h=44&f=1" style="max-width: 40px;max-height: 44px;" />
																		</c:otherwise>
				                                                    </c:choose>
				                                                </div>
				                                                <div class="text">${tableList.createdBy.displayName}: ${tableList.commentText}</div>
				                                                <div class="clear"></div>
		                                                	</li>
			                                                </display:column>
			                                                
			                                                <div class="clear"></div>
			                                                <display:setProperty name="paging.banner.item_name"><fmt:message key="comment"/></display:setProperty>
			                                                <display:setProperty name="paging.banner.items_name"><fmt:message key="comment"/></display:setProperty>
			                                                <display:setProperty name="paging.banner.placement" value="bottom"/>
			                                                <display:setProperty name="paging.banner.no_items_found" value=""/>
			                                                <display:setProperty name="paging.banner.onepage" value=""/>
			                                                <display:setProperty name="paging.banner.group_size" value="5"/>
			                                                <display:setProperty name="paging.banner.some_items_found"><span class="pagebanner">Hiển thị {2} đến {3} của {0}.</span> </display:setProperty>
			                                                <display:setProperty name="paging.banner.all_items_found"><span class="pagelinks">Hiển thị tất cả {0} bình luận.</span> </display:setProperty>
		                                                </display:table>
		                                            
		                                            </ul>
	                                            </form:form>
	                                        </div>
                                        </c:if>
                                        <div id="commentDiv" class="text">
                                            <form action="/detail/addComment.html" id="commentDivForm">
                                                <textarea id="commentText" name="pojo.commentText" class="textarea_comment"></textarea>
                                                <input type="hidden" name="pojo.content.contentID" value="${currentContentItem.contentID}" />
                                                <div style="width: 100%; margin-bottom: 3px">
                                                    <a href="#commentDiv" class="button_comment" onclick="submitComment();">Gửi</a>
                                                </div>
                                            </form>
                                        </div>
									</c:if>
                                    </div>
                                    
                                    <div class="clear"></div>
                                </div>
                            </div>
                           <div class="footer"></div>
                        </div>
                        <div class="clear"></div>
                    </div>



                </div>
                <div class="col w_1-3 right_column">
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
                                            <c:when test="${not empty contentItemContent['image'][0]}">
                                                <rep:href value="${contentItemContent['image'][0]}" var="itemURL" />
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
                                                			<a href="${contentItemContent['url'][0]}" target="_blank"><img src="<c:url value="${itemURL}"/>" width="280"/></a>
                                                		</c:when>
                                                		<c:otherwise>
                                                			<img src="<c:url value="${itemURL}"/>" width="280"/>
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
                                    <oscache:cache key="${contentItem.contentID}_${contentItem.modifiedDate}" duration="1800">
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
                <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</body>