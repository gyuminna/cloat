<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <section class="content board write">
		<div class="page_top">
			<div class="inner">
				<h2 class="pageName">고객후기</h2>
			</div>
		</div>			
		<div class="inner">
			<form action="ReviewUpload" method="post" enctype="multipart/form-data">
				<ul class="write_ul">
					<li>
						<span>ID</span>
						<input type="text" name="id" value= ${mvo.id} class="ipt_tt" readonly> <!-- 로그인한 작성자 아이디 불러오기 -->
					</li>
					<li>
						<span>제목</span>
						<input type="text" name="review_title" class="ipt_tt" >
					</li>
					<li class="flex_dir_col">
						<span>내용</span>
						<div class="post-form">
							<textarea name="review_content" id="summernote">
							</textarea>
						</div>  						
					</li>					
					<li>
						<span>첨부파일</span>
						<input type="file" name="file" class="ipt_tt">
					</li>					
				</ul>
				<div class="bttn_wrap">
					<a class="bttn bttn_cancle" href="javascript:history.back();">취소</a>
					<input class="bttn ipt_sbm" type="submit" value="작성완료">					
				</div>
			</form>
		</div>	
		<script>
			$('#summernote').summernote({

				// 에디터 크기 설정
				height: 800,
				// 에디터 한글 설정
				lang: 'ko-KR',
				// 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
				toolbar: [
					// 글자 크기 설정
					['fontsize', ['fontsize']],
					// 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
					['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
					// 글자색 설정
					['color', ['color']],
					// 표 만들기
					['table', ['table']],
					// 서식 [글머리 기호, 번호매기기, 문단정렬]
					['para', ['ul', 'ol', 'paragraph']],
					// 줄간격 설정
					['height', ['height']],
					// 이미지 첨부
					['insert', ['picture']]
				],
				// 추가한 글꼴
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋음체', '바탕체'],
				// 추가한 폰트사이즈
				fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72', '96'],
				// focus는 작성 페이지 접속시 에디터에 커서를 위치하도록 하려면 설정해주세요.
				focus: true,
				// callbacks은 이미지 업로드 처리입니다.
				callbacks: {
					onImageUpload: function (files, editor, welEditable) {
						// 다중 이미지 처리를 위해 for문을 사용했습니다.
						for (var i = 0; i < files.length; i++) {
							imageUploader(files[i], this);
						}
					}
				}

			});

			function imageUploader(file, el) {
				var formData = new FormData();
				formData.append('file', file);
			
				$.ajax({                                                              
					data : formData,
					type : "POST",
					// url은 자신의 이미지 업로드 처리 컨트롤러 경로로 설정해주세요.
					url : 'upload',  
					contentType : false,
					processData : false,
					enctype : 'multipart/form-data',                                  
					success : function(data) {   
						$(el).summernote('insertImage', "${pageContext.request.contextPath}/resources/upload/"+data, function($image) {
							$image.css('max-width', "100%");
						});
						// 값이 잘 넘어오는지 콘솔 확인 해보셔도됩니다.
						console.log(data);
					}
				});
			}			

		</script>
	</section>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>