<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
<%
	if (login_id == null || login_id == "") 
	{
		//데이터베이스 연결을 종료한다.
		conn.close();
		%>
		<script>
			alert("로그인 후 이용하실 수 있습니다");
			location.href="../login/login.jsp?type=S";
		</script>
		<%
		return;
	}
%>


<script>
	window.onload = function() {
		document.rcp_share_write.rcp_title.focus();
	}

	function rcpWriteCheck() {
		if (document.rcp_share_write.rcp_title.value == "") {
			alert("제목을 입력하세요");
			document.rcp_share_write.rcp_title.focus();
			return false;
		}
		if (confirm("게시물을 저장하시겠습니까?") != 1) {
			return false;
		}
		return true;
	}

	 function addRow() {
		var trCnt = $('#cook_step tr').length-3;
		if(trCnt < 11){
			
			var innerHtml = "";
			innerHtml += '<tr>'
			innerHtml += '<td><div style="text-align:center"><span class="rcp_span_th">'+trCnt+'</span></div></td>'
			innerHtml += '<td><textarea name="cook_explain_' + trCnt + '" cols="26" rows="10" class="rowtextarea" placeholder="조리과정을 입력하세요."></textarea></td>'
			innerHtml += '<td align="center"><div id="image_container'+trCnt+'"><input type="file" name="cook_attach_'+trCnt+'" id="image'+trCnt+'" accept="image/*" onchange="setThumbnail(event,'+trCnt+');"/>'
			innerHtml += '<button type="button" class="btnButton" id="delBtn'+trCnt+'" style="display:none" onclick="delImg('+trCnt+')">이미지 삭제</button></div></td>'
			innerHtml += '</tr>';
			
			$('#cook_step > tbody:last').append(innerHtml);
			
		}else{
			alert("최대 10개까지만 가능합니다.");
			return false;
		}
	}
	
	function deleteRow(rownum) {
		// table element 찾기
		const table = document.getElementById('cook_step');

		// 행(Row) 삭제
		const newRow = table.deleteRow(rownum);
	} 			
	
	
	function setThumbnail(event, trCnt) 
	{ 	
		//이미지 미리보기
		var reader = new FileReader(); 
		reader.onload = function(event) 
		{ 
			var str = '<img src="'+event.target.result+'" width=360 height=270 id="image'+trCnt+'">' //var str 이미지 링크를 저장
			$(str).prependTo('div#image_container'+trCnt); //prependTo 로 div id가 image_container 인곳에 처음에 추가.
			$('#delBtn'+trCnt).show();
				$('#delBtn'+trCnt).click(function()
				{
					var obj  = $("#image"+trCnt);
					obj.remove("");
					$('input[name=cook_attach_'+trCnt+']').remove("");
					var str = '<input type="file" name="cook_attach_'+trCnt+'" id="image'+trCnt+'" accept="image/*" onchange="setThumbnail(event,'+trCnt+');"/>'
					$(str).prependTo('div#image_container'+trCnt); //appendTo 로 div id가 image_container 인곳에 마지막에 추가.
					$('#delBtn'+trCnt).hide();
				});	
		}; 
		reader.readAsDataURL(event.target.files[0]); 
	}
	
/* 
	function delImg(trCnt)
	{
		var obj  = $("#image"+trCnt);
		obj.remove("");
 		$('#delBtn'+trCnt).hide();
 		var str = '<input type="file" name="cook_attach_'+trCnt+'" id="image'+trCnt+'" accept="image/*" onchange="setThumbnail(event,'+trCnt+');"/>'
		$(str).appendTo('div#image_container'+trCnt);
	}  */
	
</script>

<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="rcp_share_write" method="post" action="rcpwriteok.jsp?type=<%=type%>" onsubmit="return rcpWriteCheck()" enctype="multipart/form-data">
			<table border="0" class="post_table">
				<tr>
					<td colspan="6" style="text-align: center;" height="100px">요리공유 게시판 글작성</td>
				</tr>
				<tr>
					<th style="text-align: center;" width="100px" height="50px">작성자</th>
					<th style="text-align: center;" width="550px">제목</th>
				</tr>
				<tr>
					<td style="text-align: center; font-weight: bold"><%=login_name%></td>
					<td>
						<input style="width: 98%" type="text" name="rcp_title" placeholder="제목을 입력하세요.">
					</td>
				</tr>
			</table>
			<!--  ==================================================================================================-->
			<!--  											분류 메뉴 TOP								  				-->
			<!--  ==================================================================================================-->
			<table width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<colgroup>
					<col width="100px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2" style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">카테고리선택</span></td>
					</tr>
					<tr>
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">종류별</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">상황별</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">재료별</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">방법별</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">테마별</span></td>
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
						<td style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;"><span class="rcp_span_th">정렬</span></td>
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
			<!--  											분류 메뉴 BOTTOM								  				-->
			<!--  ======================================================================================================-->
			<table border="0" class="post_table" id="cook_step">
				<thead>
					<tr>
						<td colspan="3" style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">조리순서작성</span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="view">
								<b>&nbsp;조리순서</b>
								<span>
									<i>Steps</i>
								</span>
							</div>
						</td>
						<td align="center">
							<input type='button' class="btnButton" value='조리과정 추가하기' onclick='addRow()' />
							<input type='button' class="btnButton" value='조리과정 삭제하기' onclick='deleteRow(-1)' />
						</td>
					</tr>
				</thead>
				<tbody id="tbody">
					<tr>
						<td style="width: 35%; height:30px; color:red;" align="center" colspan="3">
							썸네일 사진을 올려주세요!
						</td>
					</tr>
					<tr>
						<td style="width: 35%; height:300px;" align="center" colspan="3">
							<div id="image_container0">
							<input type="file" name="cook_attach_0" id="image0" accept="image/*" onchange="setThumbnail(event,0);" />
							<button type="button" class="btnButton" id="delBtn0" style="display: none" onclick="delImg(0)">이미지 삭제</button>
							</div>
						</td>
					</tr>
					<tr>
						<td align="center" style="width: 20%;">
							<span class="rcp_span_th">1</span>
						</td>
						<td class="steptitle" style="width: 45%;">
							<textarea name="cook_explain_1" cols="26" rows="10" placeholder="조리과정을 입력하세요."></textarea>
							<br>
						</td>
						<td style="width: 35%;" align="center">
							<div id="image_container1">
							<input type="file" name="cook_attach_1" id="image1" accept="image/*" onchange="setThumbnail(event,1);" />
							<button type="button" class="btnButton" id="delBtn1" style="display: none" onclick="delImg(1)">이미지 삭제</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<tr>
					<td colspan="5" align="center" style="height: 80px; border-bottom: 1px solid #E6E7E8;">
						<a href="rcp.jsp?type=<%=type%>" class="btn mint">글목록</a>
					</td>
				</tr>
				<tr>
					<td align="center">
						<div class="btn_area">
							<button type="submit" id="btn_write">
								<span>글쓰기 완료</span>
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