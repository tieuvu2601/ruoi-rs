<%@ include file="/common/taglibs.jsp" %>
<div class="cd-user-modal"> <!-- this is the entire modal form, including the background -->
    <div class="cd-user-modal-container"> <!-- this is the container wrapper -->
        <ul class="cd-switcher">
            <li><a href="javascript:void(0);">Login</a></li>
            <li><a href="javascript:void(0);"><fmt:message key="site.register.get.email"/></a></li>
        </ul>

        <div id="cd-login"> <!-- log in form -->
            <form class="cd-form" action="<c:url value="/j_security_check"/>" method="post" id="loginForm">
                <%--<p class="social-login">--%>
                    <%--<span class="social-login-facebook"><a href="#"><i class="fa fa-facebook"></i> Facebook</a></span>--%>
                    <%--<span class="social-login-google"><a href="#"><i class="fa fa-google"></i> Google</a></span>--%>
                    <%--<span class="social-login-twitter"><a href="#"><i class="fa fa-twitter"></i> Twitter</a></span>--%>
                <%--</p>--%>

                <%--<div class="lined-text"><span>Or use your account on Blog</span><hr></div>--%>

                <p class="fieldset">
                    <label class="image-replace cd-username" for="signin-email">Username</label>
                    <input name="j_username" class="full-width has-padding has-border" id="signin-email" type="text" placeholder="Username">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace cd-password" for="signin-password">Password</label>
                    <input name="j_password" class="full-width has-padding has-border" id="signin-password" type="password"  placeholder="Password">
                    <a href="javascript:void(0);" class="hide-password">Show</a>
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <input type="checkbox" id="remember-me" checked>
                    <label for="remember-me">Remember me</label>
                </p>

                <p class="fieldset">
                    <input class="full-width" type="submit" value="Login" onclick="$('#loginForm').submit();"/>
                </p>
            </form>

            <p class="cd-form-bottom-message"><a href="javascript:void(0);">Forgot your password?</a></p>
            <!-- <a href="javascript:void(0);" class="cd-close-form">Close</a> -->
        </div> <!-- cd-login -->

        <div id="cd-signup"> <!-- sign up form -->
            <form class="cd-form">
                <%--<p class="social-login">--%>
                    <%--<span class="social-login-facebook"><a href="#"><i class="fa fa-facebook"></i> Facebook</a></span>--%>
                    <%--<span class="social-login-google"><a href="#"><i class="fa fa-google"></i> Google</a></span>--%>
                    <%--<span class="social-login-twitter"><a href="#"><i class="fa fa-twitter"></i> Twitter</a></span>--%>
                <%--</p>--%>

                <%--<div class="lined-text"><span>Or register your new account on Blog</span><hr></div>--%>

                <p class="fieldset">
                    <label class="image-replace cd-username" for="signup-username"><fmt:message key="customer.full.name"/></label>
                    <input class="full-width has-padding has-border" id="signup-username" type="text" placeholder="<fmt:message key="customer.full.name"/>">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace cd-email" for="signup-email">E-mail</label>
                    <input class="full-width has-padding has-border" id="signup-email" type="email" placeholder="E-mail">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="image-replace " for="signup-phone"><i class="fa fa-phone"></i></label>
                    <input class="full-width has-padding has-border" id="signup-phone" type="phone" placeholder="<fmt:message key="customer.phone.number"/>">
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <label class="" for="signup-location"></label>
                    <select class="full-width has-padding has-border" id="signup-location">
                        <option>Location 1</option>
                        <option>Location 2</option>
                        <option>Location 3</option>
                        <option>Location 4</option>
                    </select>
                    <span class="cd-error-message">Error message here!</span>
                </p>

                <p class="fieldset">
                    <input type="checkbox" id="accept-terms">
                    <label for="accept-terms">I agree to the <a href="javascript:void(0);">Terms</a></label>
                </p>

                <p class="fieldset">
                    <input class="full-width has-padding" type="submit" value="Create account">
                </p>
            </form>

            <a href="javascript:void(0);" class="cd-close-form">Close</a>
        </div> <!-- cd-signup -->

        <%--<div id="cd-reset-password"> <!-- reset password form -->--%>
            <%--<p class="cd-form-message">Lost your password? Please enter your email address. You will receive a link to create a new password.</p>--%>

            <%--<form class="cd-form">--%>
                <%--<p class="fieldset">--%>
                    <%--<label class="image-replace cd-email" for="reset-email">E-mail</label>--%>
                    <%--<input class="full-width has-padding has-border" id="reset-email" type="email" placeholder="E-mail">--%>
                    <%--<span class="cd-error-message">Error message here!</span>--%>
                <%--</p>--%>

                <%--<p class="fieldset">--%>
                    <%--<input class="full-width has-padding" type="submit" value="Reset password">--%>
                <%--</p>--%>
            <%--</form>--%>

            <%--<p class="cd-form-bottom-message"><a href="javascript:void(0);">Back to log-in</a></p>--%>
        <%--</div> <!-- cd-reset-password -->--%>
        <%--<a href="javascript:void(0);" class="cd-close-form">Close</a>--%>
    </div> <!-- cd-user-modal-container -->
</div> <!-- cd-user-modal -->