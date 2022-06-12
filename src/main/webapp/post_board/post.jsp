<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%

request.setCharacterEncoding("euc-kr");

/* ===========================================================  
						����¡ ���� ����
=========================================================== */
int total   = 0;  //��ü �Խù� ����
int maxpage = 0;  //�ִ� ������ ����
int curpage = 1;  //���� ������ ��ȣ
int startno = 0;  //SQL limit ���� ��ȣ
int startBlock = 0; //����¡ ���� �� ��ȣ
int endBlock   = 0; //����¡ �� �� ��ȣ

//(3) "index.jsp?page=1" ���� �Ѿ�� page�� �м��Ѵ�.
if( request.getParameter("page") != null)
{
	//�Ѿ�� page ���� ������ curpage �� ��ȯ�Ѵ�. 
	curpage = Integer.parseInt(request.getParameter("page"));
}else
{
	//�Ѿ�� page ���� �����Ƿ� ���� ������ ��ȣ�� 1�� �����Ѵ�. 
	curpage = 1;
}


/* ===========================================================  
					�Խ��� �Խù� �� ���
=========================================================== */

String sql = "";
sql += "select count(*) as count ";
sql += "from post ";
sql += "where p_type = '" + type + "' ";

ResultSet result = stmt.executeQuery(sql);
result.next();
total = result.getInt("count");
result.close();

//(5)�ִ� ������ ������ ����Ѵ�.
maxpage = total / 10;
if( total % 10 != 0) maxpage++;

/* ===========================================================  
						�Խù� �ڷḦ ��ȸ
=========================================================== */
sql  = "select p_no,u_no,p_title,p_type,p_contents,date_format(p_date, '%Y.%m.%d') as p_date,p_views,p_subject, ";
sql += "(select u_name from user where u_no = post.u_no) as p_writer ";
sql += "from post ";
sql += "where p_type = '" + type + "' ";
if(type.equals("N"))
{
	sql += "order by field(p_subject,'����'),p_no desc ";
}
else
{
	sql += "order by p_no desc ";
} 

//(2) SQL��  limit ���� ��ȣ�� ����Ѵ�. (1 based ������)
startno = (curpage - 1) * 10;
//(1) �������� 10���� ���������� limit �� ó���Ѵ�.
sql += "limit " + startno + ",10";

System.out.println(sql);
System.out.println("====================================");
System.out.println("login_level:" + login_level);
System.out.println("loginid:" + login_id);
System.out.println("type:" + type);
System.out.println("====================================");
result = stmt.executeQuery(sql);


%>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd>
		<table border="0" class="post_table">
			<tr>
				<td colspan="5" style="text-align: center;" height="100px;" border="none;">
					<%= type.equals("N") ? "��������" : "������ �亯" %>
				</td>
			</tr>
			<tr>
				<td colspan="4"></td>
				<td style="text-align: center;">
					<%if(type.equals("N") && login_level == null)
					{%>
						<input type="hidden" name="hidden">
						
					<%}else if(type.equals("N") && login_level.equals("A")){%>
						<a href="post_notice_write.jsp?type=<%= type %>" class="btn mint">�۾���</a>
					
					<%}else if(type.equals("Q")){%>
					<a href="post_question_write.jsp?type=<%= type %>" class="btn mint">�۾���</a>
					<%} %>
				</td>
			</tr>
			<tr>
				<th style="text-align: center;" width="100px" height="50px">
					<%= type.equals("N") ? "���Ӹ�" : "����" %>
				</th>
				<th style="text-align: center;" width="550px">����</th>
				<th style="text-align: center;" width="140px">�ۼ���</th>
				<th style="text-align: center;" width="100px">�ۼ���</th>
				<th style="text-align: center;" width="100px">��ȸ��</th>
			</tr>
			<%
			while(result.next() == true)
			{
				String p_no       = result.getString("p_no");
				String u_no       = result.getString("u_no");
				String p_title    = result.getString("p_title");
				String p_type 	  = result.getString("p_type");
				String p_contents = result.getString("p_contents");
				String p_date     = result.getString("p_date");
				String p_views    = result.getString("p_views");
				String p_writer   = result.getString("p_writer");
				String p_subject  = result.getString("p_subject");

			%>
			<tr>
				<td style="text-align: center; height: 30px; font-weight: bold">
					<%if(type.equals("N")){%><span style="color:#74B243;"><%= p_subject %></span>
					<%}else{%>
					<span style="color:#74B243;"><%= total-- %></span>
					<%}%>
				</td>
				<td>
					<%if(type.equals("N")){%>
					<a href="post_notice_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%=p_no%>"><%= p_title %></a>
					<%}else{%>
					<a href="post_question_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%=p_no%>"><%= p_title %></a>
					<%}%>
				</td>
				<td style="text-align: center;"><%= p_writer %></td>
				<td style="text-align: center;"><%= p_date %></td>
				<td style="text-align: center;"><%= p_views %></td>
			</tr>
			<%}%>
			<tr>
				<td colspan="5" style="text-align: center; height:30px;" class="paging">
				<%
		 		//(8)����¡ ���ۺ���ȣ�� ���� ��ȣ�� ����Ѵ�.(curpage: ���� ������ ��ȣ)
				startBlock = ( (curpage - 1)  / 10) * 10 + 1;
				endBlock   = startBlock + 10 - 1; 
				
				//(9)endBlock �� �ִ� ������ ��ȣ���� ũ�� �ȵ�.
				if( endBlock > maxpage)
				{
					//��: maxpage�� 22�ε�, endBlock�� 30�̸� endBlock�� 22�� ����
					endBlock = maxpage;
				}
				//���� ��
				if(startBlock >= 10)
				{
					%>
					<a href="post.jsp?type=<%= type %>&page=<%= startBlock - 1 %>">< ����</a>
					<%
				}
				
				//(10)�ִ� ������ ���� ��ŭ �������� ǥ���Ѵ�.(&: ����)
				for(int pageno = startBlock; pageno <= endBlock; pageno++)
				{
					if(curpage == pageno)
					{
						%><a href="post.jsp?type=<%= type %>&page=<%= pageno %>"><span style="color:black; font-weight: bold;"><%= pageno %></span></a> | <%
					}else
					{
						%><a href="post.jsp?type=<%= type %>&page=<%= pageno %>"><%= pageno %></a> | <%
					}
				}
				//���� ��
				if(endBlock != maxpage)
				{
					%>
					<a href="post.jsp?type=<%= type %>&page=<%= endBlock + 1 %>">����  ></a>
					<%
				}					
				%>	
				</td>
			</tr>
		</table>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>