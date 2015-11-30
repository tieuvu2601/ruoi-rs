<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="report.by.like.management"/></title>
    <meta name="heading" content="<fmt:message key="report.by.like.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="report.by.like.management"/>
</div>

<c:url var="url" value="/admin/report/userlike.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="button.search" />
            </div>
            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                	<tr>
                		<td><fmt:message key="label.top.like" /></td>
                		<td>
                			<select name="top">
                				<option value=""><fmt:message key="label.all"/></option>
                				<option value="5" <c:if test="${items.top eq 5}">selected="selected"</c:if>>5</option>
                				<option value="10" <c:if test="${items.top eq 10}">selected="selected"</c:if>>10</option>
                				<option value="15" <c:if test="${items.top eq 15}">selected="selected"</c:if>>15</option>
                				<option value="20" <c:if test="${items.top eq 20}">selected="selected"</c:if>>20</option>
                			</select>
                		</td>
                		<td></td>
                		<td></td>
                	</tr>
                    <tr>
                        <td><fmt:message key="fromDate" /></td>
                        <td><input type="text" name="fromDate" id="fromDate" value='<fmt:formatDate value="${items.fromDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
                        <td><fmt:message key="toDate" /></td>
                        <td><input type="text" name="toDate" id="toDate" value='<fmt:formatDate value="${items.toDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <form:hidden path="crudaction" id="crudaction" value="do-report"/>
                            <input type="button" value="<fmt:message key="button.search"/>" onclick="$('#listForm').submit();"/>
                            <c:if test="${not empty items.totalItems && items.totalItems > 0}">
                                <fmt:formatDate value='${items.fromDate}' pattern='dd/MM/yyyy' var="fromDate"/>
                                <fmt:formatDate value='${items.toDate}' pattern='dd/MM/yyyy' var="toDate"/>
                                <c:url var="export2ExcelURL" value="/admin/report/export/userlike.html">
                                    <c:param name="fromDate" value="${fromDate}"/>
                                    <c:param name="toDate" value="${toDate}"/>
                                    <c:param name="top" value="${items.top}"/>
                                </c:url>
                				<input type="button" value="<fmt:message key="button.export"/>" onclick="window.open('${export2ExcelURL}');"/>
							</c:if>
                        </td>
                    </tr>
                </table>
            </div>

        </div>

        <br/>
        <c:if test="${not empty items.crudaction}">
         <div class="box_container" >

            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                partialList="true" sort="external" size="${items.totalItems}" defaultsort="3" defaultorder="descending" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false">

                <display:column headerClass="table_header" sortable="true" sortName="title" titleKey="content.title">
                	<c:url value="/admin/content/view.html" var="viewUrl">
	               		<c:param name="pojo.contentID" value="${tableList.contentID }"></c:param>
	               	</c:url>
                	<a href="${viewUrl}">${tableList.title }</a>
                </display:column>
                <display:column headerClass="table_header" property="author" sortable="false" sortName="author" title="report.author" style="width: 7%"/>
                <display:column headerClass="table_header" property="views" sortable="true" sortName="views" titleKey="tracking.views" style="width: 7%"/>
                <display:column headerClass="table_header" property="likes" sortable="true" sortName="likes" titleKey="tracking.liked" style="width: 7%"/>
                <display:column headerClass="table_header" property="comments" sortable="true" sortName="comments" titleKey="comment" style="width: 7%"/>
                <display:column headerClass="table_header" titleKey="content.thumbnail" style="width: 10%">
                     <c:if test="${not empty tableList.thumbnail}">
                        <rep:href value="${tableList.thumbnail}" var="imgURL"/>
                        <img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px;max-height: 100px;"/>
                     </c:if>
                 </display:column>
                <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 10%" format="{0,date,dd/MM/yyyy}"/>
                <display:column headerClass="table_header" property="publishedDate" sortable="true" sortName="publishedDate" titleKey="content.published.date" style="width: 10%" format="{0,date,dd/MM/yyyy}"/>

                <display:setProperty name="paging.banner.item_name"><fmt:message key="tracking"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="tracking"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
                <display:setProperty name="paging.banner.onepage" value=""/>
            </display:table>
            <div class="clear"></div>
        </div>
        </c:if>
    </form:form>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $("#fromDate" ).datepicker({showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat : 'dd/mm/yy'});
        $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });
    });


</script>
