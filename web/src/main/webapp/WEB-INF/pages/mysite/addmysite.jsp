<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="mysite.document"/></title>
    <meta name="heading" content="<fmt:message key="mysite.document"/>"/>
</head>

<c:url var="url" value="/mysite/addmysite.html"/>
<c:url var="backUrl" value="/mysite/home.html"/>
<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title"><fmt:message key="mysite.document"/></div>
            <div class="sub_page_content">
                <div id="mysite_nav">
                    <jsp:include page="/themes/vms_stretch/include/mysite_navigation.jsp"/>
                </div>
                <div id="mysite_content">
                    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
                        <div class="box_container">
                            <div class="header">
                                <fmt:message key="mysite.document"/>
                            </div>

                            <div class="form">
                                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">

                                    <tr class="odd">
                                        <td width="15%"><fmt:message key="content.title"/></td>
                                        <td>
                                            <form:input path="pojo.title" size="40" cssStyle="width: 98%;"/>
                                            <form:errors path="pojo.title" cssClass="validateError"/>
                                        </td>
                                    </tr>
                                    <tr class="even">
                                        <td valign="top"><fmt:message key="content.keyword"/></td>
                                        <td>
                                            <form:textarea path="pojo.keyword" rows="3" cssStyle="width:98%"/>
                                            <form:errors path="pojo.keyword" cssClass="validateError"/>
                                        </td>
                                    </tr>

                                    <tr class="odd">
                                        <td><fmt:message key="content.accesspolicy"/></td>
                                        <td>
                                            <form:radiobutton path="pojo.accessPolicy" value="1"/><fmt:message key="content.accesspolicy.everyone"/>
                                            <form:radiobutton path="pojo.accessPolicy" value="2"/><fmt:message key="content.accesspolicy.private"/>
                                        </td>
                                    </tr>
                                    <tr class="even">
                                        <td colspan="2"><fmt:message key="content.authoringcontent"/></td>
                                    </tr>
                                    <tr class="odd">
                                        <td colspan="2">
                                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table_no_border">
                                                <c:forEach items="${authoringTemplateNodes}" var="node">
                                                    <c:set var="minOccurs" value="${node.minOccurs}"/>
                                                    <c:set var="maxOccurs" value="${node.maxOccurs}"/>
                                                    <c:if test="${empty maxOccurs}">
                                                        <c:set var="maxOccurs" value="5"/>
                                                    </c:if>
                                                    <tr>
                                                        <td>${node.displayName} <c:if test="${minOccurs > 0}"><span class="required">*</span></c:if></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <c:forEach begin="1" end="${maxOccurs}" step="1">
                                                                <c:choose>
                                                                    <c:when test="${node.type == 'BOOLEAN'}">
                                                                        <input type="radio" name="${node.name}" value="1"/> <fmt:message key="boolean.true"/>
                                                                        <input type="radio" name="${node.name}" value="0"/> <fmt:message key="boolean.false"/>
                                                                    </c:when>
                                                                    <c:when test="${node.type == 'NUMERIC'}">
                                                                        <input type="text" name="${node.name}"/>
                                                                    </c:when>
                                                                    <c:when test="${node.type == 'PLAIN_TEXT'}">
                                                                        <input type="text" name="${node.name}" style="width:98%"/>
                                                                    </c:when>
                                                                    <c:when test="${node.type == 'RICH_TEXT'}">
                                                                        <textarea cols="80" id="editor_${node.name}" name="${node.name}" rows="10"></textarea>
                                                                    </c:when>
                                                                    <c:when test="${node.type == 'IMAGE'}">
                                                                        <input type="file" name="${node.name}"/>
                                                                    </c:when>
                                                                    <c:when test="${node.type == 'ATTACHMENT'}">
                                                                        <input type="file" name="${node.name}"/>
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>

                                        </td>
                                    </tr>

                                    <tr class="even">
                                        <td></td>
                                        <td>
                                            <input type="hidden" name="pojo.authoringTemplate" value="${item.pojo.authoringTemplate.authoringTemplateID}"/>
                                            <form:hidden path="authoringTemplateID"/>
                                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                                            <form:hidden path="pojo.contentID"/>
                                            <a href="#" onclick="$('#itemForm').submit();" class="button_blue"><fmt:message key="button.save"/></a>
                                            <a href="${backUrl}" class="button_blue"><fmt:message key="button.back"/></a>

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

                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="clear"></div>
        <br/>
    </div>
</body>
<c:url var="prefixURL" value="/" />
<script type='text/javascript'>
<c:forEach items="${authoringTemplateNodes}" var="node">
	<c:if test="${node.type == 'RICH_TEXT'}">
		CKEDITOR.replace( 'editor_${node.name}',
	            {
	                filebrowserBrowseUrl :'${prefixURL}ckeditor/filemanager/browser/default/browser.html?Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
	                filebrowserImageBrowseUrl : '${prefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Image&Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
	                filebrowserFlashBrowseUrl :'${prefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Flash&Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
				    filebrowserUploadUrl  :'${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=File',
				    filebrowserImageUploadUrl : '${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Image',
				    filebrowserFlashUploadUrl : '${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Flash'
	
		});
	</c:if>
</c:forEach>
</script>