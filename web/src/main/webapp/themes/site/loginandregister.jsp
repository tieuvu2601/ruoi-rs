<%@ include file="/common/taglibs.jsp" %>
<div class="cd-user-modal"> <!-- this is the entire modal form, including the background -->
    <div class="cd-user-modal-container"> <!-- this is the container wrapper -->
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
                            <%--<input type="text" name="item.pojo.fullName" class="required-field cus-fullName">--%>
                                <%--<b class="tooltip tooltip-bottom-right">Needed to enter the website</b>--%>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-envelope"></i>
                            <form:input path="pojo.email" class="required-field cus-email" placeholder="${customerEmalLabel}"></form:input>

                            <%--<input type="text" name="item.pojo.email" placeholder="<fmt:message key="customer.email"/>" class="required-field cus-email">--%>
                                <%--<b class="tooltip tooltip-bottom-right">Needed to verify your account</b>--%>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-phone"></i>
                            <form:input path="pojo.phoneNumber" class="required-field cus-phoneNumber" placeholder="${customerPhoneNumberLabel}"></form:input>

                            <%--<input type="text" name="item.pojo.phoneNumber" class="cus-phoneNumber"  placeholder="<fmt:message key="customer.phone.number"/>">--%>
                                <%--<b class="tooltip tooltip-bottom-right">Needed to verify your account</b>--%>
                        </label>
                    </section>

                    <section>
                        <label class="input">
                            <i class="icon-append fa fa-map-marker"></i>
                            <form:input path="pojo.address" class="required-field cus-address" placeholder="${customerAddressLabel}"></form:input>

                            <%--<input type="text" name="item.pojo.address" class="cus-address"  placeholder="<fmt:message key="customer.address"/>">--%>
                                <%--<b class="tooltip tooltip-bottom-right">Needed to verify your account</b>--%>
                        </label>
                    </section>

                    <section>
                        <label class="select">
                            <form:select path="pojo.location.locationId" class="required-field cus-fullName">
                                <option value="" selected="" disabled=""><fmt:message key="location.title"/></option>
                                <content:getLocations var="locations"/>
                                <oscache:cache key="locations_items_register" duration="1">
                                    <c:forEach var="location" items="${locations}">
                                        <option value="${location.locationId}">${location.name}</option>
                                    </c:forEach>
                                </oscache:cache>
                            </form:select>


                            <%--<select class="cus-location" name="item.pojo.location.locationId">--%>
                                <%--<option value="" selected="" disabled=""><fmt:message key="location.title"/></option>--%>
                                <%--<c:forEach var="location" items="${locations}">--%>
                                    <%--<option value="${location.locationId}">${location.name}</option>--%>
                                <%--</c:forEach>--%>
                            <%--</select>--%>
                        </label>
                    </section>
                </fieldset>

                <footer>
                    <button class="btn-u" id="register-customer-btn">Register</button>
                </footer>
                <form:hidden path="crudaction" cssClass="crudaction"/>
            </form:form>

            <a href="javascript:void(0);" class="cd-close-form">Close</a>
        </div>
    </div>
</div>