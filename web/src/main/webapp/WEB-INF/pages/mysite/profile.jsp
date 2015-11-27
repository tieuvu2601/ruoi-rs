<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="mysite.profile"/></title>
    <meta name="heading" content="<fmt:message key="mysite.profile"/>"/>
</head>
<c:url var="url" value="/mysite/profile.html"/>
<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title"><fmt:message key="mysite.profile"/></div>
            <div class="sub_page_content">
                <div id="mysite_nav">
                    <jsp:include page="/themes/vms_stretch/include/mysite_navigation.jsp"/>
                </div>
                <div id="mysite_content">
                    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
                        <div class="box_container">
                            <div class="header">
                                <fmt:message key="mysite.profile"/>
                            </div>
                            <div class="form">
                                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                                    <tr>
                                        <td width="150px"><fmt:message key="user.form.username"/></td>
                                        <td>${item.pojo.username }</td>
                                    </tr>
                                    <tr>
	                                    <td><fmt:message key="usergroup"/></td>
				                        <td>${item.pojo.userGroup.name }</td>
			                        </tr>
			                        <tr>
	                                    <td><fmt:message key="department"/></td>
				                        <td>${item.pojo.department.name }</td>
			                        </tr>
                                    <tr>
                                    	<td><fmt:message key="user.email"/></td>
                                        <td>
                                        	<form:input path="pojo.email" size="40"/>
                                        	<form:errors path="pojo.email" cssClass="validateError"/>
                                       	</td>
                                    </tr>
                                    <tr>
                                        <td><fmt:message key="user.firstname"/></td>
                                        <td><form:input path="pojo.firstName" size="40"/></td>
                                        
                                    </tr>
                                    <tr>
                                    	<td><fmt:message key="user.lastname"/></td>
                                        <td><form:input path="pojo.lastName" size="40"/></td>
                                    </tr>
                                    <tr>
                                        <td><fmt:message key="user.displayname"/></td>
                                        <td><form:input path="pojo.displayName" size="40"/></td>
                                        
                                    </tr>
                                    <tr>
                                    	<td><fmt:message key="user.mobile"/></td>
                                        <td><form:input path="pojo.mobileNumber" size="40"/></td>
                                    </tr>
                                    <tr>
                                        <td><fmt:message key="user.form.avatar"/></td>
                                        <td>
                                        	<div id="defaultAvatar" style="display:none;">
	                                        	<c:forEach items="${avatars }" var="avatar">
	                                        		<div class="avatar">
	                                        			<span id="img">
	                                        				<img src="<c:url value="/themes/vms/images/avatar/${avatar}?w=100&h=100" />" />
	                                        			</span>
						                            	<span id="rdo">
						                            		<input class="avatarCls" type="radio" name="avatar" value="${avatar}"/>
						                            	</span>
					                            	</div>
	                                        	</c:forEach>
	                                        	<div class="clear"></div>
	                                        	<div style="float:right;">
	                                        		<a href="javascript:void(0);" id="btOk" class="button_blue">Xong</a>
	                                        	</div>
                                        	</div>
                                        	<input type="file" name="fileItem"/>
                                        	Hoặc <a href="javascript:void(0);" id="selectAvatar">chọn từ thư viện</a>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td></td>
                                    	<td>
                                    		<div class="avatar">
	                                    		<c:choose>
	                                    			<c:when test="${!empty item.pojo.avatar }">
						                            	<rep:href value="${item.pojo.avatar}" var="thumbnailURL"/>
						                            	<c:url var="thumbnailURL" value="${thumbnailURL}"/>
						                            	<c:if test="${fn:indexOf(item.pojo.avatar, '/') lt 0 }">
						                            		<c:url var="thumbnailURL" value="/themes/vms/images/avatar/${item.pojo.avatar}"/>
						                            	</c:if>
						                            	<img id="img" src="${thumbnailURL}?w=100&h=100" />
	                                    			</c:when>
	                                    			<c:otherwise>
	                                    				<img id="img" src="" style="width:100px;height:100px;" />
	                                    			</c:otherwise>
	                                    		</c:choose>
                                    		</div>
			                            </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <br/>
                        <div style="padding: 15px 0 30px 0;">
                            <c:if test="${!empty messageResponse}">
                                <div class="msg-response">${messageResponse }</div>
                                <br/>
                            </c:if>
                            <form:hidden path="avatar" id="avatar"/>
                            <form:hidden path="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.userID" value="${item.pojo.userID }"/>
                            <a href="javascript:void(0);" class="button_blue" onclick="$('#itemForm').submit();"><fmt:message key="button.update"/></a>
                        </div>
						<script type="text/javascript">
							$(function(){
								$("#selectAvatar").click(function(){
									$("#defaultAvatar").dialog({
										title: 'Chọn hình đại diện',
										modal: true,
										width: 665,
										resizable: false
									});	
								});
								$(".avatarCls").change(function(){
									if( $(this).is(":checked") ){
										$("#avatar").val($(this).val());	
									}
								});
								
								$("#btOk").click(function(){
									if(!$("input[name='avatar']:checked").val()){
										jAlert("Chọn một hình đại diện", "Thông báo");
									}else{
										$("#defaultAvatar").dialog("close");
										$("#img").attr("src", '<c:url value="/themes/vms/images/avatar/"/>'+$("#avatar").val()+'?w=100&h=100');
									}
								});
								$("#defaultAvatar").scrollLeft(635);
							})
						</script>
                    </form:form>
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</body>
