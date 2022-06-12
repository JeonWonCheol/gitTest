<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
		alert("제목을 입력하세요");
		document.rcp_boast_write.rcp_title.focus();
		return false;
	}
	if (document.rcp_boast_write.cook_explain.value == "") 
	{
		alert("내용을 입력하세요");
		document.rcp_boast_write.cook_explain.focus();
		return false;
	}
	if (confirm("게시물을 저장하시겠습니까?") != 1) 
	{
		return false;
	}
	return true;
}

function setThumbnail(event) 
{ 	
	//이미지 미리보기
	var reader = new FileReader(); 
	reader.onload = function(event) 
	{ 
		var str = '<img src="'+event.target.result+'" width=500 height=400 id="image">' //var str 이미지 링크를 저장
		$(str).prependTo('div#image_container'); //prependTo 로 div id가 image_container 인곳에 처음에 추가.
		$('#delBtn').show();
			$('#delBtn').click(function()
			{
				var obj  = $("#image");
				obj.remove();
				$('label[for=boast_picture]').remove();
				$('input[name=cook_sumbnail]').remove();
				var str = '<label for="boast_picture">클릭해서 이미지를 첨부해보세요!</label><input type="file" name="cook_sumbnail" id="boast_picture" accept="image/*" onchange="setThumbnail(event);"/>'
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
					<td colspan="6" style="text-align: center;" height="100px">요리자랑 게시판 글작성</td>
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
			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<tr>
					<td style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;">
						<span class="rcp_span_th">요리리뷰작성</span>
					</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid #E6E7E8;">
						<div class="view">
							<b>&nbsp;요리리뷰</b> 
							<span><i>Review</i></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="steppic" style="border-bottom: 1px solid #E6E7E8;">
						<div id="image_container" class="boast_input_file"><br>
							<div id="label_container" class="boast_input_file">
								<label for="boast_picture">
									  CLICK HERE!<br>클릭해서 이미지를 첨부해보세요! 
								</label>
							</div>
							<input type="file" name="cook_sumbnail" id="boast_picture" accept="image/*" onchange="setThumbnail(event);" />
							<button type="button" class="btnButton" id="delBtn" style="display:none" onclick="delImg()">이미지 삭제</button>
						</div>
					</td>
				</tr>
				<tr>
					<td style="height: 400px; padding: 40px 40px 40px 40px; vertical-align: top; border: auto; border-bottom: 1px solid #E6E7E8;">
						<textarea name="cook_explain" cols="160" rows="20" placeholder="내용을 입력해주세요"></textarea><br>
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px; border-bottom: 1px solid #E6E7E8;">
						<a href="boast.jsp" class="btn mint">글목록</a>
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