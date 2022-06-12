<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%@ include file="../dbms/dbopen.jsp"%>
<%

request.setCharacterEncoding("euc-kr");

/* ===========================================================  
						페이징 변수 선언
=========================================================== */
int total   = 0;  //전체 게시물 갯수
int maxpage = 0;  //최대 페이지 갯수
int curpage = 1;  //현재 페이지 번호
int startno = 0;  //SQL limit 시작 번호
int startBlock = 0; //페이징 시작 블럭 번호
int endBlock   = 0; //페이징 끝 블럭 번호

//(3) "index.jsp?page=1" 에서 넘어온 page를 분석한다.
if( request.getParameter("page") != null)
{
	//넘어온 page 값을 정수형 curpage 로 변환한다. 
	curpage = Integer.parseInt(request.getParameter("page"));
}else
{
	//넘어온 page 값이 없으므로 현재 페이지 번호를 1로 설정한다. 
	curpage = 1;
}


/* ===========================================================  
					게시판 게시물 수 얻기
=========================================================== */

String sql = "";
sql += "select count(*) as count ";
sql += "from post ";
sql += "where p_type = '" + type + "' ";

ResultSet result = stmt.executeQuery(sql);
result.next();
total = result.getInt("count");
result.close();

//(5)최대 페이지 갯수를 계산한다.
maxpage = total / 10;
if( total % 10 != 0) maxpage++;

/* ===========================================================  
						게시물 자료를 조회
=========================================================== */
sql  = "select p_no,u_no,p_title,p_type,p_contents,date_format(p_date, '%Y.%m.%d') as p_date,p_views,p_subject, ";
sql += "(select u_name from user where u_no = post.u_no) as p_writer ";
sql += "from post ";
sql += "where p_type = '" + type + "' ";
if(type.equals("N"))
{
	sql += "order by field(p_subject,'공지'),p_no desc ";
}
else
{
	sql += "order by p_no desc ";
} 

//(2) SQL의  limit 시작 번호를 계산한다. (1 based 페이지)
startno = (curpage - 1) * 10;
//(1) 페이지당 10개씩 가져오도록 limit 를 처리한다.
sql += "limit " + startno + ",10";

System.out.println(sql);
System.out.println("====================================");
System.out.println("login_level:" + login_level);
System.out.println("loginid:" + login_id);
System.out.println("type:" + type);
System.out.println("====================================");
result = stmt.executeQuery(sql);


%>
<dl style="width: 1240px; margin-right: auto; margin-left: auto;">
	<dd>
		<table border="0" class="post_table">
			<tr>
				<td colspan="5" style="text-align: center;" height="100px;" border="none;">
					<%= type.equals("N") ? "공지사항" : "질문과 답변" %>
				</td>
			</tr>
			<tr>
				<td colspan="4"></td>
				<td style="text-align: center;">
					<%if(type.equals("N") && login_level == null)
					{%>
						<input type="hidden" name="hidden">
						
					<%}else if(type.equals("N") && login_level.equals("A")){%>
						<a href="post_notice_write.jsp?type=<%= type %>" class="btn mint">글쓰기</a>
					
					<%}else if(type.equals("Q")){%>
					<a href="post_question_write.jsp?type=<%= type %>" class="btn mint">글쓰기</a>
					<%} %>
				</td>
			</tr>
			<tr>
				<th style="text-align: center;" width="100px" height="50px">
					<%= type.equals("N") ? "말머리" : "순번" %>
				</th>
				<th style="text-align: center;" width="550px">제목</th>
				<th style="text-align: center;" width="140px">작성자</th>
				<th style="text-align: center;" width="100px">작성일</th>
				<th style="text-align: center;" width="100px">조회수</th>
			</tr>
			<%
			while(result.next() == true)
			{
				String p_no       = result.getString("p_no");
				String u_no       = result.getString("u_no");
				String p_title    = result.getString("p_title");
				String p_type 	  = result.getString("p_type");
				String p_contents = result.getString("p_contents");
				String p_date     = result.getString("p_date");
				String p_views    = result.getString("p_views");
				String p_writer   = result.getString("p_writer");
				String p_subject  = result.getString("p_subject");

			%>
			<tr>
				<td style="text-align: center; height: 30px; font-weight: bold">
					<%if(type.equals("N")){%><span style="color:#74B243;"><%= p_subject %></span>
					<%}else{%>
					<span style="color:#74B243;"><%= total-- %></span>
					<%}%>
				</td>
				<td>
					<%if(type.equals("N")){%>
					<a href="post_notice_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%=p_no%>"><%= p_title %></a>
					<%}else{%>
					<a href="post_question_view.jsp?type=<%= type %>&page=<%= curpage %>&p_no=<%=p_no%>"><%= p_title %></a>
					<%}%>
				</td>
				<td style="text-align: center;"><%= p_writer %></td>
				<td style="text-align: center;"><%= p_date %></td>
				<td style="text-align: center;"><%= p_views %></td>
			</tr>
			<%}%>
			<tr>
				<td colspan="5" style="text-align: center; height:30px;" class="paging">
				<%
		 		//(8)페이징 시작블럭번호와 끝블럭 번호를 계산한다.(curpage: 현재 페이지 번호)
				startBlock = ( (curpage - 1)  / 10) * 10 + 1;
				endBlock   = startBlock + 10 - 1; 
				
				//(9)endBlock 이 최대 페이지 번호보다 크면 안됨.
				if( endBlock > maxpage)
				{
					//예: maxpage가 22인데, endBlock이 30이면 endBlock을 22로 변경
					endBlock = maxpage;
				}
				//이전 블럭
				if(startBlock >= 10)
				{
					%>
					<a href="post.jsp?type=<%= type %>&page=<%= startBlock - 1 %>">< 이전</a>
					<%
				}
				
				//(10)최대 페이지 갯수 만큼 페이지를 표시한다.(&: 구분)
				for(int pageno = startBlock; pageno <= endBlock; pageno++)
				{
					if(curpage == pageno)
					{
						%><a href="post.jsp?type=<%= type %>&page=<%= pageno %>"><span style="color:black; font-weight: bold;"><%= pageno %></span></a> | <%
					}else
					{
						%><a href="post.jsp?type=<%= type %>&page=<%= pageno %>"><%= pageno %></a> | <%
					}
				}
				//다음 블럭
				if(endBlock != maxpage)
				{
					%>
					<a href="post.jsp?type=<%= type %>&page=<%= endBlock + 1 %>">다음  ></a>
					<%
				}					
				%>	
				</td>
			</tr>
		</table>
	</dd>
</dl>
<%@ include file="../include/tail.jsp"%>