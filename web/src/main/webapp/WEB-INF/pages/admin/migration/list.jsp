<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="migration.management"/></title>
    <meta name="heading" contentEntity="<fmt:message key="migration.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="migration.management"/>
</div>

<c:url var="url" value="/admin/migration/list.html"/>
<c:url var="backURL" value="/admin/migration/migrate.html"/>
<div id="contentEntity">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="migration.management"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="migration.authoringtemplate"/></td>
                        <td>
                            <form:hidden path="authoringTemplateID"/>
                            ${authoringTemplateEntity.name}
                        </td>


                        <td valign="top"><fmt:message key="migration.categoryEntity"/></td>
                        <td>
                            <select name="categoryID" id="contentCategoryID">
                                <option value="">---Chọn danh mục tin---</option>
                                <c:forEach items="${categories}" var="categoryEntity">
                                    <option value="${categoryEntity.categoryID}" <c:if test="${items.categoryID == categoryEntity.categoryID}">selected</c:if>>${categoryEntity.name}</option>
                                </c:forEach>
                            </select>
                            <form:errors path="categoryID" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="migration.department"/></td>
                        <td colspan="3">
                            <select name="departmentID">
                                <option value="">---Chọn phòng ban---</option>
                                <c:forEach items="${departments}" var="department">
                                    <option value="${department.departmentID}" <c:if test="${items.departmentID == department.departmentID}">selected</c:if>>${department.name}</option>
                                </c:forEach>
                            </select>
                            <form:errors path="categoryID" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <form:hidden path="geturl" />
                            <form:hidden path="crudaction" id="crudaction" value="import"/>
                            <input type="button" value="<fmt:message key="button.import"/>" onclick="$('#listForm').submit();"/>
                            <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backURL}';"/>
                        </td>
                    </tr>
                </table>
            </div>

        </div>

        <br/>
         <div class="box_container" >

            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false" excludedParams="crudaction">

                <c:choose>
                    <c:when test="${items.geturl == 'true'}">
                        <display:column headerClass="table_header" escapeXml="false" sortable="false" sortName="name" title="Liên kết">
                            <c:if test="${not empty tableList.detailURL}"><a href="${tableList.detailURL}">${tableList.detailURL}</a></c:if>
                        </display:column>
                    </c:when>
                    <c:otherwise>
                        <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="title" titleKey="contentEntity.title" style="width: 40%" >
                            ${tableList.title}
                        </display:column>
                        <display:column headerClass="table_header" escapeXml="false" sortable="false" sortName="name" title="Liên kết" style="width: 40%">
                            <c:if test="${not empty tableList.detailURL}"><a href="http://10.151.70.91${tableList.detailURL}">${tableList.detailURL}</a></c:if>
                        </display:column>
                        <display:column headerClass="table_header"  escapeXml="false" sortable="false" sortName="title" title="Tóm tắt" style="width: 40%" >
                            ${tableList.brief}
                        </display:column>
                        <display:column headerClass="table_header" escapeXml="false" sortable="false" sortName="name" title="Đính kèm" style="width: 40%">
                            <c:if test="${not empty tableList.attachmentURLs}">
                                <c:forEach items="${tableList.attachmentURLs}" var="attachURL">
                                    <a href="http://10.151.70.91${attachURL}">${attachURL}</a><br/>
                                </c:forEach>
                            </c:if>

                        </display:column>
                    </c:otherwise>
                </c:choose>



                <display:setProperty name="paging.banner.item_name"><fmt:message key="contentEntity"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="contentEntity"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
                <display:setProperty name="paging.banner.onepage" value=""/>
            </display:table>
            <div class="clear"></div>
        </div>


    </form:form>
</div>

<script type="text/javascript">
	<c:if test="${not empty items.crudaction}">
    	highlightTableRows("tableList");
    </c:if>
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
</script>
