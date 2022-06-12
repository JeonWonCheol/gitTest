<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp"%>
<%
    session.invalidate();
%>
<script>
	window.onload = function() 
	{
		document.join.u_id.focus();
	}
	
	 function joincheck()
	{
		if( document.join.u_id.value == "")
		{
			alert("아이디를 입력하세요");
			document.join.u_id.focus();
			return false;
		}
		if( document.join.u_pw.value == "")
		{
			alert("비밀번호를 입력하세요");
			document.join.u_pw.focus();
			return false;
		}
		if( document.join.u_pw.value != document.join.u_pwcheck.value)
		{
			alert("비밀번호가 일치 하지 않습니다");
			document.join.u_pwcheck.focus();
			return false;
		}
		if( document.join.u_name.value == "")
		{
			alert("이름을 입력하세요");
			document.join.u_name.focus();
			return false;
		}
		if( document.join.year.value == "")
		{
			alert("출생 연도를 입력하세요");
			document.join.year.focus();
			return false;
		} 
		if( document.join.month.value == "")
		{
			if(value == null)
			{
				alert("출생 월을 입력하세요");
				document.join.month.focus();
				return false;
			}
		} 
		if( document.join.date.value == "")
		{
			alert("출생 일을 입력하세요");
			document.join.date.focus();
			return false;
		} 
		return true;
	}
	

</script>
<form name="join" method="post" action="joinok.jsp?type=" onsubmit="return joincheck()">
	<div id="wrapper">
		<div id="content">
			<!-- ID -->
			<div>
				<h3 class="join_title">
					<label for="u_id">아이디</label>
				</h3>
				<span class="box int_id">
					<input type="text" name="u_id" class="int" maxlength="20">
				</span>
			</div>

			<!-- PW1 -->
			<div>
				<h3 class="join_title">
					<label for="u_pw">비밀번호</label>
				</h3>
				<span class="box int_pass">
					<input type="password" name="u_pw" class="int" maxlength="20">
					<span id="alertTxt">사용불가</span>
				</span>
			</div>

			<!-- PW2 -->
			<div>
				<h3 class="join_title">
					<label for="u_pwcheck">비밀번호 재확인</label>
				</h3>
				<span class="box int_pass_check">
					<input type="password" name="u_pwcheck" class="int" maxlength="20">
				</span>
			</div>

			<!-- NAME -->
			<div>
				<h3 class="join_title">
					<label for="u_name">이름</label>
				</h3>
				<span class="box int_name">
					<input type="text" name="u_name" class="int" maxlength="20">
				</span>
			</div>

			<!-- BIRTH -->
			<div>
				<h3 class="join_title">
					<label for="year">생년월일</label>
				</h3>

				<div id="bir_wrap">
					<!-- BIRTH_YY -->
					<div id="bir_yy">
						<span class="box">
							<input type="text" name="year" class="int" maxlength="4" placeholder="년(4자)">
						</span>
					</div>

					<!-- BIRTH_MM -->
					<div id="bir_mm">
						<span class="box">
							<select required name="month" class="sel">
								<option value="">월</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</span>
					</div>

					<!-- BIRTH_DD -->
					<div id="bir_dd">
						<span class="box">
							<input type="text" name="date" class="int" maxlength="2" placeholder="일">
						</span>
					</div>

				</div>
			</div>

			<!-- GENDER -->
			<div>
				<h3 class="join_title">
					<label for="u_gender">성별</label>
				</h3>
				<span class="box gender_code">
					<select required name="u_gender" class="sel">
						<option value="">성별</option>
						<option value="M">남자</option>
						<option value="F">여자</option>
					</select>
				</span>
			</div>

			<!-- JOIN BTN-->
			<div class="btn_area">
				<button type="submit" class="btnJoin">
					<span>회원가입</span>
				</button>
			</div>
		</div>
		<!-- content-->
	</div>
	<!-- wrapper -->
</form>
<%@ include file="../include/tail.jsp"%>