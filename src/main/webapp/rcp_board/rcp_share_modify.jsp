<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<script src="../include/category.js"></script>
<script>
function DoCheck()
{
	if( document.rcp_share_modify.modifytitle.value == "")
	{
		alert("제목을 입력하세요");
		document.postmodify.modifytitle.focus();
		return false;
	}
	if( confirm("변경된 게시물을 저장하시겠습니까?") != 1)
	{
		return false;
	}
	return true;
}

function setThumbnail(event, i) 
{ 	
	var obj  = $("#image"+i);
	obj.remove("");

	//이미지 미리보기
	var reader = new FileReader(); 
	reader.onload = function(event) 
	{ 
		 var str = '<img src="'+event.target.result+'" width=360 height=270 id="image'+i+'">' //var str 이미지 링크를 저장
		 $(str).appendTo('div#image_container'+i); //appendTo 로 div id가 image_container 인곳에 추가.
	}; 
	reader.readAsDataURL(event.target.files[0]); 
		
}

</script>

<%



/* ===========================================================  
						데이터 유효성 검사 처리
=========================================================== */
String rcp_no = request.getParameter("rcp_no");
String curpage = request.getParameter("page");
if( curpage == null ) curpage = "1";
if (rcp_no == null || rcp_no.equals("")) 
{
	%>
	올바른 자료가 전송되지 않았습니다.
	<br>
	<a href="index.jsp">목록으로 이동</a>
	<%
	return;	
}

/* ===========================================================  
						게시물 자료를 조회
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
	게시글이 없습니다.
	<br>
	<a href="index.jsp">목록으로 이동</a>
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
						게시물 카테고리 조회
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
			//함수호출
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
					<td colspan="3" style="text-align: center;" height="100px">요리공유 게시판 글 수정</td>
				</tr>
				<tr>
					<th style="text-align: center; width: 100px; height: 50px; border-right: 1px solid #E6E7E8;">작성자</th>
					<th style="text-align: center; width: 550px; border-right: 1px solid #E6E7E8;">제목</th>
					<th style="text-align: center; width: 100px;">작성일</th>
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
			<!--  											분류 메뉴 TOP								  				-->
			<!--  ==================================================================================================-->
			<table width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
				<colgroup>
					<col width="100px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2" style="padding-top: 10px; display: table-cell; border-bottom: 1px solid #E6E7E8;">
							<span class="rcp_span_th">카테고리수정</span>
						</td>
					</tr>
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
			<table border="0" class="post_table">
				<tr>
					<td colspan="3" style="padding-top: 10px; display: table-cell; border-right: 1px solid #E6E7E8; border-bottom: 1px solid #E6E7E8;">
						<span class="rcp_span_th">썸네일수정</span>
					</td>
				</tr>
				<tr>
					<td style="width: 35%; height:300px;" align="center" colspan="3">
						<div id="image_container0"></div>
						<label for="cook_attach_0">
						<%
							/* ===========================================================  
													게시물 자료를 조회
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
						<span class="rcp_span_th">조리순서수정</span>
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
					<td valign="bottom" style="color:red">이미지를 클릭하거나 버튼을 눌러 이미지를 수정할 수 있습니다</td>
				</tr>
				<%
					/* ===========================================================  
											게시물 자료를 조회
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
						<a href="rcp_share_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%= curpage %>" class="btn mint">글수정 취소</a>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<div class="btn_area">
							<button type="submit" id="btn_modify">
								<span>글 수정 완료</span>
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</dd>
</dl>

<%@ include file="../include/tail.jsp"%>