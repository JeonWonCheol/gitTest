<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%

if(login_id == null || login_id == "" || !login_id.equals("jeon"))
{
	//데이터베이스 연결을 종료한다.
	conn.close();
	%>
	<script>
	alert("관리자만 글을 작성할 수 있습니다");
	history.back();
	</script>	
	<%
	return;
}

%>

<script>
	window.onload = function()
	{
		document.post_notice_write.p_title.focus();
	}
	
	function DoCheck()
	{
		if( document.post_notice_write.p_title.value == "")
		{
			alert("제목을 입력하세요");
			document.post_notice_write.p_title.focus();
			return false;
		}
		if( document.post_notice_write.p_contents.value == "")
		{
			alert("공지 할 내용을 입력하세요");
			document.post_notice_write.p_contents.focus();
			return false;
		}
		if( confirm("게시물을 저장하시겠습니까?") != 1)
		{
			return false;
		}
		return true;
	}
</script>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd>
		<form name="post_notice_write" method="post" action="postwriteok.jsp?type=<%= type %>" onsubmit="return DoCheck()">
			<table border="0" class="post_table">
				<tr>
					<td colspan="6" style="text-align: center;" height="100px">공지사항</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align: center;" width="100px" height="50px">말머리</th>
					<th colspan="3" style="text-align: center;" width="550px">제목</th>
					<th style="text-align: center;" width="120px">작성자</th>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;" height="30px">
						<select required name="p_subject" style="vertical-align: middle; text-align-last: center">
							<option value="필독">필독</option>
							<option value="공지">공지</option>
						</select>
					</td>
					<td colspan="3" style="text-align: center;">
						<input style="width: 100%" type="text" name="p_title" placeholder="제목을 입력하세요.">
					</td>
					<td style="text-align: center;"><%= login_name %></td>
				</tr>
				<tr>
					<td colspan="6">
						<textarea style="width: 100%" name="p_contents" cols="26" rows="20" placeholder="공지사항을 입력하세요."></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="5">
						<a href="post.jsp?type=<%= type %>" class="btn mint">글목록</a>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<div class="btn_area">
							<button type="submit" id="btn_write">
								<span>글 작성 완료</span>
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</dd>
</dl>
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp" %>