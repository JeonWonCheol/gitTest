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
							페이징 변수 선언
	=========================================================== */
	int total = 0; //전체 게시물 갯수
	int maxpage = 0; //최대 페이지 갯수
	int curpage = 1; //현재 페이지 번호
	int startno = 0; //SQL limit 시작 번호
	int startBlock = 0; //페이징 시작 블럭 번호
	int endBlock = 0; //페이징 끝 블럭 번호

	//(3) "index.jsp?page=1" 에서 넘어온 page를 분석한다.
	if (request.getParameter("page") != null) {
		//넘어온 page 값을 정수형 curpage 로 변환한다. 
		curpage = Integer.parseInt(request.getParameter("page"));
	} else {
		//넘어온 page 값이 없으므로 현재 페이지 번호를 1로 설정한다. 
		curpage = 1;
	}

	/* ===========================================================  
						게시판 게시물 수 얻기
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

	//(5)최대 페이지 갯수를 계산한다.
	maxpage = total / 12;
	if (total % 12 != 0)
		maxpage++;

	
%>
<!--  ==================================================================================================-->
<!--  											분류 메뉴 TOP								  				-->
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
								<span>검색</span>
							</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!--  ======================================================================================================-->
		<!--  											분류 메뉴 BOTTOM								  				-->
		<!--  ======================================================================================================-->
		<table class="table_center" width="100%" cellspacing="0" cellpadding="0" style="background-color: white;">
			<tr>
				<td colspan="2" height="50px" style="color:blue;"><%=type.equals("S") ? ("총 " + total +  "개의 맛있는 요리 레시피가 있습니다.") : ("총 "  + total + "개의 맛있는 요리 후기가 있습니다.")%></td>
				<td colspan="2" style="text-align: right;">
					<%
						if (type.equals("S")) {
					%>
					<a href="rcp_share_write.jsp?type=<%=type%>" class="btn mint">글쓰기</a>
					<%
						}
						if (type.equals("B")) {
					%>
					<a href="rcp_boast_write.jsp?type=<%=type%>" class="btn mint">글쓰기</a>
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
											게시물 자료를 조회
					=========================================================== */
					sql = "select rcp_no,rcp_views,u_no,rcp_title,rcp_type,date_format(rcp_date, '%Y.%m.%d') as rcp_date, ";
					sql += "(select u_name from user where u_no = rcp.u_no) as rcp_writer, ";
					sql += "(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail ";
					sql += "from rcp ";
					sql += "where rcp_type = '" + type + "' ";
					sql += "order by rcp_no desc ";
					
					//(2) SQL의  limit 시작 번호를 계산한다. (1 based 페이지)
					startno = (curpage - 1) * 10;
					//(1) 페이지당 10개씩 가져오도록 limit 를 처리한다.
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
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; 조회수:<%=rcp_views %></span>
						<%} else {%>
						<a href="rcp_boast_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; 조회수:<%=rcp_views %></span>
					</td><%}
					}	
				}
					
				if(subcategory != null)
				{
					//data ← "A:밑반찬"
					//data ← "B:국/탕"			
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
												게시물 자료를 조회
						=========================================================== */
						sql = "select *,(select u_name from user where u_no = rcp.u_no) as rcp_writer,(select cook_sumbnail from cook where rcp_no = rcp.rcp_no order by rcp_no desc limit 0,1)as cook_sumbnail from rcp left outer join category ON rcp.rcp_no = category.rcp_no where rcp.rcp_type = 'S' and category.cat_sname = '"+cat_sname+"' order by rcp.rcp_no desc ";
						//(2) SQL의  limit 시작 번호를 계산한다. (1 based 페이지)
						startno = (curpage - 1) * 10;
						//(1) 페이지당 10개씩 가져오도록 limit 를 처리한다.
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
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; 조회수:<%=rcp_views %></span>
						<%} else {%>
						<a href="rcp_boast_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%=curpage%>"><img src="../upload/<%=cook_sumbnail%>"width=260 height=260></a>
						<br><span style="font-size:14px; font-weight:bold;"><%=rcp_title%></span>
						<br><span style="font-size:13px;"><%=rcp_writer%>&nbsp;<%=rcp_date%>&nbsp; 조회수:<%=rcp_views %></span>
					</td><%}
						
					}
				}	
			}%>
				
			</tr>
			<tr>
				<td colspan="5" style="text-align: center; height: 30px;" class="paging">
					<%
						//(8)페이징 시작블럭번호와 끝블럭 번호를 계산한다.(curpage: 현재 페이지 번호)
						startBlock = ((curpage - 1) / 10) * 10 + 1;
						endBlock = startBlock + 10 - 1;

						//(9)endBlock 이 최대 페이지 번호보다 크면 안됨.
						if (endBlock > maxpage) {
							//예: maxpage가 22인데, endBlock이 30이면 endBlock을 22로 변경
							endBlock = maxpage;
						}
						//이전 블럭
						if (startBlock >= 10) {
					%>
					<a href="rcp.jsp?type=<%=type%>&page=<%=startBlock - 1%>">< 이전</a>
					<%
						}

						//(10)최대 페이지 갯수 만큼 페이지를 표시한다.(&: 구분)
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
						//다음 블럭
						if (endBlock != maxpage) {
					%>
					<a href="rcp.jsp?type=<%=type%>&page=<%=endBlock + 1%>">다음 ></a>
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