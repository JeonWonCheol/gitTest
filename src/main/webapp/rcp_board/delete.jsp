<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%

/* ===========================================================  
					������ ��ȿ�� �˻�(���� �� �Խù� ��ȣ�� ���)
=========================================================== */ 
String rcp_no = request.getParameter("rcp_no");
if( rcp_no == null || rcp_no.equals(""))
{
	%>
	�ùٸ� �ڷᰡ ���۵��� �ʾҽ��ϴ�.
	<br>
	<a href="index.jsp">������� �̵�</a>
	<%
	return;
}
/* ===========================================================  
					���� �� �Խù��� ������ �˻�
=========================================================== */ 
String sql = "";
sql  = "select u_no ";
sql += "from rcp ";
sql += "where rcp_no = " + rcp_no;

ResultSet result = stmt.executeQuery(sql);
if( result.next() == false)
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	%>
	�Խù� ������ �����ϴ�.
	<br>
	<a href="index.jsp">������� �̵�</a>
	<%
	return;
}
String u_no = result.getString("u_no");
if(u_no.equals(login_no) == false)
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	%>
	�Խù��� ���� ���� ������ �����ϴ�.
	<br>
	<a href="post.jsp">������� �̵�</a>
	<%
	return;
}

/* ===========================================================  
							�� ����
=========================================================== */ 
sql  = "delete from rcpreply where rcp_no = " + rcp_no;
stmt.executeUpdate(sql);
System.out.println(sql);

sql  = "delete from cook where rcp_no = " + rcp_no;
stmt.executeUpdate(sql);
System.out.println(sql);

sql  = "delete from category where rcp_no = " + rcp_no;
stmt.executeUpdate(sql);
System.out.println(sql);

sql  = "delete from rcp where rcp_no = " + rcp_no;
stmt.executeUpdate(sql);
System.out.println(sql);
%>


<script type="text/javascript">
	alert("�� ������ �Ϸ� �Ǿ����ϴ�.");
	location.href="rcp.jsp?type=<%= type %>";
</script>


<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>