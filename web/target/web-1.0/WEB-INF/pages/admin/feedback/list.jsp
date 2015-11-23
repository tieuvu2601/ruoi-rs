<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="feedback.management"/></title>
    <meta name="heading" content="<fmt:message key="feedback.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="feedback.management"/>
</div>

<c:url var="url" value="/admin/feedback/list.html"/>
<c:url var="replyUrl" value="/admin/feedback/reply.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="feedback"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="feedback.department"/></td>
                        <td>
                            <select path="pojo.department">
                                <option value="" <c:if test="${empty items.pojo.department}">selected</c:if>><fmt:message key="label.all"/></option>
                                <c:forEach items="${departments}" var="department">
                                    <option value="${department.departmentID}" <c:if test="${items.pojo.department.departmentID == department.departmentID}">selected</c:if>>${department.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><fmt:message key="feedback.category"/></td>
                        <td>
                            <select path="pojo.feedbackCategory">
                                <option value="" <c:if test="${empty items.pojo.feedbackCategory}">selected</c:if>><fmt:message key="label.all"/></option>
                                <c:forEach items="${feedbackCategories}" var="category">
                                    <option value="${category.feedbackCategoryID}" <c:if test="${items.pojo.feedbackCategory.feedbackCategoryID == category.feedbackCategoryID}">selected</c:if>>${category.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="label.status"/></td>
                        <td>
                            <select name="pojo.status">
                                <option value="" <c:if test="${empty items.pojo.status}">selected</c:if>><fmt:message key="label.all"/></option>
                                <option value="0" <c:if test="${items.pojo.status == 0}">selected</c:if>><fmt:message key="status.new"/></option>
                                <option value="1" <c:if test="${items.pojo.status == 1}">selected</c:if>><fmt:message key="status.replied"/></option>
                            </select>
                        </td>
                        <td><fmt:message key="feedback.createddate"/></td>
                        <td>
                        <input type="text" name="fromDate" id="fromDate" value='<fmt:formatDate value="${items.fromDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" />
                        <fmt:message key="toDate" />
                        <input type="text" name="toDate" id="toDate" value='<fmt:formatDate value="${items.toDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" />
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="feedback.title"/></td>
                        <td colspan="3"><form:input path="pojo.title" size="40"/></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td colspan="3">
                            <form:hidden path="crudaction" id="crudaction" value="search"/>
                            <input type="button" value="<fmt:message key="button.search"/>" onclick="$('#listForm').submit();"/>
                        </td>
                    </tr>
                </table>
            </div>

        </div>

        <br/>
         <div class="box_container" >

            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false" excludedParams="crudaction">
                <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                            <input type="checkbox" name="checkList" value="${tableList.feedbackID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="code" titleKey="feedback.name" style="width: 15%" >
                    <a href="${editUrl}?pojo.feedback=${tableList.feedbackID}">${tableList.title}</a>
                </display:column>

                <display:column headerClass="table_header" escapeXml="false" sortable="true" sortName="createdBy.createdBy.displayName" titleKey="feedback.createdby" style="width: 25%">
                    ${tableList.createdBy.displayName} (${tableList.createdBy.username})
                </display:column>


                <display:column sortable="false"  headerClass="table_header" url="/admin/feedback/edit.html"
                                            titleKey="action" style="width: 20%">
                    <a href="${replyUrl}?pojo.feedback.feedbackID=${tableList.feedbackID}"><img src="<c:url value='/themes/admin/images/edit.png'/>"/></a>
                    <a name="deleteLink" id="d_${tableList.feedbackID}_a" href="<c:url value='/admin/feedback/list.html'><c:param name="checkList" value="${tableList.feedbackID}"/><c:param name="crudaction" value="delete"/></c:url>"><img id="d_${tableList.feedbackID}" src="<c:url value='/themes/admin/images/no.png'/>"/></a>

                </display:column>
                <display:setProperty name="paging.banner.item_name"><fmt:message key="feedback"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="feedback"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
                <display:setProperty name="paging.banner.onepage" value=""/>
            </display:table>
            <div class="clear"></div>
        </div>
        <div style="padding: 15px 0 30px 0;">
			<c:if test="${not empty totalDeleted}">
				<div class="msg-response"><fmt:message key="database.items.deleted"><fmt:param value="${totalDeleted}"/></fmt:message></div>
				<br />
			</c:if>
			<c:if test="${not empty messageResponse}">
				<div class="msg-response">${messageResponse }</div>
				<br/>
			</c:if>
            <input type="button" value="<fmt:message key="button.add"/>" onclick="document.location.href='${editUrl}';"/>

			<c:if test="${not empty items.totalItems && items.totalItems > 0}">
                <input type="button" value="<fmt:message key="button.delete"/>" onclick="confirmDeleteItem();"/>
			</c:if>
		</div>

    </form:form>
</div>

<script type="text/javascript">
	<c:if test="${not empty items.crudaction}">
    	highlightTableRows("tableList");
    </c:if>
    $(function() {
    	$("#deleteConfirmLink").click(function() {
        	$('#crudaction').val('delete');
            jConfirm('<fmt:message key="delete.confirm"/>', '<fmt:message key="delete.confirm.title"/>', function(r) {
          		   if(r) {
          			   document.forms['listForm'].submit();
          		   }
          		});
          		return false;
    	});
    	$('a[name="deleteLink"]').click(function(eventObj) {
       		//document.location.href = eventObj.target.href;
       		return true;

        });

        $('a[name="deleteLink"]').click(function(eventObj) {
       		jConfirm('<fmt:message key="delete.confirm.one"/>', '<fmt:message key="delete.confirm.title"/>', function(r) {
       		   if(r) {
                    location.href = $('#' + eventObj.target.id + '_a').attr('href');
       		   }
       		});
   			return false;
           });

    });
    function confirmDeleteItem(){
    	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
		if(fb) {
			$("#deleteConfirmLink").trigger('click');
		}else {
			$("#hidenWarningLink").trigger('click');
		}
    }

    $(document).ready(function() {
        $("#fromDate" ).datepicker({showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat : 'dd/mm/yy'});
        $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });
    });
</script>
