<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String type  = request.getParameter("type");
String rcp_no  = request.getParameter("rcp_no");
String rcp_r_no  = request.getParameter("rcp_r_no");
String curpage    = request.getParameter("page");
if( curpage == null ) curpage = "1";

if(rcp_no == null || rcp_r_no == null)
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
%>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String sql = "delete from rcpreply where rcp_r_no = '" + rcp_r_no + "' ";
System.out.println(sql);
stmt.executeUpdate(sql);
%>

<%@ include file="../dbms/dbclose.jsp" %>

<%if(type.equals("S")){ %>
<script type="text/javascript"> location.href="rcp_share_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script>
<%}else{%>
<script type="text/javascript"> location.href="rcp_boast_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script><%}%>