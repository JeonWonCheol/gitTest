<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String p_subject  = request.getParameter("p_subject");
String p_title    = request.getParameter("p_title");
String p_contents = request.getParameter("p_contents");
String curpage    = request.getParameter("page");
if( curpage == null ) curpage = "1";

System.out.println(p_subject);
System.out.println(p_title);
System.out.println(p_contents);


/* ===========================================================  
					데이터 유효성 검사 처리
=========================================================== */ 
if( p_subject == null || p_title == null || p_contents == null)
{
//데이터베이스 연결을 종료한다.
conn.close();	
if(type.equals("N")){%>
response.sendRedirect("post_notice_write.jsp?type=<%= type %>");
<%}else{%>
response.sendRedirect("post_question_write.jsp?type=<%= type %>");
<%}
return;
}

if( p_subject.equals("") || p_title.equals("") || p_contents.equals("") )
{
//데이터베이스 연결을 종료한다.
conn.close();	
if(type.equals("N")){%>
response.sendRedirect("post_notice_write.jsp?type=<%= type %>");
<%}else{%>
response.sendRedirect("post_question_write.jsp?type=<%= type %>");
<%}
return;
}

/* ===========================================================  
					게시물 자료 작은 따옴표  처리
=========================================================== */ 
p_title       = p_title.replace("'","''");
p_contents    = p_contents.replace("'","''");

/* ===========================================================  
						게시물 정보 입력 처리
=========================================================== */ 
String sql = "";

sql  = "insert into post (u_no,p_title,p_type,p_contents,p_writer,p_subject) ";
sql += "values ( ";
sql += "'" + login_no + "', ";
sql += "'" + p_title + "', ";
sql += "'" + type + "', ";
sql += "'" + p_contents + "', ";
sql += "'" + login_name + "', ";
sql += "'" + p_subject + "' ";
sql += ")";
System.out.println(sql);
stmt.executeUpdate(sql);

/* ===========================================================  
						입력된 글 번호 얻기
=========================================================== */ 
sql = "select last_insert_id() as p_no ";
ResultSet result = stmt.executeQuery(sql);
result.next();
String p_no = result.getString("p_no");

if(type.equals("N")){ %>
<script type="text/javascript"> location.href="post_notice_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>"; </script>
<%}else{%>
<script type="text/javascript"> location.href="post_question_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>"; </script><%}%>

<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>