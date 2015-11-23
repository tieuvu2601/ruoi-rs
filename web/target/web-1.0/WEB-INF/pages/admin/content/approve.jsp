<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="comment.management" /></title>
    <meta name="heading" content="<fmt:message key="comment.management" />"/>
</head>
<div class="pathway">
    <fmt:message key="comment.management" /> ${content.title}
</div>

<c:url var="url" value="/admin/content/approve.html?contentID=${content.contentID}"/>
<c:url var="editUrl" value="/admin/comment/edit.html"/>
<c:url var="publishUrl" value="/admin/comment/publish.html"/>
<c:url var="rejectUrl" value="/admin/comment/reject.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="button.search" />
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="fromDate" /></td>
                        <td><input type="text" name="fromDate" id="fromDate" value='<fmt:formatDate value="${items.fromDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
                        <td><fmt:message key="toDate" /></td>
                        <td><input type="text" name="toDate" id="toDate" value='<fmt:formatDate value="${items.toDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
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
                partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false">
                <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                            <input type="checkbox" name="checkList" value="${tableList.commentID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                </display:column>

                <display:column headerClass="table_header" property="commentText" escapeXml="true" sortable="true" sortName="commentText" titleKey="comment.commenttext" style="width: 20%"/>
                <display:column headerClass="table_header" escapeXml="true" sortable="false" sortName="status" titleKey="comment.status" style="width: 10%">
                    <c:if test="${tableList.status == 0}">
                        <fmt:message key="comment.status.reject" />
                    </c:if>
                    <c:if test="${tableList.status == 1}">
                        <fmt:message key="comment.status.public" />
                    </c:if>
                </display:column>
                <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy}"/>
                <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy}"/>


                <display:column sortable="false"  headerClass="table_header" url="/admin/comment/edit.html"
                                            titleKey="label.options" style="width: 20%">
                    <c:if test="${tableList.status == 0}">
                        <a href="${publishUrl}?pojo.commentID=${tableList.commentID}"><img src="<c:url value='/themes/admin/images/ico_approve.png'/>"/></a>
                    </c:if>

                    <c:if test="${tableList.status == 1}">
                        <a href="${rejectUrl}?pojo.commentID=${tableList.commentID}"><img src="<c:url value='/themes/admin/images/ico_reject.png'/>"/></a>
                    </c:if>

                    <a name="deleteLink" id="d_${tableList.commentID}_a" href="<c:url value='/admin/content/approve.html?contentID=${content.contentID}'><c:param name="checkList" value="${tableList.commentID}"/><c:param name="crudaction" value="delete"/></c:url>"><img id="d_${tableList.commentID}" src="<c:url value='/themes/vms/images/no.png'/>"/></a>

                </display:column>
                <display:setProperty name="paging.banner.item_name"><fmt:message key="comment"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
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
            <c:if test="${not empty totalRejected}">
         				<div class="msg-response"><fmt:message key="database.items.rejected"><fmt:param value="${totalRejected}"/></fmt:message></div>
         				<br />
         	</c:if>
            <c:if test="${not empty totalPubliced}">
         				<div class="msg-response"><fmt:message key="database.items.publiced"><fmt:param value="${totalPubliced}"/></fmt:message></div>
         				<br />
         	</c:if>


			<c:if test="${not empty items.totalItems && items.totalItems > 0}">
                <input type="button" value="<fmt:message key="button.delete"/>" onclick="confirmDeleteItem();"/>
			</c:if>
            <c:if test="${not empty items.totalItems && items.totalItems > 0}">
                <input type="button" value="<fmt:message key="button.public"/>" onclick="confirmPublicItem();"/>
            </c:if>
            <c:if test="${not empty items.totalItems && items.totalItems > 0}">
                <input type="button" value="<fmt:message key="button.reject"/>" onclick="confirmRejectItem();"/>
            </c:if>

            <a name="rejectConfirmLink" id="rejectConfirmLink" style="display: none;"></a>
            <a name="publicConfirmLink" id="publicConfirmLink" style="display: none;"></a>

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

        $("#rejectConfirmLink").click(function() {
           	$('#crudaction').val('reject');
       		document.forms['listForm'].submit();
       	});

        $("#publicConfirmLink").click(function() {
           	$('#crudaction').val('public');
       		document.forms['listForm'].submit();
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

    function confirmRejectItem(){
    	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
		if(fb) {
			$("#rejectConfirmLink").trigger('click');
		}else {
			$("#hidenWarningLink").trigger('click');
		}
    }


    function confirmPublicItem(){
    	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
		if(fb) {
			$("#publicConfirmLink").trigger('click');
		}else {
			$("#hidenWarningLink").trigger('click');
		}
    }



    $(document).ready(function() {
        $("#fromDate" ).datepicker({showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>',dateFormat : 'dd/mm/yy'});
        $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });
    });


</script>
