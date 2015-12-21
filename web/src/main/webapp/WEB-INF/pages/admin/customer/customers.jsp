<%@ include file="/common/taglibs.jsp"%>
<c:choose>
    <c:when test="${fn:length(customers) > 0}">
        <table width="100%" class="table table-bordered no-footer">
            <tr >
                <th style="width: 5%">#</th>
                <th style="width: 15%"><fmt:message key="customer.full.name"/></th>
                <th style="width: 15%"><fmt:message key="customer.email"/></th>
                <th style="width: 15%"><fmt:message key="customer.phone.number"/></th>
                <th style="width: 30%"><fmt:message key="customer.address"/></th>
                <th style="width: 20%"><fmt:message key="customer.location"/></th>
            </tr>
            <c:forEach var="customer" items="${customers}">
                <tr class="customer-information" customerId="${customer.customerId}">
                    <td><a class="select-customer" style="size: 120%"><i class="fa fa-square-o"></i></a></td>
                    <td>${customer.fullName}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phoneNumber}</td>
                    <td>${customer.address}</td>
                    <td>${customer.location.name}</td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        Customer not found!
    </c:otherwise>
</c:choose>
<script type='text/javascript'>
    $(document).ready(function(){
    });
</script>

