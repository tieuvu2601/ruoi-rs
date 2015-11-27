<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="opinion.title"/></title>
    <meta name="heading" contentEntity="Category Management"/>
</head>
<c:url var="formUrl" value="/dong-gop-y-kien.html"/>
<c:url var="backUrl" value="/"/>
<div class="contentEntity container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left"><fmt:message key="site.opinion"/></h1>
        </header>
        <div class="page-contentEntity">
            <div class="row">
                <article class="contact-form col-md-8 col-sm-7  page-row">
                    <fmt:message key="site.opinion.description"/>
                    <form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="">
                        <div class="form-group name">
                            <label for="name"><fmt:message key="site.opinion.name"/><span class="required">*</span></label>
                            <form:input id="name" path="pojo.userName" cssClass="form-control" placeholder="Enter your name"/>
                            <form:errors path="pojo.userName" cssClass="validateError"/>
                        </div>

                        <div class="form-group name">
                            <label for="email"><fmt:message key="site.opinion.email"/><span class="required">*</span></label>
                            <form:input id="email" path="pojo.email" cssClass="form-control" placeholder="Enter your email"/>
                            <form:errors path="pojo.email" cssClass="validateError"/>
                        </div>

                        <div class="form-group name">
                            <label for="phoneNumber"><fmt:message key="site.opinion.phone.number"/></label>
                            <form:input id="phoneNumber" path="pojo.phoneNumber" cssClass="form-control" placeholder="Enter your phone number"/>
                            <form:errors path="pojo.phoneNumber" cssClass="validateError"/>
                        </div>

                        <div class="form-group">
                            <label for="title"><fmt:message key="site.opinion.title"/><span class="required">*</span></label>
                            <form:input id="title" path="pojo.title" cssClass="form-control" placeholder="Enter the title"/>
                            <form:errors path="pojo.title" cssClass="validateError"/>
                        </div>

                        <div class="form-group message">
                            <label for="description"><fmt:message key="site.opinion.contentEntity"/><span class="required">*</span></label>
                            <form:textarea id="description" path="pojo.description" cssClass="form-control" rows="10" />
                            <form:errors path="pojo.description" cssClass="validateError"/>
                        </div>
                        <a class="btn btn-theme" id="btnSave"><fmt:message key="site.opinion.send.button"/></a>
                        <form:hidden path="crudaction" id="crudaction"/>
                    </form:form>
                </article>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $("#btnSave").click(function(){
            if(validatorForm()){
                $("#crudaction").val("insert");
                $("#itemForm").submit();
            }

        });
    });
    function validatorForm(){
        var isValid = true;
        var userName = $('#name');
        var email = $('#email');
        var title = $('#title');
        var description = $('#description');

        if($(userName).val() == ''){
            $(userName).addClass('error');
            isValid = false;
        } else {
            $(userName).removeClass('error');
        }

        if($(email).val() == ''){
            $(email).addClass('error');
            isValid = false;
        } else {
            $(email).removeClass('error');
        }

        if($(title).val() == ''){
            $(title).addClass('error');
            isValid = false;
        } else {
            $(title).removeClass('error');
        }

        if($(description).val() == ''){
            $(description).addClass('error');
            isValid = false;
        } else {
            $(description).removeClass('error');
        }
        return isValid;
    }
</script>