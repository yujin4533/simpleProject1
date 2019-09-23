<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	function goCancel() {
		if( !$("input:checkbox[id=agree1]").is(":checked")) {
			alert("이용약관 및 개인정보 처리방침에 동의하셔야 합니다.");
			return;
		}
		document.changeFrm.submit();
	}
</script>

<!-- 예약정보 및 결제 페이지 -->
<section class="site-hero inner-page overlay" style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
    <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
            <div class="col-md-10 text-center" data-aos="fade">
                <h1 class="heading mb-3">Reseve Cancel</h1>
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

<section class="section contact-section" id="next">
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<div class="row">
					<div class="col-md-12 bg-white p-md-3 p-4 mb-4 border">
						<img src="/project1/resources/images/hotel/${reserveVO.hotelImg}" style="width: 441px;height: 294px;"><br>
						<p class="b_detail_border mgt10">
                               <span class="text-black">${reserveVO.hotelName}</span>
                               <span class="d-block">${reserveVO.address}</span>
                           </p>
						<p>
                               <span class="d-block">체크인/아웃:</span>
                               <span class="text-black">${reserveVO.checkin_date.substring(0,10)}&nbsp;&nbsp;-&nbsp;&nbsp;${reserveVO.checkout_date.substring(0,10)}</span>
                           </p>
                           
                           <p class="b_detail_border">
                               <span class="text-black">${reserveVO.roomName}</span>
                               <span class="d-block">객실정원:${reserveVO.roomType.substring(1)}명</span>
                           </p>
                           
						<p class="b_detail_total">
                               <span class="d-block">총 금액:</span>
                               <span class="text-black">
                               	<fmt:formatNumber value="${reserveVO.weekPrice}" pattern="###,###" /> 원
                               </span>
                           </p>
					</div>
				</div>
			</div>
			
            <div class="col-md-7">
                <form name="reserveFrm" class="bg-white p-md-5 p-4 mb-4 border">
                    <h5 class="fontB">취소자 정보</h5>
                    <span class="noticeStyle">입력된 정보가 맞는지 확인하세요.</span>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label for="name">Name</label>
                            <input type="text" name="name" id="name" class="form-control" value="${sessionScope.loginuser.memberName}" readonly style="background: transparent;" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="tel">Phone</label>
                            <input type="text" name="tel" id="tel" class="form-control" value="${sessionScope.loginuser.memberTel.substring(0,3)}-${sessionScope.loginuser.memberTel.substring(3,7)}-${sessionScope.loginuser.memberTel.substring(7)}" class="requiredInfo" placeholder="-는 생략, 숫자만입력" readonly style="background: transparent;"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 form-group">
                            <label for="email">Email</label>
                            <input type="email" name="email" id="email" class="form-control" value="${sessionScope.loginuser.email}" class="requiredInfo" placeholder="abc@gmail.com" readonly style="background: transparent;"/>
                        </div>
                    </div>
                </form>
                <!-- // end 예약자 정보 -->
                
                <div class="bg-white p-md-3 p-4 mb-2 border">
                    <h5 class="fontB">환불방법</h5>
                    <span class="noticeStyle">약관에 따라 환불이 진행되며, 영업일로부터 5~7일 이상 소요됩니다.</span>
                        <h5 class="fontB mgt10">취소영수증</h5>
                    <span class="noticeStyle">취소 영수증 발행은 호텔로 직접 문의하세요</span>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2">
                    <fieldset>
                    <legend class="blind">이용약관</legend>
                        <input type="checkbox" id="agree1"><label for="agree1" class="noticeStyle dpi">&nbsp;계속 진행 시, 예약 규정, OLLEH <a href="<%= ctxPath%>/terms.p1" target="_blank">이용약관</a> 및 <a href="<%= ctxPath%>/privacy_policy.p1" target="_blank">개인정보 처리방침</a>을 모두 읽었으며 이에 동의합니다.</label>
                    </fieldset>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2">
                    <button id="btnPayment" class="btn btn-primary btn-block text-white" onClick="goCancel();">예약확인 및 취소하기</button>
                </div>
                
            </div>
		</div>
	</div>
</section>

<form name="changeFrm" method="post" action="/project1/reserveCancelEnd.p1">
	<input type="hidden" name="memberidx" value="${sessionScope.loginuser.memberidx}">
	<input type="text" name="roomidx" value="${reserveVO.roomidx}">
</form>