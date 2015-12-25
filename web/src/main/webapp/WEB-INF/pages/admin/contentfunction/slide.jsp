<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
</head>

<c:url var="formUrl" value="/admin/content/slider-manager.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="content.title"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="content.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <fmt:message key="content.management"/>
                </h2>
            </div>
        </div>
    </div>

    <div class="content animate-panel">
        <div>
            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="button.search"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <c:if test="${not empty messageResponse}">
                                <div class="alert alert-message
                                <c:choose>
                                    <c:when test="${!empty success}">alert-success</c:when>
                                    <c:otherwise>alert-danger</c:otherwise>
                                </c:choose>">
                                    <a class="close" data-dismiss="alert" href="#">&times;</a> ${messageResponse}
                                </div>
                            </c:if>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="content.title"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.title" size="40" cssClass="form-control" id="title"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="authoring.template.title"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.authoringTemplate" id="authoringTemplateId" class="form-control">
                                            <option value="-1"><fmt:message key="label.all"/></option>
                                            <c:forEach items="${authoringTemplates}" var="authoringTemplate">
                                                <option value="${authoringTemplate.authoringTemplateId}" <c:if test="${authoringTemplate.authoringTemplateId == items.pojo.authoringTemplate.authoringTemplateId}">selected</c:if>>${authoringTemplate.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="content.keyword"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.keyword" size="40" cssClass="form-control" id="keyword"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="category.title"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.category.categoryId" id="contentCategoryId" class="form-control">
                                            <option value="-1"><fmt:message key="label.all"/></option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.categoryId}" <c:if test="${category.categoryId == items.categoryId}">selected</c:if>>
                                                    <c:forEach begin="1" end="${category.nodeLevel}">
                                                        - - -
                                                    </c:forEach>
                                                        ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="label.status"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.status" id="status" class="form-control">
                                            <option value="1" selected><fmt:message key="content.published"/></option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-12">
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <a class="btn btn-primary btnFilter"><fmt:message key="button.search"/></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="content.list"/>
                        </div>

                        <div class="panel-body" style="display: block;" id="content-selected">
                            <table width="100%" class="table table-bordered no-footer">
                                <thead>
                                <tr>
                                    <th style="width:20px;">#</th>
                                    <th style="width: 100px;"><fmt:message key="content.thumbnails"/></th>
                                    <th><fmt:message key="content.title.title"/></th>
                                    <th><fmt:message key="content.is.hot.product"/></th>
                                    <th><fmt:message key="content.published"/></th>
                                    <th><fmt:message key="content.published"/></th>
                                    <th style="width: 30px;"><fmt:message key="label.actions"/></th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <input class="btn btn-primary btn-update" type="button" value="<fmt:message key="button.update"/>"/>
                                    <a href="${backUrl}" class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="content.information"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <c:if test="${not empty messageResponse}">
                                <div class="alert alert-message
                                        <c:choose>
                                            <c:when test="${!empty success}">alert-success</c:when>
                                            <c:otherwise>alert-danger</c:otherwise>
                                        </c:choose>">
                                    <a class="close" data-dismiss="alert" href="#">&times;</a> ${messageResponse}
                                </div>
                            </c:if>

                            <table width="100%" class="table table-striped table-bordered table-hover no-footer" id="table-content-slide">
                                <thead>
                                <tr>
                                    <th style="width:20px;">#</th>
                                    <th style="width: 100px;"><fmt:message key="content.thumbnails"/></th>
                                    <th><fmt:message key="content.title.title"/></th>
                                    <th><fmt:message key="content.slider"/></th>
                                    <th><fmt:message key="content.is.hot.product"/></th>
                                    <th><fmt:message key="content.published"/></th>
                                    <th style="width: 30px;"><fmt:message key="label.actions"/></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="content" items="${item.listResult}">
                                    <tr>
                                        <td class="display-order">
                                            ${content.displayOrder}
                                        </td>
                                        <td>
                                            <c:if test="${not empty content.thumbnails}">
                                                <rep:href value="${content.thumbnails}" var="imgURL"/>
                                                <img src="<c:url value="${imgURL}?w=120"/>" style="max-width: 100px;max-height: 100px;" />
                                            </c:if>
                                        </td>
                                        <td>
                                            ${content.title}
                                            <input type="hidden" name="checkList" class="content-slide-select" value="${content.contentId}">
                                        </td>
                                        <td>
                                            <c:if test="${content.slide == 1}">
                                                <fmt:message key="content.slider"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${content.hotItem == 1}">
                                                <fmt:message key="content.is.hot.product"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${content.publishedDate}" pattern="dd-mm-yyyy"/>
                                        </td>
                                        <td><a class="btn btn-danger btn-remove"><i class="fa fa-remove"></i></a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
</form:form>

<script>
    $(document).ready(function(){
        enableReOrderRow();

        $('.btn-remove').each(function(){
            removeContentSlider($(this));
        });

        $('.btnFilter').on('click', function(){
            searchContentByProperties();
        });

        $('.btn-update').on('click', function(){
            $('#content-selected').find('tbody').empty();
            $('#crudaction').val("update-slide");
            $('#itemForm').submit();
        });
    });

    function searchContentByProperties(){
        $('#content-selected').find('tbody').empty();
        var listContent = [];
        $('#table-content-slide').find('input.content-slide-select').each(function(){
            listContent.push($(this).val());
        });

        var title = $('#title').val();
        var keyword = $('#keyword').val();
        var status = $('#status').val();
        var authoringTemplateId = $('#authoringTemplateId').val();
        var categoryId = $('#contentCategoryId').val();
        $.ajax({
            cache: false,
            type: "POST",
            dataType: 'HTML',
            data: {'title': title, 'keyword': keyword, 'status' : status, 'authoringTemplateId' : authoringTemplateId, 'categoryId' : categoryId, 'contentIds' : listContent.join(";")},
            url:  "<c:url value="/ajax/search-by-properties.html"/>",
            success: function(res){
                $('#content-selected').find('tbody').append(res);
                addContentSlideListen();
            }
        });
    }

    function removeContentSlider(element){
        $(element).on('click', function(){
            $(element).closest('tr').remove();
        });
    }

    function addContentSlideListen(){
        $('.btn-add').each(function(){
            addContentSlide($(this));
        }) ;
    }

    function addContentSlide(element){
        $(element).on('click', function(){
            var parent = $(element).closest('tr');
            var parentClone = $(parent).clone();
            $(parentClone).find('.btn-add').find('i').removeClass('fa-plus').addClass('fa-remove');
            $(parentClone).find('.btn-add').addClass('btn-remove').removeClass('btn-add');

            $("#table-content-slide").find('tbody').append($(parentClone));
            $(parent).remove();

            removeContentSlider($(parentClone).find('.btn-remove'));
            enableReOrderRow();
        });
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
                    $('td.display-order', ui.item.parent()).each(function (i) {
                        $(this).html(i + 1);
                    });
                };

        $("#table-content-slide tbody").sortable({
            helper: fixHelperModified,
            stop: updateIndex
        }).disableSelection();
    }


</script>

