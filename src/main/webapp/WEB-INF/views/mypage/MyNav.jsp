<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%
	// url에서 현재 viewname 가져오기
	String uri = request.getRequestURI(); // 예: /mypage/My_edit
	String[] parts = uri.split("/");
	String currentView = parts[parts.length - 1]; // My_edit

    // 세션에서 로그인 사용자 정보 가져오기
    com.smhrd.member.MemberVO mvo = (com.smhrd.member.MemberVO) session.getAttribute("mvo");
    String userName = (mvo != null) ? mvo.getName() : "비회원";
    String userId = (mvo != null) ? mvo.getId() : "Guest";
    String profileImg = (mvo != null && mvo.getProfile_img() != null && !mvo.getProfile_img().equals("null")) 
                        ? "resources/file/"+mvo.getProfile_img() : "resources/images/user.png";
%>

	<section class="content">
		<div class="inner">
			<h2 class="page_name2">마이페이지</h2>		
			<div class="mypage">
				<div class="mp_nav">
					<div class="mp_profile">
						<div class="thumb">
							<img src="<%=profileImg%>" alt="">
						</div>
						<ul class="txt">
							<!-- 이름 -->
							<p><%=userName%></p>
							<!-- 아이디 -->
							<small><%=userId%></small>
						</ul>
					</div>
					<ul class="mp_menu">
						<li>
							<a href="MyGallery" class="<%= "MyGallery.jsp".equals(currentView) ? "c_main" : "" %>">내 갤러리</a>
						</li>					
						<li>
							<a href="MyReview?id=${mvo.id}" class="<%= "MyReview.jsp".equals(currentView) ? "c_main" : "" %>">내 후기글</a>					
						</li>
						<li>
							<a href="MyQna?id=${mvo.id}" class="<%= "MyQna.jsp".equals(currentView) ? "c_main" : "" %>">내 문의글</a>					
						</li>						
						<li>
							<a href="MyLogin" class="<%= "MyEdit.jsp".equals(currentView) ? "c_main" : "" %>">내 정보수정</a>
						</li>
					</ul>
				</div>
				<!-- 아래부터 mp_cont 시작 ~ 닫는 태그 각 상세 페이지에 있음 -->
				<!-- <div class="mp_cont"> -->