<%@ include file="/common/taglibs.jsp" %>
<footer class="footer">
    <div class="footer-content">
        <div class="container">
            <content:findByContentTitle title="home footer" var="footer"/>
            <oscache:cache key="footer_homes_${footer.contentID}_${footer.modifiedDate}" duration="1">
                <c:set var="footerXMLData" value="${portal:parseContentXML(footer.xmlData)}"/>
                ${footerXMLData.content[0]}
            </oscache:cache>
        </div>
    </div>

    <div id="global-footer">
        <div class="container">
            <div class="row">
                <div id="bottom-logo" class="col-md-2"><a href="http://ntt.edu.vn/" target="_blank"><img src="<c:url value='/themes/site/images/ntt-logo-footer.png'/> "></a></div>
                <div id="bottom-menu" class="col-md-10">
                    <ul>
                        <li><a href="http://ntt.edu.vn/" target="_blank">NTT Home</a></li>
                        <li><a href="<c:url value="/sitemap.html"/>">Sitemap</a></li>
                        <li><a href="<c:url value="/search.html"/>">Search</a></li>
                        <li><a href="<c:url value="/page/home-page/terms-of-use.html"/>">Terms of Use</a></li>
                        <li><a href="<c:url value="/page/home-page/copyright-complaints.html"/>">Copyright Complaints</a></li>
                    </ul>
                </div>
                <div id="copyright" class="col-md-10" style="">
                    <p class="vcard"><span class="fn org"><fmt:message key="main.school"/></span>, <span class="adr"><span class="locality"><fmt:message key="address.street"/>, P13, Q4, Tp HCM</span></span></p>
                </div>
            </div>
        </div>
    </div>

    <div class="bottom-bar">
        <div class="container">
            <div class="row">
                <small class="copyright col-md-6 col-sm-12 col-xs-12">Copyright @ 2015 Nguyen Tat Thanh University | Developed by <a href="http://www.banvien.com" target="_blank">Ban Vien Co., Ltd</a></small>
                <ul class="social pull-right col-md-6 col-sm-12 col-xs-12">
                    <li><a href="#" ><i class="fa fa-twitter"></i></a></li>
                    <li><a href="#" ><i class="fa fa-facebook"></i></a></li>
                    <li><a href="#" ><i class="fa fa-youtube"></i></a></li>
                    <li><a href="#" ><i class="fa fa-linkedin"></i></a></li>
                    <li><a href="#" ><i class="fa fa-google-plus"></i></a></li>
                    <li><a href="#" ><i class="fa fa-pinterest"></i></a></li>
                    <li><a href="#" ><i class="fa fa-skype"></i></a></li>
                    <li class="row-end"><a href="#" ><i class="fa fa-rss"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-69009666-1', 'auto');
    ga('send', 'pageview');

</script>