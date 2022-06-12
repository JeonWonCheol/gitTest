<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<table border="0" class="post_table">
<%if(login_id != null)
{%>
	<script>
		function CheckComment() 
		{
			if (document.rcpreply.r_contents.value == "")
			{
				alert("댓글 내용을 입력하세요");
				document.rcpreply.r_contents.focus();
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
	<form name="rcpreply" method="post" action="comment_writeok.jsp?type=<%= type %>" onsubmit="return CheckComment();">
		<tr>
			<td align="center">
				<span class="spangreen">댓글</span>
			</td>
			<td colspan="2" align="center">
				<span class="spanred">바르고 예쁘고 고운말을 써주세요</span>
			</td>
		</tr>
		<tr>
			<input type="hidden" name="rcp_no" value="<%=rcp_no%>">
			<input type="hidden" name="u_no" value="<%=u_no%>">
			<td width="90px" align="center" style="font-weight: bold"><%=login_name%></td>
			<td>
				<input type="text" name="rcp_r_contents" style="width: 99%" placeholder="댓글을 남겨보세요">
			</td>
			<td width="110px" align="center">
				<button class="btnButton" type="submit">
					<span>댓글 등록</span>
				</button>
			</td>
		</tr>
	</form>
<%}
sql  = "select rcp_r_no,rcp_r_u_no,rcp_r_name,rcp_r_contents,date_format(rcp_r_date, '%Y.%m.%d') as rcp_r_date ";
sql += "from rcpreply ";
sql += "where rcp_no = '" + rcp_no + "' ";
sql += "order by rcp_r_no desc ";
System.out.println(sql);
result = stmt.executeQuery(sql);
		
while(result.next() == true)
{
	String rcp_r_no  = result.getString("rcp_r_no");
	String rcp_r_u_no  = result.getString("rcp_r_u_no");
	String rcp_r_name  = result.getString("rcp_r_name");
	String rcp_r_contents  = result.getString("rcp_r_contents");
	String rcp_r_date  = result.getString("rcp_r_date");
	%>
	<tr>
		<td width="110px" align="center" style="font-weight:bold"><%= rcp_r_name %></td>
		<td>
			<%= rcp_r_contents %>
			<%
				if(login_id != null)
				{
					if( login_level.equals("A") || login_no.equals(rcp_r_u_no) )
					{
						//관리자 권한이거나 글을 작성한 본인인 경우....
						%>
			<span style="float:right;"><a href="comment_delete.jsp?type=<%= type %>&rcp_no=<%= rcp_no %>&rcp_r_no=<%= rcp_r_no %>" onclick="return Checkdelete();">[댓글 삭제]</a></span>
			<%
					}
				}
				%>
				
		</td>
		<td width="110px" align="center"><%= rcp_r_date %></td>
	</tr>
<%
}
%>
</table>