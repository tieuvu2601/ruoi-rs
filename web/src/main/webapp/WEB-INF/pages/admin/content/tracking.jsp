<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="tracking.management"/></title>
    <meta name="heading" content="<fmt:message key="tracking.management"/>"/>
</head>
<div class="pathway">
    <fmt:message key="tracking"/> ${content.title}
</div>

<c:url var="url" value="/admin/content/tracking.html?contentID=${content.contentID}"/>
<c:url var="editUrl" value="/admin/tracking/edit.html"/>
<div id="content">
    <form:form commandName="items" action="${url}" method="post" id="listForm">

        <div class="box_container">
            <div class="header">
                <fmt:message key="button.search" />
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="fromDate" /></td>
                        <td><input type="text" name="fromDate" id="fromDate" value='<fmt:formatDate value="${items.fromDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
                        <td><fmt:message key="toDate" /></td>
                        <td><input type="text" name="toDate" id="toDate" value='<fmt:formatDate value="${items.toDate }" pattern="dd/MM/yyyy"/>' size="10" maxlength="10" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <form:hidden path="crudaction" id="crudaction" value="search"/>
                            <input type="button" value="<fmt:message key="button.search"/>" onclick="$('#listForm').submit();"/>
                        </td>
                    </tr>
                </table>
            </div>

        </div>

        <br/>
         <div class="box_container" >

            <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}" class="table bright_blue_body" export="false">

                <display:column headerClass="table_header" property="likes" escapeXml="true" sortable="true" sortName="likes" titleKey="tracking.liked" style="width: 30%"/>
                <display:column headerClass="table_header" property="views" escapeXml="true" sortable="true" sortName="views" titleKey="tracking.views" style="width: 30%"/>
                <display:column headerClass="table_header" property="trackingDate" sortable="true" sortName="trackingDate" titleKey="trackingDate" style="width: 20%" format="{0,date,dd/MM/yyyy}"/>

                <display:setProperty name="paging.banner.item_name"><fmt:message key="tracking"/></display:setProperty>
                <display:setProperty name="paging.banner.items_name"><fmt:message key="tracking"/></display:setProperty>
                <display:setProperty name="paging.banner.placement" value="bottom"/>
                <display:setProperty name="paging.banner.no_items_found" value=""/>
                <display:setProperty name="paging.banner.onepage" value=""/>
            </display:table>
            <div class="clear"></div>
        </div>
    </form:form>
</div>

<script type="text/javascript">
	<c:if test="${not empty items.crudaction}">
    	highlightTableRows("tableList");
    </c:if>
    $(function() {
    	$("#deleteConfirmLink").click(function() {
        	$('#crudaction').val('delete');
    		document.forms['listForm'].submit();
    	});
    	$('a[name="deleteLink"]').click(function(eventObj) {
       		//document.location.href = eventObj.target.href;
       		return true;

        });

    });
    function confirmDeleteItem(){
    	var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
		if(fb) {
			$("#deleteConfirmLink").trigger('click');
		}else {
			$("#hidenWarningLink").trigger('click');
		}
    }

    <%--$(document).ready(function() {--%>
        <%--$("#fromDate" ).datepicker({--%>
                <%--showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>',--%>
                <%--dateFormat : 'dd/mm/yy'--%>

        <%--});--%>
        <%--$("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });--%>

    <%--});--%>


</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#fromDate" ).datepicker({showOn: "button", buttonImageOnly: true, buttonImage: '/themes/vms/images/iconCalendar.png', dateFormat : 'dd/mm/yy'});
        $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '/themes/vms/images/iconCalendar.png', dateFormat:'dd/mm/yy' });
    });


</script>