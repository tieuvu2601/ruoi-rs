<%@ include file="/common/taglibs.jsp" %>
<div class="footer-v8 footer-custom">
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6 column-one md-margin-bottom-50">
                    <h3 class="footer-header margin-bottom-20"><a href="<c:url value="/index.html"/>"><fmt:message key="site.footer.company"/></a></h3>
                    <span>Address:</span>
                    <p><fmt:message key="site.footer.address"/></p>
                    <hr>
                    <span>Phone Number:</span>
                    <p><fmt:message key="site.author.phonenumber"/></p>
                    <hr>
                    <span>Email:</span>
                    <a href="#"><fmt:message key="site.author.email"/></a>
                </div>


                <div class="col-md-6 col-sm-6">
                    <h2>Subscribe</h2>
                    <p><fmt:message key="site.footer.subcrible.message"/></p><br>

                    <div class="input-group margin-bottom-50">
                        <input class="form-control" type="email" placeholder="Enter email">
                        <div class="input-group-btn">
                            <button type="button" class="btn-u input-btn"><fmt:message key="site.footer.subcribe.button"/></button>
                        </div>
                    </div>

                    <h2><fmt:message key="site.footer.social"/></h2>
                    <p><strong>Follow Us</strong></p><br>

                    <ul class="social-icon-list margin-bottom-20">
                        <li><a href="#"><i class="rounded-x fa fa-twitter"></i></a></li>
                        <li><a href="#"><i class="rounded-x fa fa-facebook"></i></a></li>
                        <li><a href="#"><i class="rounded-x fa fa-linkedin"></i></a></li>
                        <li><a href="#"><i class="rounded-x fa fa-google-plus"></i></a></li>
                        <li><a href="#"><i class="rounded-x fa fa-dribbble"></i></a></li>
                    </ul>

                </div>
            </div>
        </div>
    </footer>

    <footer class="copyright">
        <div class="container">
            <ul class="list-inline terms-menu">
                <li>2015 &copy; All Rights Reserved.</li>
                <li class="home"><a href="#">Terms of Use</a></li>
                <li><a href="#">Privacy and Policy</a></li>
            </ul>
        </div>
    </footer>
</div>
