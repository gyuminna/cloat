<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

	<section class="content join">
		<div class="inner inner_500">
			<h2 class="page_name2">내 정보수정</h2>
			<form action="login_to" method="post">
				<ul class="form_ul">
					<li>
						<div class="po_rel">
							<input type="hidden" name="id" value="${mvo.getId()}" maxlength="200">
							<input type="password" name="pw" placeholder="비밀번호를 입력하세요" class="ipt_tt" required>
							<div class="po_ab pwview" onClick="pkView(this)">
								<img src="resources/images/visibility_off.svg" alt="">
							</div>
						</div>						
					</li>
					<li>
						<input type="submit" value="비밀번호 확인" class="bttn bttn_sbm2">
					</li>	
				</ul>	
			</form>		
		</div>
	</section>
	
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>