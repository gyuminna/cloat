<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <footer class="footer">
         <div class="inner">
            <div class="logo ft_logo"><img src="resources/images/logo_gray.svg" alt=""></div>
            <div class="ft_rt">
               <ul class="ft_link">
                  <li><a href="javascript:popUp('tou');">이용약관</a></li>
                  <li><a href="javascript:popUp('privacy');">개인정보처리방침</a></li>
                  <li><a href="javascript:popUp('email');">이메일무단수집거부</a></li>
               </ul>
               <p>
                  <strong>주소</strong>
                  서울 마포구 양화로 85 5층  2025 CLOAT All Rights Reserved.
               </p>
            </div>
         </div>
   </footer>

	<div class="popWrap">
		<div class="popBg" onClick="popClose()"></div>
		<div class="popBox">
			<div class="popClose" onClick="popClose()">
				<img src="resources/images/close.svg">
			</div>		
			<div class="pop_tit"></div>
			<div class="pop_cont"></div>		
		</div>
	</div>
	
	<script>
		function popUp(txt) {
			$(".popWrap").show();
			$("html, body").css('overflow','hidden');
	
			let title = "";
			let url = "";
	
			switch(txt){
				case 'tou':
					title = '이용약관';
					url = '${pageContext.request.contextPath}/terms/tou';
					break;
				case 'privacy':
					title = '개인정보처리방침';
					url = '${pageContext.request.contextPath}/terms/privacy';
					break;
				case 'email':
					title = '이메일 무단 수집거부';
					url = '${pageContext.request.contextPath}/terms/email';
					break;
			}
	
			$(".popWrap .pop_tit").text(title);
			$(".popWrap .pop_cont").load(url);
		}
	
		function popClose(){
			$(".popWrap").hide();
			$("html, body").css('overflow','auto');
		}
	</script>

</body>

</html>