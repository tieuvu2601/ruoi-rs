<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="net.myvietnam.mvncore.util.*" %>
<%@ page import="net.myvietnam.mvncore.filter.DisableHtmlTagFilter" %>
<%@ page import="com.mvnforum.db.*" %>
<%@ page import="com.mvnforum.user.UserModuleConfig" %>
<%@ page import="com.mvnforum.MVNForumResourceBundle" %>
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
String channelTitle = MVNForumResourceBundle.getString(onlineUser.getLocale(), "mvnforum.common.forum.title_name");
channelTitle = DisableHtmlTagFilter.filter(channelTitle);
String channelDesc;
Timestamp now = DateUtil.getCurrentGMTTimestamp();
String channelPubDate = DateUtil.getDateRFC822(now);
String channelLastBuildDate = channelPubDate;
String channelDocs = prefix + "/rsssummary";
String channelGenerator = "mvnForum Feed Generator " + mvnForumInfo.getProductVersion();
ForumCache forumCache = ForumCache.getInstance();
if (forumID > 0) {
    // Forum specific RSS
    String forumName = forumCache.getBean(forumID).getForumName();
    forumName = DisableHtmlTagFilter.filter(forumName);
    channelTitle = channelTitle + " (Forum: " + forumName + ")";
    channelDesc  = "RSS Feed of " + channelTitle;
} else {
    // global RSS
    channelTitle = channelTitle;
    channelDesc  = "RSS Feed of " + channelTitle + " (Global RSS)";
}
%>
<rss version="2.0">
<channel>
  <title><%=channelTitle%></title>
  <link><%=prefix%>/index</link>
  <description><%=channelDesc%></description>
  <language>en-us</language>
<%--  <pubDate><%=channelPubDate%></pubDate> --%>
  <lastBuildDate><%=channelLastBuildDate%></lastBuildDate>
  <docs><%=channelDocs%></docs>
  <generator><%=channelGenerator%></generator>
  <image>
    <title><fmt:message key="mvnforum.common.forum.title_name"/></title>
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

  MemberCache memberCache = MemberCache.getInstance();
  int idFromMemberName = memberCache.getMemberIDFromMemberName(threadBean.getMemberName());
  MemberBean memberBean = memberCache.getMember(idFromMemberName);
  String memverAvatar = memberBean.getMemberAvatar_processed(request, response); %>

  <% if(threadBean.getThreadShowVMS() == 1) { %>
  <item>
    <title><%=DisableHtmlTagFilter.filter(threadBean.getThreadTopic())%>#<%if(memverAvatar.compareTo("") != 0){ if (!memverAvatar.startsWith("/dien-dan")) { %><%=prefix%>/<%}}%><%=memverAvatar%>#<%=threadBean.getThreadViewCount()%>#<%=threadBean.getThreadReplyCount()%></title>
    <%
    String threadUrl = "/viewthread?thread=" + threadBean.getThreadID();
    String threadUrlWithLastPage = "/viewthread?thread=" + threadBean.getThreadID() + "&amp;lastpage=yes";
    if (MVNForumConfig.getEnableFriendlyURL()) {
      threadUrl = FriendlyURLParamUtil.createFriendlyURL(threadUrl);
      threadUrlWithLastPage = FriendlyURLParamUtil.createFriendlyURL(threadUrlWithLastPage);
    }
    %>
    <link><%=prefix%><%=threadUrl%></link>
    <description><%=DisableHtmlTagFilter.filter( StringUtil.getShorterString(threadBean.getThreadBody(), MVNForumConfig.getMaxCharsInRSS()) )%></description>
    <%-- author><%=threadBean.getMemberName()%></author --%>
    <pubDate><%=DateUtil.getDateRFC822(threadBean.getThreadCreationDate())%></pubDate>
    <category><%=DisableHtmlTagFilter.filter( forumCache.getBean(threadBean.getForumID()).getForumName() )%></category>
    
    <guid><%=prefix%><%=threadUrlWithLastPage%></guid>
  </item>
  <% } %>
<% }//for%>
</channel>
</rss>
</fmt:bundle>

