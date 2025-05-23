<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="content join">
	<div class="inner inner_500">
		<h2 class="page_name2">회원가입</h2>
		<form action="join_us" method="post" enctype="multipart/form-data">
			<ul class="form_ul">
				<li>
					<small class="s_info c_red">* 필수</small>
					<div class="agree_box">
						<div class="agree_top">
							<div class="chkbox_div">
								<input type="checkbox" name="chk_1" id="chk_1" required>
								<label for="chk_1" class="chk_btn"></label>
								<label for="chk_1" class="chk_txt">이용약관 동의 <span class="c_main">(필수)</span></label>
							</div>
							<div class="view_term" onClick="viewTerms(this)">
								<span>약관 보기</span>
								<img src="resources/images/play_arrow.svg">
							</div>						
						</div>
						<div class="agree_txt">
							<!-- 이용약관 파일 가져오기 -->
							<jsp:include page="/WEB-INF/views/includes/terms_of_use.jsp" />							
						</div>
					</div>
					<div class="agree_box">
						<div class="agree_top">
							<div class="chkbox_div">
								<input type="checkbox" name="chk_2" id="chk_2" required>
								<label for="chk_2" class="chk_btn"></label>
								<label for="chk_2" class="chk_txt">개인정보처리방침 동의 <span class="c_main">(필수)</span></label>
							</div>
							<div class="view_term" onClick="viewTerms(this)">
								<span>약관 보기</span>
								<img src="resources/images/play_arrow.svg">
							</div>						
						</div>							
						<div class="agree_txt">
							<!-- 개인정보처리방침 파일 가져오기 -->		
							<jsp:include page="/WEB-INF/views/includes/privacy_policy.jsp" />												
						</div>
					</div>
				</li>			
				<li>
					<input type="hidden" name="user_type" value="NORMAL" placeholder="">
					<span class="form_label">아이디</span>
					<div class="po_rel">
						<input id="inputid" type="text" name="id" placeholder="ID를 입력하세요" class="ipt_tt" maxlength="100" required>
						<button type="button" class="bttn po_ab" id="idChkBtn">중복확인</button>					
					</div>
					<small id="idCheckMsg"></small>
				</li>
				<li>
					<span class="form_label">비밀번호</span>
					<div class="po_rel">
						<input id="inputPw" type="password" name="pw" placeholder="영문/숫자/특수문자 조합 8자 이상" class="ipt_tt" maxlength="200" required>
						<div class="po_ab pwview" onClick="pkView(this)">
							<img src="resources/images/visibility_off.svg" alt="">
						</div>
					</div>
					<small id="pwCheckMsg"></small>
				</li>
				<li>
					<span class="form_label">비밀번호 확인</span>
					<div class="po_rel">
						<input id="inputPwChk" type="password" placeholder="비밀번호를 다시 한 번 입력해주세요" class="ipt_tt" maxlength="200">
						<div class="po_ab pwview" onClick="pkView(this)">
							<img src="resources/images/visibility_off.svg" alt="">
						</div>		
					</div>			
					<small id="pwMatchMsg"></small>
				</li>				
				<li>
					<span class="form_label">이름</span>
					<input type="text" name="name" placeholder="이름을 입력하세요" class="ipt_tt" required>
				</li>
				<li>
					<span class="form_label">이메일</span>
					<input type="text" name="email" placeholder="이메일을 입력하세요" class="ipt_tt" required>
				</li>
				<li>
					<span class="form_label">연락처</span>
					<input type="text" name="phone" placeholder="전화번호를 입력하세요" class="ipt_tt" required>
				</li>
				<li class="profile">
					<small class="s_info c_main">* 선택</small>
					<span class="form_label">프로필 이미지 등록</span>
					<div class="filebox preview-image">
						<label for="profile_img" class="label_hidden"></label>
						<div class="upload-display">
							<img src="resources/images/user.png" alt="">
						</div>
						<input class="upload-name" value="파일선택" disabled="disabled">
						<input type="file" name="file" id="profile_img" class="upload-hidden" accept="image/*">
					</div>
				</li>								
				<li>
					<input type="submit" value="회원가입" class="bttn bttn_sbm2">
				</li>	
			</ul>	
		</form>		
	</div>
</section>		
<script>
function viewTerms(el){
	$(el).closest(".agree_box").toggleClass("on");
}


// 아이디 유효성 체크
let hangulcheck = /[ㄱ-ㅎㅏ-ㅣ가-힣]/; // 한글 체크
let spe = /[~!@#$%^&*|\\'";:/?]/;       // 특수문자 체크 (₩ 제거)

//아이디 중복검사
$('#idChkBtn').on('click', function() {
	// 입력된 값에서 공백을 제거하고 나서 id 변수에 저장
	let id = $("#inputid").val().trim();

    if (id.length < 4) {
        $("#idCheckMsg").css("color", "red").text("아이디는 4글자 이상 입력해주세요.");
        return false;
    } else if (id.search(/\s/) !== -1) {
        $("#idCheckMsg").css("color", "red").text("아이디는 공백 없이 입력해주세요.");
        return false;
    } else if (hangulcheck.test(id)) {
        $("#idCheckMsg").css("color", "red").text("아이디는 한글을 사용할 수 없습니다.");
        return false;
    } else if (spe.test(id)) {
        $("#idCheckMsg").css("color", "red").text("아이디는 특수문자를 사용할 수 없습니다.");
        return false;	
    }else{
 	   $.ajax({
 	      //url : './IdCheck',
 	      url : '${cpath}/IdCheck',
 	      type : 'GET', //전송방법
 	      data : {
 	         id : id //key,value값 json형태
 	         // 전송할 데이터
 	      },
 	      dataType : 'json',
 	      success : function(data) {
 	         console.log(data)
 	         if (data.available) { //true-사용가능
 	        	$("#idCheckMsg").css("color", "green");
 	            $("#idCheckMsg").text("사용 가능한 ID입니다");
 	         } else { //false-중복id
 	        	$("#idCheckMsg").css("color", "red");
 	            $("#idCheckMsg").text("중복된 ID 입니다");
 	         }
 	      }
 	
 	   })   	
    }
})

$(document).ready(function() {
	
	//비밀번호 유효성 체크
	$("#inputPw").on("keyup", function() {
		let pw = $("#inputPw").val();
		let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/영문자/특수문자 조합 8자리 이상 체크
		 
		 if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)){ 
        	$("#pwCheckMsg").css("color", "red");
            $("#pwCheckMsg").text("비밀번호는 숫자/영문자/특수문자 조합으로 8자리 이상이어야 합니다.");
            return false;
		 }else if(pw.search(/\s/) != -1){
        	$("#pwCheckMsg").css("color", "red");
            $("#pwCheckMsg").text("비밀번호는 공백 없이 입력해주세요.");
            return false;
		 }else if(hangulcheck.test(pw)){
        	$("#pwCheckMsg").css("color", "red");
            $("#pwCheckMsg").text("비밀번호는 한글을 사용할 수 없습니다.");
            return false;
		 }else {
        	$("#pwCheckMsg").css("color", "green");
            $("#pwCheckMsg").text("사용가능한 비밀번호입니다.");			 
		 	return true;
		 }
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
    let fileTarget = $('.filebox .upload-hidden');
    let filename = "";

    fileTarget.on('change', function() {
        if (window.FileReader) {
            filename = $(this)[0].files[0]?.name;
        } else {
            filename = $(this).val().split('/').pop().split('\\').pop();
        }

        $(this).siblings('.upload-name').val(filename);
    });

    // 이미지 미리보기 및 유효성 검사 (확장자 & 용량)
    let imgTarget = $('.preview-image .upload-hidden');

    imgTarget.on('change', function() {
        let file = $(this)[0].files[0];

        if (!file) return;

        // 이미지 MIME 타입 허용 리스트
        let validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/bmp'];
        let maxSize = 5 * 1024 * 1024; // 5MB

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

        let parent = $(this).parent();
        let uploadDisplay = parent.find('.upload-display');
        let imgTag = uploadDisplay.find('.upload-thumb');

        if (window.FileReader) {
            let reader = new FileReader();
            reader.onload = function(e) {
                let src = e.target.result;

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
            let imgSrc = document.selection.createRange().text;

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

<%@include file="/WEB-INF/views/includes/footer.jsp" %>