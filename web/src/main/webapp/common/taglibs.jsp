<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springmodules.org/tags/commons-validator" prefix="v" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.1" prefix="str" %>
<%@ taglib prefix="rep" uri="http://banvien.com/tags/repository" %>
<%@ taglib uri="http://www.banvien.com/portal-taglibs" prefix="portal" %>
<%@ taglib uri="http://www.banvien.com/tags/seo" prefix="seo" %>
<%@ taglib uri="http://www.banvien.com/tags/contentEntity" prefix="contentEntity" %>
<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>

<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
