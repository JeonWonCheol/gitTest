<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
<style>
table {
	border: 1px solid #E6E7E8;
}

.table_center td, tr, th {
	border: 1px solid #E6E7E8;
}
</style>
<%
	/* ===========================================================  
							����¡ ���� ����
	=========================================================== */
	int total = 0; //��ü �Խù� ����
	int maxpage = 0; //�ִ� ������ ����
	int curpage = 1; //���� ������ ��ȣ
	int startno = 0; //SQL limit ���� ��ȣ
	int startBlock = 0; //����¡ ���� �� ��ȣ
	int endBlock = 0; //����¡ �� �� ��ȣ

	//(3) "index.jsp?page=1" ���� �Ѿ�� page�� �м��Ѵ�.
	if (request.getParameter("page") != null) {
		//�Ѿ�� page ���� ������ curpage �� ��ȯ�Ѵ�. 
		curpage = Integer.parseInt(request.getParameter("page"));
	} else {
		//�Ѿ�� page ���� �����Ƿ� ���� ������ ��ȣ�� 1�� �����Ѵ�. 
		curpage = 1;
	}

	/* ===========================================================  
						�Խ��� �Խù� �� ���
	=========================================================== */

	String sql = "";
	sql += "select count(*) as count ";
	sql += "from rcp ";
	sql += "where rcp_type = '" + type + "' ";

	ResultSet result = stmt.executeQuery(sql);
	System.out.println(sql);
	result.next();
	total = result.getInt("count");
	result.close();

	//(5)�ִ� ������ ������ ����Ѵ�.
	maxpage = total / 12;
	if (total % 12 != 0)
		maxpage++;

	
%>
<!--  ==================================================================================================-->
<!--  											�з� �޴� TOP								  				-->
<!--  ==================================================================================================-->
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="searchcategory" method="post" action="rcp.jsp?type=<%=type%>">
			<table width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<colgroup>
					<col width="100px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">������</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck1" name='checkall1'>
									<label for="allcheck1">��ü</label>
									<input type="checkbox" id="cat_name1-1" class="check1" name="subcategory" value="A:������:A:�ع���">
									<label for="cat_name1-1">�ع���</label>
									<input type="checkbox" id="cat_name1-2" class="check1" name="subcategory" value="A:������:B:��/��">
									<label for="cat_name1-2">��/��</label>
									<input type="checkbox" id="cat_name1-3" class="check1" name="subcategory" value="A:������:C:����Ʈ">
									<label for="cat_name1-3">����Ʈ</label>
									<input type="checkbox" id="cat_name1-4" class="check1" name="subcategory" value="A:������:D:��/����">
									<label for="cat_name1-4">��/����</label>
									<input type="checkbox" id="cat_name1-5" class="check1" name="subcategory" value="A:������:E:���/�ҽ�">
									<label for="cat_name1-5">���/�ҽ�</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">��Ȳ��</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck2" name="subcategory">
									<label for="allcheck2">��ü</label>
									<input type="checkbox" id="cat_name2-1" class="check2" name="subcategory" value="B:��Ȳ��:A:�մ�����">
									<label for="cat_name2-1">�մ�����</label>
									<input type="checkbox" id="cat_name2-2" class="check2" name="subcategory" value="B:��Ȳ��:B:����Ʈ">
									<label for="cat_name2-2">����Ʈ</label>
									<input type="checkbox" id="cat_name2-3" class="check2" name="subcategory" value="B:��Ȳ��:C:��/����">
									<label for="cat_name2-3">��/����</label>
									<input type="checkbox" id="cat_name2-4" class="check2" name="subcategory" value="B:��Ȳ��:D:���/�ҽ�">
									<label for="cat_name2-4">���/�ҽ�</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">��Ằ</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck3" name="subcategory">
									<label for="allcheck3">��ü</label>
									<input type="checkbox" id="cat_name3-1" class="check3" name="subcategory" value="C:��Ằ:A:�Ұ��">
									<label for="cat_name3-1">�Ұ��</label>
									<input type="checkbox" id="cat_name3-2" class="check3" name="subcategory" value="C:��Ằ:B:�������">
									<label for="cat_name3-2">�������</label>
									<input type="checkbox" id="cat_name3-3" class="check3" name="subcategory" value="C:��Ằ:C:�߰��">
									<label for="cat_name3-3">�߰��</label>
									<input type="checkbox" id="cat_name3-4" class="check3" name="subcategory" value="C:��Ằ:D:�ع���">
									<label for="cat_name3-4">�ع���</label>
									<input type="checkbox" id="cat_name3-5" class="check3" name="subcategory" value="C:��Ằ:E:���">
									<label for="cat_name3-5">���</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">�����</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck4" name="subcategory">
									<label for="allcheck4">��ü</label>
									<input type="checkbox" id="cat_name4-1" class="check4" name="subcategory" value="D:�����:A:����">
									<label for="cat_name4-1">����</label>
									<input type="checkbox" id="cat_name4-2" class="check4" name="subcategory" value="D:�����:B:���̱�">
									<label for="cat_name4-2">���̱�</label>
									<input type="checkbox" id="cat_name4-3" class="check4" name="subcategory" value="D:�����:C:��ħ">
									<label for="cat_name4-3">��ħ</label>
									<input type="checkbox" id="cat_name4-4" class="check4" name="subcategory" value="D:�����:D:����">
									<label for="cat_name4-4">����</label>
									<input type="checkbox" id="cat_name4-5" class="check4" name="subcategory" value="D:�����:E:��ħ">
									<label for="cat_name4-5">��ħ</label>
									<input type="checkbox" id="cat_name4-6" class="check4" name="subcategory" value="D:�����:F:Ƣ��">
									<label for="cat_name4-6">Ƣ��</label>
									<input type="checkbox" id="cat_name4-7" class="check4" name="subcategory" value="D:�����:G:��">
									<label for="cat_name4-7">��</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">�׸���</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="cat_name5-1" class="check5" name="subcategory" value="E:�׸���:A:����/��Ƽ">
									<label for="cat_name5-1">����/��Ƽ</label>
									<input type="checkbox" id="cat_name5-2" class="check5" name="subcategory" value="E:�׸���:B:����/�Ʊ�">
									<label for="cat_name5-2">����/�Ʊ�</label>
									<input type="checkbox" id="cat_name5-3" class="check5" name="subcategory" value="E:�׸���:C:�ǰ�/����">
									<label for="cat_name5-3">�ǰ�/����</label>
									<input type="checkbox" id="cat_name5-4" class="check5" name="subcategory" value="E:�׸���:D:��ö�丮">
									<label for="cat_name5-4">��ö�丮</label>
									<input type="checkbox" id="cat_name5-5" class="check5" name="subcategory" value="E:�׸���:E:Į�θ���ź">
									<label for="cat_name5-5">Į�θ���ź</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">����</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8; padding-top: 5px; padding-bottom: 5px">
							<div>
								<div id="rcp_select" style="font-weight: bold; padding-left: 10px">
									<div id="result1" style="align: center; display: table-cell;"></div>
									<br>
									<div id="result2" style="align: center; display: table-cell;"></div>
									<br>
									<div id="result3" style="align: center; display: table-cell;"></div>
									<br>
									<div id="result4" style="align: center; display: table-cell;"></div>
									<br>
									<div id="result5" style="align: center; display: table-cell;"></div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" class="btn_area">
							<button type="submit" class="searchbtnButton">
								<span>�˻�</span>
							</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!--  ======================================================================================================-->
		<!--  											�з� �޴� BOTTOM								  				-->
		<!--  ======================================================================================================-->
		<table class="table_center" width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
			<tr>
				<td colspan="2" height="50px" style="color:blue;"><%=type.equals("S") ? ("�� " + total +  "���� ���ִ� �丮 �����ǰ� �ֽ��ϴ�.") : ("�� "  + total + "���� ���ִ� �丮 �ıⰡ �ֽ��ϴ�.")%></td>
				<td colspan="2" style="text-align: right;">
					<%
						if (type.equals("S")) {
					%>
					<a href="rcp_share_write.jsp?type=<%=type%>" class="btn mint">�۾���</a>
					<%
						}
						if (type.equals("B")) {
					%>
					<a href="rcp_boast_write.jsp?type=<%=type%>" class="btn mint">�۾���</a>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<%
				
				int i = 0;
				String[] subcategory = request.getParameterValues("subcategory");
				if(subcategory == null)
				{
					/* ===========================================================  
											�Խù� �ڷḦ ��ȸ
					=========================================================== */
					sql = "select rcp_no,rcp_views,u_no,rcp_title,rcp_type,date_format(rcp_date, '%Y.%m.%d') as rcp_date, ";
					sql += "(select u_name from user where u_no = rcp.u_no) as rcp_writer, ";
					sql += "(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail ";
					sql += "from rcp ";
					sql += "where rcp_type = '" + type + "' ";
					sql += "order by rcp_no desc ";
					
					//(2) SQL��  limit ���� ��ȣ�� ����Ѵ�. (1 based ������)
					startno = (curpage - 1) * 10;
					//(1) �������� 10���� ���������� limit �� ó���Ѵ�.
					sql += "limit " + startno + ",12";
					System.out.println(sql);
					result = stmt.executeQuery(sql);
					
					while (result.next() == true) 
					{
						i++;
						String rcp_no = result.getString("rcp_no");
						String u_no = result.getString("u_no");
						String rcp_title = result.getString("rcp_title");
						String rcp_type = result.getString("rcp_type");
						String rcp_views    = result.getString("rcp_views");
						String rcp_date = result.getString("rcp_date");
						String rcp_writer = result.getString("rcp_writer");
						String cook_sumbnail = result.getString("cook_sumbnail");
						%>
						
					<%if (i % 5 == 0) 
					{%>
				<tr>
				</tr>
				<tr>
					<%i = 1;}%>
					<td align="center" width="20%"><%if (type.equals("S")) {%>
						<a href="rcp_share_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; ��ȸ��:<%=rcp_views %></span>
						<%} else {%>
						<a href="rcp_boast_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; ��ȸ��:<%=rcp_views %></span>
					</td><%}
					}	
				}
					
				if(subcategory != null)
				{
					//data �� "A:�ع���"
					//data �� "B:��/��"			
					for(String data : subcategory)
					{
						String cat_mcode = "";
						String cat_mname = "";
						String cat_scode = "";
						String cat_sname = "";
						String [] ary = data.split(":");
						cat_mcode = ary[0];
						cat_mname = ary[1];
						cat_scode = ary[2];
						cat_sname = ary[3];
						/* ===========================================================  
												�Խù� �ڷḦ ��ȸ
						=========================================================== */
						sql = "select *,(select u_name from user where u_no = rcp.u_no) as rcp_writer,(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail from rcp left outer join category ON rcp.rcp_no = category.rcp_no where rcp.rcp_type = 'S' and category.cat_sname = '"+cat_sname+"' order by rcp.rcp_no desc ";
						//(2) SQL��  limit ���� ��ȣ�� ����Ѵ�. (1 based ������)
						startno = (curpage - 1) * 10;
						//(1) �������� 10���� ���������� limit �� ó���Ѵ�.
						sql += "limit " + startno + ",12";
						System.out.println(sql);
						result = stmt.executeQuery(sql);
						
						while (result.next() == true) 
						{
							i++;
							String rcp_no = result.getString("rcp_no");
							String u_no = result.getString("u_no");
							String rcp_title = result.getString("rcp_title");
							String rcp_type = result.getString("rcp_type");
							String rcp_date = result.getString("rcp_date");
							String rcp_views    = result.getString("rcp_views");
							String rcp_writer = result.getString("rcp_writer");
							String cook_sumbnail = result.getString("cook_sumbnail");
							%>
						
					<%if (i % 5 == 0) 
					{%>
				<tr>
				</tr>
				<tr>
					<%i = 1;}%>
					<td align="center" width="20%"><%if (type.equals("S")) {%>
						<a href="rcp_share_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; ��ȸ��:<%=rcp_views %></span>
						<%} else {%>
						<a href="rcp_boast_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; ��ȸ��:<%=rcp_views %></span>
					</td><%}
						
					}
				}	
			}%>
				
			</tr>
			<tr>
				<td colspan="5" style="text-align: center; height: 30px;" class="paging">
					<%
						//(8)����¡ ���ۺ���ȣ�� ���� ��ȣ�� ����Ѵ�.(curpage: ���� ������ ��ȣ)
						startBlock = ((curpage - 1) / 10) * 10 + 1;
						endBlock = startBlock + 10 - 1;

						//(9)endBlock �� �ִ� ������ ��ȣ���� ũ�� �ȵ�.
						if (endBlock > maxpage) {
							//��: maxpage�� 22�ε�, endBlock�� 30�̸� endBlock�� 22�� ����
							endBlock = maxpage;
						}
						//���� ��
						if (startBlock >= 10) {
					%>
					<a href="rcp.jsp?type=<%=type%>&page=<%=startBlock - 1%>">< ����</a>
					<%
						}

						//(10)�ִ� ������ ���� ��ŭ �������� ǥ���Ѵ�.(&: ����)
						for (int pageno = startBlock; pageno <= endBlock; pageno++) {
							if (curpage == pageno) {
					%><a href="rcp.jsp?type=<%=type%>&page=<%=pageno%>">
						<span style="color: black; font-weight: bold;"><%=pageno%></span>
					</a>
					|
					<%
						} else {
					%><a href="rcp.jsp?type=<%=type%>&page=<%=pageno%>"><%=pageno%></a>
					|
					<%
						}
						}
						//���� ��
						if (endBlock != maxpage) {
					%>
					<a href="rcp.jsp?type=<%=type%>&page=<%=endBlock + 1%>">���� ></a>
					<%
						}
					%>
				</td>
			</tr>
		</table>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>
<%@ include file="../dbms/dbclose.jsp"%>