<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.container {
	display: flex;
	justify-content: center;
	align-items: flex-start; /* 상단 맞춤 정렬 (또는 center로 가운데 정렬 가능) */
	gap: 20px; /* info-box와 map_area 사이 간격 */
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
	box-sizing: border-box;
}

.info-box {
	width: 80%; /* 필요 시 조정 */
	max-height: 350px; /* 높이 제한 */
	overflow: auto; /* 넘칠 경우 스크롤 */
	border: 1px solid #ccc; /* (선택) 테두리로 영역 구분 */
	padding: 10px; /* (선택) 내부 여백 */
	box-sizing: border-box;
}

.map_area {
	width: 100%;
}

.sub_tit {
	display: inline-block;
	margin: 0 15px 0 0;
	padding: 0 10px;
	background-color: #18a280;
	font-weight: 400;
	font-size: 15px;
	line-height: 24px;
	color: #ffffff;
	vertical-align: middle;
}

.title {
	display: inline-block;
	font-weight: 700;
	font-size: 18px;
	line-height: 24px;
	color: #212121;
	vertical-align: middle;
}

.title_area {
	display: block;
	margin: 0 0 12px;
	font-size: 0;
}

.icon01 {
	background-image:
		url(https://www.stop.or.kr/images/home/kor/user/sub/major_map_icon01.png);
}

.icon02 {
	background-image:
		url(https://www.stop.or.kr/images/home/kor/user/sub/major_map_icon02.png);
}

.data_list_area li {
	list-style: none;
	padding: 0 0 0 20px;
	background-size: 13px auto;
	background-repeat: no-repeat;
	font-size: 14px;
	line-height: 21px;
}

.cont {
	border: 1px solid #e1e1e1;
	padding: 10px;
	margin: 10px;
}

.search-area {
	display: flex;
	justify-content: center;
	padding: 30px 20px;
	width: 100%;
	box-sizing: border-box;
}

.search_bar_box {
	width: 100%;
	max-width: 1200px;
	background: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.box2 {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
}

.box2 .tit {
	font-weight: 600;
	font-size: 15px;
	margin-right: 10px;
}

.slt_box select, .input_box input {
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.input_box {
	display: flex;
	align-items: center;
	gap: 10px;
}

.input_box button {
	padding: 8px 16px;
	font-size: 14px;
	background-color: #18a280;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.input_box button:hover {
	background-color: #139171;
}

.sub-area {
  display: flex;
  justify-content: center;
}

.sub-area ul {
  display: flex;
  padding: 0;
  margin-top: 1%;
  list-style: none;
  background-color: #f9f9f9;
}

.sub-area ul li {
  padding: 10px 20px;
  border: 1px solid #ccc;
}

li.on{
	background-color : white;
}

.sub-area ul li.on a {
  color: #009688;
  font-weight: bold;
}

div.cont{
	cursor: pointer; /* 마우스 커서를 손가락 모양으로 */
    transition: background-color 0.2s ease; /* 부드러운 효과 */
}

div.cont:hover {
    background-color: #f0f0f0; /* 마우스 올릴 때 배경색 변화 */
    border : 1px solid green;
}
</style>

<section class="main content">
	<div class="sub-area">
		<ul class="list">
			<li class="${type == '청소년상담복지센터' ? 'on' : ''}"><a href="map?type=청소년상담복지센터">청소년상담복지센터</a></li>
			<li class="${type == '해바라기센터' ? 'on' : ''}"><a href="map?type=해바라기센터">해바라기센터</a></li>
			<li class="${type == '성착취 피해아동·청소년 지원센터' ? 'on' : ''}"><a href="map?type=성착취+피해아동·청소년+지원센터">성착취 피해아동·청소년 지원센터</a></li>
			<li class="${type == '지역디지털성범죄피해자지원센터' ? 'on' : ''}"><a href="map?type=지역디지털성범죄피해자지원센터">지역디지털성범죄피해자지원센터</a></li>
		</ul>
	</div>
	<div class="search-area">
		<form action="searchMap">
			<div class="search_bar_com_area">
				<div class="search_bar_box">
					<div class="box2">
						<div class="tit">키워드</div>
						<div class="slt_box">
							<select name="searchValue" title="키워드를 선택해주세요" class="com_slt">
								<option value="0">전체</option>
								<option value="1">지역</option>

								<option value="2">기관명</option>
								<option value="3">주소</option>

							</select>
						</div>
						<div class="input_box">
							<input type="text" name="searchKeyword" value=""
								placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">
							<input type="hidden" name="type" value="${type}">
							<button type="submit">
								<span>검색</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<c:if test="${!empty mapvo}">
		<div class="container">
			<div class="info-box">
				<c:forEach var="center" items="${mapvo}" varStatus="status">
					<div class="cont">
						<div class="info_cont">
							<div class="title_area">
								<div class="sub_tit">${center.sido}</div>
								<div class="title">${center.org_name}</div>
							</div>
							<div class="data_list_area">
								<li class="icon01">${center.addr}</li>
								<li class="icon02">${center.org_tel}</li>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="map_area">
				<div class="map_inner">
					<div id="map" style="width: 100%; height: 350px;"></div>
				</div>
			</div>
		</div>
	</c:if>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93ef0428acf91a435ff28bf23556f61d&libraries=services"></script>
	<script>
   		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(${mapvo[0].lat}, ${mapvo[0].lon}), // 지도의 중심좌표
			level : 8 // 지도의 확대 레벨
		};
   		
   		var infowindowArray = [];
   		var markers = [];
   		
   		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
   		
		var positions = [
		    <c:forEach var="center" items="${mapvo}" varStatus="status">
		        {
		        	// 이 부분 인포윈도우 디자인
		        	content: `<div style="width: 100%; height: 100%; padding:5px;">
		        				<div class="cont" style="border: none;">
		        					<div class="info_cont">
		                				<div class="title_area">
		                  					<div class="sub_tit">${center.sido}</div>
		                  					<div class="title">${center.org_name}</div>
		                				</div>
		                				<div class="data_list_area">
		                  					<li class="icon01">${center.addr}</li>
		                  					<li class="icon02">${center.org_tel}</li>
		                				</div>
		              				</div>
		              		  	</div>
		              		  </div>
		  			`,
		        	
		            title: '${center.org_name}',
		            latlng: new kakao.maps.LatLng(${center.lat}, ${center.lon})
		        }<c:if test="${!status.last}">,</c:if>
		    </c:forEach>
		]
		var selectedMarker = null;
		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		
		// 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    var imageSize2 = new kakao.maps.Size(48, 70); 
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		var clickImage = new kakao.maps.MarkerImage(imageSrc, imageSize2);     
	    
		for (let i = 0; i < positions.length; i ++) {
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		    
		    // 마커에 표시할 인포윈도우를 생성
		    var infowindow = new kakao.maps.InfoWindow({
		        content: positions[i].content // 인포윈도우에 표시할 내용
		    });
		    
		    infowindowArray.push(infowindow);
		    markers.push(marker); // 배열에 마커 저장
		    
		    // 마커에 click 이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', test(map,marker,infowindow, positions[i].latlng));
		 	
		}
		
		function test(map, marker,infowindow,latlng){
			return function(){
				closeInfoWindow();
				infowindow.open(map, marker);
				selectedMarker = marker;
				map.panTo(latlng);
			};
		}
	
		
		// 인포윈도우를 닫는 함수
		function closeInfoWindow() {
		  for (infowindow of infowindowArray) {
		    infowindow.close();
		  }
		}
		
		$('div.cont').click(function() {
			  var orgName = $(this).find('.title').text();
	  		
			  // markers 배열에서 title이 일치하는 마커 찾기
			  for (let i = 0; i < markers.length; i++) {
			        if (markers[i].getTitle() == orgName) {
			            kakao.maps.event.trigger(markers[i], 'click'); // 마커 클릭 트리거
			            break;
			        }
			  }
		});
		
		kakao.maps.event.trigger(markers[0], 'click');
   		</script>

</section>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>