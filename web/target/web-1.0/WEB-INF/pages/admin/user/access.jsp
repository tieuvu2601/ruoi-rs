<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="role.management"/></title>
    <meta name="heading" content="<fmt:message key="role.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="user.access"/>
</div>

<c:url var="backUrl" value="/admin/user/list.html"/>
<c:url var="accessUrl" value="/admin/user/access.html"/>
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
                        ${item.pojo.username}
                    </td>
                </tr>
                <tr>
                    <td><fmt:message key="user.displayname"/></td>
                    <td>
                        ${item.pojo.displayName}
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <form:hidden path="crudaction" id="crudaction" value="access"/>
                        <form:hidden path="pojo.userID"/>
                        <form:hidden path="roleBean.firstItem"/>
                        <input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
                        <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>

                    </td>
                </tr>
            </table>
        </div>

        <br/>
         <div class="box_container" >

            <display:table name="item.roleBean.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                 excludedParams="crudaction" partialList="true" sort="external" size="${item.roleBean.totalItems}" defaultsort="2" uid="tableList" pagesize="${item.roleBean.maxPageItems}" class="table bright_blue_body" export="false">

                <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('itemForm', 'roleBean.checkList', this)\">">

                    <input type="checkbox" name="roleBean.checkList" value="${tableList.roleID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')"
                        <c:if test="${item.roleMap[tableList.roleID] eq true}">
                                checked="true"
                        </c:if>
                    >

                </display:column>
                <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="role" titleKey="role.role" style="width: 10%" >
                    ${tableList.role}
                </display:column>
                <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="role.name" style="width: 10%"/>


                <display:column headerClass="table_header" property="description" escapeXml="true" sortable="true" sortName="description" titleKey="role.description" style="width: 27%"/>
                <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 15%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>
                <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 15%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                <display:setProperty name="paging.banner.item_name"><fmt:message key="role"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="role"/></display:setProperty>
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
    $(function() {
    	$("#deleteConfirmLink").click(function() {
        	$('#crudaction').val('delete');
    		document.forms['listForm'].submit();
    	});
    	$('a[name="deleteLink"]').click(function(eventObj) {
       		//document.location.href = eventObj.target.href;
       		return true;

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
