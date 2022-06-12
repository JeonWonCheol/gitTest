<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%

//������ ���ε� �� ���
String uploadPath = "D:\\eclipse-workspace\\solo_project\\jsp_project02\\src\\main\\webapp\\upload";
//  D:\\eclipse-workspace\\solo_project\\jsp_project02\\src\\main\\webapp\\upload
//  D:\\jwc\\project\\jsp_project_02\\WebContent\\upload

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;

//1. MultipartRequest�� ����ϱ� ���� com.oreilly.servlet ��Ű���� import �ؾ��Ѵ�.
//2. MultipartRequest�� ��ü�� �������ڸ��� ������ ���ε��Ѵ�.
//(request,����������(String),����ũ��(int),���ڵ���� )
MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"euc-kr",new DefaultFileRenamePolicy());


//MultipartRequest�� ����ϸ� getParameter�� ���� ���� ���� ���Ѵ�
//�׷��� MultipartRequest�� getParameter�� �̿��Ͽ� ���� ���� �޴´�.
String	 rcp_title 	  = multi.getParameter("rcp_title");

//String[] cook_explain = multi.getParameterValues("cook_explain");

//���ε�� ���ϸ��� ��´�.
//Enumeration �� �����͸� �������µ� ����ϴ� Ŭ����
Enumeration files = multi.getFileNames();

/* ===========================================================  
					������ ��ȿ�� �˻� ó��
=========================================================== */ 
if( rcp_title == null)
{
//�����ͺ��̽� ������ �����Ѵ�.
conn.close();	
if(type.equals("S"))
{%>
response.sendRedirect("rcp_share_write.jsp?type=<%= type %>");
<%}else{%>
response.sendRedirect("rcp_boast_write.jsp?type=<%= type %>");
<%}
return;
}

if( rcp_title.equals(""))
{
//�����ͺ��̽� ������ �����Ѵ�.
conn.close();	
if(type.equals("S")){%>
response.sendRedirect("rcp_share_write.jsp?type=<%= type %>");
<%}else{%>
response.sendRedirect("rcp_boast_write.jsp?type=<%= type %>");
<%}
return;
}

/* ===========================================================  
					�Խù� �ڷ� ���� ����ǥ  ó��
=========================================================== */ 
rcp_title       = rcp_title.replace("'","''");
/*
for(int i=0; i<cook_explain.length; i++){
cook_explain[i]    = cook_explain[i].replace("'","''");
}
*/

/* ===========================================================  
						�Խù� ���� �Է� ó��
=========================================================== */ 

String sql ="";
sql  = "insert into rcp (u_no,rcp_title,rcp_type,rcp_writer) ";
sql += "values ( ";
sql += "'" + login_no + "', ";
sql += "'" + rcp_title + "', ";
sql += "'" + type + "', ";
sql += "'" + login_name + "' ";
sql += ")";
System.out.println(sql);
stmt.executeUpdate(sql);

/* ===========================================================  
						�Էµ� �� ��ȣ ���
=========================================================== */ 
sql = "select last_insert_id() as rcp_no ";
ResultSet result = stmt.executeQuery(sql);
result.next();
String rcp_no = result.getString("rcp_no");

/* ===========================================================  
						�Խù� ���� �Է� ó��
=========================================================== */ 

String[] subcategory = multi.getParameterValues("subcategory");
if(subcategory != null)
{
	//data �� "A:�ع���"
	//data �� "B:��/��"			
	for(String data : subcategory)
	{
		String cat_mcode = "";
		String cat_mname = "";
		String cat_scode = "";
		String cat_sname = "";
		String [] ary = data.split(":");
		cat_mcode = ary[0];
		cat_mname = ary[1];
		cat_scode = ary[2];
		cat_sname = ary[3];
		
		sql  = "insert into category (rcp_type,u_no,rcp_no,cat_mcode,cat_mname,cat_scode,cat_sname) ";
		sql += "values ( ";
		sql += "'" + type + "', ";
		sql += "'" + login_no + "', ";
		sql += "'" + rcp_no + "', ";
		sql += "'" + cat_mcode + "', ";
		sql += "'" + cat_mname + "', ";
		sql += "'" + cat_scode + "', ";
		sql += "'" + cat_sname + "' ";
		sql += ")";
		stmt.executeUpdate(sql);	
		System.out.println(sql);
	}
}

/* ===========================================================  
						�Խù� ���� �Է� ó��
=========================================================== */
if(type.equals("S"))
{ 
	int trCount = 1; //���ȣ
	
	for(trCount = 1; trCount < 11; trCount++)
	{
		//����
		String name = "cook_explain_" + trCount; 				//name = �����ȣ
		String cook_explain = multi.getParameter(name);			//name�� ���� cook_expalin�� �ִ´�
		
		if(cook_explain != null)
		{	
			//÷������
			name = "cook_attach_" + trCount;									//name = �����ȣ
			String cook_attach_name = (String)multi.getFilesystemName(name);	//name�� ���� cook_attach_name�� �ִ´�
			String cook_sumbnail = (String)multi.getFilesystemName("cook_attach_0");
			
			sql  = "insert into cook (rcp_type,u_no,rcp_no,cook_explain,cook_attach,cook_sumbnail) ";
			sql += "values ( ";
			sql += "'" + type + "', ";
			sql += "'" + login_no + "', ";
			sql += "'" + rcp_no + "', ";
			sql += "'" + cook_explain + "', ";
			sql += "'" + cook_attach_name + "', ";
			sql += "'" + cook_sumbnail + "' ";
			sql += ")";
			System.out.println(sql);
			stmt.executeUpdate(sql);	
		}
	}
}
else
{
	String cook_explain = multi.getParameter("cook_explain");
	String cook_sumbnail = (String)multi.getFilesystemName("cook_sumbnail");

	sql  = "insert into cook (rcp_type,u_no,rcp_no,cook_explain,cook_sumbnail) ";
	sql += "values ( ";
	sql += "'" + type + "', ";
	sql += "'" + login_no + "', ";
	sql += "'" + rcp_no + "', ";
	sql += "'" + cook_explain + "', ";
	sql += "'" + cook_sumbnail +  "' ";
	sql += ")";
	
	System.out.println(sql);
	stmt.executeUpdate(sql);	
}
%>
<%if(type.equals("S")){ %>
<script type="text/javascript"> location.href="rcp_share_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script>
<%}else{%>
<script type="text/javascript"> location.href="rcp_boast_view.jsp?type=<%= type %>&rcp_no=<%=rcp_no%>"; </script><%}%>

<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>