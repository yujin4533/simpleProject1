<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

	function goChange(action,hotelidx,hotelName,address,checkin_date,checkout_date,hotelImg,roomidx,weekPrice,roomName,roomType){
		
		document.changeFrm.action="/project1/reserve"+action+".p1";
		document.changeFrm.hotelidx.value=hotelidx;
		document.changeFrm.hotelName.value=hotelName;
		document.changeFrm.hotelImg.value=hotelImg;
		document.changeFrm.address.value=address;
		document.changeFrm.checkout_date.value=checkout_date;
		document.changeFrm.checkin_date.value=checkin_date;
		document.changeFrm.roomidx.value=roomidx;
		document.changeFrm.roomName.value=roomName;
		document.changeFrm.weekPrice.value=weekPrice;
		document.changeFrm.roomType.value=roomType;
		
		document.changeFrm.submit();
	}
	
</script>

<section class="site-hero inner-page overlay" style="background-image: url(/project1/resources/images/hero_4.jpg;); background-position: 0% 0px;" data-stellar-background-ratio="0.5">
  <div class="container">
    <div class="row site-hero-inner justify-content-center align-items-center">
      <div class="col-md-10 text-center aos-init aos-animate" data-aos="fade">
        <h1 class="heading mb-3">Reserve List</h1>
      </div>
    </div>
  </div>

  <a class="mouse smoothscroll" href="#next">
    <div class="mouse-icon">
      <span class="mouse-wheel"></span>
    </div>
  </a>
</section>

<section class="section bg-light">
	<div class="container">
		<div class="row">
			<c:if test="${reserveVO!=null}">
				<c:forEach var="vo" items="${reserveVO}">
					<div class="col-lg-12 col-md-12 col-md-12" style="display: -webkit-box; margin-bottom: 27px;border-bottom: solid 1px gray;">
						<div class="col-lg-3 col-md-3 col-md-3">
							<a href="<%=request.getContextPath()%>/product.p1?hotelidx=${vo.hotelidx}" class="mb-4 d-block"><img src="/project1/resources/images/hotel/${vo.hotelImg}" class="img-fluid" style="width: 270px; height: 180px; cursor: pointer; " ></a>
						</div>
						<div class="col-lg-6 col-md-3 col-md-3">
							<div class="media-body"> 
			                <span class="meta-post"><span style="margin-right: 30px;">예약번호 : ${vo.roomidx}</span><span style="margin-right: 30px;">예약일 : ${vo.hotelRegDay.substring(0,16)}</span><span>객실정원 : ${vo.roomType.substring(1)} / 침대개수 : ${vo.roomType.substring(0,1)}</span></span>
			                <h2><a href="<%=request.getContextPath()%>/product.p1?hotelidx=${vo.hotelidx}">${vo.hotelName} / ${vo.roomName}</a></h2>
			                <p>${vo.address}</p>
			                <h4>체크인 ${vo.checkin_date.substring(0,10)} - 체크아웃${vo.checkout_date.substring(0,10)}</h4>
			                <span class="meta-post"><span style="margin-right: 30px;">취소 : 체크인 2일 전 까지 가능 / 리뷰작성 : 체크아웃 후 2주 이내</span></span>
			                <%-- ------
			                ${vo.canCancleReserve}  --%>
			                </div>
						</div>
						<div class="col-lg-3 col-md-3 col-md-3">
							<br>
							<c:if test="${vo.roomStatus==1}">
								<br>
							</c:if>
							<c:if test="${vo.roomStatus==0}">
								<span>취소된 예약</span>
							</c:if>
							<c:if test="${vo.roomStatus==2}">
								<span>이용중인 예약</span>
							</c:if>
							<c:if test="${vo.roomStatus>2}">
								<span>이용완료된 예약</span>
							</c:if>
							
							<h4><fmt:formatNumber value="${vo.weekPrice+vo.weekendPrice}" pattern="###,###" />원</h4>
							
							<c:if test="${vo.roomStatus!=0 and vo.cancel>1}">
								<span style="cursor: pointer;" class="d-block text-primary" onclick="goChange('Cancel','${vo.hotelidx}','${vo.hotelName}','${vo.address}','${vo.checkin_date}','${vo.checkout_date}',
									   '${vo.hotelImg}','${vo.roomidx}','${vo.weekPrice+vo.weekendPrice}','${vo.roomName}','${vo.roomType}')">예약 취소 가능</span>
							</c:if>
							<c:if test="${vo.roomStatus==3 and 14>vo.reviewWrite}">
								<span style="cursor: pointer;" class="d-block text-primary" onclick="goChange('Review','${vo.hotelidx}','${vo.hotelName}','${vo.address}','${vo.checkin_date}','${vo.checkout_date}',
									   '${vo.hotelImg}','${vo.roomidx}','${vo.weekPrice+vo.weekendPrice}','${vo.roomName}','${vo.roomType}')">리뷰 작성하기</span>
							</c:if>
							<c:if test="${vo.roomStatus==3 and 14<=vo.reviewWrite}">
								<span style="cursor: pointer;" class="d-block text-primary" onclick="goChange('Point','${vo.hotelidx}','${vo.hotelName}','${vo.address}','${vo.checkin_date}','${vo.checkout_date}',
									   '${vo.hotelImg}','${vo.roomidx}','${vo.weekPrice+vo.weekendPrice}','${vo.roomName}','${vo.roomType}')">포인트 적립</span>
							</c:if>
							<c:if test="${vo.roomStatus==4}">
								<span style="cursor: pointer;" class="d-block text-primary" onclick="goChange('Point','${vo.hotelidx}','${vo.hotelName}','${vo.address}','${vo.checkin_date}','${vo.checkout_date}',
									   '${vo.hotelImg}','${vo.roomidx}','${vo.weekPrice+vo.weekendPrice}','${vo.roomName}','${vo.roomType}')">포인트 적립</span>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</c:if>
			
			<div class="col-12">
				<div class="custom-pagination">
					<ul class="list-unstyled" id="pagebar">
						<c:if test="${pagebar!=null}">
							${pagebar}
						</c:if>
					</ul>
				</div>
			</div>

			<form name="changeFrm" method="post">
				<input type="hidden" name="memberidx" value="${sessionScope.loginuser.memberidx}">
				<input type="hidden" name="hotelidx" value="">
				<input type="hidden" name="hotelName" value="">
				<input type="hidden" name="hotelImg" value="">
				<input type="hidden" name="address" value="">
				<input type="hidden" name="checkout_date" value="">
				<input type="hidden" name="checkin_date" value="">
				<input type="hidden" name="roomidx" value="">
				<input type="hidden" name="roomName" value="">
				<input type="hidden" name="weekPrice" value="">
				<input type="hidden" name="roomType" value="">
			</form>
		</div>
	</div>
</section>