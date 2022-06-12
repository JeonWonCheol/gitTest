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

function setThumbnail(event) 
{ 	
	var obj  = $("#image");
	obj.remove("");

	//이미지 미리보기
	var reader = new FileReader(); 
	reader.onload = function(event) 
	{ 
		 var str = '<img src="'+event.target.result+'" width=500 height=400 id="image">' //var str 이미지 링크를 저장
		 $(str).appendTo('div#image_container'); //appendTo 로 div id가 image_container 인곳에 추가.
	}; 
	reader.readAsDataURL(event.target.files[0]); 
		
}

</script>
<%
request.setCharacterEncoding("euc-kr");

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
System.out.println(sql);
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


/* ===========================================================  
						게시물 자료를 조회
=========================================================== */
sql = "select cook_no,cook_explain,cook_sumbnail ";
sql += "from cook ";
sql += "where rcp_no = " + rcp_no ;

System.out.println(sql);
result = stmt.executeQuery(sql);

result.next();
String cook_no = result.getString("cook_no");
String cook_explain = result.getString("cook_explain");
String cook_imagname = result.getString("cook_sumbnail");
System.out.println(cook_imagname);
result.close();
%>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd style="clear: both;">
		<form name="rcp_boast_modify" method="post" action="rcpmodifyok.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>" onsubmit="return DoCheck();" enctype="multipart/form-data">
			<table border="0" class="post_table">
				<tr>
					<td colspan="3" style="text-align: center;" height="100px">요리자랑 게시판</td>
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
				<tr>
					<td colspan="3">
						<div class="view">
							<b>&nbsp;요리리뷰</b>
							<span>
								<i>Review</i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="steppic" style="border-bottom: 1px solid #E6E7E8;">
						<div id="image_container"></div>
						<label for="cook_sumbnail">
							<img src="../upload/<%=cook_imagname%>" id="image" width=500 height=400>
						</label>
						<br>
						<input type="file" name="cook_sumbnail" id="cook_sumbnail" accept="image/*" onchange="setThumbnail(event);" />
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center" style="font-size: 13pt; height: 400px; padding: 40px 40px 40px 40px; vertical-align: top; border: auto; border-bottom: 1px solid #E6E7E8;">
						<textarea name="cook_explain" cols="160" rows="20"><%=cook_explain%></textarea>
						<input type="hidden" name="cook_no" value="<%=cook_no%>">
					</td>
				</tr>
				<tr>
					<td align="center" style="height: 80px;" colspan="3">
						<a href="rcp_boast_view.jsp?type=<%=type%>&rcp_no=<%=rcp_no%>&page=<%= curpage %>" class="btn mint">글수정 취소</a>
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
			<%@ include file="comment.jsp"%>
		</form>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>