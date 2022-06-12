<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("euc-kr");
String type    = request.getParameter("type");

	/* ===========================================================  
							���ǿ��� �α��� ������ �����´�.
	=========================================================== */
	String login_id    = (String) session.getAttribute("u_id");
	String login_no    = (String) session.getAttribute("u_no");
	String login_name  = (String) session.getAttribute("u_name");
	String login_level = (String) session.getAttribute("u_level");
%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<link rel="stylesheet" type="text/css" href="../css/join.css">
<link rel="stylesheet" type="text/css" href="../css/login.css">
<link rel="stylesheet" type="text/css" href="../css/yore.css">
<script src="../js/jquery-3.6.0.js"></script>
<title>�䷹</title>
</head>
<body>
	<div id='wrap'>
		<section>
			<table border="0" style="width: 100%; height: 60px;">
				<tr>
					<td width="20%"></td>
					<td width="20%"></td>
					<td width="20%">
						<a href="../main/home.jsp?type=H">
							<img src="../picture/yorelogo.jpg" width="200px" height="150px" style="display: block; margin: 0 auto;">
						</a>
					</td>
					<td width="20%"></td>
					<td style="vertical-align: bottom; text-align: light; padding-bottom: 15px;" width="20%">
						<%
							if (login_id == null) {
								//============ �α��� ���� ���� ============
						%>
						<a href="../join/join.jsp?type=" class="btn mint">ȸ������</a>
						<a href="../login/login.jsp?type=" class="btn mint">�α���</a>
						<%
							} else {
								//============ �α��� �� ��� ===========
						%>
						<span style="color: green"><%=login_name%></span>
						<span>�� �ݰ����ϴ�.</span>
						&nbsp;&nbsp;
						<span>
							<a href="../login/logout.jsp?type=" class="btn mint">�α׾ƿ�</a>
						</span>
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<div class="menu_wrap">
				<ul class="menu">
				<%
					if(type.equals("N"))
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1"><span style="color: #FFFF16">��������</span></a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S">�丮����</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B">�ڶ��ϱ�</a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1">�ñ��ؿ�</a></li>
				  <%}
				  
				  	else if(type.equals("S"))
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1">��������</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S"><span style="color: #FFFF16">�丮����</span></a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B">�ڶ��ϱ�</a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1">�ñ��ؿ�</a></li>
				  <%}
				  
				 	else if(type.equals("B"))
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1">��������</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S">�丮����</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B"><span style="color: #FFFF16">�ڶ��ϱ�</span></a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1">�ñ��ؿ�</a></li>
				  <%}
				  
				    else if(type.equals("Q"))
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1">��������</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S">�丮����</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B">�ڶ��ϱ�</a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1"><span style="color: #FFFF16">�ñ��ؿ�</span></a></li>
				  <%}
				  
				 	else if(type.equals("H"))
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1">��������</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S">�丮����</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B">�ڶ��ϱ�</a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1">�ñ��ؿ�</a></li>
					<%} 
					
					else if( type == null || type.equals("") )
					{ %>
					<li><a href="../post_board/post.jsp?type=N&page=1">��������</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=S">�丮����</a></li>
					<li><a href="../rcp_board/rcp.jsp?type=B">�ڶ��ϱ�</a></li>
					<li><a href="../post_board/post.jsp?type=Q&page=1">�ñ��ؿ�</a></li>
					<%} %>
				</ul>
			</div>