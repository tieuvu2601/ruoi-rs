<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.user.UserModuleConfig" %>
<% request.setAttribute("contentType", "text/xml;charset=utf-8");%>
<%@ include file="inc_common.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<% response.setContentType("text/xml;charset=utf-8");%>
<%
Collection threadBeans = (Collection) request.getAttribute("ThreadBeans");
int forumID = ((Integer)request.getAttribute("ForumID")).intValue();
String prefix = ParamUtil.getServerPath() + contextPath + UserModuleConfig.getUrlPattern();
String logoUrl = ParamUtil.getServerPath() + contextPath + "/mvnplugin/mvnforum/images/logo.gif";

String channelLink = prefix + "/index";
String channelTitle;
String channelDesc;
if (forumID > 0) {
    // Forum specific RSS
    ForumCache forumCache = ForumCache.getInstance();
    String forumName = forumCache.getBean(forumID).getForumName();
    forumName = DisableHtmlTagFilter.filter(forumName);
    channelTitle = ParamUtil.getServerPath() + " (Forum: " + forumName + ")";
    channelDesc  = "RSS Feed of " + channelTitle;
} else {
    // global RSS
    channelTitle = ParamUtil.getServerPath();
    channelDesc  = "RSS Feed of " + channelTitle + " (Global RSS)";
}
%>
<rss version="0.91">
<channel>
  <title><%=channelTitle%></title>
  <link><%=prefix%>/index</link>
  <description><%=channelDesc%></description>
  <language>en-us</language>

  <image>
    <title>mvnForum RSS</title>
    <url><%=logoUrl%></url>
    <link><%=prefix%>/index</link>
    <width>141</width>
    <height>50</height>
    <description>mvnForum - free open source Jsp/Servlet forum</description>
  </image>

  <textInput>
    <title>Search</title>
    <description>Search all posts</description>
    <name>key</name>
    <link><%=prefix%>/search</link>
  </textInput>
<%
for (Iterator iterator = threadBeans.iterator(); iterator.hasNext(); ) {
  ThreadBean threadBean = (ThreadBean)iterator.next();
%>
  <item>
    <title><%=DisableHtmlTagFilter.filter(threadBean.getThreadTopic())%>+++<%=memverAvatar%> +++ <%=threadBean.getThreadViewCount()%></title>
    <%
    String threadUrl = "/viewthread?thread=" + threadBean.getThreadID();
    if (MVNForumConfig.getEnableFriendlyURL()) {
      threadUrl = FriendlyURLParamUtil.createFriendlyURL(threadUrl);

    }
    %>
    <link><%=prefix%><%=threadUrl%></link>
    <description><%=DisableHtmlTagFilter.filter(StringUtil.getShorterString(threadBean.getThreadBody(), MVNForumConfig.getMaxCharsInRSS()))%></description>
  </item>
<% }//for%>
</channel>
</rss>
</fmt:bundle>

