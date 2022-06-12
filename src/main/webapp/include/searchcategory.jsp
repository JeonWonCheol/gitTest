<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!--  ==================================================================================================-->
<!--  											분류 메뉴 TOP								  				-->
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
							<span class="rcp_span_th">종류별</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck1" name='checkall1'>
									<label for="allcheck1">전체</label>
									<input type="checkbox" id="cat_name1-1" class="check1" name="subcategory" value="A:종류별:A:밑반찬">
									<label for="cat_name1-1">밑반찬</label>
									<input type="checkbox" id="cat_name1-2" class="check1" name="subcategory" value="A:종류별:B:국/탕">
									<label for="cat_name1-2">국/탕</label>
									<input type="checkbox" id="cat_name1-3" class="check1" name="subcategory" value="A:종류별:C:디저트">
									<label for="cat_name1-3">디저트</label>
									<input type="checkbox" id="cat_name1-4" class="check1" name="subcategory" value="A:종류별:D:면/만두">
									<label for="cat_name1-4">면/만두</label>
									<input type="checkbox" id="cat_name1-5" class="check1" name="subcategory" value="A:종류별:E:양념/소스">
									<label for="cat_name1-5">양념/소스</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">상황별</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck2" name="subcategory">
									<label for="allcheck2">전체</label>
									<input type="checkbox" id="cat_name2-1" class="check2" name="subcategory" value="B:상황별:A:손님접대">
									<label for="cat_name2-1">손님접대</label>
									<input type="checkbox" id="cat_name2-2" class="check2" name="subcategory" value="B:상황별:B:디저트">
									<label for="cat_name2-2">디저트</label>
									<input type="checkbox" id="cat_name2-3" class="check2" name="subcategory" value="B:상황별:C:면/만두">
									<label for="cat_name2-3">면/만두</label>
									<input type="checkbox" id="cat_name2-4" class="check2" name="subcategory" value="B:상황별:D:양념/소스">
									<label for="cat_name2-4">양념/소스</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">재료별</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck3" name="subcategory">
									<label for="allcheck3">전체</label>
									<input type="checkbox" id="cat_name3-1" class="check3" name="subcategory" value="C:재료별:A:소고기">
									<label for="cat_name3-1">소고기</label>
									<input type="checkbox" id="cat_name3-2" class="check3" name="subcategory" value="C:재료별:B:돼지고기">
									<label for="cat_name3-2">돼지고기</label>
									<input type="checkbox" id="cat_name3-3" class="check3" name="subcategory" value="C:재료별:C:닭고기">
									<label for="cat_name3-3">닭고기</label>
									<input type="checkbox" id="cat_name3-4" class="check3" name="subcategory" value="C:재료별:D:해물류">
									<label for="cat_name3-4">해물류</label>
									<input type="checkbox" id="cat_name3-5" class="check3" name="subcategory" value="C:재료별:E:곡물류">
									<label for="cat_name3-5">곡물류</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">방법별</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="allcheck4" name="subcategory">
									<label for="allcheck4">전체</label>
									<input type="checkbox" id="cat_name4-1" class="check4" name="subcategory" value="D:방법별:A:볶음">
									<label for="cat_name4-1">볶음</label>
									<input type="checkbox" id="cat_name4-2" class="check4" name="subcategory" value="D:방법별:B:끓이기">
									<label for="cat_name4-2">끓이기</label>
									<input type="checkbox" id="cat_name4-3" class="check4" name="subcategory" value="D:방법별:C:부침">
									<label for="cat_name4-3">부침</label>
									<input type="checkbox" id="cat_name4-4" class="check4" name="subcategory" value="D:방법별:D:조림">
									<label for="cat_name4-4">조림</label>
									<input type="checkbox" id="cat_name4-5" class="check4" name="subcategory" value="D:방법별:E:무침">
									<label for="cat_name4-5">무침</label>
									<input type="checkbox" id="cat_name4-6" class="check4" name="subcategory" value="D:방법별:F:튀김">
									<label for="cat_name4-6">튀김</label>
									<input type="checkbox" id="cat_name4-7" class="check4" name="subcategory" value="D:방법별:G:찜">
									<label for="cat_name4-7">찜</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">테마별</span>
						</td>
						<td style="border-bottom: 1px solid #E6E7E8;">
							<div>
								<div id="rcp_span" style="padding-top: 10px; display: table-cell;">
									<input type="checkbox" id="cat_name5-1" class="check5" name="subcategory" value="E:테마별:A:여성/뷰티">
									<label for="cat_name5-1">여성/뷰티</label>
									<input type="checkbox" id="cat_name5-2" class="check5" name="subcategory" value="E:테마별:B:엄마/아기">
									<label for="cat_name5-2">엄마/아기</label>
									<input type="checkbox" id="cat_name5-3" class="check5" name="subcategory" value="E:테마별:C:건강/질병">
									<label for="cat_name5-3">건강/질병</label>
									<input type="checkbox" id="cat_name5-4" class="check5" name="subcategory" value="E:테마별:D:제철요리">
									<label for="cat_name5-4">제철요리</label>
									<input type="checkbox" id="cat_name5-5" class="check5" name="subcategory" value="E:테마별:E:칼로리폭탄">
									<label for="cat_name5-5">칼로리폭탄</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">정렬</span>
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
								<span>검색</span>
							</button>
						</div>
					</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!--  ======================================================================================================-->
		<!--  											분류 메뉴 BOTTOM								  				-->
		<!--  ======================================================================================================-->