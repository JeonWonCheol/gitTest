<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp" %>
<%

if(login_id == null || login_id == "")
{
	//�����ͺ��̽� ������ �����Ѵ�.
	conn.close();
	%>
	<script>
	alert("�α��� ���ּ���");
	history.back();
	</script>	
	<%
	return;
}

%>

<script>
	window.onload = function()
	{
		document.post_question_write.p_title.focus();
	}
	
	function DoCheck()
	{
		if( document.post_question_write.p_title.value == "")
		{
			alert("������ �Է��ϼ���");
			document.post_question_write.p_title.focus();
			return false;
		}
		if( document.post_question_write.p_contents.value == "")
		{
			alert("���� �� ������ �Է��ϼ���");
			document.post_question_write.p_contents.focus();
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
		<form name="post_question_write" method="post" action="postwriteok.jsp?type=<%= type %>" onsubmit="return DoCheck()">
			<table border="0" class="post_table">
				<tr>
					<td colspan="5" style="text-align: center;" height="100px">������ �亯</td>
					<input type="hidden" name="p_subject" value="Q">
				</tr>
				<tr>
					<td colspan="5" style="text-align: center;">
						<input type="text" name="p_title" style="width: 100%; height: 30px;" placeholder="������ �Է��ϼ���.">
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<textarea style="width: 100%" name="p_contents" cols="26" rows="30" placeholder="���������� �Է��ϼ���."></textarea>
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
								<span>�۾��� �Ϸ�</span>
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</dd>
</dl>
<%@ include file="../dbms/dbclose.jsp" %>
<%@ include file="../include/tail.jsp"%>