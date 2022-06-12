<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String u_id        = request.getParameter("u_id");
String u_pw        = request.getParameter("u_pw");
String u_name      = request.getParameter("u_name");

String year 	   = request.getParameter("year");
String month 	   = request.getParameter("month");
String date 	   = request.getParameter("date");
int date01 		   = Integer.parseInt(date);
String date02	   = String.format("%02d", date01);	
String u_birthdate = (year + month + date02);

String u_gender    = request.getParameter("u_gender");

/* ===========================================================  
					������ ��ȿ�� �˻� ó��
=========================================================== */  
if( u_id == null || u_pw == null || u_name == null || u_gender == null || year == null || month == null || date == null)
{
//�����ͺ��̽� ������ �����Ѵ�.
conn.close();	
response.sendRedirect("join.jsp");	
return;
}

if( u_id.equals("") || u_pw.equals("") || u_name.equals("") || u_gender.equals("") || year.equals("") || month.equals("") || date.equals(""))
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	response.sendRedirect("join.jsp");	
	return;
}

/* ===========================================================  
						�ߺ��� ID �˻� ó��
=========================================================== */ 
String sql = "";

sql = "select u_no from user where u_id = '" + u_id + "'";
ResultSet result = stmt.executeQuery(sql);
if( result.next() == true)
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	%>
	<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
		<dd>
			<table border="0" class="join_table">
				<tr>
					<td colspan="5" style="text-align: center;" height="100px">���̵� �ߺ��Ǿ����ϴ�</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="5">
						<a href="../main/home.jsp">Ȩ����</a>
						&nbsp;|&nbsp;
						<a href="join.jsp">�ٽ� ȸ������</a>
					</td>
				</tr>
			</table>
		</dd>
	</dl>
	<br>
	<%
	return;
}

/* ===========================================================  
						ȸ������ �Է� ó��
=========================================================== */ 

sql  = "insert into user (u_id,u_pw,u_name,u_gender,u_birthdate) ";
sql += "values ('" + u_id + "',md5('" + u_pw + "'),'" + u_name + "','" + u_gender + "','" + u_birthdate + "') ";
//md5('pw'): pw md5 ������� ��ȣȭ
System.out.println(sql);
//�۾� ó���� Ŭ������ �Ҵ� �޴´�.
stmt.executeUpdate(sql);

/* ===========================================================  
						�Էµ� ȸ����ȣ ���
=========================================================== */ 
sql = "select last_insert_id() as u_no "; // last_insert_id(): ������ ������ Auto_Increment ���� ��ȯ ���ִ� ����
result = stmt.executeQuery(sql);
result.next();
String u_no = result.getString("u_no");
//out.print("��ϵ� ȸ����ȣ : " + u_no);

	response.sendRedirect("../main/home.jsp?type=H");
%>	
<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>