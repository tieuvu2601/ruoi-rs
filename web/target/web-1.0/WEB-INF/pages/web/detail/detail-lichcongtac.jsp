<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>Detail</title>
    <meta name="heading" content="Home Page"/>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/jquery.form.js' />"></script>
    <script type="text/javascript">
        $("#commentDivForm").ajaxForm({
            target: "commentDiv"
        });
        function submitComment(){
            $("#commentDivForm").submit();
            $("#commentText").val('');
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
<body>
    <div class="col w_2-3">
        <div id="component-1" class="row">
            <div class="large_blue_skin">
                <div class="header">
                    <a href="<c:url value="/trang-chu.html"/>"><img src="<c:url value="/themes/vms/images/home_ico.png"/>" class="home_icon"/></a>
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
                            <div class="content_title">
                                ${currentContentItem.title} <span class="modified_date"><fmt:formatDate value="${currentContentItem.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                            </div>
                            <div class="text">
                                ${currentContentItemContent['content'][0]}
                            </div>
                            </oscache:cache>
                        </div>
                        <div class="related_items">
                          <div class="title">
                                <div style="float:left;margin-right:10px;"><img src="<c:url value="/themes/vms/skins/images/red_related_items_bk.png"/>"/></div>Các tin liên quan
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
                        Online: ${userOnlineCounter}<br/>
                        Visited: ${totalVisitors}

                    </div>
                </div>
               <div class="footer"></div>
            </div>
        </div>

    </div>
</body>