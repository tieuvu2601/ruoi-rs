<%@ include file="/common/taglibs.jsp"%>
<table width="100%" class="table table-striped table-bordered table-hover no-footer">
    <tr>
        <th>
            <fmt:message key="authoring.template.title"/> ${authoringTemplate.name}
            <input type="hidden" name="pojo.authoringTemplate.authoringTemplateId" id="authoringTemplateId" value="${authoringTemplate.authoringTemplateId}"/>
            <input type="hidden" id="areProduct" value="${authoringTemplate.areProduct}"/>
        </th>
    </tr>
    <% pageContext.setAttribute("newLineChar", "\n"); %>
    <c:forEach items="${authoringTemplateNodes}" var="node">
        <c:set var="minOccurs" value="${node.minOccurs}"/>
        <c:set var="maxOccurs" value="${node.maxOccurs}"/>
        <c:if test="${empty maxOccurs}">
            <c:set var="maxOccurs" value="5"/>
        </c:if>
        <c:set var="cssClass" value=""/>
        <c:if test="${minOccurs > 0 && (node.type == 'NUMERIC' || node.type == 'PLAIN_TEXT')}">
            <c:set var="cssClass" value="required"/>
        </c:if>
        <tr><td>${node.displayName}</td></tr>
        <tr>
            <td>
                <c:choose>
                    <c:when test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
                        <div><span id="spanButtonPlaceHolder_${node.name }"></span></div>
                        <div class="fieldset flash" id="fsUploadProgress_${node.name }">
                            <span class="legend">Files</span>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <c:if test="${not empty  node.constraintValues && fn:length(node.constraintValues) > 0}">
                            <c:set value="${fn:replace(node.constraintValues, newLineChar, ';')}" var="constraintValues"/>
                            <c:set value="${fn:split(constraintValues,';') }" var="constraintValues"/>
                        </c:if>
                        <c:forEach begin="1" end="${maxOccurs}" step="1" varStatus="statusIndex">
                            <c:choose>
                                <c:when test="${node.type == 'BOOLEAN'}">
                                    <input type="radio" name="${node.name}" value="1"/> <fmt:message key="boolean.true"/>
                                    <input type="radio" name="${node.name}" value="0"/> <fmt:message key="boolean.false"/>
                                </c:when>

                                <c:when test="${node.type == 'NUMERIC'}">
                                    <c:choose>
                                        <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                            <select name="${node.name}" class="form-control">
                                                <c:forEach items="${constraintValues}" var="constraintV">
                                                    <option value="${constraintV}">${constraintV}</option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" name="${node.name}" class="form-control ${cssClass}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>

                                <c:when test="${node.type == 'PLAIN_TEXT'}">
                                    <c:choose>
                                        <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                            <select name="${node.name}" class="form-control">
                                                <c:forEach items="${constraintValues}" var="constraintV">
                                                    <option value="${constraintV}">${constraintV}</option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" name="${node.name}" class="form-control ${cssClass}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>

                                <c:when test="${node.type == 'RICH_TEXT'}">
                                    <textarea class="richTextEditor" cols="80" id="${statusIndex.index}_editor_${node.name}" name="${node.name}" rows="10"></textarea>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
<c:url var="prefixUrl" value="/" />
<script type='text/javascript'>
    <c:forEach items="${authoringTemplateNodes}" var="node">
        <c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
        var swfu_${node.name};
        </c:if>
    </c:forEach>
    $(document).ready(function(){
        bindUploadFileListener();

        $('.richTextEditor').each(function() {
            CKEDITOR.timestamp = new Date().getTime(); /*Used to debug*/
            CKEDITOR.replace($(this).attr('id'),{
                filebrowserBrowseUrl :'${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserImageBrowseUrl : '${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Type=Image&Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserFlashBrowseUrl :'${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Type=Flash&Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserUploadUrl  :'${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=File',
                filebrowserImageUploadUrl : '${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=Image',
                filebrowserFlashUploadUrl : '${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=Flash'

            });
        });
    });

    function bindUploadFileListener(){
        <c:forEach items="${authoringTemplateNodes}" var="node">
            <c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
                var settings${node.name} = {
                    flash_url : "<c:url value='/swfupload/swfupload.swf'/>",
                    upload_url: "<c:url value='/ajax/content/uploadfile.html;jsessionid=${pageContext.session.id}'/>",
                    post_params: {'nodename' : '${node.name}', 'authoringTemplateId': '${authoringTemplate.authoringTemplateId}','categoryId': '${category.categoryId}'},
                    file_size_limit : "500 MB",
                    file_types : "*.*",
                    file_types_description : "All Files",
                    file_upload_limit : ${node.maxOccurs},
                    file_queue_limit : 0,
                    custom_settings : {
                        progressTarget : "fsUploadProgress_${node.name }",
                        cancelButtonId : "btnCancel"
                    },
                    debug: false,

                    // Button settings
                    button_image_url: "<c:url value='/swfupload/TestImageNoText_65x29.png'/>",
                    button_width: "55",
                    button_height: "29",
                    button_placeholder_id: "spanButtonPlaceHolder_${node.name}",
                    button_text: 'Browse...',
                    button_text_style: ".theFont { font-size: 22; }",
                    button_text_left_padding: 2,
                    button_text_top_padding: 3,

                    // The event handler functions are defined in handlers.js
                    file_queued_handler : fileQueued,
                    file_queue_error_handler : fileQueueError,
                    upload_start_handler : uploadStart,
                    upload_progress_handler : uploadProgress,
                    upload_error_handler : uploadError,
                    upload_success_handler : uploadSuccess,
                    upload_complete_handler : uploadComplete
                };
            swfu_${node.name} = new SWFUpload(settings${node.name});
            </c:if>
        </c:forEach>
    }
</script>

