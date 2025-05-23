<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section class="content">
	<div class="inner inner_500">
		<div class="join_success">
		<form action="login_do" method="post">
			<input type="text" name="id" value="<%=request.getParameter("id") %>" hidden>
			<input type="text" name="pw" value="<%=request.getParameter("pw") %>" hidden>
			<img src="resources/images/welcome.png" alt="가입 완료">
			<h1><b><%=request.getParameter("id") %></b>님, 환영합니다!🎉</h1>
			<p>안전한 인터넷, 행복한 얼굴, <br>이제 CLOAT와 함께하세요!</p>
			<div class="bttn_wrap">
			  <input type="submit" class="bttn_sbm" value="바로 시작하기">
			</div>
		</form>
		</div>
	</div>
</section>
<%@include file="/WEB-INF/views/includes/footer.jsp"%>