<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/mypage/MyNav.jsp" %>

				<div class="mp_cont">
					<!-- 내 갤러리 내용 -->
					<div class="mp_tit">내 갤러리</div>
					<!-- if : 클로킹한 이미지가 하나도 없다면?! -->
					<!-- <div class="no_content">
						<p>아직 클로킹한 이미지가 없습니다.</p>
					</div> -->

					<!-- if : 클로킹한 이미지가 있다면 -->
					<ul class="my_gall">
						
						<!-- 클로킹 이미지들.. li 통째로 반복문에 넣어주세요 -->
						<li>
							<div class="gall_box">
								<!-- DB: tb_ubload.id == tb_user.id인 transformed_img의 이미지 파일 경로 ! -->
								<a href="resources/images/test.png" class="thumb">
									<img src="resources/images/test.png" alt="">
								</a>
								<!-- tb_upload.created_at -->
								<p class="txt">변환날짜 : 2025.05.22 16:01:30</p>
							</div>
						</li>			

					</ul>
				</div>
				
			</div>			
		</div>
	</section>
				
<%@include file="/WEB-INF/views/includes/footer.jsp" %>