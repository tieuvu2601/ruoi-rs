<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="migration.management"/></title>
    <meta name="heading" content="<fmt:message key="migration.management"/>"/>
</head>
<div class="pathway">

   <fmt:message key="migration.management"/>

</div>
<c:url var="url" value="/admin/migration/migrate.html"/>
<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="migration.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="migration.crawlerurl"/></td>
                        <td>
                            <form:input path="crawlerUrl" size="40"/>
                            <form:errors path="crawlerUrl" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="migration.authoringtemplate"/></td>
                        <td>
                            <form:select path="authoringTemplateID" id="authoringTemplateId" items="${authoringTemplates}" itemLabel="name" itemValue="authoringTemplateID"/>
                            <form:errors path="authoringTemplateID" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="migration.category"/></td>
                        <td>
                            <select name="categoryID" id="contentCategoryID">
                                <option value="">---Chọn danh mục tin---</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryID}" <c:if test="${item.categoryID == category.categoryID}">selected</c:if>>${category.name}</option>
                                </c:forEach>
                            </select>
                            <form:errors path="categoryID" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="migration.department"/></td>
                        <td>
                            <select name="departmentID">
                                <option value="">---Chọn phòng ban---</option>
                                <c:forEach items="${departments}" var="department">
                                    <option value="${department.departmentID}" <c:if test="${item.departmentID == department.departmentID}">selected</c:if>>${department.name}</option>
                                </c:forEach>
                            </select>
                            <form:errors path="categoryID" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="migration.maxcrawlitem"/></td>
                        <td>
                            <form:input path="maxCrawlItem"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="migrate"/>
                            <input type="button" value="<fmt:message key="button.crawler"/>" onclick="$('#itemForm').submit();"/>
                            <input type="button" value="Lấy danh mục" onclick="$('#crudaction').val('geturl');$('#itemForm').submit();"/>
                        </td>
                    </tr>
                </table>
            </div>
            <c:if test="${not empty messageResponse}">
                <div style="text-align: left; color: red;">
                    <label>${messageResponse}</label>
                </div>
            </c:if>
            <c:if test="${not empty param.messageResponse}">
                <div style="text-align: left; color: blue;">
                    <label>${param.messageResponse}</label>
                </div>
            </c:if>
        </div>

    </form:form>
</div>

<script language="javascript" type="text/javascript">
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