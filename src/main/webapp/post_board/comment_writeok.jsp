<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
String type    = request.getParameter("type");

request.setCharacterEncoding("euc-kr");

String p_no       = request.getParameter("p_no");
String u_no       = request.getParameter("u_no");
String r_contents = request.getParameter("r_contents");
String curpage    = request.getParameter("page");
if( curpage == null ) curpage = "1";

//======================== 세션에서 로그인 정보를 가져온다. ========
String login_id    = (String)session.getAttribute("u_id");
String login_no    = (String)session.getAttribute("u_no");
String login_name  = (String)session.getAttribute("u_name");
String login_level = (String)session.getAttribute("u_level");

if(p_no == null || u_no == null || r_contents == null || login_id == null)
{
	response.sendRedirect("post_question_view.jsp");	
	return;
}

//======================== 게시물 자료 작은 따옴표  처리 ========
r_contents = r_contents.replace("'","''");

%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== 게시물 자료 입력  처리 ========
String sql = "";
sql  = "insert into postreply (p_no,u_no,r_u_no,r_name,r_contents) ";
sql += "values ('" + p_no + "','" + u_no + "','" + login_no + "','" + login_name + "','" + r_contents + "')";
System.out.println(sql);
stmt.executeUpdate(sql);
%>
<%@ include file="../dbms/dbclose.jsp" %>

<script type="text/javascript"> location.href="post_question_view.jsp?type=Q&page=<%= curpage %>&p_no=<%=p_no%>"; </script>


