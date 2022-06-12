<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
<%
	if (login_id == null || login_id == "") 
	{
		//�����ͺ��̽� ������ �����Ѵ�.
		conn.close();
		%>
		<script>
			alert("�α��� �� �̿��Ͻ� �� �ֽ��ϴ�");
			location.href="../login/login.jsp?type=S";
		</script>
		<%
		return;
	}
%>
<script>
	function Checkdelete()
	{
		if( confirm("�Խù��� ���� �Ͻðڽ��ϱ�?") != 1)
		{
			return false;
		}
		return true;
	}
</script>
<%
request.setCharacterEncoding("euc-kr");

/* ===========================================================  
						������ ��ȿ�� �˻� ó��
=========================================================== */
String rcp_no = request.getParameter("rcp_no");
String curpage = request.getParameter("page");
if( curpage == null ) curpage = "1";

if (rcp_no == null || rcp_no.equals("")) 
{
%>
	�ùٸ� �ڷᰡ ���۵��� �ʾҽ��ϴ�.
	<br>
	<a href="index.jsp">������� �̵�</a>
	<%
	return;
}

/* ===========================================================  
						�Խù� �ڷḦ ��ȸ
=========================================================== */
String sql = "";
sql = "select u_no,rcp_views,rcp_title,rcp_type,rcp_writer,date_format(rcp_date, '%Y.%m.%d') as rcp_date ";
sql += "from rcp ";
sql += "where rcp_no = " + rcp_no;
ResultSet result = stmt.executeQuery(sql);

if (result.next() == false) 
{
	stmt.close();
	%>
	�Խñ��� �����ϴ�.
	<br>
	<a href="index.jsp">������� �̵�</a>
	<%
	return;
}

String u_no = result.getString("u_no");
String rcp_title = result.getString("rcp_title");
String rcp_type = result.getString("rcp_type");
String rcp_writer = result.getString("rcp_writer");
String rcp_date = result.getString("rcp_date");
String rcp_views = result.getString("rcp_views");
result.close();

//======================== ��ȸ���� ������Ų��. ========
sql = "update rcp set rcp_views = rcp_views + 1 where rcp_no = " + rcp_no;
stmt.executeUpdate(sql);
%>

<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<table border="0" class="post_table">
			<tr>
				<td colspan="4" style="text-align: center;" height="100px">�丮���� �Խ���</td>
			</tr>
			<tr>
				<th style="text-align: center; width: 100px; height: 50px; border-right: 1px solid #E6E7E8;">�ۼ���</th>
				<th style="text-align: center; width: 550px; border-right: 1px solid #E6E7E8;">����</th>
				<th style="text-align: center; width: 100px;">�ۼ���</th>
				<th style="text-align: center; width: 100px;">��ȸ��</th>
			</tr>
			<tr>
				<td style="width: 10%; text-align: center; font-weight: bold; border-right: 1px solid #E6E7E8;"><%=login_name%></td>
				<td style="width: 70%; font-weight: bold; border-right: 1px solid #E6E7E8;" align="center"><%=rcp_title%></td>
				<td style="width: 10%; text-align: center;"><%=rcp_date%></td>
				<td style="width: 10%; text-align: center;"><%=rcp_views%></td>
			</tr>
		</table>
		<table border="0" class="post_table">
			<tr>
				<td colspan="4">
					<div class="view">
						<b>&nbsp;��������</b>
						<span>
							<i>Steps</i>
						</span>
					</div>
				</td>
			</tr>
			<%
				/* ===========================================================  
										�Խù� �ڷḦ ��ȸ
				=========================================================== */
				sql = "select cook_no,cook_explain,cook_attach ";
				sql += "from cook ";
				sql += "where rcp_no = " + rcp_no;

				result = stmt.executeQuery(sql);
				System.out.println(sql);
				int i = 1;
				while (result.next()) {
					String cook_no = result.getString("cook_no");
					String cook_explain = result.getString("cook_explain");
					String cook_imagname = result.getString("cook_attach");
			%>
			<tr>
				<td align="center" style="width: 20%;">
					<span class="rcp_span_th"><%=i%></span>
				</td>
				<td class="steptitle" style="width: 45%; padding-left: 30px; padding-right: 30px;"><%=cook_explain%></td>
				<td style="width: 35%;" align="center">
					<div id="image_container1"></div>
					<img src="../upload/<%=cook_imagname%>" width=360 height=270>
				</td>
				<%
					i++;
					}
				%>
			</tr>
			<tr>
				<td align="center" style="height: 80px; border-bottom: 1px solid #E6E7E8;" colspan="4">
					<%if(login_level == null)
					{ %>
						<input type="hidden" name="hidden">
					<%}else if((login_level.equals("A") || u_no.equals(login_no) )){ %>
					<a href="rcp.jsp?type=<%=type%>&page=<%= curpage %>" class="btn mint">�۸��</a>
					&nbsp;|&nbsp;
					<a href="rcp_share_modify.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%= curpage %>" class="btn mint">�ۼ���</a>
					&nbsp;|&nbsp;
					<a href="delete.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>" class="btn mint" onclick="return Checkdelete();">�ۻ���</a>
					<%} %>
				</td>
			</tr>
		</table>
		<%@ include file="comment.jsp"%>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>
<%@ include file="../dbms/dbclose.jsp"%>