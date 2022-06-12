<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
String type = request.getParameter("type");

request.setCharacterEncoding("euc-kr");

String rcp_no         = request.getParameter("rcp_no");
String u_no           = request.getParameter("u_no");
String rcp_r_contents = request.getParameter("rcp_r_contents");
String curpage        = request.getParameter("page");
if( curpage == null ) curpage = "1";

//======================== 세션에서 로그인 정보를 가져온다. ========
String login_id    = (String)session.getAttribute("u_id");
String login_no    = (String)session.getAttribute("u_no");
String login_name  = (String)session.getAttribute("u_name");
String login_level = (String)session.getAttribute("u_level");

if(rcp_no == null || u_no == null || rcp_r_contents == null || login_id == null)
{
	if(type.equals("S"))
	{
		response.sendRedirect("rcp_share_view.jsp?type=S");	
	}
	else
	{
		response.sendRedirect("rcp_boast_view.jsp?type=B");
	}
	return;
}

//======================== 게시물 자료 작은 따옴표  처리 ========
rcp_r_contents = rcp_r_contents.replace("'","''");

%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
//======================== 게시물 자료 입력  처리 ========
String sql = "";
sql  = "insert into rcpreply (rcp_no,u_no,rcp_r_u_no,rcp_r_name,rcp_r_contents) ";
sql += "values ('" + rcp_no + "','" + u_no + "','" + login_no + "','" + login_name + "','" + rcp_r_contents + "')";
System.out.println(sql);
stmt.executeUpdate(sql);
%>
<%@ include file="../dbms/dbclose.jsp" %>

<%if(type.equals("S")){ %>
<script type="text/javascript"> location.href="rcp_share_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script>
<%}else{%>
<script type="text/javascript"> location.href="rcp_boast_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script><%}%>