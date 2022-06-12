<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<table border="0" class="post_table">
<%if(login_id != null)
{%>
	<script>
		function CheckComment() 
		{
			if (document.postreply.r_contents.value == "")
			{
				alert("댓글 내용을 입력하세요");
				document.postreply.r_contents.focus();
				return false;
			}
			if (confirm("댓글을 작성하시겠습니까?") != 1)
			{
				return false;
			}
			return true;
		}
		
		function Checkdelete()
		{
			if( confirm("댓글을 삭제 하시겠습니까?") != 1)
			{
				return false;
			}
			return true;
		}
	</script>
	<form name="postreply" method="post" action="comment_writeok.jsp" onsubmit="return CheckComment();">
		<tr>
			<td align="center">
				<span class="spangreen">댓글</span>
			</td>
			<td colspan="2" align="center">
				<span class="spanred">바르고 예쁘고 고운말을 써주세요</span>
			</td>
		</tr>
		<tr>
			<input type="hidden" name="p_no" value="<%=p_no%>">
			<input type="hidden" name="u_no" value="<%=u_no%>">
			<td width="90px" align="center" style="font-weight: bold"><%=login_name%></td>
			<td>
				<input type="text" name="r_contents" style="width: 99%" placeholder="댓글을 남겨보세요">
			</td>
			<td width="110px" align="center">
				<button class="btnButton" type="submit">
					<span>댓글 등록</span>
				</button>
			</td>
		</tr>
	</form>
<%}
sql  = "select r_no,r_u_no,r_name,r_contents,date_format(r_date, '%Y.%m.%d') as r_date ";
sql += "from postreply ";
sql += "where p_no = '" + p_no + "' ";
sql += "order by r_no desc ";
System.out.println(sql);
result = stmt.executeQuery(sql);
		
while(result.next() == true)
{
	String r_no       = result.getString("r_no");
	String r_u_no     = result.getString("r_u_no");
	String r_name     = result.getString("r_name");
	String r_contents = result.getString("r_contents");
	String r_date     = result.getString("r_date");
	%>
	<tr>
		<td width="110px" align="center" style="font-weight:bold"><%= r_name %></td>
		<td>
			<%= r_contents %>
			<%
				if(login_id != null)
				{
					if( login_level.equals("A") || login_no.equals(r_u_no) )
					{
						//관리자 권한이거나 글을 작성한 본인인 경우....
						%>
			<span style="float:right;"><a href="comment_delete.jsp?p_no=<%= p_no %>&r_no=<%= r_no %>" onclick="return Checkdelete();">[댓글 삭제]</a></span>
			<%
					}
				}
				%>
		</td>
		<td width="110px" align="center"><%= r_date %></td>
	</tr>
<%
}
%>
</table>