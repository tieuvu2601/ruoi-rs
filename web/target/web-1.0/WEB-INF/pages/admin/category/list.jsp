<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="category.management"/></title>
    <meta name="heading" content="<fmt:message key="category.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="category.management"/>
</div>

<c:url var="url" value="/admin/category/list.html"/>
<c:url var="editUrl" value="/admin/category/edit.html"/>
<c:url var="accessUrl" value="/admin/category/access.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="category"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="category.code"/></td>
                        <td><form:input path="pojo.code" size="40"/></td>
                        <td><fmt:message key="category.name"/></td>
                        <td><form:input path="pojo.name" size="40"/></td>
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
                            <input type="checkbox" name="checkList" value="${tableList.categoryID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="code" titleKey="category.code" style="width: 15%" >
                    <a href="${editUrl}?pojo.categoryID=${tableList.categoryID}">${tableList.code}</a>
                </display:column>

                <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="category.name" style="width: 25%"/>
                <display:column headerClass="table_header" property="displayOrder" escapeXml="true" sortable="true" sortName="displayOrder" titleKey="category.displayorder" style="width: 10%"/>
                <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>
                <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>


                <display:column sortable="false"  headerClass="table_header" url="/admin/category/edit.html"
                                            titleKey="action" style="width: 20%">
				    <a href="${accessUrl}?pojo.categoryID=${tableList.categoryID}"><img src="<c:url value='/themes/admin/images/iconAccessRole.png'/>"/></a>
                    <a href="${editUrl}?pojo.categoryID=${tableList.categoryID}"><img src="<c:url value='/themes/admin/images/edit.png'/>"/></a>
                    <a name="deleteLink" id="d_${tableList.categoryID}_a" href="<c:url value='/admin/category/list.html'><c:param name="checkList" value="${tableList.categoryID}"/><c:param name="crudaction" value="delete"/></c:url>"><img id="d_${tableList.categoryID}" src="<c:url value='/themes/admin/images/no.png'/>"/></a>

                </display:column>
                <display:setProperty name="paging.banner.item_name"><fmt:message key="category"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="category"/></display:setProperty>
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
</script>
