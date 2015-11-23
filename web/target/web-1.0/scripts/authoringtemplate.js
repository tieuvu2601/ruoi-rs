validateAddNodeToAuthoringTemplate = function() {
    var validateElements = new Array(
		new Array('displayName', 'text', 'Vui lòng nhập tên hiển thị.', ''),
		new Array('nodeName', 'text', 'Nhập tên thuộc tính của cấu trúc tin.', ''),
		new Array('nodeType', 'text', 'Chọn kiểu dữ liệu của thuộc tính', '')
	);
    if (validateForm(validateElements)) {
        var displayName = $("#displayName").val();
        var nodeName = $("#nodeName").val();
        var nodeType = $("#nodeType").val();
        var defaultValue = $("#defaultValue").val();
        var constraintValues = $("#constraintValues").val();
        var minOccurs = $("#minOccurs").val() != '' ? parseInt($("#minOccurs").val(), 10) : 0;
        var maxOccurs = $("#maxOccurs").val() != '' ? parseInt($("#maxOccurs").val(), 10) : 0;

        $("#authoringTemplateNodePanel tr").each(function(){
            var rowId = $(this).attr('id');
            if (rowId == ('tr_attribute_' + nodeName)) {
                $(this).remove();
            }
        });
        var index = $("#authoringTemplateNodePanel tr").length;
        var html = '<tr id="tr_attribute_' + nodeName + '">'
                    + '<td>' + displayName + '</td>'
                    + '<td>' + nodeName + '</td>'
                    + '<td>' + nodeType2Text(nodeType) + '</td>'
                    + '<td>' + defaultValue + '</td>'
                    + '<td>' + normalizeLineBreak(constraintValues) + '</td>'
                    + '<td>' + minOccurs + ' - ' + (maxOccurs <= 0 ? 'Không giới hạn' : maxOccurs) + '</td>'
                    + '<td><a href="javascript:editAuthoringTemplateNode(\'' + nodeName + '\')"><img src="/themes/admin/images/edit.png"/></a>'
                        + '<a href="javascript:deleteAuthoringTemplateNode(\'' + nodeName + '\')"><img src="/themes/admin/images/no.png"/></a>'
                        + '<input type="hidden" id="name_' + nodeName + '" name="authoringTemplateNodes[' + index + '].name" value="' + nodeName + '"/>'
                        + '<input type="hidden" id="displayName_' + nodeName + '" name="authoringTemplateNodes[' + index + '].displayName" value="' + displayName + '"/>'
                        + '<input type="hidden" id="type_' + nodeName + '" name="authoringTemplateNodes[' + index + '].type" value="' + nodeType + '"/>'
                        + '<input type="hidden" id="defaultValue_' + nodeName + '" name="authoringTemplateNodes[' + index + '].defaultValue" value="' + defaultValue + '"/>'
                        + '<input type="hidden" id="constraintValues_' + nodeName + '" name="authoringTemplateNodes[' + index + '].constraintValues" value="' + constraintValues + '"/>'
                        + '<input type="hidden" id="minOccurs_' + nodeName + '" name="authoringTemplateNodes[' + index + '].minOccurs" value="' + minOccurs + '"/>'
                        + '<input type="hidden" id="maxOccurs_' + nodeName + '" name="authoringTemplateNodes[' + index + '].maxOccurs" value="' + maxOccurs + '"/>'

                    + '</td>'

                    + '</tr>';
        $("#authoringTemplateNodePanel").append(html);
    }
}

editAuthoringTemplateNode = function(node) {
    $("#displayName").val($('#displayName_' + node).val());
    $("#nodeName").val($('#name_' + node).val());
    $("#nodeType").val($('#type_' + node).val());
    $("#defaultValue").val($('#defaultValue_' + node).val());
    $("#constraintValues").val($('#constraintValues_' + node).val());
    $("#minOccurs").val($('#minOccurs_' + node).val() != '' ? parseInt($('#minOccurs_' + node).val()) : '0');
    $("#maxOccurs").val($('#maxOccurs_' + node).val() != '' ? parseInt($('#maxOccurs_' + node).val()) : '');
}

deleteAuthoringTemplateNode = function(node) {
    $("#authoringTemplateNodePanel tr").each(function(){
        var rowId = $(this).attr('id');
        if (rowId == ('tr_attribute_' + node)) {
            $(this).remove();
        }
    });
}

normalizeLineBreak = function(input) {
    return input.replace(/\n/gi, "<br/>");
}

nodeType2Text = function(nodeType) {
    var res = 'Đúng/Sai';
    if (nodeType == 'BOOLEAN') {
        res = 'Đúng/Sai';
    }else if (nodeType == 'NUMERIC') {
        res = 'Dữ liệu số';
    }else if (nodeType == 'PLAIN_TEXT') {
        res = 'Văn bản thường';
    }else if (nodeType == 'RICH_TEXT') {
        res = 'Văn bản đa phương tiện';
    } else if (nodeType == 'IMAGE') {
        res = 'Hình ảnh';
    }else if (nodeType == 'ATTACHMENT') {
        res = 'Đính kèm';
    }
    return res;
}