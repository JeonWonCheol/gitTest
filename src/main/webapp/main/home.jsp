<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%
/* ===========================================================  
						게시물 자료를 조회
=========================================================== */

String sql = "";
sql = "select rcp_no,rcp_views,u_no,rcp_title,rcp_type,date_format(rcp_date, '%Y.%m.%d') as rcp_date, ";
sql += "(select u_name from user where u_no = rcp.u_no) as rcp_writer, ";
sql += "(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail ";
sql += "from rcp ";
sql += "where rcp_type = 'S' ";
sql += "order by rcp_views desc ";
sql += "limit 0,4 ";
System.out.println(sql);
ResultSet result = stmt.executeQuery(sql);

%>

<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<table width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
			<tr>
				<td colspan="2" style="height: 60px; border-bottom: 1px solid #E6E7E8;">
					<table border="0" style="width: 100%;">
						<tr>
							<td colspan="4" style="width: 100%; height: 50px; border-bottom: 1px solid #E6E7E8;">
								<h3 style="padding-left:20px">
									BEST<span id="g"> 레시피</span>
								</h3>
							</td>
						</tr>
						<tr>
							<%while (result.next() == true) 
							{
								String rcp_no = result.getString("rcp_no");
								String u_no = result.getString("u_no");
								String rcp_title = result.getString("rcp_title");
								String rcp_type = result.getString("rcp_type");
								String rcp_views    = result.getString("rcp_views");
								String rcp_date = result.getString("rcp_date");
								String rcp_writer = result.getString("rcp_writer");
								String cook_sumbnail = result.getString("cook_sumbnail");
							%>
							<td style="text-align: center; border-bottom: 1px solid #E6E7E8;">
								<a href="../rcp_board/rcp_share_view.jsp?type=S&rcp_no=<%=rcp_no%>&page=1">
									<img src="../upload/<%=cook_sumbnail%>" width=280 height=270>
								</a>
								<br>
								<span style="font-size:18px; font-weight:bold;"><%= rcp_title %></span>
								<br>
								<span style="font-size:15px; font-weight:bold;"><%= rcp_writer %></span>
							</td>
							<%}%>
						</tr>
					</table>
					<table border="0" style="width: 100%;">
						<tr>
							<td colspan="4" style="width: 100%; height: 50px; border-bottom: 1px solid #E6E7E8;">
								<h3 style="padding-left:20px">
									화제의<span id="g"> TV레시피</span>
								</h3>
							</td>
						</tr>
						<tr>
						<%  
							sql = "select rcp_no,rcp_title,rcp_type, ";
							sql += "(select u_name from user where u_no = rcp.u_no) as rcp_writer, ";
							sql += "(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail ";
							sql += "from rcp ";
							sql += "where rcp_type = 'S' and (rcp_title like '%TV레시피%') ";
							sql += "order by rcp_views desc ";
							sql += "limit 0,4 ";
							System.out.println(sql);
							result = stmt.executeQuery(sql);	
							System.out.println(sql);
							while (result.next() == true) 
							{
								String rcp_no = result.getString("rcp_no");
								String rcp_title = result.getString("rcp_title");
								String rcp_type = result.getString("rcp_type");
								String rcp_writer = result.getString("rcp_writer");
								String cook_sumbnail = result.getString("cook_sumbnail");
								
						%>
							<td style="text-align: center; border-bottom: 1px solid #E6E7E8;" width="25%">
								<a href="../rcp_board/rcp_share_view.jsp?type=S&rcp_no=<%=rcp_no%>">
									<img src="../upload/<%=cook_sumbnail%>" width=280 height=270>
								</a>
								<br>
								<span style="font-size:18px; font-weight:bold;"><%= rcp_title %></span>
								<br>
								<span style="font-size:15px; font-weight:bold;"><%= rcp_writer %></span>
							</td>
							<%}%>
						</tr>
					</table>
					<table border="0" style="width: 100%;">
						<tr>
							<td colspan="4" style="width: 100%; height: 50px; border-bottom: 1px solid #E6E7E8;">
								<h3 style="padding-left:20px">
									오늘<span id="g"> 뭐 먹지?</span>
								</h3>
							</td>
						</tr>
						<tr>
						<%  
						
						sql = "select rcp_no,rcp_views,u_no,rcp_title,rcp_type,date_format(rcp_date, '%Y.%m.%d') as rcp_date, ";
						sql += "(select u_name from user where u_no = rcp.u_no) as rcp_writer, ";
						sql += "(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail ";
						sql += "from rcp ";
						sql += "where rcp_type = 'S' ";
						sql += "order by rand() desc ";
						sql += "limit 0,4 ";
						System.out.println(sql);
						result = stmt.executeQuery(sql);	
						System.out.println(sql);
						while (result.next() == true) 
						{
							String rcp_no = result.getString("rcp_no");
							String rcp_title = result.getString("rcp_title");
							String rcp_type = result.getString("rcp_type");
							String rcp_writer = result.getString("rcp_writer");
							String cook_sumbnail = result.getString("cook_sumbnail");
								
						%>
							<td style="text-align: center; border-bottom: 1px solid #E6E7E8;" width="25%">
								<a href="../rcp_board/rcp_share_view.jsp?type=S&rcp_no=<%=rcp_no%>">
									<img src="../upload/<%=cook_sumbnail%>" width=280 height=270>
								</a>
								<br>
								<span style="font-size:18px; font-weight:bold;"><%= rcp_title %></span>
								<br>
								<span style="font-size:15px; font-weight:bold;"><%= rcp_writer %></span>
							</td>
							<%}%>
						</tr>
					</table>
					<br>
				</td>
			</tr>
		</table>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>
<%@ include file="../dbms/dbclose.jsp"%>