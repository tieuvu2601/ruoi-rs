<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>${currentContentItem.title}</title>
    <meta name="heading" content="${currentContentItem.title}"/>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js' />"></script>
    <script type="text/javascript">
        $("#commentDivForm").ajaxForm({
            type: "POST",
            target: "commentDiv"
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
            var url = $('#trackingDivForm').serialize();
            var surl = '<c:url value='/detail/tracking.html'/>?' + url;
            $.ajax({
                type: 'GET',
                cache: false,
                url: surl,
                timeout: 30000,
                error: function(xhr, ajaxOptions, thrownError){ },
                success: function(data){
                    $("#trackingStatistic").html(data.like);
                }
            });
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
            <div class="sub_page_title"><str:truncateNicely lower="140" upper="160" appendToEnd="...">${currentContentItem.title}</str:truncateNicely></div>
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
                                <div class="date_modified">
                                    [<fmt:formatDate value="${currentContentItem.modifiedDate}" pattern="dd/MM/yyyy HH:mm:ss"/>]
                                </div>
                            </div>
                            <div class="body  myCorner" data-corner="bottom 5px">
                                <div class="body_content">
                                    <oscache:cache key="${currentContentItem.contentID}_${currentContentItem.modifiedDate}" duration="1800">
                                    <div class="content_item">
                                        <c:set var="currentContentItemContent" value="${portal:parseContentXML(currentContentItem.xmlData)}"/>
                                        <div class="text">
                                            ${currentContentItemContent['content'][0]}
                                        </div>
                                        <div class="author">
                                            ${currentContentItem.createdBy.displayName}
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                    </oscache:cache>

                                    <div class="related_items">
                                        <div class="share_panel myCorner" data-corner="5px">
                                            <form action="<c:url value='/detail/tracking.html'/>" id="trackingDivForm" method="POST">
                                                <input type="hidden" name="isLiked" id="isLiked" value="true"/>
                                                <input type="hidden" name="pojo.content.contentID" value="${currentContentItem.contentID}" />
                                            </form>
                                            <c:choose>
                                                <c:when test="${currentContentItem.accessPolicy == 1}">
                                                    <div style="width:240px;margin: 0 auto;">
                                                        <span style="float:left;line-height:32px;"><fmt:formatNumber value="${trackingDetail.views}" pattern="###,###"/></span>
                                                        <a href="#" class="statistic"></a>
                                                        <span style="float:left;line-height:32px;" id="trackingStatistic"><fmt:formatNumber value="${trackingDetail.likes}" pattern="###,###"/></span> <a href="javascript:submitTracking('true');" class="like">&nbsp;</a>
                                                        <a href="javascript:shareFacebook();" class="facebook">&nbsp;</a>
                                                        <a href="javascript:shareGoogle();" class="google">&nbsp;</a>
                                                        <a href="javascript:shareTwitter();" class="twitter">&nbsp;</a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width:120px;margin: 0 auto;">
                                                        <span style="float:left;line-height:32px;" id="trackingStatistic"><fmt:formatNumber value="${trackingDetail.likes}" pattern="###,###"/></span> <a href="javascript:submitTracking('true');" class="like">&nbsp;</a>

                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="clear"></div>
                                        </div>
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
                                                    <div class="clear"></div>
                                                </div>
                                            </form>
                                        </div>
                                        </c:if>
                                        <c:if test="${not empty relatedItems && fn:length(relatedItems) > 0 }">
                                        <div class="title">
                                            Tin khác
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
                    <jsp:include page="right_panel.jsp" flush="true"/>

                </div>
                <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</body>