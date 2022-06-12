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
			location.href="../login/login.jsp?type=B";
		</script>
		<%
		return;
	}
%>

<script>
function rcpWriteCheck() 
{
	if (document.rcp_boast_write.rcp_title.value == "") 
	{
		alert("������ �Է��ϼ���");
		document.rcp_boast_write.rcp_title.focus();
		return false;
	}
	if (document.rcp_boast_write.cook_explain.value == "") 
	{
		alert("������ �Է��ϼ���");
		document.rcp_boast_write.cook_explain.focus();
		return false;
	}
	if (confirm("�Խù��� �����Ͻðڽ��ϱ�?") != 1) 
	{
		return false;
	}
	return true;
}

function setThumbnail(event) 
{ 	
	//�̹��� �̸�����
	var reader = new FileReader(); 
	reader.onload = function(event) 
	{ 
		var str = '<img src="'+event.target.result+'" width=500 height=400 id="image">' //var str �̹��� ��ũ�� ����
		$(str).prependTo('div#image_container'); //prependTo �� div id�� image_container �ΰ��� ó���� �߰�.
		$('#delBtn').show();
			$('#delBtn').click(function()
			{
				var obj  = $("#image");
				obj.remove();
				$('label[for=boast_picture]').remove();
				$('input[name=cook_sumbnail]').remove();
				var str = '<label for="boast_picture">Ŭ���ؼ� �̹����� ÷���غ�����!</label><input type="file" name="cook_sumbnail" id="boast_picture" accept="image/*" onchange="setThumbnail(event);"/>'
				$(str).prependTo('div#label_container'); 
				$('#delBtn').hide();
			});	
	}; 
	reader.readAsDataURL(event.target.files[0]); 
}


</script>

<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="rcp_boast_write" method="post" action="rcpwriteok.jsp?type=<%=type%>" onsubmit="return rcpWriteCheck()" enctype="multipart/form-data" >
			<table border="0" class="post_table">
				<tr>
					<td colspan="6" style="text-align: center;" height="100px">�丮�ڶ� �Խ��� ���ۼ�</td>
				</tr>
				<tr>
					<th style="text-align: center;" width="100px" height="50px">�ۼ���</th>
					<th style="text-align: center;" width="550px">����</th>
				</tr>
				<tr>
					<td style="text-align: center; font-weight: bold"><%=login_name%></td>
					<td>
						<input style="width: 98%" type="text" name="rcp_title" placeholder="������ �Է��ϼ���.">
					</td>
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
						<td colspan="2" style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">ī�װ�����</span></td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">������</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">��Ȳ��</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">��Ằ</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">�����</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">�׸���</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">����</span></td>
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
			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<tr>
					<td style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;">
						<span class="rcp_span_th">�丮�����ۼ�</span>
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid #E6E7E8;">
						<div class="view">
							<b>&nbsp;�丮����</b> 
							<span><i>Review</i></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="steppic" style="border-bottom: 1px solid #E6E7E8;">
						<div id="image_container" class="boast_input_file"><br>
							<div id="label_container" class="boast_input_file">
								<label for="boast_picture">
									  CLICK HERE!<br>Ŭ���ؼ� �̹����� ÷���غ�����! 
								</label>
							</div>
							<input type="file" name="cook_sumbnail" id="boast_picture" accept="image/*" onchange="setThumbnail(event);" />
							<button type="button" class="btnButton" id="delBtn" style="display:none" onclick="delImg()">�̹��� ����</button>
						</div>
					</td>
				</tr>
				<tr>
					<td style="height: 400px; padding: 40px 40px 40px 40px; vertical-align: top; border: auto; border-bottom: 1px solid #E6E7E8;">
						<textarea name="cook_explain" cols="160" rows="20" placeholder="������ �Է����ּ���"></textarea><br>
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px; border-bottom: 1px solid #E6E7E8;">
						<a href="boast.jsp" class="btn mint">�۸��</a>
					</td>
				</tr>
				<tr>
					<td align="center">
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
<%@ include file="../dbms/dbclose.jsp"%>
<%@ include file="../include/tail.jsp"%>