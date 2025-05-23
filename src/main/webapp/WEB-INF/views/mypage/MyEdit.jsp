<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/mypage/MyNav.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

				<div class="mp_cont edit">
					<div class="mp_tit">내 정보수정</div>
					<form action="Update" method="post" enctype="multipart/form-data">
						<small class="s_info c_red">* 필수</small>
						<ul class="form_ul">
							<li>
								<span class="form_label">아이디</span>
								<input type="text" name="id" value="${mvo.id}" placeholder="아이디를 입력하세요" class="ipt_tt" readonly>
							</li>
							<li>
								<ul class="d_flex">
									<li>
										<span class="form_label">비밀번호</span>
										<div class="po_rel">
											<input id="inputPw" type="password" name="pw" value="${mvo.pw}" placeholder="비밀번호를 입력하세요" class="ipt_tt" required>
											<div class="po_ab pwview" onClick="pkView(this)">
												<img src="resources/images/visibility_off.svg" alt="">
											</div>
										</div>
										<small id="pwCheckMsg"></small>										
									</li>
									<li>
										<span class="form_label">비밀번호 확인</span>
										<div class="po_rel">
											<input id="inputPwChk" type="password" value="${mvo.pw}" placeholder="비밀번호를 다시 한 번 입력해주세요" class="ipt_tt">
											<div class="po_ab" onClick="pkView(this)">
												<img src="resources/images/visibility_off.svg" alt="">
											</div>											
										</div>
										<small id="pwMatchMsg"></small>
									</li>									
								</ul>
							</li>				
							<li>
								<span class="form_label">이름</span>
								<input type="text" name="name" value="${mvo.name}" class="ipt_tt" readonly>
							</li>
							<li>
								<span class="form_label">이메일</span>
								<input type="text" name="email" placeholder="이메일을 입력하세요" value="${mvo.email}" class="ipt_tt" required>
							</li>
							<li>
								<span class="form_label">연락처</span>
								<input type="text" name="phone" placeholder="전화번호를 입력하세요" value="${mvo.phone}" class="ipt_tt" required>
							</li>
							<li class="profile">
								<small class="s_info c_main">* 선택</small>
								<span class="form_label">프로필 이미지 등록</span>
								<div class="filebox preview-image">
									<label for="profile_img" class="label_hidden"></label>
									<div class="upload-display">
										<!-- tb_user의 profile_img 경로 가져오기 -->
										<img src="<%=profileImg%>" alt="">
									</div>
									<input class="upload-name" value="파일선택" disabled="disabled">
									<input type="file" name="file" id="profile_img" class="upload-hidden" accept="image/*">
								</div>
							</li>								
						</ul>							
					<div class="bttn_wrap">
						<a href="javascript:history.back();" class="bttn bttn_cancle">취소</a>
						<input type="submit" value="회원정보수정" class="bttn bttn_sbm2">
					</div>	
					<div class="tar">
						<a href="javascript:mbOut('id')" class="mb_out">회원탈퇴</a>
					</div>	
					</form>
					<!-- 정보수정에 필요한 스크립트 -->
					<script>
					function mbOut(id){
						let mbOutConfrm  = confirm("정말 탈퇴하시겠습니까?");
						if(mbOutConfrm == true){
							// 회원탈퇴로직 진행
							alert("회원탈퇴완료");
						}
					}

					$(document).ready(function() {
						
						//비밀번호 유효성 체크
						$("#inputPw").on("keyup", function() {
							var pw = $("#inputPw").val();
							var num = pw.search(/[0-9]/g);
							var eng = pw.search(/[a-z]/ig);
							var spe = pw.search(/[!@#$%^&*(),.?":{}|<>]/g); // 특수문자 재정비
							var msg = "";
							
							if(pw.length < 8 || pw.length > 20){
								msg = "8~20자리 이내로 입력해주세요.";
							} else if(num < 0 || eng < 0 || spe < 0){
								msg = "영문, 숫자, 특수문자를 모두 포함해주세요.";		  
							} else if(pw.search(/\s/) != -1){
								msg = "공백 없이 입력해주세요.";
							} else {
								msg = "사용 가능한 비밀번호입니다.";
								$("#pwCheckMsg").css("color", "green");
								$("#pwCheckMsg").text(msg);
								return true;
							}
							$("#pwCheckMsg").css("color", "red");
							$("#pwCheckMsg").text(msg);
							return false;
						});	
						
						// 확인 비밀번호 키 입력 시 일치 여부 확인
						$("#inputPwChk").on("keyup", function () {
							const pw = $("#inputPw").val();
							const pwConfirm = $("#inputPwChk").val();
							const msg = $("#pwMatchMsg");
							
							if (!pwConfirm) {
							msg.text("");
							return;
							}
							
							if (pw === pwConfirm) {
							msg.text("비밀번호가 일치합니다.").css("color", "green");
							} else {
							msg.text("비밀번호가 일치하지 않습니다.").css("color", "red");
							}
						});	
						
						//이미지 업로드 로직
						var fileTarget = $('.filebox .upload-hidden');

						fileTarget.on('change', function() {
							if (window.FileReader) {
								var filename = $(this)[0].files[0]?.name;
							} else {
								var filename = $(this).val().split('/').pop().split('\\').pop();
							}

							$(this).siblings('.upload-name').val(filename);
						});

						// 이미지 미리보기 및 유효성 검사 (확장자 & 용량)
						var imgTarget = $('.preview-image .upload-hidden');

						imgTarget.on('change', function() {
							var file = $(this)[0].files[0];

							if (!file) return;

							// 이미지 MIME 타입 허용 리스트
							var validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/bmp'];
							var maxSize = 5 * 1024 * 1024; // 5MB

							// MIME 타입 검사
							if (!validTypes.includes(file.type)) {
								alert('이미지 파일만 업로드할 수 있습니다. (jpg, png, gif, webp 등)');
								$(this).val('');
								$(this).siblings('.upload-name').val(''); // 파일명 초기화
								return;
							}

							// 파일 용량 검사
							if (file.size > maxSize) {
								alert('5MB 이하의 이미지만 업로드할 수 있습니다.');
								$(this).val('');
								$(this).siblings('.upload-name').val('');
								return;
							}

							var parent = $(this).parent();
							var uploadDisplay = parent.find('.upload-display');
							var imgTag = uploadDisplay.find('.upload-thumb');

							if (window.FileReader) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var src = e.target.result;

									if (imgTag.length > 0) {
										imgTag.attr('src', src);
									} else {
										uploadDisplay.html(
											'<div class="upload-thumb-wrap"><img src="' + src + '" class="upload-thumb"></div>'
										);
									}
								}
								reader.readAsDataURL(file);
							} else {
								// 구형 브라우저 (IE 대응)
								$(this)[0].select();
								$(this)[0].blur();
								var imgSrc = document.selection.createRange().text;

								if (imgTag.length > 0) {
									imgTag[0].style.filter =
										"progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\"" +
										imgSrc +
										"\")";
								} else {
									uploadDisplay.html('<div class="upload-thumb-wrap"><img class="upload-thumb"></div>');
									uploadDisplay.find('.upload-thumb')[0].style.filter =
										"progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\"" +
										imgSrc +
										"\")";
								}
							}
						});
					});
					</script>					 
				</div>

			</div>			
		</div>
	</section>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>