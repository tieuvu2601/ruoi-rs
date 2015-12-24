<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
	<style>
        .content-title{
            width: 20%;
            vertical-align: middle;
            text-align: right;
        }
        .customer-information{
            cursor: pointer;
        }
        .customer-information.selected{
            background-color: #dff0d8;
            color: #3c763d;
        }
	</style>
</head>

<c:url var="formUrl" value="/admin/content/send-email.html"/>
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
    <security:authorize ifAnyGranted="CUSTOMER,FULL_ACCESS_RIGHT">
        <div class="content animate-panel">
            <div>


                <div class="row">
                    <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                        <div class="hpanel">
                            <div class="panel-heading">
                                <div class="panel-tools">
                                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                                </div>
                                <fmt:message key="customer.list"/>
                            </div>

                            <div class="panel-body" style="display: block;">
                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label"><fmt:message key="customer.location"/></label>
                                        <div class="col-sm-8">
                                            <select id="customerLocation" class="form-control">
                                                <option value="-1"><fmt:message key="label.all"/></option>
                                                <c:forEach var="location" items="${locations}">
                                                    <option value="${locationId}">${location.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label"><fmt:message key="customer.full.name"/></label>
                                        <div class="col-sm-8">
                                            <input id="customerName" size="255" class="form-control"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label"><fmt:message key="customer.email"/></label>
                                        <div class="col-sm-8">
                                            <input id="customerEmail" size="100" class="form-control"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-5">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label"><fmt:message key="customer.phone.number"/></label>
                                        <div class="col-sm-8">
                                            <input id="customerPhoneNumber" size="255" class="form-control"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-10">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="customer.address"/></label>
                                        <div class="col-sm-10">
                                            <input id="customerAddress" size="255" class="form-control"/>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="col-sm-8 col-sm-offset-4">
                                            <a class="btn btn-primary btnFilter"><i class="fa fa-search"></i> <fmt:message key="button.search"/></a>
                                            <a class="btn btn-danger btnReset"><i class="fa fa-refresh"></i> <fmt:message key="button.reset"/></a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel-body"  style="display: block;" id="customer-container">

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
                                <fmt:message key="content.customer.list"/>
                            </div>

                            <div class="panel-body" style="display: block;" id="customer-selected">
                                <table width="100%" class="table table-bordered no-footer">
                                    <thead>
                                        <tr >
                                            <th style="width: 5%">#</th>
                                            <th style="width: 15%"><fmt:message key="customer.full.name"/></th>
                                            <th style="width: 15%"><fmt:message key="customer.email"/></th>
                                            <th style="width: 15%"><fmt:message key="customer.phone.number"/></th>
                                            <th style="width: 30%"><fmt:message key="customer.address"/></th>
                                            <th style="width: 20%"><fmt:message key="customer.location"/></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <input class="btn btn-success btn-send-email" type="button" value="<fmt:message key="button.send"/>"/>
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

                                <table width="100%" class="table table-striped table-bordered table-hover no-footer">
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.title.title"/></td>
                                        <td class="content-content">${item.pojo.title}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.header"/></td>
                                        <td class="content-content">${item.pojo.header}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.keyword"/></td>
                                        <td class="content-content">${item.pojo.keyword}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.description"/></td>
                                        <td class="content-content">${item.pojo.description}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.thumbnails"/></td>
                                        <td class="content-content">
                                            <rep:href value="${item.pojo.thumbnails}" var="imgURL"/>
                                            <label class="col-sm-12 control-label text-default"><img src="<c:url value="${imgURL}"/>?w=120"/></label>
                                        </td>
                                    </tr>

                                    <c:if test="${item.pojo.authoringTemplate.areProduct == 1}">
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.location.text"/></td>
                                            <td class="content-content">${item.pojo.locationText}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.location"/></td>
                                            <td class="content-content">${item.pojo.location.name}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.area"/></td>
                                            <td class="content-content">${item.pojo.area}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.total.area"/></td>
                                            <td class="content-content">${item.pojo.totalArea}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.area.ratio"/></td>
                                            <td class="content-content">${item.pojo.areaRatio}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.number.of.block"/></td>
                                            <td class="content-content">${item.pojo.numberOfBlock}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.cost"/></td>
                                            <td class="content-content">${item.pojo.cost}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.is.hot.product"/></td>
                                            <td class="content-content">${item.pojo.hotItem}</td>
                                        </tr>
                                        <tr>
                                            <td class="content-title"><fmt:message key="content.is.new.product"/></td>
                                            <td class="content-content">${item.pojo.productStatus}</td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </security:authorize>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentId"/>
</form:form>
<script>
    $(document).ready(function(){
        $('.btnFilter').on('click', function(){
            loadCustomerForSendEmail();
        });

        $('.btnReset').on('click', function(){
            resetCustomerFilter();
        });
        $('.btn-send-email').on('click', function(){
            $('#crudaction').val("send-email");
            $('#itemForm').submit();
        });

    });

    function loadCustomerForSendEmail(){
        var email = $('#customerEmail').val();
        var fullName = $('#customerName').val();
        var phoneNumber = $('#customerPhoneNumber').val();
        var address = $('#customerAddress').val();
        var locationId = $('#customerLocation').val();
        var listCustomer = [];
        $('#customer-selected').find('.customer-information').find('input.customer-selected').each(function(){
           listCustomer.push($(this).val());
        });
        $('#customer-container').empty();
        $.ajax({
            cache: false,
            type: "POST",
            dataType: 'HTML',
            data: {'email': email, 'fullName': fullName, 'phoneNumber': phoneNumber, 'address': address, 'locationId': locationId, 'listCustomer' : listCustomer.join(";")},
            url:  "<c:url value="/ajax/load-customer-for-send-email.html"/>",
            success: function(res){
                $('#customer-container').html(res);
                selectedCustomer();
            }
        });
    }

    function resetCustomerFilter(){
        $('#customerEmail').val("");
        $('#customerName').val("");
        $('#customerPhoneNumber').val("");
        $('#customerAddress').val("");
        $('#customerLocation').val("-1");
    }

    function submitContentForm(crudaction) {
        $('#crudaction').val(crudaction);
        $('#itemForm').submit();
    }

    function selectedCustomer(){
        $('.customer-information').on('click', function(){
            if($(this).hasClass('selected')){
                 removeCustomer($(this).attr("customerId"));
            } else {
                $(this).addClass('selected');
                $(this).find('.select-customer').find('i').removeClass('fa-square-o').addClass('fa-check-square-o');

                var customerSelected = $(this).clone();
                $(customerSelected).append($('<input type="hidden" class="customer-selected" name="checkList" value="'+ $(this).attr("customerId") +'">'));
                $(customerSelected).removeClass('selected');
                $(customerSelected).find('.select-customer').find('i').removeClass('fa-check-square-o').addClass('fa-times');
                $('#customer-selected').find('table').find('tbody').append($(customerSelected));

                removeCustomerSelected($(customerSelected).find('.select-customer'));
            }
        });
    }

    function removeCustomerSelected(element){
        $(element).on('click', function(){
            var customer = $(element).closest('.customer-information');
            removeCustomer($(customer).attr("customerId"));
        });
    }

    function removeCustomer(customerId){
        var customerSelected = $('#customer-selected').find('.customer-information[customerId="' + customerId +'"]');
        var customer = $('#customer-container').find('.customer-information[customerId="' + customerId +'"]');


        if($(customerSelected) != null && $(customerSelected) != undefined && $(customerSelected).length > 0){
            $(customerSelected).remove();
        }

        if($(customer) != null && $(customer) != undefined && $(customer).length > 0){
            $(customer).removeClass('selected');
            $(customer).find('.select-customer').find('i').removeClass('fa-check-square-o').addClass('fa-square-o');
        }
    }
</script>

