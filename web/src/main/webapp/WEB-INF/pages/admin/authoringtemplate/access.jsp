<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="authoringtemplate.template"/></title>
    <meta name="heading" content="<fmt:message key="authoringtemplate.management"/>"/>
</head>
<script type="text/javascript" language="javascript" src="<c:url value="/scripts/authoringtemplate.js"/>"></script>
<c:url var="formUrl" value="/admin/authoringtemplate/access.html"/>
<c:url var="backUrl" value="/admin/authoringtemplate/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="authoringtemplate.template"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="authoringtemplate.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <fmt:message key="authoringtemplate.access"/>
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
                            Information
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

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="authoringtemplate.code"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.code}</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="authoringtemplate.name"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.name}</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <a id="btnSave" class="btn w-xs btn-primary"><fmt:message key="button.save"/></a>
                                    <a href="${backUrl}"class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-8">
                                    <input id="displayAll" name="displayAll" type="checkbox" <c:if test="${!empty displayAll and displayAll eq 'Y'}">checked="checked"</c:if> ><fmt:message key="label.display.all"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="usergroup_user">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.1s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="usergroup"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="userGroups" uid="userGroup" cellspacing="0" cellpadding="0"
                                               class="table table-striped table-bordered table-hover no-footer" export="false">
                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="#" >
                                        <input class="userGroupCheckbox" id="${userGroup.userGroupID}chkBox" type="checkbox" name="checkGroupList" value="${userGroup.userGroupID}" <c:if test="${!empty mapCheckedGroup[userGroup.userGroupID]}">checked="checked"</c:if> >
                                    </display:column>
                                    <display:column style="width: 48%" headerClass="table_header" property="code" titleKey="usergroup.code"></display:column>
                                    <display:column headerClass="table_header" property="name" titleKey="usergroup.name"></display:column>
                                </display:table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="user_area">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.1s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="user.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="users" uid="user" cellspacing="0" cellpadding="0"
                                               class="table table-striped table-bordered table-hover no-footer" export="false">
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
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.authoringTemplateID"/>
</form:form>


<script type="text/javascript">
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');
        $("#btnSave").click(function(){
            $("#crudaction").val("insert-update");
            $("#itemForm").submit();
        });
    });

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
