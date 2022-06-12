<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
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
String rcp_title = multi.getParameter("modifytitle");
String rcp_no    = multi.getParameter("rcp_no");

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
rcp_title  = rcp_title.replace("'","''");


/* ===========================================================  
						ī�װ� ���� ó��
=========================================================== */
String sql ="";
sql  = "delete from category ";
sql += "where rcp_no = " + rcp_no;
System.out.println(sql);
stmt.executeUpdate(sql);	

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
		
		sql  = "insert into category (u_no,rcp_no,cat_mcode,cat_mname,cat_scode,cat_sname) ";
		sql += "values ( ";
		sql += "'" + login_no + "', ";
		sql += "'" + rcp_no + "', ";
		sql += "'" + cat_mcode + "', ";
		sql += "'" + cat_mname + "', ";
		sql += "'" + cat_scode + "', ";
		sql += "'" + cat_sname + "' ";
		sql += ")";
		System.out.println(sql);
		stmt.executeUpdate(sql);	
		
		
	/* 	String sql ="";
		sql  = "update category set ";
		sql += "cat_mcode = '"+ cat_mcode + "', ";
		sql += "cat_mname = '"+ cat_mname + "', ";
		sql += "cat_scode = '"+ cat_scode + "', ";
		sql += "cat_sname = '"+ cat_sname + "' ";
		sql += "where rcp_no = " + rcp_no;
		System.out.println(sql);
		stmt.executeUpdate(sql);	 */
	}
}



/* ===========================================================  
						�Խù� ���� ���� ó��
=========================================================== */

sql  = "update rcp set ";
sql += "rcp_title = '"+ rcp_title + "' ";
sql += "where rcp_no = " + rcp_no;

stmt.executeUpdate(sql);
System.out.println(sql);

/* ===========================================================  
						�Խù� ���� ���� ó��
=========================================================== */
if(type.equals("S"))
{
	int trCount = 1; //���ȣ
	for(trCount = 1; trCount < 11; trCount++)
	{
		//����
		String name = "cook_explain_" + trCount; 				//name = �����ȣ
		String cook_explain = multi.getParameter(name);			//name�� ���� cook_expalin�� �ִ´�
		String[] cook_no = multi.getParameterValues("cook_no");
		if(cook_explain != null)
		{	
			//÷������
			name = "cook_attach_" + trCount;									//name = �����ȣ
			String cook_attach_name = (String)multi.getFilesystemName(name);	//name�� ���� cook_attach_name�� �ִ´�
			System.out.println(cook_attach_name);
			
			if(cook_attach_name == null)
			{
				sql  = "update cook ";
				sql += "set ";
				sql += "cook_explain = '" + cook_explain + "' ";
				sql += "where cook_no = " + cook_no[trCount-1];
				System.out.println(sql);
				stmt.executeUpdate(sql);
			}
			else
			{
				sql  = "update cook ";
				sql += "set ";
				sql += "cook_explain = '" + cook_explain + "', ";
				sql += "cook_attach = '" + cook_attach_name + "' ";
				sql += "where cook_no = " + cook_no[trCount-1];
				System.out.println(sql);
				stmt.executeUpdate(sql);		
			}
		}
	}	
}
else
{
	/* ===========================================================  
							�Խù� �ڷḦ ��ȸ
	=========================================================== */
	sql = "select cook_sumbnail ";
	sql += "from cook ";
	sql += "where rcp_no = " + rcp_no ;
	System.out.println(sql);
	ResultSet result = stmt.executeQuery(sql);
	
	result.next();
	String cook_imagname = result.getString("cook_sumbnail");
	System.out.println(cook_imagname);
	result.close();
	
	String cook_no = multi.getParameter("cook_no");
	String cook_explain = multi.getParameter("cook_explain");
	String cook_sumbnail = (String)multi.getFilesystemName("cook_sumbnail");
	
	if(cook_sumbnail == null) cook_sumbnail = cook_imagname;
	sql  = "update cook ";
	sql += "set ";
	sql += "cook_explain = '" + cook_explain + "', ";
	sql += "cook_sumbnail = '" + cook_sumbnail + "' ";
	sql += "where cook_no = " + cook_no ;
	System.out.println(sql);
	stmt.executeUpdate(sql);	
}


if(type.equals("S")){ %>
<script type="text/javascript"> 
	alert("�� ������ �Ϸ�Ǿ����ϴ�.");
	location.href="rcp_share_view.jsp?type=<%= type %>&rcp_no=<%= rcp_no %>"; 
</script>
<%}else{%>
<script type="text/javascript">
	alert("�� ������ �Ϸ�Ǿ����ϴ�.");
	location.href="rcp_boast_view.jsp?type=<%= type %>&rcp_no=<%= rcp_no %>
	";
</script>
<%}%>
<%@ include file="../include/tail.jsp"%>