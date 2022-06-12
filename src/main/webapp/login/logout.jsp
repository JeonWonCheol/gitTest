<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%
	//()세션 지우기
	session.removeAttribute("u_id");
	session.removeAttribute("u_no");
	session.removeAttribute("u_name");
	session.removeAttribute("u_level");
	
	response.sendRedirect("../main/home.jsp?type=H");
%>
<%@ include file="../include/tail.jsp" %>