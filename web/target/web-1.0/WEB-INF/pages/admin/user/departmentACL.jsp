<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="role.management"/></title>
    <meta name="heading" content="<fmt:message key="role.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="user.access"/>
</div>

<c:url var="backUrl" value="/admin/user/list.html"/>
<c:url var="accessUrl" value="/admin/user/departmentACL.html"/>
<div id="content">
    <form:form commandName="item" action="${accessUrl}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="user.access"/>
            </div>


        <div class="form">
            <table width="100%" cellpadding="5" cellspacing="5" border="0">
                <tr>
                    <td width="15%"><fmt:message key="user.username"/></td>
                    <td>
                        ${currentUser.username}
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="user.displayname"/></td>
                    <td>
                        ${currentUser.displayName}
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <form:hidden path="crudaction" id="crudaction" value="update"/>
                        <form:hidden path="userID"/>
                        <input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
                        <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>

                    </td>
                </tr>
            </table>
        </div>

        <br/>
         <div class="box_container" >

            <display:table name="item.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                 excludedParams="crudaction" partialList="true" sort="external" size="${item.totalItems}" defaultsort="2" uid="tableList" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">

                <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('itemForm', 'checkList', this)\">">

                    <input type="checkbox" name="checkList" value="${tableList.departmentID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')"
                        <c:if test="${not empty item.departmentACLMap[tableList.departmentID]}">
                                checked="true"
                        </c:if>
                    >
                    <input type="hidden" name="departmentIDsInPage" value="${tableList.departmentID}"/>
                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="role" titleKey="department.code" style="width: 10%" >
                    ${tableList.code}
                </display:column>
                <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="department.name" style="width: 10%"/>


                <display:column headerClass="table_header" property="description" escapeXml="true" sortable="true" sortName="description" titleKey="department.description" style="width: 27%"/>

                <display:setProperty name="paging.banner.item_name"><fmt:message key="department"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="department"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
                <display:setProperty name="paging.banner.onepage" value=""/>
                <display:setProperty name="basic.msg.empty_list" value="" />
                <display:setProperty name="basic.msg.empty_list_row" value=""/>


            </display:table>
            <div class="clear"></div>
        </div>

    </form:form>
</div>

<script type="text/javascript">
	<c:if test="${not empty items.crudaction}">
    	highlightTableRows("tableList");
    </c:if>


</script>
