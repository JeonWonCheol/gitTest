<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String u_id = request.getParameter("u_id");
String u_pw = request.getParameter("u_pw");

/* ===========================================================  
						������ ��ȿ�� �˻� ó��	
=========================================================== */
	if( u_id == null || u_pw == null )
	{
		//�����ͺ��̽� ������ �����Ѵ�.
		conn.close();
		response.sendRedirect("login.jsp");
		return;
	}
	if( u_id.equals("") || u_pw.equals("")  )
	{
		//�����ͺ��̽� ������ �����Ѵ�.
		conn.close();
		response.sendRedirect("login.jsp");
		return;
	}
	
/* ===========================================================  
						�α��� ó��
=========================================================== */
String sql = "";
sql += "select u_no,u_name,u_level "; 
sql += "from user "; 
sql += "where u_id = '"+ u_id +"' and u_pw = md5('" + u_pw + "') "; 
System.out.println(sql);

	//�۾� ó���� Ŭ������ �Ҵ� �޴´�.
	ResultSet result = stmt.executeQuery(sql);
	if( result.next() == false)
	{
		//�����ͺ��̽� ������ �����Ѵ�.
		conn.close();
		%>
		<script>
			alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�");
			history.back();
		</script>	
		<%
		return;
	}
	String u_no   = result.getString("u_no");
	String u_name = result.getString("u_name");
	String u_level = result.getString("u_level");
	result.close();
	
/* ===========================================================  
				���ǿ� �α��� ������ ���� (��忡 getAttribute)
=========================================================== */
	//���ǿ� �� ���� setAttribute(String name, Object value)
	session.setAttribute("u_id",u_id);
	session.setAttribute("u_no",u_no);
	session.setAttribute("u_name",u_name);
	session.setAttribute("u_level",u_level);
	
	
	response.sendRedirect("../main/home.jsp?type=H");
%>

<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>