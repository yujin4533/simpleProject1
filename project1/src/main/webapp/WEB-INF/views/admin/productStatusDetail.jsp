<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	$(document).ready(function(){
		
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var geocoder = new kakao.maps.services.Geocoder();
	geocoder.addressSearch('${hotelDetail.address}', function(result, status) {
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	         
	        map.setCenter(coords);
	    } 
	});         
   
});// end of ready

function goproduct(H,R,I,A){
	document.AllFrm.hotelStatus.value = H;
	document.AllFrm.roomStatus.value = R;
	document.AllFrm.roomidx.value = I;
	document.AllFrm.hotelName.value = A;
	document.AllFrm.action = "/project1/productChange.p1";
	document.AllFrm.submit();
}

</script>

<section class="site-hero inner-page overlay"
	style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)"
	data-stellar-background-ratio="0.5">
	<div class="container">
		<div
			class="row site-hero-inner justify-content-center align-items-center">
			<div class="col-md-10 text-center" data-aos="fade">
				<h1 class="heading mb-3">Product Status</h1>
			</div>
		</div>
	</div>
	<a class="mouse smoothscroll" href="#next">
		<div class="mouse-icon">
			<span class="mouse-wheel"></span>
		</div>
	</a>
</section>

<section class="py-5 bg-light">
   <div class="container">
      <div class="row align-items-center">
         <c:if test="${hotelDetail!=null}">
            <div class="col-md-12 col-lg-5 order-lg-1">
                <p class="d-block">숙박정보 : ${hotelDetail.categoryName} / 등록일 : ${hotelDetail.hotelRegDay}</p>
                <h2 class="heading" >${hotelDetail.hotelName}</h2>
                <p style="margin-bottom: 30px;">${hotelDetail.address.substring(8)}</p>

                <p class="mb-4" style="word-break:normal; padding-right: 30px;">${hotelDetail.hotelInfo}</p>
				<p class="mb-4">${hotelDetail.hotelOption}</p>
				<p class="mb-4">문의 : ${hotelDetail.businessTel}</p>
				<p style="margin-bottom:0;">
					<c:if test="${hotelDetail.hotelStatus==0}">
						<a href="#" class="btn btn-primary text-white py-2 mr-3" onclick="goproduct('1','0','0','')">공개전환</a>
					</c:if>
					<c:if test="${hotelDetail.hotelStatus==1}">
						<a href="#" class="btn btn-primary text-white py-2 mr-3" onclick="goproduct('0','0','0','')">비공개전환</a>
					</c:if>
					<c:if test="${hotelDetail.hotelStatus==2}">
						<a href="#" class="btn btn-primary text-white py-2 mr-3">리모델링중</a>
					</c:if>
					<c:if test="${hotelDetail.hotelStatus==4}">
						<a href="#" class="btn btn-primary text-white py-2 mr-3">판매기간X</a>
					</c:if>
				</p>
            </div>
            <div
               class="col-md-12 col-lg-7 ml-auto order-lg-2 position-relative mb-5  ">
               <img
                  src="/project1/resources/images/hotel/${hotelDetail.hotelImg}"
                  alt="Image" class="img-fluid">
            </div>
         </c:if>
      </div>
   </div>
</section>

<section class="py-5 bg-light">
	<div class="container">
		<c:if test="${roomList!=null}">
			<!-- 객실 뽑을 for문 -->
			<c:forEach var="RoomVO" items="${roomList}" varStatus="status">
				<div class="row bg-white mb-4">
					<div class="col-lg-6 col-md-12 mt-3 mb-3">
						<div class="slide_wrap mt-3">
							<div class="slide_viewport">
							    <div class="slides">
									<img src="/project1/resources/images/room/${RoomVO.roomImg}" class="img-fluid">
							   	</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6 col-md-12 mt-4 mb-3">
						<h5 class="mb-3" style="font-size: 25px;">${RoomVO.roomName}</h5>
						<span class="d-block mb-3"> 공고기간 : ${RoomVO.roomPeriod1.substring(0,10)}&nbsp;&nbsp;~&nbsp;&nbsp;${RoomVO.roomPeriod2.substring(0,10)} </span>						
						<span class="d-block mb-3"> 
							<span class="text-uppercase letter-spacing-2" style="display: inline-block; vertical-align: super;">주중/주말 : </span>
							<span class="display-4 text-primary" style="font-size: 25pt;">${RoomVO.weekPrice}&nbsp;/&nbsp;${RoomVO.weekendPrice}</span> 	
						</span> 
						<h5 class="mb-4">침대갯수 : ${RoomVO.roomType.substring(0,1)}개 / 수용인원 : ${RoomVO.roomType.substring(1)}명</h5>
						<p class="mb-4">${RoomVO.roomInfo}</p>
						<p class="mb-4">${RoomVO.roomOption}</p>
						<p style="margin-bottom:0;">
							<c:if test="${RoomVO.roomStatus==0}">
								<a href="#" class="btn btn-primary text-white py-2 mr-3"  onclick="goproduct('0','1','${RoomVO.roomidx}','')">공개전환</a>
							</c:if>
							<c:if test="${RoomVO.roomStatus==1}">
								<a href="#" class="btn btn-primary text-white py-2 mr-3"  onclick="goproduct('0','0','${RoomVO.roomidx}','')">비공개전환</a>
							</c:if>
							<c:if test="${RoomVO.roomStatus==2}">
								<a href="#" class="btn btn-primary text-white py-2 mr-3">리모델링중</a>
							</c:if>
							<c:if test="${RoomVO.roomStatus==4}">
								<a href="#" class="btn btn-primary text-white py-2 mr-3">판매기간X</a>
							</c:if>
						</p>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${roomList==null}">
			<h1 class="header" style="margin: 0 auto;">~객실이 등록되지 않았습니다~</h1>
		</c:if>
	</div>
	<br><br>
	<form name="AllFrm" method="post">
		<input type="hidden" name="hotelStatus" value="">
		<input type="hidden" name="roomStatus" value="">
		<input type="hidden" name="roomidx" value="">
		<input type="hidden" name="hotelName" value="">
		<input type="hidden" name="hotelidx" value="${hotelDetail.hotelidx}">
		<div style="text-align: center;">
			<button type="button" onclick="goproduct('1','1','0','all')" class="btn btn-primary text-white py-2 mr-3" style="font-size: x-large;">전체 공개전환</button>
			<button type="button" onclick="goproduct('0','0','0','all')" class="btn btn-primary text-white py-2 mr-3" style="font-size: x-large;">전체 비공개전환</button>
		</div>
	</form>
	<br>
</section>

<section class="section contact-section" id="next">
	<div class="container">
		<div class="col-md-12">
			<h4>${hotelDetail.address}</h4>
			<div class="row">
				<div id="map" style="width: 1100px; height: 500px; margin: 0 auto;"></div>
			</div>
		</div>
	</div>
</section>