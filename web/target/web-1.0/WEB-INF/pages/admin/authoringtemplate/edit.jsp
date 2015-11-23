<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="authoringtemplate.template"/></title>
    <meta name="heading" content="<fmt:message key="authoringtemplate.management"/>"/>
</head>
<script type="text/javascript" language="javascript" src="<c:url value="/scripts/authoringtemplate.js"/>"></script>
<!-- Dependencies -->
<script language="javascript" src="<c:url value="/scripts/jQueryAlert/jquery.js"/>" type="text/javascript"></script>
<script src="<c:url value="/scripts/jQueryAlert/jquery.ui.draggable.js"/>" type="text/javascript"></script>

<!-- Core files -->
<script src="<c:url value="/scripts/jQueryAlert/jquery.alerts.js"/>"  type="text/javascript"></script>
<link href="<c:url value="/scripts/jQueryAlert/jquery.alerts.css"/>" rel="stylesheet" type="text/css" media="screen">

<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.authoringTemplateID}">
           <fmt:message key="authoringtemplate.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="authoringtemplate.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/authoringtemplate/edit.html"/>
<c:url var="backUrl" value="/admin/authoringtemplate/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" name="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="authoringtemplate.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="authoringtemplate.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="authoringtemplate.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>

                    </tr>

                    <tr>
                        <td><fmt:message key="authoringtemplate.hasthumbnail"/></td>
                        <td>
                            <input type="radio" name="pojo.hasThumbnail" value="Y" <c:if test="${item.pojo.hasThumbnail eq 'Y'}">checked="checked"</c:if> /><fmt:message key="label.yes"/>
                            <input type="radio" name="pojo.hasThumbnail" value="N" <c:if test="${empty item.pojo.hasThumbnail or item.pojo.hasThumbnail eq 'N'}">checked="checked"</c:if>/><fmt:message key="label.no"/>
                        </td>

                    </tr>

                    <tr>
                        <td><fmt:message key="authoringtemplate.hashotitem"/></td>
                        <td>
                            <input type="radio" name="pojo.hasHotItem" value="Y" <c:if test="${item.pojo.hasHotItem eq 'Y'}">checked="checked"</c:if> /><fmt:message key="label.yes"/>
                            <input type="radio" name="pojo.hasHotItem" value="N" <c:if test="${empty item.pojo.hasHotItem or item.pojo.hasHotItem eq 'N'}">checked="checked"</c:if>/><fmt:message key="label.no"/>
                        </td>

                    </tr>

                    <tr>
                        <td><fmt:message key="authoringtemplate.hasdepartment"/></td>
                        <td>
                            <input type="radio" name="pojo.hasDepartment" value="Y" <c:if test="${item.pojo.hasDepartment eq 'Y'}">checked="checked"</c:if> /><fmt:message key="label.yes"/>
                            <input type="radio" name="pojo.hasDepartment" value="N" <c:if test="${empty item.pojo.hasDepartment or item.pojo.hasDepartment eq 'N'}">checked="checked"</c:if>/><fmt:message key="label.no"/>
                        </td>

                    </tr>


                    <tr>
                        <td><fmt:message key="label.status"/></td>
                        <td>
                            <input type="radio" name="pojo.status" value="Y" <c:if test="${empty item.pojo.status or item.pojo.status eq 'Y'}">checked="checked"</c:if> /><fmt:message key="authoringtemplate.comment.yes"/>
                            <input type="radio" name="pojo.status" value="N" <c:if test="${item.pojo.status eq 'N'}">checked="checked"</c:if>/><fmt:message key="authoringtemplate.comment.no"/>
                        </td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.authoringTemplateID"/>
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="document.itemForm.submit();"/>
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
        <div class="box_container">
            <div class="header">
                <fmt:message key="authoringtemplate.designer"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="authoringtemplate.designer.displayname"/></td>
                        <td><input type="text" name="displayName" id="displayName"/></td>
                        <td><fmt:message key="authoringtemplate.designer.name"/></td>
                        <td><input type="text" name="nodeName" id="nodeName"/></td>
                    </tr>
                    <tr>
                        <td><fmt:message key="authoringtemplate.designer.type"/></td>
                        <td>
                            <select name="nodeType" id="nodeType">
                                <option value="BOOLEAN"><fmt:message key="authoringtemplate.designer.type.boolean"/></option>
                                <option value="NUMERIC"><fmt:message key="authoringtemplate.designer.type.numeric"/></option>
                                <option value="PLAIN_TEXT"><fmt:message key="authoringtemplate.designer.type.plaintext"/></option>
                                <option value="RICH_TEXT"><fmt:message key="authoringtemplate.designer.type.richtext"/></option>
                                <option value="IMAGE"><fmt:message key="authoringtemplate.designer.type.image"/></option>
                                <option value="ATTACHMENT"><fmt:message key="authoringtemplate.designer.type.attachment"/></option>
                            </select>
                        </td>
                        <td>
                            <fmt:message key="authoringtemplate.designer.occurs"/>
                        </td>
                        <td>
                            <input type="text" name="minOccurs" id="minOccurs" style="width:80px;"/>
                            &nbsp;<fmt:message key="authoringtemplate.designer.maxoccurs"/>&nbsp;<input type="text" name="maxOccurs" id="maxOccurs" style="width:80px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="authoringtemplate.designer.defaultvalue"/></td>
                        <td colspan="3"><input type="text" name="defaultValue" id="defaultValue" style="width:98%;"/></td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <fmt:message key="authoringtemplate.designer.constraintvalues"/><br/>
                            <i><fmt:message key="authoringtemplate.designer.constraintvalues.note"/></i>
                        </td>
                        <td colspan="3"><textarea type="text" name="constraintValues" id="constraintValues" rows="5" style="width:98%"></textarea></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <input type="button" value="<fmt:message key="button.insert"/>" onclick="validateAddNodeToAuthoringTemplate()"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="form">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" id="authoringTemplateNodePanel" class="table bright_blue_body">
                    <tr>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.displayname"/></th>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.name"/></th>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.type"/></th>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.defaultvalue"/></th>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.constraintvalues"/></th>
                        <th class="table_header"><fmt:message key="authoringtemplate.designer.occurs"/></th>
                        <th class="table_header"><fmt:message key="action"/></th>
                    </tr>
                    <c:forEach items="${item.authoringTemplateNodes}" var="node" varStatus="status">
                        <c:set var="rowCss" value="even"/>
                        <c:if test="${status.index % 2 == 0}">
                            <c:set var="rowCss" value="odd"/>
                        </c:if>
                        <tr id="tr_attribute_${node.name}" class="${rowCss}">
                            <td>${node.displayName}</td>
                            <td>${node.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${node.type == 'BOOLEAN'}"><fmt:message key="authoringtemplate.designer.type.boolean"/></c:when>
                                    <c:when test="${node.type == 'NUMERIC'}"><fmt:message key="authoringtemplate.designer.type.numeric"/></c:when>
                                    <c:when test="${node.type == 'PLAIN_TEXT'}"><fmt:message key="authoringtemplate.designer.type.plaintext"/></c:when>
                                    <c:when test="${node.type == 'RICH_TEXT'}"><fmt:message key="authoringtemplate.designer.type.richtext"/></c:when>
                                    <c:when test="${node.type == 'IMAGE'}"><fmt:message key="authoringtemplate.designer.type.image"/></c:when>
                                    <c:when test="${node.type == 'ATTACHMENT'}"><fmt:message key="authoringtemplate.designer.type.attachment"/></c:when>
                                </c:choose>
                            </td>
                            <td>${node.defaultValue}</td>
                            <td>${node.constraintValues}</td>
                            <td>${node.minOccurs} -
                                <c:choose>
                                    <c:when test="${empty node.maxOccurs}"><fmt:message key="authoringtemplate.designer.occurs.unlimited"/></c:when>
                                    <c:otherwise>${node.maxOccurs}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="javascript:editAuthoringTemplateNode('${node.name}')"><img src="<c:url value='/themes/admin/images/edit.png'/>"/></a>
                                <a href="javascript:deleteAuthoringTemplateNode('${node.name}')"><img src="<c:url value='/themes/admin/images/no.png'/>"/></a>
                                <input type="hidden" id="name_${node.name}" name="authoringTemplateNodes[${status.index}].name" value="${node.name}"/>
                                <input type="hidden" id="displayName_${node.name}" name="authoringTemplateNodes[${status.index}].displayName" value="${node.displayName}"/>
                                <input type="hidden" id="type_${node.name}" name="authoringTemplateNodes[${status.index}].type" value="${node.type}"/>
                                <input type="hidden" id="defaultValue_${node.name}" name="authoringTemplateNodes[${status.index}].defaultValue" value="${node.defaultValue}"/>
                                <input type="hidden" id="constraintValues_${node.name}" name="authoringTemplateNodes[${status.index}].constraintValues" value="${node.constraintValues}"/>
                                <input type="hidden" id="minOccurs_${node.name}" name="authoringTemplateNodes[${status.index}].minOccurs" value="${node.minOccurs}"/>
                                <input type="hidden" id="maxOccurs_${node.name}" name="authoringTemplateNodes[${status.index}].maxOccurs" value="${node.maxOccurs}"/>
                                <input type="hidden" id="displayOrder_${node.name}" name="authoringTemplateNodes[${status.index}].displayOrder" value="${node.displayOrder}"/>

                            </td>

                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </form:form>
</div>

