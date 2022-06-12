<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
<script>
function DoCheck()
{
	if( document.rcp_share_modify.modifytitle.value == "")
	{
		alert("������ �Է��ϼ���");
		document.postmodify.modifytitle.focus();
		return false;
	}
	if( confirm("����� �Խù��� �����Ͻðڽ��ϱ�?") != 1)
	{
		return false;
	}
	return true;
}

function setThumbnail(event, i) 
{ 	
	var obj  = $("#image"+i);
	obj.remove("");

	//�̹��� �̸�����
	var reader = new FileReader(); 
	reader.onload = function(event) 
	{ 
		 var str = '<img src="'+event.target.result+'" width=360 height=270 id="image'+i+'">' //var str �̹��� ��ũ�� ����
		 $(str).appendTo('div#image_container'+i); //appendTo �� div id�� image_container �ΰ��� �߰�.
	}; 
	reader.readAsDataURL(event.target.files[0]); 
		
}

</script>

<%



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
sql = "select u_no,rcp_title,rcp_type,rcp_writer,date_format(rcp_date, '%Y.%m.%d') as rcp_date ";
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
result.close();



/* ===========================================================  
						�Խù� ī�װ� ��ȸ
=========================================================== */

sql = "select cat_mcode,cat_mname,cat_scode,cat_sname ";
sql += "from category ";
sql += "where rcp_no = " + rcp_no;
result = stmt.executeQuery(sql);
System.out.println(sql);



%>

<script>
	window.onload = function()
	{
		<%
		while(result.next())
		{
			String cat_mcode = result.getString("cat_mcode");
			String cat_mname = result.getString("cat_mname");
			String cat_scode = result.getString("cat_scode");
			String cat_sname = result.getString("cat_sname");
			String category = cat_mcode+":"+cat_mname+":"+cat_scode+":"+cat_sname;
			System.out.println(category);
			%>
			//�Լ�ȣ��
			SetCheckBox("<%= category %>"); 
			<%
		}
		%>
	}
	
	function SetCheckBox(category)
	{
		//alert(category);
		$("input[type='checkbox']").each(function()
		{
			var chkval = $(this).val(); 
			if( chkval == category )
			{ 
				$(this).attr("checked", true ); 
			} 
		});		
	}
</script>

<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="rcp_share_modify" method="post" action="rcpmodifyok.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>" onsubmit="return DoCheck();" enctype="multipart/form-data">
			<table border="0" class="post_table">
				<tr>
					<td colspan="3" style="text-align: center;" height="100px">�丮���� �Խ��� �� ����</td>
				</tr>
				<tr>
					<th style="text-align: center; width: 100px; height: 50px; border-right: 1px solid #E6E7E8;">�ۼ���</th>
					<th style="text-align: center; width: 550px; border-right: 1px solid #E6E7E8;">����</th>
					<th style="text-align: center; width: 100px;">�ۼ���</th>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; font-weight: bold; border-right: 1px solid #E6E7E8;"><%=login_name%></td>
					<td style="width: 70%; font-weight: bold; border-right: 1px solid #E6E7E8;" align="center">
						<input type="text" name="modifytitle" style="width: 60%; height: 30px;" value="<%=rcp_title%>">
					</td>
					<td style="width: 15%; text-align: center;"><%=rcp_date%></td>
				</tr>
			</table>
			<!--  ==================================================================================================-->
			<!--  											�з� �޴� TOP								  				-->
			<!--  ==================================================================================================-->
			<table width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<colgroup>
					<col width="100px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2" style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">ī�װ�����</span>
						</td>
					</tr>
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
						<td style="border-bottom: 1px solid #E6E7E8;">
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
				</tbody>
			</table>
			<!--  ======================================================================================================-->
			<!--  											�з� �޴� BOTTOM								  				-->
			<!--  ======================================================================================================-->
			<table border="0" class="post_table">
				<tr>
					<td colspan="3" style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
						<span class="rcp_span_th">����ϼ���</span>
					</td>
				</tr>
				<tr>
					<td style="width: 35%; height:300px;" align="center" colspan="3">
						<div id="image_container0"></div>
						<label for="cook_attach_0">
						<%
							/* ===========================================================  
													�Խù� �ڷḦ ��ȸ
							=========================================================== */
							sql = "select cook_sumbnail ";
							sql += "from cook ";
							sql += "where rcp_no = " + rcp_no;
							result = stmt.executeQuery(sql);
							System.out.println(sql); 
							if(result.next()){
							String cook_sumbnail = result.getString("cook_sumbnail");
							%><img src="../upload/<%=cook_sumbnail %>" id="image0" width=360 height=270><%
							System.out.println(cook_sumbnail); 
							}
							result.close();
						 %>
						</label>
						<input type="file" name="cook_attach_0" id="cook_attach_0" accept="image/*" onchange="setThumbnail(event,0);" />
					</td>
				</tr>
				<tr>
					<td colspan="3" style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
						<span class="rcp_span_th">������������</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="view">
							<b>&nbsp;��������</b>
							<span>
								<i>Steps</i>
							</span>
						</div>
					</td>
					<td valign="bottom" style="color:red">�̹����� Ŭ���ϰų� ��ư�� ���� �̹����� ������ �� �ֽ��ϴ�</td>
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
						<input type="hidden" name="cook_no" value="<%=cook_no%>">
						<span class="rcp_span_th"><%=i%></span>
					</td>
					<td class="steptitle" style="width: 45%; padding-left: 30px; padding-right: 30px;">
						<textarea name="cook_explain_<%=i%>" cols="26" rows="10"><%=cook_explain%></textarea>
					</td>
					<td style="width: 35%;" align="center">
						<div id="image_container<%=i%>"></div>
						<label for="cook_attach_<%=i%>">
							<img src="../upload/<%=cook_imagname%>" id="image<%=i%>" width=360 height=270>
						</label>
						<input type="file" name="cook_attach_<%=i%>" id="cook_attach_<%=i%>" accept="image/*" onchange="setThumbnail(event,<%=i%>);" />
					</td>
				</tr>
				<%
					i++;
					}
				%>
				<tr>
					<td align="center" style="height: 80px;" colspan="3">
						<a href="rcp_share_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%= curpage %>" class="btn mint">�ۼ��� ���</a>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<div class="btn_area">
							<button type="submit" id="btn_modify">
								<span>�� ���� �Ϸ�</span>
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</dd>
</dl>

<%@ include file="../include/tail.jsp"%>