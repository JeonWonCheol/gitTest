<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>    
<%
//���� ������ �� 50���� ����� ���
String sql = "";

sql = "delete from rcpreply";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from cook";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from category";
System.out.println(sql);
stmt.executeUpdate(sql);

sql = "delete from rcp";
System.out.println(sql);
stmt.executeUpdate(sql);

for(int i=1; i <= 50; i++)
{
	String rcp_title = String.format("�丮���� %03d ��° ���Դϴ�.",i);
	String rcp_type	  = "S";
	
	sql  = "insert into rcp (rcp_no,u_no,rcp_writer,rcp_title,rcp_type) ";
	sql += "values ('"+i+"','1','������','" + rcp_title + "','" + rcp_type + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
	
	String cook_explain = "�丮���� �� �����Դϴ�";
	String cook_attach  = "image.jpg";
	String cook_sumbnail = "yorelogo.jpg";
	
	sql  = "insert into cook (rcp_type,cook_no,rcp_no,u_no,cook_explain,cook_attach,cook_sumbnail) ";
	sql += "values ('"+ rcp_type +"','"+i+"','"+i+"','1','" + cook_explain + "','" + cook_attach + "','" + cook_sumbnail + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
	
	sql  = "insert into category (rcp_type,rcp_no,cat_no,u_no,cat_mcode,cat_mname,cat_scode,cat_sname) ";
	sql += "values ( ";
	sql += "'"+rcp_type+"', ";
	sql += "'"+i+"', ";
	sql += "'"+i+"', ";
	sql += "'1', ";
	sql += "'A', ";
	sql += "'������', ";
	sql += "'A', ";
	sql += "'�ع���' ";
	sql += ")";
	stmt.executeUpdate(sql);	
	System.out.println(sql);
}

for(int i=51; i <= 101; i++)
{
	String rcp_title = String.format("�丮�ڶ� %03d ��° ���Դϴ�.",i);
	String rcp_type	  = "B";
	
	sql  = "insert into rcp (rcp_no,u_no,rcp_writer,rcp_title,rcp_type) ";
	sql += "values ('"+i+"','1','������','" + rcp_title + "','" + rcp_type + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
	
	String cook_explain = "�丮�ڶ� �� �����Դϴ�";
	String cook_attach	  = "image.jpg";
	String cook_sumbnail = "yorelogo.jpg";
	
	sql  = "insert into cook (rcp_type,cook_no,rcp_no,u_no,cook_explain,cook_attach,cook_sumbnail) ";
	sql += "values ('"+ rcp_type +"','"+i+"','"+i+"','1','" + cook_explain + "','" + cook_attach + "','" + cook_sumbnail + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
	
	sql  = "insert into category (rcp_type,rcp_no,cat_no,u_no,cat_mcode,cat_mname,cat_scode,cat_sname) ";
	sql += "values ( ";
	sql += "'"+rcp_type+"', ";
	sql += "'"+i+"', ";
	sql += "'"+i+"', ";
	sql += "'1', ";
	sql += "'A', ";
	sql += "'������', ";
	sql += "'A', ";
	sql += "'�ع���' ";
	sql += ")";
	stmt.executeUpdate(sql);	
	System.out.println(sql);
}
%>
<%@ include file="../dbms/dbclose.jsp" %>