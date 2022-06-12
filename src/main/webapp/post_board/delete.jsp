<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%

/* ===========================================================  
					데이터 유효성 검사(삭제 할 게시물 번호를 얻기)
=========================================================== */ 
String p_no = request.getParameter("p_no");
if( p_no == null || p_no.equals(""))
{
	%>
	올바른 자료가 전송되지 않았습니다.
	<br>
	<a href="index.jsp">목록으로 이동</a>
	<%
	return;
}
/* ===========================================================  
					삭제 할 게시물의 권한을 검사
=========================================================== */ 
String sql = "";
sql  = "select u_no ";
sql += "from post ";
sql += "where p_no = " + p_no;

ResultSet result = stmt.executeQuery(sql);
if( result.next() == false)
{
	//데이터베이스 연결을 종료한다.
	conn.close();	
	%>
	게시물 정보가 없습니다.
	<br>
	<a href="index.jsp">목록으로 이동</a>
	<%
	return;
}
String u_no = result.getString("u_no");
if(u_no.equals(login_no) == false)
{
	//데이터베이스 연결을 종료한다.
	conn.close();	
	%>
	게시물에 대한 삭제 권한이 없습니다.
	<br>
	<a href="post.jsp">목록으로 이동</a>
	<%
	return;
}

/* ===========================================================  
							글 삭제
=========================================================== */ 
sql  = "delete from postreply where p_no = " + p_no;
stmt.executeUpdate(sql);
System.out.println(sql);

sql  = "delete from post where p_no = " + p_no;
stmt.executeUpdate(sql);
System.out.println(sql);
%>


<script type="text/javascript">
	alert("글 삭제가 완료 되었습니다.");
	location.href="post.jsp?type=<%= type %>";
</script>


<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>