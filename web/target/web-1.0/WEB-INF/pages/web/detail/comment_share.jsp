<%@ include file="/common/taglibs.jsp"%>


<div class="related_items">
    <div class="share_panel myCorner" data-corner="5px">
        <form action="<c:url value='/detail/tracking.html'/>" id="trackingDivForm" method="POST">
            <input type="hidden" name="isLiked" id="isLiked" value="true"/>
            <input type="hidden" name="pojo.content.contentID" value="${currentContentItem.contentID}" />
        </form>
        <c:choose>
            <c:when test="${currentContentItem.accessPolicy == 1}">
                <div style="width:180px;margin: 0 auto;">
                    <span style="float:left;line-height:32px;" id="trackingStatistic"><fmt:formatNumber value="${trackingDetail.likes}" pattern="###,###"/></span> <a href="javascript:submitTracking('true');" class="like">&nbsp;</a>
                    <a href="javascript:shareFacebook();" class="facebook">&nbsp;</a>
                    <a href="javascript:shareGoogle();" class="google">&nbsp;</a>
                    <a href="javascript:shareTwitter();" class="twitter">&nbsp;</a>
                </div>
            </c:when>
            <c:otherwise>
                <div style="width:60px;margin: 0 auto;">
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
        <form action="/detail/addComment.html" id="commentDivForm" method="POST">
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
        <div class="title_container">
            <div class="title" style="float:left;">
                Tin khác
            </div>
            <div class="slider_nav">
                <a id="relatedPrev" class="relatedPrev" href="#"><img src="<c:url value="/themes/vms_stretch/skins/images/previous_icon.png"/>"/></a>
                <a id="relatedNext" class="relatedNext" href="#"><img src="<c:url value="/themes/vms_stretch/skins/images/next_icon.png"/>"/></a>

            </div>
        </div>
        <div class="clear"></div>
        <ul id="sliderRelatedArticles">
            <c:forEach items="${relatedItems}" var="contentItem">
                <c:set var="prefix" value="/${param.authoringTemplate}/"/>
                <c:if test="${not empty $param.category}">
                    <c:set var="prefix" value="${prefix}${param.category}/"/>
                </c:if>
                <c:set var="prefix" value="${prefix}${contentItem.contentID}/"/>
                <seo:url prefix="${prefix}" value="${contentItem.title}" var="seoURL"/>
                <rep:href value="${contentItem.thumbnail}" var="thumbnailURL"/>
                <li>
                    <div class="box_image myCorner" data-corner="2px">
                        <a href="<c:url value="${seoURL}"/>"><img src="<c:url value="${thumbnailURL}?w=150&h=100" />"></a>
                    </div>
                    <div class="description">
                        <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </c:if>

</div>
<div class="clear"></div>
