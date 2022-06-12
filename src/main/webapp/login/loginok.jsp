<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%
String u_id = request.getParameter("u_id");
String u_pw = request.getParameter("u_pw");

/* ===========================================================  
						데이터 유효성 검사 처리	
=========================================================== */
	if( u_id == null || u_pw == null )
	{
		//데이터베이스 연결을 종료한다.
		conn.close();
		response.sendRedirect("login.jsp");
		return;
	}
	if( u_id.equals("") || u_pw.equals("")  )
	{
		//데이터베이스 연결을 종료한다.
		conn.close();
		response.sendRedirect("login.jsp");
		return;
	}
	
/* ===========================================================  
						로그인 처리
=========================================================== */
String sql = "";
sql += "select u_no,u_name,u_level "; 
sql += "from user "; 
sql += "where u_id = '"+ u_id +"' and u_pw = md5('" + u_pw + "') "; 
System.out.println(sql);

	//작업 처리용 클래스를 할당 받는다.
	ResultSet result = stmt.executeQuery(sql);
	if( result.next() == false)
	{
		//데이터베이스 연결을 종료한다.
		conn.close();
		%>
		<script>
			alert("아이디 또는 비밀번호가 일치하지 않습니다");
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
				세션에 로그인 정보를 설정 (헤드에 getAttribute)
=========================================================== */
	//세션에 값 저장 setAttribute(String name, Object value)
	session.setAttribute("u_id",u_id);
	session.setAttribute("u_no",u_no);
	session.setAttribute("u_name",u_name);
	session.setAttribute("u_level",u_level);
	
	
	response.sendRedirect("../main/home.jsp?type=H");
%>

<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>