<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<script>
	window.onload = function() 
	{
		document.login.u_id.focus();
	}
	
	function DoCheck()
	{
		if( document.join.u_id.value == "" )
		{
			alert("아이디를 입력하세요.");
			document.login.u_id.focus();
			return false;
		}
		if( document.join.u_pw.value == "" )
		{
			alert("비밀번호를 입력하세요.");
			document.login.u_pw.focus();
			return false;
		}
		return true;
	}

</script>
<div class="inner_login">
	<div class="login_yore">
		<form name="login" method="post" action="loginok.jsp?type=<%= type %>">
			<fieldset>
				<!-- fieldset: HTML요소를 박스로 묶어주는 태그 legend: fieldset에 이름 -->
				<legend class="screen_out">로그인 정보 입력폼</legend>
				<div class="box_login">
					<div class="inp_text">
						<input type="text" name="u_id" placeholder="ID">
					</div>
					<div class="inp_text">
						<input type="password" name="u_pw" placeholder="Password">
					</div>
				</div>
				<button type="submit" class="btn_login">로그인</button>
			</fieldset>
		</form>
	</div>
</div>
<%@ include file="../include/tail.jsp" %>