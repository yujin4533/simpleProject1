<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%	String ctxPath = request.getContextPath();%>
<style>

.heartAreaIn {
	background: url(<%=request.getContextPath()%>/resources/images/heart_bgb.png);
    background-size: 22px 22px;
    display: inline-flex;
    width: 22px;
    height: 22px;
}

.heartAreaOut {
	background: url(<%=request.getContextPath()%>/resources/images/heart_bg.png);
    background-size: 22px 22px;
    display: inline-flex;
    width: 22px;
    height: 22px;
}
</style>

<script type="text/javascript">
   map = null;
   
   $(document).ready(function(){
      
	   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(33.381788, 126.544377), // 지도의 중심좌표
			level: 10 // 지도의 확대 레벨
		};  
	   
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		var geocoder = new kakao.maps.services.Geocoder();
	      
		$.ajax({ // 지도 ajax 처리
			url:"/project1/ajaxSearchMap.p1",
			type:"GET",
			dataType:"JSON",
			success:function(json){

			if(json.length > 0) { 
	                
				var html = "";
				content = "";
				cnt = 0;
	             
				$.each(json, function(entryIndex, item){
	            	var hotelidx = item.hotelidx;
					var address = item.address;
	                var hotelName = item.hotelName;
	                var hotelImg = item.hotelImg;
	                var weekPrice = item.weekPrice;
	                cnt++;
	                   
	                geocoder.addressSearch(address, function(result, status) {

						if (status === kakao.maps.services.Status.OK) {

	                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

						var marker = new kakao.maps.Marker({
	                    	map: map,
	                        position: coords,
	                        clickable: true
						});

	                    var iwContent = '<div class="wrap">' + 
	                    				'    <div class="info">' + 
	                           			'        <div class="title">' + 
	                           			'            '+hotelName + 
				                        '        </div>' + 
				                        '        <div class="body">' + 
				                        '            <div class="img ">' +
				                        '                <img src="/project1/resources/images/hotel/'+hotelImg+'" width="73" height="70">' +
				                        '           </div>' + 
				                        '            <div class="desc">' + 
				                        '                <div class="ellipsis">'+address.substring(8)+'</div>' +
				                        '                <div><a href="/project1/product.p1?hotelidx='+hotelidx+'" target="_blank" class="link">상세조회</a></div>' + 
				                        '            </div>' + 
				                        '        </div>' + 
				                        '    </div>' +    
				                         '</div>';//,
						iwRemoveable = true;
	                           
	                    var infowindow = new kakao.maps.InfoWindow({
	                    	content : iwContent,
	                        removable : iwRemoveable
						});
	                           
	                    kakao.maps.event.addListener(marker,'click',function(){
	                    	infowindow.open(map,marker);
	                    })
	                           
	                         
	                    var overlay = new kakao.maps.CustomOverlay({
	                    	content: content,
	                        map: map,
	                        position: marker.getPosition()       
	                    });
	                           
	                    kakao.maps.event.addListener(marker, 'click', function() {
	                        overlay.setMap(map);
	                    });
	                           
	                    if(cnt==1)
	                        map.setCenter(coords);
						} 
	                }); 
				});
			}
		},
		    error: function(request, status, error){
		    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
	    }); // 지도 ajax 처리
	    
        
   });//document.ready

  
       
</script>


<section class="site-hero inner-page overlay"
	style="background-image: url(<%= ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
	<div class="container">
		<div class="row site-hero-inner justify-content-center align-items-center">
			<div class="col-md-10 text-center" data-aos="fade">
				<h1 class="heading mb-3">Heart List</h1>
			</div>
		</div>
	</div>

	<a class="mouse smoothscroll" href="#next">
		<div class="mouse-icon">
			<span class="mouse-wheel"></span>
		</div>
	</a>
</section>
<!-- END section -->

<section class="section bg-light">


	<div class="container">
		<div class="row">
			<div class="col-md-6 col-sm-12">
				<div class="map_wrap">
					<div id="map" style="height: 540px; margin: 0 auto;" class="block-32"></div>
				</div>
			</div>
			<div class="col-md-6 col-sm-12 aos-animate">
				<div>
					<div class="row">
					<c:if test="${hotelList!=null}">
						<c:forEach var="vo" items="${hotelList}">
							<div class="col-lg-6 col-md-6 col-sm-12 hotelBox ">
								<!-- 상단(이미지,찜하트) -->
								<div style="position: relative;">
									<button type="button" onclick="location.href='<%= ctxPath%>/addHeart.p1?hotelidx=${vo.hotelidx}'" class="heart" id="btn_heart${status}" aria-busy="false" style="padding: 8px; margin: -8px; border: none; background-color: transparent;">
										<span class="heartAreaOut"> 
											<c:if test="${vo.heart!=0}">
												<span class="heartAreaIn" style="width: 22px;"><span class="blind">heart</span></span>
											</c:if> 
											<c:if test="${vo.heart==0}">
												<span class="heartAreaIn" style="width: 0px;"><span	class="blind">heart</span></span>
											</c:if>
										</span>
									</button>
									<img src="/project1/resources/images/hotel/${vo.hotelImg}" 
										style="width: 270px; height: 180px; cursor: pointer;" onclick="location.href='<%= ctxPath%>/product.p1?hotelidx=${vo.hotelidx}'">
								</div>
								
								<!-- 하단(설명,호텔명,가격,평점) -->
								<div style="padding: 12px 0 0 0;">
									<div class="hotelAddr" >${vo.address}</div>
									<div class="hotelName" style="cursor: pointer;" onclick="location.href='<%= ctxPath%>/product.p1?hotelidx=${vo.hotelidx}'">${vo.hotelName}</div>
									<div class="hotelStar">
										<c:if test="${vo.starCnt != 0}">
										<span class="starAreaIn"> <span class="starAreaOut"
											style="width: ${vo.starRating*14.6}px;"><span class="blind">star</span></span>
										</span>
										<span style="font-size: 10pt;">${vo.starRating}점
											&nbsp;${vo.starCnt}개의 후기</span>
										</c:if>
										<c:if test="${vo.starCnt==0}">
											<span class="starAreaIn"> </span>
											<span style="font-size: 10pt;">아직 후기가 없습니다.</span>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
					
					<form ></form>

					</div>
					<div class="custom-pagination">
						<ul class="list-unstyled">${pagebar}</ul>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
