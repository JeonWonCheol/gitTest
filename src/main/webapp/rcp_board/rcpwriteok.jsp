<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> 
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%

//파일이 업로드 될 경로
String uploadPath = "D:\\eclipse-workspace\\solo_project\\jsp_project02\\src\\main\\webapp\\upload";
//  D:\\eclipse-workspace\\solo_project\\jsp_project02\\src\\main\\webapp\\upload
//  D:\\jwc\\project\\jsp_project_02\\WebContent\\upload

//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;

//1. MultipartRequest를 사용하기 위해 com.oreilly.servlet 패키지를 import 해야한다.
//2. MultipartRequest는 객체를 생성하자마자 파일을 업로드한다.
//(request,파일저장경로(String),파일크기(int),인코딩방식 )
MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"euc-kr",new DefaultFileRenamePolicy());


//MultipartRequest를 사용하면 getParameter로 값을 전달 받지 못한다
//그래서 MultipartRequest의 getParameter를 이용하여 값을 전달 받는다.
String	 rcp_title 	  = multi.getParameter("rcp_title");

//String[] cook_explain = multi.getParameterValues("cook_explain");

//업로드된 파일명을 얻는다.
//Enumeration 는 데이터를 가져오는데 사용하는 클래스
Enumeration files = multi.getFileNames();

/* ===========================================================  
					데이터 유효성 검사 처리
=========================================================== */ 
if( rcp_title == null)
{
//데이터베이스 연결을 종료한다.
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
//데이터베이스 연결을 종료한다.
conn.close();	
if(type.equals("S")){%>
response.sendRedirect("rcp_share_write.jsp?type=<%= type %>");
<%}else{%>
response.sendRedirect("rcp_boast_write.jsp?type=<%= type %>");
<%}
return;
}

/* ===========================================================  
					게시물 자료 작은 따옴표  처리
=========================================================== */ 
rcp_title       = rcp_title.replace("'","''");
/*
for(int i=0; i<cook_explain.length; i++){
cook_explain[i]    = cook_explain[i].replace("'","''");
}
*/

/* ===========================================================  
						게시물 정보 입력 처리
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
						입력된 글 번호 얻기
=========================================================== */ 
sql = "select last_insert_id() as rcp_no ";
ResultSet result = stmt.executeQuery(sql);
result.next();
String rcp_no = result.getString("rcp_no");

/* ===========================================================  
						게시물 정보 입력 처리
=========================================================== */ 

String[] subcategory = multi.getParameterValues("subcategory");
if(subcategory != null)
{
	//data ← "A:밑반찬"
	//data ← "B:국/탕"			
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
						게시물 정보 입력 처리
=========================================================== */
if(type.equals("S"))
{ 
	int trCount = 1; //행번호
	
	for(trCount = 1; trCount < 11; trCount++)
	{
		//설명
		String name = "cook_explain_" + trCount; 				//name = 설명번호
		String cook_explain = multi.getParameter(name);			//name의 값을 cook_expalin에 넣는다
		
		if(cook_explain != null)
		{	
			//첨부파일
			name = "cook_attach_" + trCount;									//name = 설명번호
			String cook_attach_name = (String)multi.getFilesystemName(name);	//name의 값을 cook_attach_name에 넣는다
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