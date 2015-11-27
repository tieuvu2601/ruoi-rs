<%@ include file="/common/taglibs.jsp"%>

<head>
    <title>Comment Management</title>
    <meta name="heading" contentEntity="Comment Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.commentID}">
           Edit Comment
       </c:when>
       <c:otherwise>
           Add Comment
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/comment/edit.html"/>
<c:url var="backUrl" value="/admin/contentEntity/approve.html"/>

<div id="contentEntity">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                Comment Management
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td>Content</td>
                        <td>
                            <form:input path="pojo.contentEntity.title" size="40" readonly="true"/>
                            <form:errors path="pojo.contentEntity" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Comment Text</td>
                        <td>
                            <form:textarea path="pojo.commentText" rows="3" cssStyle="width:98%"/>
                            <form:errors path="pojo.commentText" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>
                            <form:radiobutton path="pojo.status" value="1"/> <fmt:message key="comment.status.public"/> &nbsp;
                            <form:radiobutton path="pojo.status" value="0"/> <fmt:message key="comment.status.reject"/> <br/>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.commentID"/>
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
                            <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}?pojo.contentID=${item.pojo.contentEntity.contentID}';"/>

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