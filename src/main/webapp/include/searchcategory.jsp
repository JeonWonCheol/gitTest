<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!--  ==================================================================================================-->
<!--  											�з� �޴� TOP								  				-->
<!--  ==================================================================================================-->
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="searchcategory" method="post" action="rcp.jsp?type=<%=type%>" enctype="multipart/form-data">
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
						<td style="border-bottom: 1px solid #E6E7E8; padding-top:5px; padding-bottom:5px">
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
						<td colspan="2" align="center">
						<div class="btn_area">
							<button type="submit" class=btnButton>
								<span>�˻�</span>
							</button>
						</div>
					</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!--  ======================================================================================================-->
		<!--  											�з� �޴� BOTTOM								  				-->
		<!--  ======================================================================================================-->