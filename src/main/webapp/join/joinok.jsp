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
					데이터 유효성 검사 처리
=========================================================== */  
if( u_id == null || u_pw == null || u_name == null || u_gender == null || year == null || month == null || date == null)
{
//데이터베이스 연결을 종료한다.
conn.close();	
response.sendRedirect("join.jsp");	
return;
}

if( u_id.equals("") || u_pw.equals("") || u_name.equals("") || u_gender.equals("") || year.equals("") || month.equals("") || date.equals(""))
{
	//데이터베이스 연결을 종료한다.
	conn.close();	
	response.sendRedirect("join.jsp");	
	return;
}

/* ===========================================================  
						중복된 ID 검사 처리
=========================================================== */ 
String sql = "";

sql = "select u_no from user where u_id = '" + u_id + "'";
ResultSet result = stmt.executeQuery(sql);
if( result.next() == true)
{
	//데이터베이스 연결을 종료한다.
	conn.close();	
	%>
	<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
		<dd>
			<table border="0" class="join_table">
				<tr>
					<td colspan="5" style="text-align: center;" height="100px">아이디가 중복되었습니다</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="5">
						<a href="../main/home.jsp">홈으로</a>
						&nbsp;|&nbsp;
						<a href="join.jsp">다시 회원가입</a>
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
						회원정보 입력 처리
=========================================================== */ 

sql  = "insert into user (u_id,u_pw,u_name,u_gender,u_birthdate) ";
sql += "values ('" + u_id + "',md5('" + u_pw + "'),'" + u_name + "','" + u_gender + "','" + u_birthdate + "') ";
//md5('pw'): pw md5 방식으로 암호화
System.out.println(sql);
//작업 처리용 클래스를 할당 받는다.
stmt.executeUpdate(sql);

/* ===========================================================  
						입력된 회원번호 얻기
=========================================================== */ 
sql = "select last_insert_id() as u_no "; // last_insert_id(): 마지막 생성된 Auto_Increment 값을 반환 해주는 구문
result = stmt.executeQuery(sql);
result.next();
String u_no = result.getString("u_no");
//out.print("등록된 회원번호 : " + u_no);

	response.sendRedirect("../main/home.jsp?type=H");
%>	
<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>