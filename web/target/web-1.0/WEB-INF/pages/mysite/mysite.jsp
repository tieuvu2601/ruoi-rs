<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="mysite.document"/></title>
    <meta name="heading" content="<fmt:message key="mysite.document"/>"/>
</head>
<c:url var="url" value="/mysite/home.html"/>
<c:url var="addUrl" value="/mysite/addmysite.html?authoringTemplateID=${authoringTemplateDocumentID}"/>
<c:url var="editUrl" value="/mysite/edit.html"/>



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

<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title"><fmt:message key="mysite.document"/></div>
            <div class="sub_page_content">
                <div id="mysite_nav">
                    <jsp:include page="/themes/vms_stretch/include/mysite_navigation.jsp"/>
                </div>
                <div id="mysite_content">
                    <form:form commandName="items" action="${url}" method="post" id="listForm">
                        <div class="box_container">
                            <div class="header">
                                <fmt:message key="label.filter"/>
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
                                        <td></td>
                                        <td colspan="3">
                                            <form:hidden path="crudaction" id="crudaction" value="search"/>
                                            <a href="#" onclick="$('#listForm').submit();" class="button_blue"><fmt:message key="button.search"/></a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <br/>
                        <div>

                             <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                                 partialList="true" sort="external" excludedParams="crudaction" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false">
                                 <display:column headerClass="table_header" property="title" escapeXml="true" sortable="true" sortName="title" titleKey="content.title" style="width: 30%"/>
                                 <display:column headerClass="table_header" escapeXml="true" titleKey="content.accesspolicy" style="width: 30%">
                                    <c:if test="${tableList.accessPolicy == 1}">
                                        <fmt:message key="content.accesspolicy.allowshare" />
                                    </c:if>
                                    <c:if test="${tableList.accessPolicy == 0}">
                                        <fmt:message key="content.accesspolicy.notallowshare" />
                                    </c:if>
                                 </display:column>
                                 <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                                 <display:column headerClass="table_header" url="/admin/content/edit.html"
                                                             titleKey="action" style="width: 20%">
                                     <div class="toolbar">
                                         <a title="<fmt:message key="content.edit"/>" href="${editUrl}?pojo.contentID=${tableList.contentID}" class="edit">&nbsp;</a>
                                         <a name="deleteLink" id="d_${tableList.contentID}_a" title="<fmt:message key="content.delete"/>"  class="delete" href="<c:url value='/mysite/home.html'><c:param name="checkList" value="${tableList.contentID}"/><c:param name="crudaction" value="delete"/></c:url>">&nbsp;</a>
                                         <%--<a name="deleteLink" id="d_${tableList.contentID}_a" href="<c:url value='/mysite/home.html'><c:param name="checkList" value="${tableList.contentID}"/><c:param name="crudaction" value="delete"/></c:url>"><img id="d_${tableList.contentID}" src="<c:url value='/themes/admin/images/no.png'/>"/></a>--%>
                                     </div>
                                 </display:column>
                                 <display:setProperty name="paging.banner.item_name"><fmt:message key="content"/></display:setProperty>
                                 <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
                                 <display:setProperty name="paging.banner.placement" value="bottom"/>
                                 <display:setProperty name="paging.banner.no_items_found" value=""/>
                                 <display:setProperty name="paging.banner.onepage" value=""/>
                                 <display:setProperty name="paging.banner.group_size" value="5"/>
                                 <display:setProperty name="paging.banner.some_items_found"><span class="pagebanner">Hiển thị {2} đến {3} của {0}.</span> </display:setProperty>
                                 <display:setProperty name="paging.banner.all_items_found"><span class="pagelinks">{0} tài liệu được tìm thấy.</span> </display:setProperty>
                             </display:table>
                            <div class="clear"></div>
                        </div>
                        <div style="padding: 15px 0 30px 0;">
                            <c:if test="${not empty totalDeleted}">
                                <div class="msg-response"><fmt:message key="database.items.deleted"><fmt:param value="${totalDeleted}"/></fmt:message></div>
                                <br />
                            </c:if>
                            <c:if test="${empty totalDeleted && not empty messageResponse}">
                                <div class="msg-response">${messageResponse }</div>
                                <br/>
                            </c:if>
                            <c:if test="${not empty param.messageResponse}">
                                <div class="msg-response">${param.messageResponse }</div>
                                <br/>
                            </c:if>
                            <a href="${addUrl}" class="button_blue"><fmt:message key="button.add"/></a>
                        </div>

                    </form:form>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</body>


