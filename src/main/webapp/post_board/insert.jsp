<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>    
<%
//���� ������ �� 100���� ����� ���
String sql = "";

sql = "delete from postreply";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from post";
System.out.println(sql);
stmt.executeUpdate(sql);

for(int i=1; i <= 100; i++)
{
	String p_title;
	String p_type	  = "N";
	String p_subject  = "����";
	String p_contents = "�����Դϴ�.<br>�����Դϴ�.<br>�����Դϴ�.<br>�����Դϴ�.<br>";
	
	p_title = String.format("�������� %03d ��°�Դϴ�.",i);
	
	sql  = "insert into post (u_no,p_writer,p_title,p_type,p_contents,p_subject) ";
	sql += "values ('1','������','" + p_title + "','" + p_type + "','" + p_contents + "','" + p_subject + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
}


for(int i=1; i <= 100; i++)
{
	String p_title;
	String p_type 	  = "Q";
	String p_subject  = "Q";
	String p_contents = "�����Դϴ�.<br>�����Դϴ�.<br>�����Դϴ�.<br>�����Դϴ�.<br>";
	
	p_title = String.format("�������� %03d ��°�Դϴ�.",i);
	
	sql  = "insert into post (u_no,p_writer,p_title,p_type,p_contents,p_subject) ";
	sql += "values ('1','������','" + p_title + "','" + p_type + "','" + p_contents + "','" + p_subject + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
}

%>
<%@ include file="../dbms/dbclose.jsp" %>