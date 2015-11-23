<%@ include file="/common/taglibs.jsp"%>

<head>
    <title>Server Information</title>
    <meta name="menu" content="Server Info"/>
</head>

<body class="sub_page">
    <div class="sub_page_panel">
        <div class="box_wrapper">
            <div class="sub_page_title">
            Server Information
            </div>
            <div class="sub_page_content">

                <div class="middle" style="height: 540px">
                    <br/>
                    <br/>
                    <br/>
                    Server Info   :&nbsp;   <%=getServletContext().getServerInfo()%>
                    <br/>
                    <br/>
                    <br/>
                    Server Name   :&nbsp;   <%=request.getServerName()%>
                    <br/>
                    <br/>
                    <br/>
                    IP Address    :&nbsp; <%=request.getLocalAddr() %>
                    <br/>
                    <br/>
                    <br/>
                    Build Version		  :&nbsp; <fmt:message key="webapp.version"/>
                    <br/>

                </div>
            </div>
        </div>
    </div>
</body>