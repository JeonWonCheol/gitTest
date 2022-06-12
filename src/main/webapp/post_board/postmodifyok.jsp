<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String p_no 	      = request.getParameter("p_no");
String modifytitle    = request.getParameter("modifytitle");
String modifycontents = request.getParameter("modifycontents");
String p_subject 	  = request.getParameter("p_subject");
String curpage    = request.getParameter("page");
if( curpage == null ) curpage = "1";

/* ===========================================================  
						������ ��ȿ�� �˻� ó��
=========================================================== */  
if( p_no == null || type == null || modifytitle == null || modifycontents == null )
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	response.sendRedirect("post.jsp");	
	return;
}

if( p_no.equals("") || type.equals("") || modifytitle.equals("") || modifycontents.equals("")  )
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();	
	response.sendRedirect("post.jsp");	
	return;
}
/* ===========================================================  
						�Խù� �ڷ� ���� ����ǥ  ó��
=========================================================== */ 
modifytitle     = modifytitle.replace("'","''");
modifycontents  = modifycontents.replace("'","''");

/* ===========================================================  
						�Խù� ���� �Է� ó��
=========================================================== */ 
String sql = "";
sql  = "update post ";
sql += "set ";
sql += "p_title = '" + modifytitle + "', ";
sql += "p_type = '" + type + "', ";
sql += "p_subject = '" + p_subject + "', ";
sql += "p_contents = '" + modifycontents + "' ";
sql += "where p_no = " + p_no;
stmt.executeUpdate(sql);
System.out.println(sql);


if(type.equals("N")){ %>
<script type="text/javascript"> location.href="post_notice_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>"; </script>
<%}else{%>
<script type="text/javascript"> location.href="post_question_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>"; </script><%}%>

<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>