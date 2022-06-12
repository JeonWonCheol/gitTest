<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<script>
	function Checkdelete()
	{
		if( confirm("게시물을 삭제 하시겠습니까?") != 1)
		{
			return false;
		}
		return true;
	}
</script>
<%
String p_no    = request.getParameter("p_no");
String curpage = request.getParameter("page");
if( curpage == null ) curpage = "1";


/* ===========================================================  
						게시물 자료를 조회
=========================================================== */
String sql = "";
sql  = "select p_no,u_no,p_title,p_type,p_contents,date_format(p_date, '%Y.%m.%d') as p_date,p_views,p_subject, ";
sql += "(select u_name from user where u_no = post.u_no) as p_writer ";
sql += "from post ";
sql += "where p_no = " + p_no;

ResultSet result = stmt.executeQuery(sql);
if( result.next() == false)
{
stmt.close();
	%>
	<script>
	alert("게시글이 없습니다");
	history.back();
	</script>	
	<%
return;
}

String u_no       = result.getString("u_no");
String p_title    = result.getString("p_title");
String p_type 	  = result.getString("p_type");
String p_contents = result.getString("p_contents");
String p_date     = result.getString("p_date");
String p_views    = result.getString("p_views");
String p_writer   = result.getString("p_writer");
String p_subject  = result.getString("p_subject");
result.close();

//======================== 조회수를 증가시킨다. ========
sql = "update post set p_views = p_views + 1 where p_no = " + p_no;
System.out.println(sql);
System.out.println("====================================");
System.out.println("u_no:" + u_no);
System.out.println("login_no:" + login_no);
System.out.println("login_level:" + login_level);
System.out.println("====================================");
stmt.executeUpdate(sql);

%>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd>
		<table border="0" class="post_table">
			<tr>
				<td colspan="5" style="text-align: center;" height="100px">공지사항</td>
			</tr>
			<tr>
				<th style="text-align: center;" width="100px" height="50px">말머리</th>
				<th style="text-align: center;" width="550px">제목</th>
				<th style="text-align: center;" width="140px">작성자</th>
				<th style="text-align: center;" width="100px">작성일</th>
				<th style="text-align: center;" width="100px">조회수</th>
			</tr>
			<tr>
				<td style="text-align: center;" height="30px"><%= p_subject %></td>
				<td style="text-align: center;"><%= p_title %></td>
				<td style="text-align: center;"><%= p_writer %></td>
				<td style="text-align: center;"><%= p_date %></td>
				<td style="text-align: center;"><%= p_views %></td>
			</tr>
			<tr>
				<td colspan="5" style="height:400px; vertical-align:top; padding :50px"><%= p_contents %></td>
			</tr>
			<tr>
				<td align="center" style="height: 80px;" colspan="5">
					<a href="post.jsp?type=<%= type %>&page=<%= curpage %>" class="btn mint">글목록</a>
					<%if(login_level == null)
					{ %>
						<input type="hidden" name="hidden">
					<%}else if((login_level.equals("A"))){ %>
					<a href="post_notice_modify.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>" class="btn mint">글수정</a>
					<a href="delete.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>" class="btn mint" onclick="return Checkdelete();">글삭제</a>
					<%} %>
				</td>
			</tr>
		</table>
	</dd>
</dl>
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>