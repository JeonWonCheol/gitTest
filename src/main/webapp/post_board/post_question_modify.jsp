<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script>
	window.onload = function()
	{
		document.post_question_modify.modify_notice_title.focus();
	}
	
	function DoCheck()
	{
		if( document.postmodify.modifytitle.value == "")
		{
			alert("제목을 입력하세요");
			document.postmodify.modifytitle.focus();
			return false;
		}
		if( document.postmodify.modifycontents.value == "")
		{
			alert("내용을 입력하세요");
			document.postmodify.modifycontents.focus();
			return false;
		}
		if( confirm("변경된 게시물을 저장하시겠습니까?") != 1)
		{
			return false;
		}
		return true;
	}
</script>
<%
String p_no = request.getParameter("p_no");
String curpage = request.getParameter("page");
if( curpage == null ) curpage = "1";

/* ===========================================================  
						질문과 답변 게시물 수 얻기
=========================================================== */

String sql = "";
sql += "select count(*) as count ";
sql += "from post ";
sql += "where p_type = 'Q' ";

ResultSet result = stmt.executeQuery(sql);
result.next();
int total = result.getInt("count");
result.close();

/* ===========================================================  
						게시물 자료를 조회
=========================================================== */
sql  = "select p_no,u_no,p_title,p_type,p_contents,date_format(p_date, '%Y.%m.%d') as p_date,p_views,p_subject, ";
sql += "(select u_name from user where u_no = post.u_no) as p_writer ";
sql += "from post ";
sql += "where p_no = " + p_no;
result = stmt.executeQuery(sql);

if( result.next() == false)
{
	%>
	<script>
		window.onload = function()
		{
			alert("올바른 게시물 정보가 아닙니다.");
			history.back();
		}
	</script>
	<%@ include file="../dbms/dbclose.jsp" %>
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


%>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd>
		<form name="postmodify" method="post" action="postmodifyok.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>" onsubmit="return DoCheck();">
			<table border="0" class="post_table">
				<tr>
					<td colspan="5" style="text-align: center;" height="100px">질문과 답변</td>
				</tr>
				<tr>
					<th style="text-align: center;" width="100px" height="50px">글번호</th>
					<th style="text-align: center;" width="550px">제목</th>
					<th style="text-align: center;" width="140px">작성자</th>
					<th style="text-align: center;" width="100px">작성일</th>
					<th style="text-align: center;" width="100px">조회수</th>
				</tr>
				<tr>
					<td style="text-align: center;" height="30px"><%= total-- %></td>
					<td style="text-align: center;">
						<input type="text" name="modifytitle" style="width: 60%; height: 30px;" value="<%= p_title %>">
					</td>
					<td style="text-align: center;"><%= p_writer %></td>
					<td style="text-align: center;"><%= p_date %></td>
					<td style="text-align: center;"><%= p_views %></td>
				</tr>
				<tr>
					<td colspan="5">
						<textarea name="modifycontents" cols="170" rows="20" width="100%"><%= p_contents %></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="5">
						<a href="post_question_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%= p_no %>" class="btn mint">글수정 취소</a>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<div class="btn_area">
							<button type="submit" id="btn_modify">
								<span>글 수정 완료</span>
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</dd>
</dl>
<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>