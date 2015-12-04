<%@ include file="/common/taglibs.jsp"%>

<div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.1s;">
    <div class="hpanel">
        <div class="panel-heading">
            <div class="panel-tools">
                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
            </div>
            <fmt:message key="user.title"/>
        </div>
        <div class="panel-body">
            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                <display:table name="users" uid="user" cellspacing="0" cellpadding="0"
                               class="table table-striped table-bordered table-hover no-footer" export="false">
                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheckUser\" id=\"allCheckUser\" onclick=\"checkAll('itemForm', 'checkUserList', this)\">">
                        <input type="checkbox" name="checkUserList" value="${user.userID}"
                               <c:if test="${mapCheckedUser[user.userGroup.userGroupID] eq 'disabled'}">checked="checked" disabled="disabled"</c:if>
                               <c:if test="${mapCheckedUser[user.userID] eq 'edit'}">checked="checked"</c:if>
                                >
                    </display:column>
                    <display:column style="width: 48%" headerClass="table_header" property="username" titleKey="user.username"></display:column>
                    <display:column headerClass="table_header" property="displayName" titleKey="user.displayname"></display:column>
                </display:table>
            </div>
        </div>
    </div>
</div>