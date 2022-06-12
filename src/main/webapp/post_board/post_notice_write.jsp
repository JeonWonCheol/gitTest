<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@ include file="../dbms/dbopen.jsp" %>
<%

if(login_id == null || login_id == "" || !login_id.equals("jeon"))
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();
	%>
	<script>
	alert("�����ڸ� ���� �ۼ��� �� �ֽ��ϴ�");
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
			alert("������ �Է��ϼ���");
			document.post_notice_write.p_title.focus();
			return false;
		}
		if( document.post_notice_write.p_contents.value == "")
		{
			alert("���� �� ������ �Է��ϼ���");
			document.post_notice_write.p_contents.focus();
			return false;
		}
		if( confirm("�Խù��� �����Ͻðڽ��ϱ�?") != 1)
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
					<td colspan="6" style="text-align: center;" height="100px">��������</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align: center;" width="100px" height="50px">���Ӹ�</th>
					<th colspan="3" style="text-align: center;" width="550px">����</th>
					<th style="text-align: center;" width="120px">�ۼ���</th>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;" height="30px">
						<select required name="p_subject" style="vertical-align: middle; text-align-last: center">
							<option value="�ʵ�">�ʵ�</option>
							<option value="����">����</option>
						</select>
					</td>
					<td colspan="3" style="text-align: center;">
						<input style="width: 100%" type="text" name="p_title" placeholder="������ �Է��ϼ���.">
					</td>
					<td style="text-align: center;"><%= login_name %></td>
				</tr>
				<tr>
					<td colspan="6">
						<textarea style="width: 100%" name="p_contents" cols="26" rows="20" placeholder="���������� �Է��ϼ���."></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="5">
						<a href="post.jsp?type=<%= type %>" class="btn mint">�۸��</a>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<div class="btn_area">
							<button type="submit" id="btn_write">
								<span>�� �ۼ� �Ϸ�</span>
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