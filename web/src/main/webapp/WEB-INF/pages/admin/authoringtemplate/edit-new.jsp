<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><fmt:message key="authoringtemplate.template"/></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Jquery step -->
    <style>
        table.tableNodeElements tr.selected .node_label{
            color: #B94A48 !important;
        }
        .alert_message {
            float: left;
            font-size: 14px;
            padding-left: 15px;
            padding-right: 15px;
            margin-top: 7px;
            font-weight: bold;
        }

        .alert_message.errors{
            color: #B94A48;
        }

        .alert_message.success{
            color: #00a65a;
        }

        .invalid {
            border: 1px solid #B94A48 !important;
        }
    </style>
</head>
<c:url var="backUrl" value="/admin/authoringtemplate/list.html"/>
<c:url var="formlUrl" value="/admin/authoringtemplate/edit.html"/>
<body>
<form:form commandName="item" id="formItem" action="${formUrl}" method="post" cssClass="form-horizontal" novalidate="novalidate">
<section class="content">
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-message  alert-${alertType}">
            <a class="close" data-dismiss="alert" href="#">&times;</a> ${messageResponse}
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-12" id="authoringForm">
            <h3><fmt:message key="authoringtemplate.manager.home"/></h3>
            <fieldset>
                <legend><fmt:message key="authoringtemplate.manager.home"/></legend>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-3 control-label"><fmt:message key="authoringtemplate.manager.code"/></label>
                        <div class="col-sm-7">
                            <form:input path="pojo.code" cssClass="form-control" id="authoringTemplateCode"/>
                            <form:errors path="pojo.code" cssClass="error-inline-validate"/>
                        </div>
                    </div>
                </div>

                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-3 control-label"><fmt:message key="authoringtemplate.manager.name"/></label>
                        <div class="col-sm-7">
                            <form:input path="pojo.name" cssClass="form-control" id="authoringTemplateName"/>
                            <form:errors path="pojo.name" cssClass="error-inline-validate"/>
                        </div>
                    </div>
                </div>
            </fieldset>

            <h3><fmt:message key="content.manager.xmldata"/></h3>
            <fieldset>
                <legend><fmt:message key="content.manager.xmldata"/></legend>
                <div class="box box-solid box-primary" id="xmlNodeTemplate" numberRow="${fn:length(item.authoringTemplateNodes)}">
                    <div class="box-header with-border">
                        <h3 class="box-title"><fmt:message key="authoringtemplate.manager.node.template"/></h3>
                    </div>

                    <div class="box-body">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.designer.type.type"/></label>
                                <div class="col-sm-8">
                                    <select class="form-control type_attribute col-sm-6">
                                        <option value=""><fmt:message key="authoringtemplate.designer.type.select"/></option>
                                        <option value="BOOLEAN"><fmt:message key="authoringtemplate.designer.type.boolean"/></option>
                                        <option value="NUMERIC"><fmt:message key="authoringtemplate.designer.type.numeric"/></option>
                                        <option value="PLAIN_TEXT"><fmt:message key="authoringtemplate.designer.type.plaintext"/></option>
                                        <option value="RICH_TEXT"><fmt:message key="authoringtemplate.designer.type.richtext"/></option>
                                        <option value="IMAGE"><fmt:message key="authoringtemplate.designer.type.image"/></option>
                                        <option value="ATTACHMENT"><fmt:message key="authoringtemplate.designer.type.attachment"/></option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.manager.node.name"/></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control name_node">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.manager.node.displayname"/></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control display_name">
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-7">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.manager.node.defaultvalue"/></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control default_value">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.manager.node.constraintvalue"/></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control constraint_values" placeholder="Split values by ;">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4 control-label form-control_label"><fmt:message key="authoringtemplate.manager.node.occurs"/> <fmt:message key="authoringtemplate.manager.node.occurs.from"/> </label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control min_occurs short" placeholder="<fmt:message key="authoringtemplate.manager.node.occurs.min"/>">
                                </div>
                                <label class=" col-sm-1 control-label form-control_label"> <fmt:message key="authoringtemplate.manager.node.occurs.to"/> </label>
                                <div class="col-sm-3">
                                    <input type="text" placeholder="<fmt:message key="authoringtemplate.manager.node.occurs.max"/>" class="form-control max_occurs short">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="box-footer">
                        <div class="alert_message"></div>
                        <a onclick="clearDataNodeElementTemplate();" class="btn btn-danger pull-right"><i class="fa fa-fw fa-refresh"></i> <fmt:message key="button.reset"/></a>
                        <a onclick="addNodeElement();" class="btn btn-primary xmlNodeTemplateAction pull-right" style="margin-right: 10px;"><i class="fa fa-fw fa-plus"></i> <fmt:message key="button.add"/></a>
                    </div>
                </div>

                <div class="box box-solid box-primary" id="xmlNodeElements">
                    <div class="box-header with-border">
                        <h3 class="box-title"><fmt:message key="authoringtemplate.manager.node"/></h3>
                    </div>

                    <div class="box-body">
                        <table class="tableNodeElements table table-bordered table-hover table-striped">
                            <thead>
                            <tr>
                                <th style="width: 15%;"><fmt:message key="authoringtemplate.manager.node.name"/></th>
                                <th style="width: 15%;"><fmt:message key="authoringtemplate.manager.node.displayname"/></th>
                                <th style="width: 10%;"><fmt:message key="authoringtemplate.manager.node.type"/></th>
                                <th style="width: 20%;"><fmt:message key="authoringtemplate.manager.node.defaultvalue"/></th>
                                <th style="width: 20%;"><fmt:message key="authoringtemplate.manager.node.constraintvalue"/></th>
                                <th style="width: 10%;"><fmt:message key="authoringtemplate.manager.node.occurs"/></th>
                                <th style="width: 10%;"><fmt:message key="label.action"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${item.authoringTemplateNodes}" var="node" varStatus="status">
                                <tr class="node_parent" name_node="${node.name}">
                                    <td><span class="label_name_node node_label">${node.name}</span></td>
                                    <td><span class="label_display_name node_label">${node.displayName}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${node.type == 'BOOLEAN'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.boolean"/></span></c:when>
                                            <c:when test="${node.type == 'NUMERIC'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.numeric"/></span></c:when>
                                            <c:when test="${node.type == 'PLAIN_TEXT'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.plaintext"/></span></c:when>
                                            <c:when test="${node.type == 'RICH_TEXT'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.richtext"/></span></c:when>
                                            <c:when test="${node.type == 'IMAGE'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.image"/></span></c:when>
                                            <c:when test="${node.type == 'ATTACHMENT'}"><span class="label_type_attribute node_label"><fmt:message key="authoringtemplate.designer.type.attachment"/></span></c:when>
                                        </c:choose>
                                    </td>
                                    <td><span class="label_default_value node_label">${node.defaultValue}</span></td>
                                    <td><span class="label_constraint_values node_label">${node.constraintValues}</span></td>
                                    <td><span class="node_label"><fmt:message key="authoringtemplate.manager.node.occurs.from"/></span> <span class="label_min_occurs node_label">${node.minOccurs}</span> <span class="node_label"><fmt:message key="authoringtemplate.manager.node.occurs.to"/></span> <span class="label_max_occurs node_label">${node.maxOccurs}</span></td>
                                    <td class="text-center">
                                        <a class="tip-top action_edit" onclick="selectDataNodeElement(this)"><i class="fa fa-pencil-square-o"></i></a> |
                                        <a class="tip-top action_delete" onclick="removeDataNodeElement(this)"><i class="fa fa-times"></i></a>
                                        <input name="authoringTemplateNodes[${status.index}].name" class="name_node" value="${node.name}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].displayName" class="display_name" value="${node.displayName}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].defaultValue" class="default_value" value="${node.defaultValue}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].minOccurs" class="min_occurs" value="${node.minOccurs}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].maxOccurs" class="max_occurs" value="${node.maxOccurs}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].type" class="type_attribute"  value="${node.type}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].constraintValues" class="constraint_values" value="${node.constraintValues}" type="hidden"/>
                                        <input name="authoringTemplateNodes[${status.index}].displayOrder" class="display_order_values" value="${node.displayOrder}" type="hidden"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</section>

    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.authoringTemplateId"/>
</form:form>

<script>
    $(document).ready(function(){
        setActiveMenu4Admin('#content_administration_menu', '#authoring_template_menu');

        var form = $("#authoringForm").show();
        form.steps({
            headerTag: "h3",
            bodyTag: "fieldset",
            transitionEffect: "slideLeft",
            enableCancelButton: true,
            onCanceled: function (event) {
                document.location = "${backUrl}";
            },
            onStepChanging: function (event, currentIndex, newIndex){
                $('.checkbox-control').bootstrapSwitch();
                if (currentIndex > newIndex){
                    return true;
                }
                if (currentIndex < newIndex){
                    return isValidAuthoringForm(currentIndex);
                }

            },
            onStepChanged: function (event, currentIndex, priorIndex){
                if (currentIndex === 2 >= 18){
                    form.steps("next");
                }
                if (currentIndex === 2 && priorIndex === 3){
                    form.steps("previous");
                }
            },
            onFinishing: function (event, currentIndex){
                return isValidAuthoringForm(currentIndex);
            },
            onFinished: function (event, currentIndex){
                $("#crudaction").val("insert-update");
                reOrderDisplay();
                $("#formItem").submit();
            }
        });
        enableReOrderRow();
    });

    function  isValidAuthoringForm(step){
        var isValid = false;
        if(step == 0){
            var authoringTemplateCode = $('#authoringTemplateCode');
            var authoringTemplateName = $('#authoringTemplateName');
            if ($(authoringTemplateCode).val() != ""){
                $(authoringTemplateCode).removeClass('error');
                if($(authoringTemplateName).val() != ""){
                    $(authoringTemplateName).removeClass('error');
                    isValid = true;
                } else {
                    $(authoringTemplateName).addClass('error');
                }
            } else {
                $(authoringTemplateCode).addClass('error');
            }
        } else if (step == 1){
            if ($('#xmlNodeElements').find('table.tableNodeElements').find('.node_parent').length > 0){
                isValid = true;
            }  else {
                alertActionMessage("<fmt:message key="authoringtemplate.designer.insertnode"/>", "errors");
            }
        }
        return isValid;
    }

    function reOrderDisplay(){
        var displayOrder = 0;
        $('.node_parent').find('.display_order_values').each(function(){
            $(this).val(displayOrder);
            displayOrder++;
        });
    }

    function addNodeElement(){
        var xmlNodeTemplate = $('#xmlNodeTemplate');
        var numberRow = parseInt($('#xmlNodeTemplate').attr('numberRow'));
        var dataNode = getDataNodeByParentElement(xmlNodeTemplate);
        var validate = validateDataNode(dataNode);
        if (validate.crudaction == "insert"){
            if (addDataNode(dataNode, numberRow)){
                unselectedDataNodeElement();
                clearDataNodeElementTemplate();
                numberRow += 1;
                $('#xmlNodeTemplate').attr('numberRow', numberRow);
                updateLabelForXMLNodeTemplateAction('<i class="fa fa-fw fa-plus"></i> <fmt:message key="button.add"/>');
                alertActionMessage('<fmt:message key="authoringtemplate.manager.node.successfull.add"/>', 'success');
            }
        } else if (validate.crudaction == "update"){
            if (updateDataNode(dataNode)){
                unselectedDataNodeElement();
                clearDataNodeElementTemplate();
                updateLabelForXMLNodeTemplateAction('<i class="fa fa-fw fa-plus"></i> <fmt:message key="button.add"/>');
                alertActionMessage('<fmt:message key="authoringtemplate.manager.node.successfull.update"/>', 'success');
            }
        } else {
            alertActionMessage(validate.crudaction, 'errors');
            $(xmlNodeTemplate).find('.'+ validate.field).addClass('invalid');
        }
    }

    function alertActionMessage(message, className){
        var alert_message = $('.alert_message');
        $(alert_message).removeClass('errors');
        $(alert_message).removeClass('success');
        $(alert_message).empty().text(message);
        $(alert_message).addClass(className);
    }

    function updateDataNode(dataNode){
        return bindDataNodeFromDataTemplate(dataNode);
    }

    function addDataNode(dataNode, numberRow){
        var xmlNodeElements = $('#xmlNodeElements');
        var tableNodeElements = $(xmlNodeElements).find('table.tableNodeElements');
        var elementRow = $(
                '<tr class="node_parent"  name_node="'+ dataNode.name_node +'">' +
                    '<td><span class="label_name_node node_label">'+ dataNode.name_node +'</span></td>' +
                    '<td><span class="label_display_name node_label">'+ dataNode.display_name +'</span></td>' +
                    '<td><span class="label_type_attribute node_label">'+ dataNode.type_attribute +'</span></td>' +
                    '<td><span class="label_default_value node_label">'+ dataNode.default_value +'</span></td>' +
                    '<td><span class="label_constraint_values node_label">'+ dataNode.constraint_values +'</span></td>' +
                    '<td><span class="node_label"><fmt:message key="authoringtemplate.manager.node.occurs.from"/></span> <span class="label_min_occurs node_label">'+ dataNode.min_occurs +'</span> <span class="node_label"><fmt:message key="authoringtemplate.manager.node.occurs.to"/></span> <span class="label_max_occurs node_label">' + dataNode.max_occurs + '</span></td>' +
                    '<td class="text-center">' +
                        '<a class="tip-top action_edit" onclick="selectDataNodeElement(this)"><i class="fa fa-pencil-square-o"></i></a> | ' +
                        '<a class="tip-top action_delete" onclick="removeDataNodeElement(this)"><i class="fa fa-times"></i></a>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].name" class="name_node" value="' + dataNode.name_node +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].displayName" class="display_name" value="'+ dataNode.display_name +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].defaultValue" class="default_value" value="'+ dataNode.default_value +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].minOccurs" class="min_occurs" value="'+ dataNode.min_occurs +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].maxOccurs" class="max_occurs" value="'+ dataNode.max_occurs +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].type" class="type_attribute"  value="'+ dataNode.type_attribute +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].constraintValues" class="constraint_values" value="'+ dataNode.constraint_values +'" type="hidden"/>' +
                        '<input name="authoringTemplateNodes['+ numberRow +'].displayOrder" class="display_order_values" value="'+ dataNode.display_order_values +'" type="hidden"/>' +
                    '</td>' +
                    '</tr>');
        $(tableNodeElements).find('tbody:last').append($(elementRow));
        enableReOrderRow();
        return true;
    }

    function removeDataNodeElement(element){
        var dataNodeElement = $(element).closest('.node_parent');
        var name_node = $(dataNodeElement).attr('id');
        if( $(dataNodeElement).length > 0){
            var xmlNodeTemplate = $('#xmlNodeTemplate');
            var name_node_ = $(xmlNodeTemplate).attr('dataNode');
            if(name_node_ == name_node){
                $(xmlNodeTemplate).removeAttr('dataNode');
                updateLabelForXMLNodeTemplateAction('<i class="fa fa-fw fa-plus"></i> <fmt:message key="button.add"/>');
            }
            $(dataNodeElement).remove();
            alertActionMessage('<fmt:message key="authoringtemplate.manager.node.successfull.delete"/>', 'success');
        }
    }

    function validateDataNode(dataNode){
        removeClassInvalidCheck();
        var errors = "";
        var field = "";
        if (dataNode.name_node == "" || dataNode.display_name == "" || dataNode.type_attribute == "" || isNaN(dataNode.min_occurs) || isNaN(dataNode.max_occurs)){
            if (dataNode.type_attribute == "") {
                errors = "<fmt:message key="authoringtemplate.manager.node.exception.empty.type"/>";
                field = "type_attribute";
            }else if(dataNode.name_node == ""){
                errors = "<fmt:message key="authoringtemplate.manager.node.exception.empty.name"/>";
                field = "name_node";
            } else if(dataNode.display_name == ""){
                errors = "<fmt:message key="authoringtemplate.manager.node.exception.empty.displayname"/>";
                field = "display_name";
            } else if (isNaN(dataNode.min_occurs)){
                errors = "<fmt:message key="authoringtemplate.manager.node.exception.empty.min.occurs"/>";
                field = "min_occurs";
            } else if (isNaN(dataNode.max_occurs)){
                errors = "<fmt:message key="authoringtemplate.manager.node.exception.empty.max.occurs"/>";
                field = "max_occurs";
            }
            return getErrorMessage(errors, field);
        } else {
            return getCrudactionFromDataNode(dataNode.name_node);
        }
    }


    function getCrudactionFromDataNode(name_node){
        var xmlNodeTemplate = $('#xmlNodeTemplate');
        var name_node_selected = $(xmlNodeTemplate).attr('dataNode');
        var field = ""
        var crudaction = "";
        var dataNodeElement = getDataNodeElementByNameNode(name_node);
        if(name_node_selected != null && name_node_selected != undefined){
            crudaction = "update";
            if (dataNodeElement != null && $(dataNodeElement).length > 0){
                if(!$(dataNodeElement).hasClass('selected')){
                    crudaction = "<fmt:message key="authoringtemplate.manager.node.exception.empty.name.duplicated"/>";
                    field = "name_node";
                }
            }
        } else {
            crudaction = "insert";
            if(dataNodeElement != null && $(dataNodeElement).length > 0){
                crudaction = "<fmt:message key="authoringtemplate.manager.node.exception.empty.name.duplicated"/>";
                field = "name_node";
            }
        }
        return getErrorMessage(crudaction, field);
    }

    function getErrorMessage(crudaction, field){
        return {
            'crudaction' : crudaction,
            'field' : field
        }
    }

    function getDataNodeElementByNameNode(name_node){
        var returnElement = null;
        $('#xmlNodeElements').find('table.tableNodeElements').find('tr.node_parent').each(function(){
            if($(this).attr('name_node') == name_node){
                returnElement = $(this);
            }
        });
        return returnElement;
    }

    function getDataNodeByParentElement(parentElement){
        var name_node =  $(parentElement).find('.name_node').val();
        var display_name = $(parentElement).find('.display_name').val();
        var default_value = $(parentElement).find('.default_value').val();
        var min_occurs = $(parentElement).find('.min_occurs').val();
        var max_occurs = $(parentElement).find('.max_occurs').val();
        var type_attribute = $(parentElement).find('.type_attribute').val();
        var constraint_values = $(parentElement).find('.constraint_values').val();
        var dataNode = nodeElement(name_node, display_name, default_value, min_occurs, max_occurs, type_attribute, constraint_values);

        return dataNode;
    }

    function nodeElement(name_node, display_name, default_value, min_occurs, max_occurs, type_attribute, constraint_values){
        if(default_value == ""){
            default_value = "";
        }

        if(min_occurs == ""){
            min_occurs = 0;
        } else {
            min_occurs = parseInt(min_occurs);
        }

        if(max_occurs == ""){
            max_occurs = 1;
        } else {
            max_occurs = parseInt(max_occurs);
        }

        if(min_occurs >= 0 && max_occurs >=0){
            if (min_occurs > max_occurs){
                var temp = max_occurs;
                max_occurs = min_occurs;
                min_occurs = temp;
            }
        }

        var nodeElement = {
            name_node: name_node.trim(),
            display_name : display_name.trim(),
            default_value : default_value,
            min_occurs: min_occurs,
            max_occurs: max_occurs,
            type_attribute: type_attribute,
            constraint_values: constraint_values,
            display_order_values: 0
        };
        return nodeElement;
    }

    function bindDataNodeFromDataTemplate(dataNode){
        var xmlNodeTemplate = $('#xmlNodeTemplate');
        var type_label = $(xmlNodeTemplate).find('.type_attribute option:selected').text();
        var name_node = $(xmlNodeTemplate).attr('dataNode');
        var parent = getDataNodeElementByNameNode(name_node);
        if (parent != null && parent.length > 0){
            var name_node = $(parent).find('.name_node');
            var display_name = $(parent).find('.display_name');
            var default_value = $(parent).find('.default_value');
            var min_occurs = $(parent).find('.min_occurs');
            var max_occurs = $(parent).find('.max_occurs');
            var type_attribute = $(parent).find('.type_attribute');
            var constraint_values = $(parent).find('.constraint_values');

            var label_name_node = $(parent).find('.label_name_node');
            var label_display_name = $(parent).find('.label_display_name');
            var label_default_value = $(parent).find('.label_default_value');
            var label_min_occurs = $(parent).find('.label_min_occurs');
            var label_max_occurs = $(parent).find('.label_max_occurs');
            var label_type_attribute = $(parent).find('.label_type_attribute');
            var label_constraint_values = $(parent).find('.label_constraint_values');

            $(name_node).val(dataNode.name_node);
            $(display_name).val(dataNode.display_name);
            $(default_value).val(dataNode.default_value);
            $(min_occurs).val(dataNode.min_occurs);
            $(max_occurs).val(dataNode.max_occurs);
            $(type_attribute).val(dataNode.type_attribute);
            $(constraint_values).val(dataNode.constraint_values);

            $(label_name_node).empty().append(dataNode.name_node);
            $(label_display_name).empty().append(dataNode.display_name);
            $(label_default_value).empty().append(dataNode.default_value);
            $(label_min_occurs).empty().append(dataNode.min_occurs);
            $(label_max_occurs).empty().append(dataNode.max_occurs);
            $(label_type_attribute).empty().append(type_label);
            $(label_constraint_values).empty().append(dataNode.constraint_values);

            $(parent).attr('name_node', dataNode.name_node);
            return true;
        } else {
            return false;
        }
    }

    function bindDataNodeTemplateFromDataNode(parent){
        var dataNode = getDataNodeByParentElement(parent);
        var xmlNodeTemplate = $('#xmlNodeTemplate');

        var name_node =  $(xmlNodeTemplate).find('.name_node');
        var display_name = $(xmlNodeTemplate).find('.display_name');
        var default_value = $(xmlNodeTemplate).find('.default_value');
        var min_occurs = $(xmlNodeTemplate).find('.min_occurs');
        var max_occurs = $(xmlNodeTemplate).find('.max_occurs');
        var type_attribute = $(xmlNodeTemplate).find('.type_attribute');
        var constraint_values = $(xmlNodeTemplate).find('.constraint_values');

        $(name_node).val(dataNode.name_node);
        $(display_name).val(dataNode.display_name);
        $(default_value).val(dataNode.default_value);
        $(min_occurs).val(dataNode.min_occurs);
        $(max_occurs).val(dataNode.max_occurs);
        $(type_attribute).val(dataNode.type_attribute);
        $(constraint_values).val(dataNode.constraint_values);

        $(xmlNodeTemplate).attr('dataNode', dataNode.name_node);
    }

    function clearDataNodeElementTemplate(){
        var xmlNodeTemplate = $('#xmlNodeTemplate');

        var name_node =  $(xmlNodeTemplate).find('.name_node');
        var display_name = $(xmlNodeTemplate).find('.display_name');
        var default_value = $(xmlNodeTemplate).find('.default_value');
        var min_occurs = $(xmlNodeTemplate).find('.min_occurs');
        var max_occurs = $(xmlNodeTemplate).find('.max_occurs');
        var type_attribute = $(xmlNodeTemplate).find('.type_attribute');
        var constraint_values = $(xmlNodeTemplate).find('.constraint_values');

        $(name_node).val('');
        $(display_name).val('');
        $(default_value).val('');
        $(min_occurs).val('');
        $(max_occurs).val('');
        $(type_attribute).val('');
        $(constraint_values).val('');
    }

    function removeClassInvalidCheck(){
        var xmlNodeTemplate = $('#xmlNodeTemplate');

        var name_node =  $(xmlNodeTemplate).find('.name_node');
        var display_name = $(xmlNodeTemplate).find('.display_name');
        var default_value = $(xmlNodeTemplate).find('.default_value');
        var min_occurs = $(xmlNodeTemplate).find('.min_occurs');
        var max_occurs = $(xmlNodeTemplate).find('.max_occurs');
        var type_attribute = $(xmlNodeTemplate).find('.type_attribute');
        var constraint_values = $(xmlNodeTemplate).find('.constraint_values');

        $(name_node).removeClass('invalid');
        $(display_name).removeClass('invalid');
        $(type_attribute).removeClass('invalid');
        $(min_occurs).removeClass('invalid');
        $(max_occurs).removeClass('invalid');
    }

    function selectDataNodeElement(element){
        var dataNodeElement = $(element).closest('.node_parent');
        if(dataNodeElement != null && $(dataNodeElement).length > 0){
            if($(dataNodeElement).hasClass('selected')){
                unselectedDataNodeElement();
                clearDataNodeElementTemplate();
                updateLabelForXMLNodeTemplateAction('<i class="fa fa-fw fa-plus"></i> <fmt:message key="button.add"/>');
            } else {
                unselectedDataNodeElement();
                bindDataNodeTemplateFromDataNode(dataNodeElement);
                $(dataNodeElement).addClass('selected');
                $(dataNodeElement).find('.action_edit').find('i').removeClass('fa-pencil-square-o').addClass('fa-info-circle');
                updateLabelForXMLNodeTemplateAction('<i class="fa fa-fw fa-edit"></i> <fmt:message key="button.update"/>');
            }
        }
    }

    function updateLabelForXMLNodeTemplateAction(label){
        var xmlNodeTemplateAction = $('#xmlNodeTemplate').find('.xmlNodeTemplateAction');
        $(xmlNodeTemplateAction).empty().html(label);
    }

    function unselectedDataNodeElement(){
        var xmlNodeElements = $('#xmlNodeElements');
        var tableNodeElements = $(xmlNodeElements).find('table.tableNodeElements');
        $(tableNodeElements).find('tr.selected').each(function(){
            if($(this).hasClass('selected')){
                $(this).removeClass('selected');
                $(this).find('.action_edit').find('i').removeClass('fa-info-circle').addClass('fa-pencil-square-o');
            }
        });
        var xmlNodeTemplate = $('#xmlNodeTemplate');
        $(xmlNodeTemplate).removeAttr('dataNode');
    }

    function enableReOrderRow(){
        var fixHelperModified = function(e, tr) {
                    var $originals = tr.children();
                    var $helper = tr.clone();
                    $helper.children().each(function(index) {
                        $(this).width($originals.eq(index).width())
                    });
                    return $helper;
                },
                updateIndex = function(e, ui) {
                    $('td.node_parent', ui.item.parent()).each(function (i) {
                        $(this).html(i + 1);
                    });
                };

        $(".tableNodeElements tbody").sortable({
            helper: fixHelperModified,
            stop: updateIndex
        }).disableSelection();
    }

</script>
<script src="<c:url value="/themes/portal/plugins/jquery_steps_v1.1.0/jquery.steps.js"/>"></script>
<script src="<c:url value="/themes/portal/plugins/datatables/dataTables.bootstrap.min.js"/>"></script>
</body>
</html>
