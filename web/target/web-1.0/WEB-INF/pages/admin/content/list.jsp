<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
    <script type="text/javascript" src="<c:url value='/scripts/jquery/sexyalertbox.v1.2_vms.jquery.js' />"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/themes/admin/sexyalertbox.css'/>" media="screen" />

</head>
<div class="pathway">
    <fmt:message key="content.management"/>
</div>

<c:url var="url" value="/admin/content/list.html"/>
<c:url var="addUrl" value="/admin/content/add.html"/>
<c:url var="editUrl" value="/admin/content/edit.html"/>
<c:url var="approveUrl" value="/admin/content/approve.html"/>
<c:url var="trackingUrl" value="/admin/content/tracking.html"/>
<c:url var="approveFlowUrl" value="/admin/content/approveflow.html"/>
<fmt:message key="content.approve" var="approveLabel"/>
<security:authorize ifAllGranted="AUTHOR">
	<c:url var="approveFlowUrl" value="/admin/content/submit.html"/>
	<fmt:message key="button.send" var="approveLabel"/>
</security:authorize>
                            
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="content"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="content.title"/></td>
                        <td><form:input path="pojo.title" size="40"/></td>
                        <td><fmt:message key="content.keyword"/></td>
                        <td><form:input path="pojo.keyword" size="40"/></td>
                    </tr>
                    <tr>
                        <td><fmt:message key="authoringtemplate.template"/></td>
                        <td>
                            <select name="pojo.authoringTemplate" id="authoringTemplateId">
                                <option value=""><fmt:message key="label.all"/></option>
                                <c:forEach items="${authoringTemplates}" var="authoringTemplate">
                                    <option value="${authoringTemplate.authoringTemplateID}" <c:if test="${authoringTemplate.authoringTemplateID == items.pojo.authoringTemplate.authoringTemplateID}">selected</c:if>>${authoringTemplate.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <fmt:message key="category"/>
                        </td>
                        <td>
                            <select name="categoryID" id="contentCategoryID">
                                <option value=""><fmt:message key="label.all"/></option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryID}" <c:if test="${category.categoryID == items.categoryID}">selected</c:if>>${category.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                    	<td><fmt:message key="label.status"/></td>
                    	<td>
                    		<input type="radio" name="pojo.status" value="0" <c:if test="${items.pojo.status eq 0}">checked="checked"</c:if>/><fmt:message key="content.waiting"/>
                    		<input type="radio" name="pojo.status" value="1" <c:if test="${items.pojo.status eq 1 }">checked="checked"</c:if>/><fmt:message key="content.published"/>
                   			<input type="radio" name="pojo.status" value="-1" <c:if test="${items.pojo.status eq -1}">checked="checked"</c:if>/><fmt:message key="content.reject.option"/>
                    		<input type="radio" name="pojo.status" value="" <c:if test="${empty items.pojo.status }">checked="checked"</c:if>/><fmt:message key="label.all"/>
                    	</td>
                    	<td></td>
                    	<td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <form:hidden path="crudaction" id="crudaction"/>
                            <input type="button" value="<fmt:message key="button.search"/>" onclick="submitForm('search');"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <br/>
         <div class="box_container">
			
             <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                 partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false">
                 
                 <c:set var="disabled" value="false"/>
                 <c:if test="${empty items.contentPublishedMap[tableList.contentID] or !items.contentPublishedMap[tableList.contentID]}">
                 	<c:set var="disabled" value="true"/>
                 </c:if>
                 
                 <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                    <input type="checkbox" <c:if test="${!empty disabled and disabled}">disabled="disabled"</c:if> id="chk${tableList.contentID }" name="checkList" value="${tableList.contentID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                 </display:column>

                 <display:column headerClass="table_header" sortable="true" sortName="title" titleKey="content.title" style="width: 20%">
                 	<c:url value="/admin/content/view.html" var="viewUrl">
                 		<c:param name="pojo.contentID" value="${tableList.contentID }"></c:param>
                 	</c:url>
                 	<a href="${viewUrl}" >${tableList.title}</a>
                 </display:column>
                 <display:column headerClass="table_header" titleKey="content.thumbnail" style="width: 10%">
                     <c:if test="${not empty tableList.thumbnail}">
                     	<rep:href value="${tableList.thumbnail}" var="imgURL"/>
                     	<c:choose>
                     		<c:when test="${(tableList.createdBy.userID eq currentUserID) or (items.contentPublishedMap[tableList.contentID] eq true)}">
                     			<img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px;max-height: 100px;" onclick="showImageLarger(${tableList.contentID})"/>
                     		</c:when>
                     		<c:otherwise>
                     			<img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px;max-height: 100px;" />
                     		</c:otherwise>
                     	</c:choose>
                     </c:if>
                 </display:column>
                 <display:column headerClass="table_header" titleKey="content.status" style="width: 10%">
                    <c:choose>
                        <c:when test="${tableList.status == Constants.CONTENT_PUBLISH}">
                            <fmt:message key="content.published"/>
                        </c:when>
                        <c:when test="${tableList.status == Constants.CONTENT_REJECT}">
                        	<fmt:message key="content.reject.option"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="content.waiting"/>
                        </c:otherwise>
                    </c:choose>
                 </display:column>
                 <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>
                 <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>


                 <display:column sortable="false"  headerClass="table_header" url="/admin/content/edit.html"
                                             titleKey="action" style="width: 20%">
                     <div class="toolbar">
                         <c:if test="${tableList.status == Constants.CONTENT_PUBLISH}">
	                         <a title="<fmt:message key="content.tracking"/>" href="${trackingUrl}?contentID=${tableList.contentID}" class="statistic">&nbsp;</a>
	                         <a title="<fmt:message key="content.approve"/>" href="${approveUrl}?contentID=${tableList.contentID}" class="comment">&nbsp;</a>
                         </c:if>
                         <c:if test="${items.contentPublishedMap[tableList.contentID] eq true}">
                         	<security:authorize ifNotGranted="AUTHOR,PUBLISHER">
                            	<a title="${approveLabel}" href="javascript:void(0);" onclick="approve('${tableList.contentID}', 'accept');" class="publish">&nbsp;</a>
                            </security:authorize>
                            
                            <security:authorize ifAllGranted="PUBLISHER">
                            	<c:if test="${tableList.createdBy.userID eq currentUserID}">
                            		<a title="${approveLabel}" href="javascript:void(0);" onclick="approve('${tableList.contentID}', 'accept');" class="publish">&nbsp;</a>
                            	</c:if>
                            </security:authorize>
                            
                            <security:authorize ifAllGranted="AUTHOR">
                            	<a title="${approveLabel}" href="javascript:void(0);" onclick="approve('${tableList.contentID}', 'approve');" class="publish">&nbsp;</a>
                            </security:authorize>
                            
                           	<c:if test="${tableList.createdBy.userID != currentUserID}">
                       			<a title="<fmt:message key="content.reject"/>" href="javascript:void(0);" onclick="approve('${tableList.contentID}', 'reject');" class="reject">&nbsp;</a>
                       			<a title="<fmt:message key="content.edit"/>" href="${editUrl}?pojo.contentID=${tableList.contentID}&approve=yes" class="edit">&nbsp;</a>
                                <security:authorize ifAllGranted="FULL_ACCESS_RIGHT">
                                    <a title="<fmt:message key="content.delete"/>" name="deleteLink" id="${tableList.contentID}_a" class="delete" href="<c:url value='/admin/content/list.html'><c:param name="checkList" value="${tableList.contentID}"/><c:param name="crudaction" value="delete"/></c:url>">&nbsp;</a>
                                </security:authorize>
                       		</c:if>
                         </c:if>
                         <c:if test="${(empty items.contentPublishedMap[tableList.contentID] or !items.contentPublishedMap[tableList.contentID]) and tableList.createdBy.userID != currentUserID}">
                         	<security:authorize ifAnyGranted="PUBLISHER,APPROVER">
                         		<a title="<fmt:message key="content.edit"/>" href="${editUrl}?pojo.contentID=${tableList.contentID}<c:if test="${items.contentPublishedMap[tableList.contentID] eq true}">&approve=yes</c:if>" class="edit">&nbsp;</a>
                         	</security:authorize>
                             <security:authorize ifAllGranted="FULL_ACCESS_RIGHT">
                                 <a title="<fmt:message key="content.delete"/>" name="deleteLink" id="${tableList.contentID}_a" class="delete" href="<c:url value='/admin/content/list.html'><c:param name="checkList" value="${tableList.contentID}"/><c:param name="crudaction" value="delete"/></c:url>">&nbsp;</a>
                             </security:authorize>
                         </c:if>
                         
                       	<c:if test="${tableList.createdBy.userID eq currentUserID}">
                       		<a title="<fmt:message key="content.edit"/>" href="${editUrl}?pojo.contentID=${tableList.contentID}<c:if test="${items.contentPublishedMap[tableList.contentID] eq true}">&approve=yes</c:if>" class="edit">&nbsp;</a>
                       		<a title="<fmt:message key="content.delete"/>" name="deleteLink" id="${tableList.contentID}_a" class="delete" href="<c:url value='/admin/content/list.html'><c:param name="checkList" value="${tableList.contentID}"/><c:param name="crudaction" value="delete"/></c:url>">&nbsp;</a>
                       	</c:if>
                         
                     </div>
                 </display:column>
                 <display:setProperty name="paging.banner.item_name"><fmt:message key="content"/></display:setProperty>
                 <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
                 <display:setProperty name="paging.banner.placement" value="bottom"/>
                 <display:setProperty name="paging.banner.no_items_found" value=""/>
                 <display:setProperty name="paging.banner.onepage" value=""/>
             </display:table>
            <div class="clear"></div>
        </div>
        <div style="padding: 15px 0 30px 0;">
			<c:if test="${not empty messageResponse}">
				<div class="msg-response"><c:if test="${!empty InProcess}">${InProcess} </c:if>${messageResponse }</div>
				<br/>
			</c:if>
			<c:if test="${not empty param.messageResponse}">
				<div class="msg-response">${param.messageResponse }</div>
				<br/>
			</c:if>
			<c:if test="${!empty NotInProcess }">
				<div class="msg-response">${NotInProcess}</div>
				<br/>
			</c:if>
            <security:authorize ifNotGranted="GUEST">
                <input type="button" value="<fmt:message key="button.add"/>" onclick="document.location.href='${addUrl}';"/>
                <input type="button" value="${approveLabel}" id="btApprove"/>
            </security:authorize>

            <security:authorize ifNotGranted="AUTHOR,GUEST">
            	<input type="button" value="<fmt:message key="content.reject"/>" id="btReject"/>
			</security:authorize>
			<%-- <c:if test="${not empty items.totalItems && items.totalItems > 0}">
                <input type="button" value="<fmt:message key="button.delete"/>" onclick="confirmDeleteItem();"/>
			</c:if> --%>
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
       		jConfirm('<fmt:message key="delete.confirm.one"/>', '<fmt:message key="delete.confirm.title"/>', function(r) {
       		   if(r) {
       			   location.href = $('#' + eventObj.target.id).attr('href');
       		   }
       		});
   			return false;
           });
        
        $("#authoringTemplateId").change(function(){
        	var value = $(this).val();
        	var categoryOptions = document.getElementById('contentCategoryID').options;
        	categoryOptions.length = 1;
        	if(value != null && value != ''){
        		jQuery.ajax({
        			url : '<c:url value="/ajax/loadCategoryByAuthoringTemplate.html"/>?au=' + value + '&dt=' + new Date().getTime(),
        			dataType: 'json',
        			success: function(data){
        				if (data.array != null) {
			    			for (var i = 0; i < data.array.length; i++) {
			    				var item = data.array[i];
			    				categoryOptions[i + 1] = new Option(item[1], item[0]);
			    			}	    				
		    			}
        			}
        		});
        	}
        });
        
        $("#btReject").click(function(){
        	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
    		if(fb) {
    			submitForm("reject");
    		}else{
    			$("#hidenWarningLink").trigger('click');
    		}
        });
        
        $("#btApprove").click(function(){
        	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
    		if(fb) {
    			submitForm("approve");
    		}else{
    			$("#hidenWarningLink").trigger('click');
    		}
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
    function submitForm(crudaction){
    	$('#crudaction').val(crudaction);
    	$('#listForm').submit();
    }
    function approve(contentID, decision){
    	var list = document.getElementById('listForm').elements['checkList'];
    	var listSize = list.length;
    	for(i = 0; i < listSize; i++) {
            if (!list[i].disabled) {
                list[i].checked = false;
            }
        }
    	$("#chk"+contentID).attr('checked','checked');
    	$('#crudaction').val(decision);
    	$('#listForm').submit();
    }
    var nc = 0;
    function showImageLarger(contentID) {
        nc ++;
        var surl = '<c:url value="/ajax/crop.html"/>?contentID=' + contentID;
        $.ajax({
            type: 'GET',
            cache: false,
            url: surl,
            timeout: 30000,
            error: function(xhr, ajaxOptions, thrownError){ },
            success: function(data){
                Sexy.vdata(data);
            }
        });
    }
</script>
