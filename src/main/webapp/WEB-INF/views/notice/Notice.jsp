<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<section class="content board list">
	<div class="page_top">
		<div class="inner">
			<h2 class="pageName">공지사항</h2>
		</div>
	</div>
	<div class="inner">
		<table class="tb">
			<colgroup>
				<col width="5%">
				<col width="60%">
				<col width="10%">
				<col width="10%">
				<col width="5%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<!-- 게시판 테이블에 있는 내용 불러오기 / 한 목록에 10개씩, 최신순 -->
			<c:forEach items="${list}" var="bvo">
				<tr>
					<td>${bvo.notice_idx}</td>
					<td class="tb_title"><a
						href="${pageContext.request.contextPath}/noticeview?no=${bvo.notice_idx}&pageNum=${pageNum}">${bvo.notice_title}</a>
					</td>
					<td>관리자 <!-- ${bvo.admin_id} --></td>
					<td><fmt:formatDate value="${bvo.created_at}"
							pattern="yyyy.MM.dd" /></td>
					<td>${bvo.notice_views}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty list}">
				<p>게시물이 없습니다.</p>
			</c:if>
		</table>

		<!-- 글쓰기 -->
		<div class="bttn_wrap">
			<!--
				로그인 안했으면 : '로그인해주세요' alert;
				로그인 했으면 : 글쓰기 페이지로 이동; 
			-->
			<c:if test="${mvo.getUser_type() == 'ADMIN'}">
				<button onClick="writeBtn()" class="bttn ipt_sbm">글쓰기</button>
			</c:if>
			<script>
				let writeBtn = () => {
					// 로그인 상태 아니면
					//alert('로그인해주세요');
					// 로그인 상태면
					// -> 아이디 정보 가지고 글쓰기 페이지로 이동
					window.location.href = "NoticeWrite";
				}
			</script>
		</div>

		<!-- 페이징 -->
		<div class="pg_wrap">
			<nav>
				<ul class="pagination">
					<%-- 가장 첫 페이지가 아니면 '<' 버튼 활성화 --%>
					<c:if test="${pageNum > 1}">
						<li class="page-item"><a class="page-link animate__animated"
							href="NoticeList?pageNum=1&condition=${condition}&keyword=${encodedK}">
								<img src="resources/images/p_prev.png" alt="첫 페이지로 이동">
						</a></li>
					</c:if>

					<%-- 페이지 번호 반복 --%>
					<c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
						<li class="page-item ${pageNum == i ? 'active' : ''}"><a
							class="page-link animate__animated"
							href="NoticeList?pageNum=${i}&condition=${condition}&keyword=${encodedK}">${i}</a>
						</li>
					</c:forEach>

					<%-- 마지막 페이지가 아니면 '>' 버튼 활성화 --%>
					<c:if test="${pageNum < totalPageCount}">
						<li class="page-item"><a class="page-link animate__animated"
							href="NoticeList?pageNum=${totalPageCount}&condition=${condition}&keyword=${encodedK}">
								<img src="resources/images/p_next.png" alt="마지막 페이지로 이동">
						</a></li>
					</c:if>
				</ul>
			</nav>
		</div>

		<!-- 검색창 -->
		<div class="search_form">
			<form action="NoticeSearch">
				<select class="sel" name="searchValue">
					<!-- <option name="">내용+댓글</option> -->
					<option value="notice_content">내용</option>
					<option value="notice_title">제목</option>
				</select> <input class="ipt_tt" type="text" name="searchContent"
					placeholder="검색어 입력"> <input class="ipt_sbm" type="submit"
					value="검색">
			</form>
		</div>

	</div>
</section>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>