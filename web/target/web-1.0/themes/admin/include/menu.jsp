<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<div class="navigation">
    <ul id="nav">
        <security:authorize ifAllGranted="AUTHORING_TEMPLATE">
            <li><a class="first" href="<c:url value="/admin/authoringtemplate/list.html"/>"><fmt:message key="menu.authoringtemplate"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="CATEGORY">
            <li><a class="first" href="<c:url value="/admin/category/list.html"/>" ><fmt:message key="menu.category"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="CONTENT">
            <li><a class="first" href="<c:url value="/admin/content/list.html"/>" ><fmt:message key="menu.content"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="DEPARTMENT">
            <li><a class="first" href="<c:url value="/admin/department/list.html"/>" ><fmt:message key="menu.department"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="RENDERING_TEMPLATE">
            <li><a class="first" href="<c:url value="/admin/renderingtemplate/list.html"/>" ><fmt:message key="menu.renderingtemplate"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="ROLE">
            <li><a class="first" href="<c:url value="/admin/role/list.html"/>" ><fmt:message key="menu.role"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="USER">
            <li><a class="first" href="<c:url value="/admin/user/list.html"/>" ><fmt:message key="menu.user"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="USERGROUP">
            <li><a class="first" href="<c:url value="/admin/usergroup/list.html"/>" ><fmt:message key="menu.usergroup"/></a></li>
        </security:authorize>
        <security:authorize ifAllGranted="CONTENT">
            <li><a class="first" href="#" ><fmt:message key="menu.feedback"/></a>
                <ul class="child">
                    <li><a href="<c:url value="/admin/feedbackcategory/list.html"/>"><fmt:message key="menu.feedbackcategory"/></a></li>
                    <li><a href="<c:url value="/admin/feedback/list.html"/>"><fmt:message key="menu.feedback"/></a></li>
                </ul>
            </li>
        </security:authorize>
        <security:authorize ifAllGranted="CONTENT">
            <li><a class="first" href="<c:url value="/admin/content/updateAds.html"/>" ><fmt:message key="menu.updateAds"/></a></li>
        </security:authorize>
        <li>
        	<a class="first" href="#" ><fmt:message key="report"/></a>
        	<ul class="child">
				<li><a href="<c:url value="/admin/report/posttime.html"/>"><fmt:message key="report.by.posttime"/></a></li>
				<li><a href="<c:url value="/admin/report/department.html"/>"><fmt:message key="report.by.department"/></a></li>
				<li><a href="<c:url value="/admin/report/accessview.html"/>"><fmt:message key="report.by.access"/></a></li>
				<li><a href="<c:url value="/admin/report/userlike.html"/>"><fmt:message key="report.by.like"/></a></li>
				<li><a href="<c:url value="/admin/report/comment.html"/>"><fmt:message key="report.by.vote"/></a></li>
			</ul>
        </li>
    </ul>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#nav li").has("ul").hover(function(){
		$(this).addClass("current").children("ul").fadeIn();
	}, function() {
		$(this).removeClass("current").children("ul").hide();
	});
});
</script>
