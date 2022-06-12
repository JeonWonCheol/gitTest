<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../dbms/dbopen.jsp" %>    
<%
//샘플 데이터 각 100개씩 만드는 기능
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
	String p_subject  = "공지";
	String p_contents = "내용입니다.<br>내용입니다.<br>내용입니다.<br>내용입니다.<br>";
	
	p_title = String.format("공지사항 %03d 번째입니다.",i);
	
	sql  = "insert into post (u_no,p_writer,p_title,p_type,p_contents,p_subject) ";
	sql += "values ('1','관리자','" + p_title + "','" + p_type + "','" + p_contents + "','" + p_subject + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
}


for(int i=1; i <= 100; i++)
{
	String p_title;
	String p_type 	  = "Q";
	String p_subject  = "Q";
	String p_contents = "내용입니다.<br>내용입니다.<br>내용입니다.<br>내용입니다.<br>";
	
	p_title = String.format("질문사항 %03d 번째입니다.",i);
	
	sql  = "insert into post (u_no,p_writer,p_title,p_type,p_contents,p_subject) ";
	sql += "values ('1','관리자','" + p_title + "','" + p_type + "','" + p_contents + "','" + p_subject + "') ";
	System.out.println(sql);
	stmt.executeUpdate(sql);
}

%>
<%@ include file="../dbms/dbclose.jsp" %>