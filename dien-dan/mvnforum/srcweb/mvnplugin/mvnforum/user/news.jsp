<%--
 - This file could be used to add news to mvnForum
 --%>
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td>
      <%if (MVNForumConfig.getCMSNewsViewMode() != MVNForumConfig.CMS_NEWS_VIEW_MODE_DISABLED && MvnForumServiceFactory.getMvnForumService().getMvnForumCMSService().canRunNewsInMvnForum()) {%>
      <table width="<%=MVNForumConfig.getCMSNewsTableWidth()%>%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <br/>
            <jsp:include page="<%=MvnForumServiceFactory.getMvnForumService().getMvnForumCMSService().getCdsUrlPattern()%>">
              <jsp:param name="nameOfURI" value="<%=MvnForumServiceFactory.getMvnForumService().getMvnForumCMSService().getNewsInMvnForumURL()%>"/>    
            </jsp:include>
          </td>
        </tr>
      </table>
      <%}%>
    </td>
  </tr>
</table>
