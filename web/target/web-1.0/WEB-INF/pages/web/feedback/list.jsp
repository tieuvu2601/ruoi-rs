<%@ include file="/common/taglibs.jsp"%>
<head>
    <title>Phản hồi ý kiến</title>
    <meta name="heading" content="Home Page"/>

</head>
<c:url var="url" value="/phan-hoi.html"/>
<body class="sub_page">
	<div class="sub_page_panel">
		<div class="box_wrapper">
			<form:form method="post" commandName="item" action="${url}" id="frmFeedback">
				<div class="sub_page_title">
                    <div style="float:left">Ý kiến phản hồi</div>
                    <div style="float:right" class="button_feedback"><a href="<c:url value="/gui-y-kien.html"/>">Gửi ý kiến</a></div>
                </div>
				<div class="sub_page_content">
					<div class="col w_2-3">
						<div id="component-1" class="row">
							<div class="detail_two_cols_skin">

	                            <div class="clear"></div>
                                <div class="body myCorner" data-corner="bottom 5px">
                                    <div class="body_content">
                                        <c:if test="${not empty param.messageResponse}">
                                            <div class="message">${param.messageResponse}</div>
                                        </c:if>
                                        <display:table name="item.listResult" cellspacing="0" cellpadding="0" style="margin-bottom: 2.5em;" requestURI="${url}"
                                             size="${item.totalItems}" partialList="true" sort="external" uid="tableList" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">
                                             <display:column>
                                                 <c:set var="answerClass" value="answered"/>
                                                 <c:if test="${tableList.status == 0}">
                                                     <c:set var="answerClass" value="notAnsweredYet"/>
                                                 </c:if>
                                                 <div class="feedback_item ${answerClass}">
                                                    <seo:url prefix="/phan-hoi/${tableList.feedbackID}/" value="${tableList.title}" var="seoURL"/>
                                                    <div class="title">
                                                        <a href="<c:url value="${seoURL}"/>">${tableList.title}</a>
                                                    </div>
                                                    <div class="modified_date">
                                                        Gửi bởi <span class="author">${tableList.createdBy.displayName}</span> lúc <fmt:formatDate value="${tableList.createdDate}" pattern="dd/MM/yyyy"/>
                                                    </div>

                                                    <div class="text">
                                                        <div class="brief">
                                                            ${tableList.content}

                                                        </div>
                                                    </div>
                                                    <div class="clear"></div>
                                                 </div>
                                             </display:column>

                                            <div class="clear"></div>
                                            <display:setProperty name="paging.banner.item_name"><fmt:message key="content"/></display:setProperty>
                                            <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
                                            <display:setProperty name="paging.banner.placement" value="bottom"/>
                                            <display:setProperty name="paging.banner.no_items_found" value=""/>
                                            <display:setProperty name="paging.banner.onepage" value=""/>
                                            <display:setProperty name="paging.banner.group_size" value="5"/>
                                            <display:setProperty name="paging.banner.some_items_found"><span class="pagebanner">Hiển thị {2} đến {3} của {0}.</span> </display:setProperty>
                                            <display:setProperty name="paging.banner.all_items_found"><span class="pagelinks">{0} phản hồi được tìm thấy.</span> </display:setProperty>
                                        </display:table>
                                        <div class="clear"></div>
                                    </div>
                                </div>
						    </div>
						</div>
					</div>

					<div class="col w_1-3 right_column">
                        <div id="component-search-feedback">
                            <div class="small_light_skin">
                                <div class="header">Tìm kiếm ý kiến</div>
                                <div class="body">
                                    <ul class="feedback_search_panel">
                                        <li>
                                            <form:input path="pojo.title" size="40" value="${item.pojo.title }" cssStyle="height: 20px; width: 280px;border: 1px solid #C9C9C9;"/>
                                        </li>
                                        <li>
                                            <select name="pojo.department" id="departmentID" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                                <option value="">Phòng ban</option>
                                                <c:forEach items="${departments}" var="department">
                                                    <option value="${department.departmentID}" <c:if test="${department.departmentID eq item.pojo.department.departmentID}">selected</c:if>>${department.name}</option>
                                                </c:forEach>
                                            </select>
                                        </li>
                                        <li>
                                            <select name="pojo.feedbackCategory" id="feedbackCategoryID" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                                <option value="">Loại phản hồi</option>
                                                <c:forEach items="${feedbackCategories}" var="feedbackCategory">
                                                    <option value="${feedbackCategory.feedbackCategoryID}" <c:if test="${feedbackCategory.feedbackCategoryID eq item.pojo.feedbackCategory.feedbackCategoryID}">selected</c:if>>${feedbackCategory.name}</option>
                                                </c:forEach>
                                            </select>
                                        </li>
                                        <li>
                                            <select name="pojo.status" id="status" style="height: 20px; width: 280px;border: 1px solid #C9C9C9;">
                                                <option value="" <c:if test="${empty item.pojo.status}">selected</c:if>>Tình trạng</option>
                                                <option value="0" <c:if test="${item.pojo.status == 0}">selected</c:if>><fmt:message key="status.new"/></option>
                                                <option value="1" <c:if test="${item.pojo.status == 1}">selected</c:if>><fmt:message key="status.replied"/></option>
                                            </select>
                                        </li>
                                        <li>
                                            <div style="width: 80px;float:left;">Từ ngày</div><div style="float:left;"><input type="text" name="fromDate" id="fromDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.fromDate}" pattern="dd/MM/yyyy"/>"/></div>
                                        </li>
                                        <li>
                                            <div style="width: 80px;float:left;">đến</div><div style="float:left;"><input type="text" name="toDate" id="toDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.toDate}" pattern="dd/MM/yyyy"/>"/></div>
                                        </li>
                                        <li>
                                            <form:hidden path="crudaction" id="crudaction" value="search"/>
                                            <input type="submit" value="<fmt:message key="button.search"/>" />
                                        </li>
                                    </ul>
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
				</div>
				<script type="text/javascript">
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
			</form:form>
		</div>
		<div class="clear"></div>
	</div>
</body>

