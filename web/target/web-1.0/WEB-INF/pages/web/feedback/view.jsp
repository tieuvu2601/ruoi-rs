<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>${item.pojo.title}</title>
    <meta name="heading" content="${item.pojo.title}"/>

</head>
<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title">
                <div style="float:left;">${item.pojo.title}</div>
                <div style="float:right" class="button_feedback"><a href="<c:url value="/gui-y-kien.html"/>">Gửi ý kiến</a></div>
            </div>
            <div class="sub_page_content">
                <div class="col w_2-3">
                    <div id="component-1" class="row">
                        <div class="detail_two_cols_skin">
                            <div class="header">
                                <a href="<c:url value="/trang-chu.html"/>"><fmt:message key="home.home"/></a>

                                &raquo; <a href="<c:url value="/phan-hoi.html"/>">Ý kiến phản hồi</a>

                            </div>
                            <div class="body  myCorner" data-corner="bottom 5px">
                                <div class="body_content">
                                    <c:if test="${not empty param.messageResponse}">
                                        <div class="message myCorner" data-corner="5px" style="margin-bottom:5px;">${param.messageResponse}</div>
                                    </c:if>
                                    <ul class="feedback_detail_panel">
                                        <li class="first_item">
                                            <div class="content">
                                                <div class="avatar">
                                                    <c:choose>
                                                        <c:when test="${!empty item.pojo.createdBy.avatar }">
                                                            <rep:href value="${item.pojo.createdBy.avatar}" var="thumbnailURL"/>
                                                            <c:url var="thumbnailURL" value="${thumbnailURL}"/>
                                                            <c:if test="${fn:indexOf(item.pojo.createdBy.avatar, '/') lt 0 }">
                                                                <c:url var="thumbnailURL" value="/themes/vms/images/avatar/${item.pojo.createdBy.avatar}"/>
                                                            </c:if>
                                                            <img id="img" src="${thumbnailURL}?w=40&h=44&f=1" style="max-width: 60px;max-height: 60px;" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img id="img" src="<c:url value='/themes/vms/images/avatar/no_picture.gif'/>?w=60&h=60&f=1" style="max-width: 60px;max-height: 60px;" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="content_wrapper">
                                                    <div class="author">${item.pojo.createdBy.displayName}</div>
                                                    <div class="posted_date"><fmt:formatDate value="${item.pojo.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
                                                    <div class="excerpt myCorner" data-corner="5px">
                                                        <span class="pointer">&nbsp;</span>
                                                        <div class="question" style="font-weight:bold;">${item.pojo.title}</div>
                                                        ${item.pojo.content}
                                                    </div>
                                                    <div class="actions">
                                                        <a href="/tra-loi-y-kien.html?pojo.feedbackID=${item.pojo.feedbackID}">Phản hồi</a>
                                                        <span class="statistic">
                                                            <c:choose>
                                                                <c:when test="${item.totalReplied > 0}">
                                                                    Có ${item.totalReplied} phản hồi
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Chưa có phản hồi
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clear"></div>

                                        </li>
                                        <c:forEach items="${item.replies}" var="reply">
                                            <li class="first_item">
                                            <div class="content">
                                                <div class="avatar">
                                                    <c:choose>
                                                        <c:when test="${!empty reply.createdBy.avatar }">
                                                            <rep:href value="${reply.createdBy.avatar}" var="thumbnailURL"/>
                                                            <c:url var="thumbnailURL" value="${thumbnailURL}"/>
                                                            <c:if test="${fn:indexOf(reply.createdBy.avatar, '/') lt 0 }">
                                                                <c:url var="thumbnailURL" value="/themes/vms/images/avatar/${reply.createdBy.avatar}"/>
                                                            </c:if>
                                                            <img id="img" src="${thumbnailURL}?w=40&h=44&f=1" style="max-width: 60px;max-height: 60px;" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img id="img" src="<c:url value='/themes/vms/images/avatar/no_picture.gif'/>?w=60&h=60&f=1" style="max-width: 60px;max-height: 60px;" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="content_wrapper">
                                                    <div class="author">${reply.createdBy.displayName}</div>
                                                    <div class="posted_date"><fmt:formatDate value="${reply.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/></div>
                                                    <div class="excerpt myCorner" data-corner="5px">
                                                        <span class="pointer">&nbsp;</span>
                                                        ${reply.content}
                                                    </div>

                                                </div>
                                            </div>

                                        </li>
                                        </c:forEach>

                                    </ul>
                                    <div class="clear"></div>
                                </div>
                            </div>
                           <div class="footer"></div>
                        </div>
                        <div class="clear"></div>
                    </div>



                </div>
                <div class="col w_1-3 right_column">
                	<div id="component-search-feedback">
                        <div class="small_light_skin">
                            <div class="header">Tìm kiếm ý kiến</div>
                            <div class="body">
                                <form action="<c:url value='/phan-hoi.html'/>" id="frmFeedbackList">
                                <ul class="feedback_search_panel">
                                    <li>
                                        <input type="text" name="pojo.title" size="40" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;"/>
                                    </li>
                                    <li>
                                        <select name="pojo.department" id="departmentID" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                            <option value="">Phòng ban</option>
                                            <c:forEach items="${departments}" var="department">
                                                <option value="${department.departmentID}">${department.name}</option>
                                            </c:forEach>
                                        </select>
                                    </li>
                                    <li>
                                        <select name="pojo.feedbackCategory" id="feedbackCategoryID" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                            <option value="">Loại phản hồi</option>
                                            <c:forEach items="${feedbackCategories}" var="feedbackCategory">
                                                <option value="${feedbackCategory.feedbackCategoryID}">${feedbackCategory.name}</option>
                                            </c:forEach>
                                        </select>
                                    </li>
                                    <li>
                                        <select name="pojo.status" id="status" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                            <option value="">Tình trạng</option>
                                            <option value="0"><fmt:message key="status.new"/></option>
                                            <option value="1"><fmt:message key="status.replied"/></option>
                                        </select>
                                    </li>
                                    <li>
                                        <div style="width: 80px;float:left;">Từ ngày</div><div style="float:left;"><input type="text" name="fromDate" id="fromDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.fromDate}" pattern="dd/MM/yyyy"/>"/></div>
                                    </li>
                                    <li>
                                        <div style="width: 80px;float:left;">đến</div><div style="float:left;"><input type="text" name="toDate" id="toDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.toDate}" pattern="dd/MM/yyyy"/>"/></div>
                                    </li>
                                    <li>
                                        <input type="hidden" name="crudaction" id="crudaction" value="search"/>
                                        <input type="submit" value="<fmt:message key="button.search"/>" />
                                    </li>
                                </ul>
                                </form>
                            </div>
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
                <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
 </div>
    <script type="text/javascript" language="javascript">
    $(document).ready(function() {
        $("#fromDate" ).datepicker({
                showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms_stretch/images/iconCalendar.png"/>',
                dateFormat : 'dd/mm/yy',
                onSelect: function (selectedDateTime){
                    var dateFmt = 'mm/dd/yy';
                    var start = $(this).datetimepicker('getDate');
                    var end = new Date(start.getTime() + (1000 * 86400 * 7));
                    $('#toDate').val($.datepicker.formatDate(dateFmt, end, dateFmt));
                }
        });
        $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms_stretch/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });
    });
    </script>
</body>