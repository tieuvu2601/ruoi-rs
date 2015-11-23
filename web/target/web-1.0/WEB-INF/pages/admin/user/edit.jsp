<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="user.management"/></title>
    <meta name="heading" content="User Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.userID}">
           <fmt:message key="user.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="user.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/user/edit.html"/>
<c:url var="backUrl" value="/admin/user/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
        <div class="box_container">
            <div class="header">
                <fmt:message key="user.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td>LAN ID</td>
                        <td>
                            <form:input id="username" path="pojo.username" size="40"/>
                            <input id="searchLanId" type="button" value="<fmt:message key="button.search"/>" style="padding-top:1px;padding-bottom:1px;"/>
                            <form:errors path="pojo.username" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="user.password"/></td>
                        <td>
                            <form:password id="password" path="pojo.password" size="40"/>
                            <form:errors path="pojo.password" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.email"/></td>
                        <td>
                            <form:input id="email" path="pojo.email" size="40"/>
                            <form:errors path="pojo.email" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.firstname"/></td>
                        <td>
                            <form:input id="firstName" path="pojo.firstName" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.lastname"/></td>
                        <td>
                            <form:input id="lastName" path="pojo.lastName" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.displayname"/></td>
                        <td>
                            <form:input id="displayName" path="pojo.displayName" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.mobile"/></td>
                        <td>
                            <form:input path="pojo.mobileNumber" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="user.status"/></td>
                        <td>
                            <form:radiobutton path="pojo.status" value="1"/><fmt:message key="user.status.active"/>
                            <form:radiobutton path="pojo.status" value="0"/><fmt:message key="user.stauts.disable"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:checkbox path="pojo.fullAccess" value="1"/><fmt:message key="user.fullaccess"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="usergroup"/></td>
                        <td>
                            <select name="pojo.userGroup.userGroupID">
                                <c:forEach items="${userGroups}" var="usg">
                                    <option value="${usg.userGroupID}" <c:if test="${not empty item.pojo.userGroup && item.pojo.userGroup.userGroupID == usg.userGroupID}">selected</c:if>>${usg.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="department"/></td>
                        <td>
                            <select name="pojo.department.departmentID">
                                <c:forEach items="${departments}" var="dpt">
                                    <option value="${dpt.departmentID}" <c:if test="${not empty item.pojo.department && item.pojo.department.departmentID == dpt.departmentID}">selected</c:if>>${dpt.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
					<tr>
						<td><fmt:message key="user.form.avatar"/></td>
                        <td>
                            <input type="file" name="fileItem"/>
                            <c:if test="${!empty item.pojo.avatar }">
                            	<rep:href value="${item.pojo.avatar}" var="thumbnailURL"/>
                            	<img src="<c:url value="${thumbnailURL}?w=120&h=100" />" />
                            </c:if>
                        </td>
					</tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.userID"/>
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
                            <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>
                        </td>
                    </tr>
                </table>
            </div>
            <c:if test="${not empty messageResponse}">
                <div style="text-align: left; color: red;">
                    <label>${messageResponse}</label>
                </div>
            </c:if>
        </div>
    </form:form>
    
	<script type="text/javascript">
	$(document).ready(function(){
		$("#searchLanId").click(function(){
			var userName = $('#username').val();
			if(userName != null && userName != ""){
				$.ajax({
		    		url: '<c:url value="/ajax/searchLanId.html"/>?lanid=' + userName + '&dc='+ (new Date().getTime()), 
		    		dataType: 'json',
	    			beforeSend: function(){
		    		},
				   	complete: function(){
				   	},
		    	   	success: function(data) {
			    		var success = data.success;
			    		if (success != null && success == true) {
			    			$('#displayName').val(data.displayName);
			    			$('#email').val(data.email);
			    			$('#password').val(data.password);
			    			$('#firstName').val(data.firstName);
			    			$('#lastName').val(data.lastName);
			    		}else {
			    			jAlert('<fmt:message key="user.lanid.notfound"/>', 'Warning');
			    		}
		    		}
		      	});	
			}else{
				jAlert('<fmt:message key="user.lanid.error.empty"/>', 'Warning');
			}
		});	
	});
	</script>    
</div>