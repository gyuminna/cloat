<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
</head>
<body>

<section class="content board view list">
    <div class="page_top">
        <div class="inner">
            <!-- 공지사항 제목을 상단에 출력 -->
            <h2 id="pageName">공지사항</h2>
        </div>
    </div>			
    <div class="inner">
        <div class="view_wrap">
            <div class="view_top">
                <h3 class="view_title">${notice.notice_title}</h3>
                <div class="view_info">
                    <div class="view_info_lt">
                        <p><span>작성자</span> ${notice.admin_id}</p>
                        <p><span>조회수</span> ${notice.notice_views}</p>
                    </div>
                    <div class="view_info_rt">
                        <p><span>작성날짜</span> ${notice.created_at}</p>
                    </div>
                </div>
            </div>
            <div class="view_btm">
                ${notice.notice_content}
                
                <!-- 첨부파일이 있을 경우 표시 -->
                <c:if test="${not empty notice.notice_file}">
                    <div class="view_file">
                        <a href="${pageContext.request.contextPath}/upload/${notice.notice_file}" download>${notice.notice_file}</a>
                    </div>
                </c:if>
            </div>
        </div>				
        <div class="bttn_wrap">
            <!-- 해당 글 작성자 또는 관리자일 경우 버튼 표시 -->
			<c:if test="${sessionScope.userId eq notice.admin_id or sessionScope.userRole eq 'admin'}">
                <button onClick="location.href='NoticeEdit.jsp?no=${notice.notice_no}'" class="bttn">수정</button>
                <button onClick="location.href='NoticeDelete.jsp?no=${notice.notice_no}'" class="bttn">삭제</button>
            </c:if>
			<a href="${pageContext.request.contextPath}/NoticeList?pageNum=${pageNum}" class="bttn ipt_sbm">목록</a>
        </div>				
    </div>	
</section>

</body>
</html>