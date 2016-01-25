<%@ include file="/common/taglibs.jsp" %>
<div class="cd-user-modal">
    <div class="cd-user-modal-container">
        <ul class="cd-switcher">
            <li><a href="javascript:void(0);">Login</a></li>
            <li><a href="javascript:void(0);"><fmt:message key="site.register.get.email"/></a></li>
        </ul>

        <div id="cd-login">
            <form action="<c:url value="/j_security_check"/>" id="loginForm" class="sky-form" novalidate="novalidate">
                <fieldset>
                    <section>
                        <div class="row">
                            <label class="label col col-4">Username</label>
                            <div class="col col-8">
                                <label class="input">
                                    <i class="icon-append fa fa-user"></i>
                                    <input type="text" name="j_username">
                                </label>
                            </div>
                        </div>
                    </section>

                    <section>
                        <div class="row">
                            <label class="label col col-4">Password</label>
                            <div class="col col-8">
                                <label class="input">
                                    <i class="icon-append fa fa-lock"></i>
                                    <input type="password" name="j_password">
                                </label>
                            </div>
                        </div>
                    </section>

                    <section>
                        <div class="row">
                            <div class="col col-4"></div>
                            <div class="col col-8">
                                <label class="checkbox"><input type="checkbox" name="remember" checked=""><i></i>Keep me logged in</label>
                            </div>
                        </div>
                    </section>
                </fieldset>
                <footer>
                    <button type="submit" class="btn-u" onclick="$('#loginForm').submit();">Log in</button>
                </footer>
            </form>
        </div>

        <div id="cd-signup">
            <c:url var="customerFormUrl" value="/register-customer.html"/>
            <fmt:message var="customerFullNameLabel" key="customer.full.name"/>
            <fmt:message var="customerEmalLabel" key="customer.email"/>
            <fmt:message var="customerPhoneNumberLabel" key="customer.phone.number"/>
            <fmt:message var="customerAddressLabel" key="customer.address"/>

            <form:form commandName="customerForm" action="${customerFormUrl}" method="post" id="registerForm" cssClass="sky-form register-form">
                <fieldset>
                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-user"></i>
                            <form:input path="pojo.fullName" class="required-field cus-fullName"  placeholder="${customerFullNameLabel}"></form:input>
                            <b class="tooltip tooltip-bottom-right">Needed to enter your name</b>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-envelope"></i>
                            <form:input path="pojo.email" class="required-field cus-email cus-email-field" placeholder="${customerEmalLabel}"></form:input>
                            <b class="tooltip tooltip-bottom-right">Needed to verify your email</b>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-phone"></i>
                            <form:input path="pojo.phoneNumber" class="cus-phoneNumber" placeholder="${customerPhoneNumberLabel}"></form:input>
                            <b class="tooltip tooltip-bottom-right">Needed to enter your phone number</b>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-map-marker"></i>
                            <form:input path="pojo.address" class="cus-address" placeholder="${customerAddressLabel}"></form:input>
                            <b class="tooltip tooltip-bottom-right">Needed to enter your address</b>
                        </label>
                    </section>

                    <section>
                        <label class="select">
                            <form:select path="pojo.location.locationId" cssClass="required-field cus-fullName" cssStyle="padding: 5px 10px;">
                                <option value="" selected="" disabled=""><fmt:message key="location.title"/></option>
                                <content:getLocations var="locations"/>
                                <oscache:cache key="locations_items_register" duration="1">
                                    <c:forEach var="location" items="${locations}">
                                        <option value="${location.locationId}">${location.name}</option>
                                    </c:forEach>
                                </oscache:cache>
                            </form:select>
                        </label>
                    </section>
                </fieldset>

                <footer>
                    <a class="btn-u" id="register-customer-btn">Register</a>
                </footer>
                <form:hidden path="crudaction" cssClass="crudaction"/>
            </form:form>
            <a href="javascript:void(0);" class="cd-close-form">Close</a>
        </div>
    </div>
</div>