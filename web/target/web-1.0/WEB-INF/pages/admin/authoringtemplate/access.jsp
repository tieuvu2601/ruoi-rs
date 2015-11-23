<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="authoringtemplate.template"/></title>
    <meta name="heading" content="<fmt:message key="authoringtemplate.management"/>"/>
</head>
<script type="text/javascript" language="javascript" src="<c:url value="/scripts/authoringtemplate.js"/>"></script>
<div class="pathway">
	<fmt:message key="authoringtemplate.access"/>
</div>
<c:url var="url" value="/admin/authoringtemplate/access.html"/>
<c:url var="backUrl" value="/admin/authoringtemplate/list.html"/>
<c:if test="${not empty messageResponse}">
    <div style="text-align: left; color: red;">
        <label>${messageResponse}</label>
    </div>
</c:if>
<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" name="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="authoringtemplate.template"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="authoringtemplate.code"/></td>
                        <td>${item.pojo.code}</td>
                    </tr>
                    <tr>
                        <td><fmt:message key="authoringtemplate.name"/></td>
                        <td>${item.pojo.name}</td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="margin: 10px 0;">
        	<input id="displayAll" name="displayAll" type="checkbox" <c:if test="${!empty displayAll and displayAll eq 'Y'}">checked="checked"</c:if> ><fmt:message key="label.display.all"/>
        </div>
        
        <div id="usergroup_user">
	        <div class="box_container" style="margin: 10px 0;">
	            <div class="header">
	                <fmt:message key="usergroup"/>
	            </div>
	            <display:table name="userGroups" uid="userGroup" cellspacing="0" cellpadding="0" class="table bright_blue_body" export="false">
	            	<display:column headerClass="table_header" sortable="false" style="width: 3%" title="#" >
	                	<input class="userGroupCheckbox" id="${userGroup.userGroupID}chkBox" type="checkbox" name="checkGroupList" value="${userGroup.userGroupID}" <c:if test="${!empty mapCheckedGroup[userGroup.userGroupID]}">checked="checked"</c:if> >
	                </display:column>
	                <display:column style="width: 48%" headerClass="table_header" property="code" titleKey="usergroup.code"></display:column>
	            	<display:column headerClass="table_header" property="name" titleKey="usergroup.name"></display:column>
	            </display:table>
	        </div>
	        <div id="user_area" class="box_container" style="margin: 10px 0;">
	            <div class="header">
	                <fmt:message key="user"/>
	            </div>
	            <display:table name="users" uid="user" cellspacing="0" cellpadding="0" class="table bright_blue_body" export="false">
	            	<display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheckUser\" id=\"allCheckUser\" onclick=\"checkAll('itemForm', 'checkUserList', this)\">">
	                	<input type="checkbox" name="checkUserList" value="${user.userID}"
	                	<c:if test="${mapCheckedUser[user.userID] eq 'disabled'}">checked="checked" disabled="disabled"</c:if> 
	                	<c:if test="${mapCheckedUser[user.userID] eq 'edit'}">checked="checked"</c:if> >
	                </display:column>
	            	<display:column  style="width: 48%" headerClass="table_header" property="username" titleKey="user.username"></display:column>
	            	<display:column headerClass="table_header" property="displayName" titleKey="user.displayname"></display:column>
	            </display:table>
	        </div>
        </div>
        
        <div style="padding: 15px 0 30px 0;">
        	<input type="hidden" name="pojo.authoringTemplateID" value="${item.pojo.authoringTemplateID }"/>
        	<form:hidden path="crudaction" id="crudaction" value="insert-update"/>
        	<input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
			<input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>
        </div>
    </form:form>
</div>
<script type="text/javascript">
$(function() {
	$("#displayAll").click(function(){
		var isCheck = $(this).is(':checked');//$(this).attr('checked'); 
		if(isCheck || isCheck == 1){
			$("#usergroup_user").fadeTo('slow',.3);
			$('#usergroup_user :input').attr('disabled', true);
		}else{
			$("#usergroup_user").fadeTo('slow',1);
			$('#usergroup_user :input').removeAttr('disabled');
		}
	})
	
	$(".userGroupCheckbox").click(function(){
		var checkBoxGroups = $("input[name='checkGroupList']");
		var checkBoxUsers = $("input[name='checkUserList']");
		var params = "?";
		 $.each(checkBoxGroups, function(){
			 if($(this).is(':checked')){
				 params += "id="+$(this).val() + "&";	 
			 }
		});
		 $.each(checkBoxUsers, function(){
			 if($(this).is(':checked') && !$(this).attr('disabled')){
				 params += "uid="+$(this).val() + "&";	 
			 } 
		 });
		params += "dt=" + (new Date().getTime());
		 
		if(params.length > 1){
			$.ajax({
				url: '<c:url value="/ajax/filterUserByGroup.html"/>' + params,
				success: function(data) {
					$("#user_area").html(data);	
				}
			});
		}
	});
	
	<c:if test="${!empty displayAll and displayAll eq 'Y'}">
		$("#usergroup_user").fadeTo('slow',.3);
		$('#usergroup_user :input').attr('disabled', true);
	</c:if>
});

</script>