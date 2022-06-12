<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String type  = request.getParameter("type");
String p_no  = request.getParameter("p_no");
String r_no  = request.getParameter("r_no");
String curpage    = request.getParameter("page");
if( curpage == null ) curpage = "1";

if(p_no == null || r_no == null)
{
	response.sendRedirect("post_question_view.jsp");
	return;
}
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String sql = "delete from postreply where r_no = '" + r_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);
%>
<%@ include file="../dbms/dbclose.jsp" %>

<script type="text/javascript"> location.href="post_question_view.jsp?type=Q&page=<%= curpage %>&p_no=<%=p_no%>"; </script>
