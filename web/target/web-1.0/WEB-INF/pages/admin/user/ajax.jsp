<%@ include file="/common/taglibs.jsp"%>

<div class="header">
    <fmt:message key="user"/>
</div>
<display:table name="users" uid="user" cellspacing="0" cellpadding="0" class="table bright_blue_body" export="false">
	<display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheckUser\" id=\"allCheckUser\" onclick=\"checkAll('itemForm', 'checkUserList', this)\">">
    	<input type="checkbox" name="checkUserList" value="${user.userID}" 
    		<c:if test="${mapCheckedUser[user.userGroup.userGroupID] eq 'disabled'}">checked="checked" disabled="disabled"</c:if>
           	<c:if test="${mapCheckedUser[user.userID] eq 'edit'}">checked="checked"</c:if> 
    		>
    </display:column>
	<display:column style="width: 48%" headerClass="table_header" property="username" titleKey="user.username"></display:column>
	<display:column headerClass="table_header" property="displayName" titleKey="user.displayname"></display:column>
</display:table>