<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="renderingtemplate.template"/></title>
    <meta name="heading" content="<fmt:message key="renderingtemplate.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="renderingtemplate.management"/>
</div>

<c:url var="url" value="/admin/renderingtemplate/list.html"/>
<c:url var="editUrl" value="/admin/renderingtemplate/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="renderingtemplate.template"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="renderingtemplate.code"/></td>
                        <td><form:input path="pojo.code" size="40"/></td>
                        <td><fmt:message key="renderingtemplate.name"/></td>
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
                            <input type="checkbox" name="checkList" value="${tableList.renderingTemplateID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="code" titleKey="renderingtemplate.code" style="width: 15%" >
                    <a href="${editUrl}?pojo.renderingTemplateID=${tableList.renderingTemplateID}">${tableList.code}</a>
                </display:column>
                <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="renderingtemplate.name" style="width: 20%"/>

                <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>
                <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>


                <display:column sortable="false"  headerClass="table_header" url="/admin/renderingtemplate/edit.html"
                                            titleKey="action" style="width: 20%">
                    <a href="${editUrl}?pojo.renderingTemplateID=${tableList.renderingTemplateID}"><img src="<c:url value='/themes/admin/images/edit.png'/>"/></a>
                    <a name="deleteLink"  id="d_${tableList.renderingTemplateID}_a"  href="<c:url value='/admin/renderingtemplate/list.html'><c:param name="checkList" value="${tableList.renderingTemplateID}"/><c:param name="crudaction" value="delete"/></c:url>"><img id="d_${tableList.renderingTemplateID}" src="<c:url value='/themes/admin/images/no.png'/>"/></a>

                </display:column>
                <display:setProperty name="paging.banner.item_name"><fmt:message key="renderingtemplate.template"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="renderingtemplate.template"/></display:setProperty>
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
