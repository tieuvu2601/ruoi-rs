<%@ include file="/common/taglibs.jsp" %>
<section id="footer-v7" class="contacts-section custom-footer">
    <div class="container content-lg">
        <div class="row contacts-in">
            <div class="col-md-7 md-margin-bottom-20">
                <ul class="list-unstyled">
                    <li><i class="fa fa-home"></i> <a href="<c:url value="/index.html"/>" style="color: #68af28; font-size: 110%"><fmt:message key="site.footer.company"/></a></li>
                    <li><i class="fa fa-map-marker"></i> <fmt:message key="site.footer.address"/></li>
                    <li><i class="fa fa-phone"></i> <fmt:message key="site.author.phonenumber"/></li>
                    <li><i class="fa fa-envelope"></i> <a href="mailto:<fmt:message key="site.author.email"/>?subject=T%C6%B0%20v%E1%BA%A5n%20v%E1%BB%81%20d%E1%BB%B1%20%C3%A1n%20b%E1%BA%A5t%20%C4%91%E1%BB%99ng%20s%E1%BA%A3n"><fmt:message key="site.author.email"/></a></li>
                    <%--<li><i class="fa fa-globe"></i> <a href="http://htmlstream.com/">www.htmlstream.com</a></li>--%>
                </ul>
            </div>

            <div class="col-md-5">
                <c:url var="customerFormUrl" value="/register-customer.html"/>
                <form:form commandName="customerForm" action="${customerFormUrl}" method="post" id="registerFormFooter" cssClass="sky-form contact-style register-form">
                    <fieldset style="padding: 0px;">
                        <label><fmt:message key="customer.full.name"/> <span class="color-red">*</span></label>
                        <div class="row">
                            <div class="col-md-10 margin-bottom-10 col-md-offset-0">
                                <div>
                                    <form:input path="pojo.fullName" class="required-field cus-fullName"></form:input>
                                </div>
                            </div>
                        </div>

                        <label><fmt:message key="customer.email"/> <span class="color-red">*</span></label>
                        <div class="row">
                            <div class="col-md-10 margin-bottom-10 col-md-offset-0">
                                <div>
                                    <form:input path="pojo.email" class="required-field cus-email cus-email-field"></form:input>
                                </div>
                            </div>
                        </div>

                        <label><fmt:message key="customer.phone.number"/></label>
                        <div class="row">
                            <div class="col-md-10 margin-bottom-10 col-md-offset-0">
                                <div>
                                    <form:input path="pojo.phoneNumber" class="cus-phoneNumber"></form:input>
                                </div>
                            </div>
                        </div>

                        <label><fmt:message key="customer.address"/></label>
                        <div class="row">
                            <div class="col-md-10 margin-bottom-10 col-md-offset-0">
                                <div>
                                    <form:input path="pojo.address" class="cus-address"></form:input>
                                </div>
                            </div>
                        </div>

                        <label><fmt:message key="customer.location"/> <span class="color-red">*</span></label>
                        <div class="row">
                            <div class="col-md-10 margin-bottom-20 col-md-offset-0">
                                <div>
                                    <form:select path="pojo.location.locationId" cssClass="required-field cus-fullName">
                                        <content:getLocations var="locations"/>
                                        <oscache:cache key="locations_items_register" duration="1">
                                            <c:forEach var="location" items="${locations}">
                                                <option value="${location.locationId}" style="background: rgba(0,0,0,0.7) !important; color: #fff">${location.name}</option>
                                            </c:forEach>
                                        </oscache:cache>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <p><a class="btn-u btn-brd btn-brd-hover btn-u-dark" id="register-customer-footer-btn">Register</a></p>
                    </fieldset>
                    <form:hidden path="crudaction" cssClass="crudaction"/>
                </form:form>
            </div>
        </div>
    </div>
</section>
