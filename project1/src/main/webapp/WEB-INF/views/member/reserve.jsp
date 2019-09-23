<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">

	function goReserveSelect() {
		
		if( !$("input:checkbox[id=agree1]").is(":checked")) {
			alert("이용약관 및 개인정보 처리방침에 동의하셔야 합니다.");
			return;
		}

		var form_data = $("form[name=reserveHotelInfoFrm]").serialize();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/ajaxReserveCk.p1",
			type:"GET",
			data:form_data,
			dataType:"JSON",
			success:function(json){
				if(json.msg == 'OK') {
					alert('예약가능합니다!! 결제창으로 넘어갑니다.');
					goPay();
				}
				else {
					alert(json.msg);
					// "예약가능한 방이 없습니다. 다른 날짜를 선택해 주세요!!\n숙박 상세페이지로 넘어갑니다."
					location.href="<%= request.getContextPath()%>/product.go?hotelidx=${paraMap.largeCategoryontionCode}";
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	
	}// end of function goReserveSelect()---------
	
	function goPay() {
		var frm = document.reserveHotelInfoFrm;
		window.open("", "paymentGateway", "left=350px, top=100px, width=820px, height=600px");
		frm.method = "POST";
		frm.action = "/project1/paymentGateway.p1";
		frm.target = "paymentGateway";
		frm.submit();
	}// end of function goPay(idx)----------------------

	</script>

<!-- 예약정보 및 결제 페이지 -->
<section class="site-hero inner-page overlay" style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
    <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
            <div class="col-md-10 text-center" data-aos="fade">
                <h1 class="heading mb-3">ReserVation</h1>
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
						<img src="/project1/resources/images/hotel/${hotelroomVO.hotelImg}" style="width: 441px;height: 294px;"><br>
						<p class="b_detail_border mgt10">
                               <span class="text-black">${hotelroomVO.hotelName}</span>
                               <span class="d-block">${hotelroomVO.address}</span>
                           </p>
						<p>
                               <span class="d-block">체크인/아웃:</span>
                               <span class="text-black">${hotelroomVO.checkin_date}&nbsp;&nbsp;-&nbsp;&nbsp;${hotelroomVO.checkout_date}</span>
                           </p>
                           
                           <p class="b_detail_border">
                               <span class="text-black">${hotelroomVO.roomName}</span>
                               <span class="d-block">객실정원:${hotelroomVO.roomType.substring(1)}명</span>
                           </p>
                           
						<p>
                               <span class="d-block">1 개 객실 : <fmt:formatNumber value="${hotelroomVO.adult+hotelroomVO.children}" pattern="###,###" />박:(세금미포함)</span>
                               <span class="d-block">주중 1박 : <fmt:formatNumber value="${hotelroomVO.weekPrice}" pattern="###,###" /> 원<br></span>
                               <span class="text-black">
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${hotelroomVO.adult}박 :
                               <fmt:formatNumber value="${hotelroomVO.weekPrice*hotelroomVO.adult}" pattern="###,###" /> 원<br>
                               </span>
                               	<span class="d-block">주말 1박 : <fmt:formatNumber value="${hotelroomVO.weekendPrice}" pattern="###,###" /> 원<br></span>
                               <span class="text-black">
                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${hotelroomVO.children}박 :
                               	<fmt:formatNumber value="${hotelroomVO.weekendPrice*hotelroomVO.children}" pattern="###,###" /> 원<br>
                               </span>
                               <span class="text-black">
                               	합   계 :	  <fmt:formatNumber value="${hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children}" pattern="###,###" /> 원<br>
                               </span>
                               <span class="d-block">세금&amp;서비스 금액:</span>
                               <span class="text-black">
                               	<fmt:formatNumber value="${(hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children)/10}" pattern="###,###" /> 원
                               </span>
						</p>
						<p class="b_detail_total">
                               <span class="d-block">총 금액:</span>
                               <span class="text-black">
                               	<fmt:formatNumber value="${hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children+(hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children)/10}" pattern="###,###" /> 원
                               </span>
                           </p>
					</div>
				</div>
			</div>
			
            <div class="col-md-7">
                <form name="reserveFrm" class="bg-white p-md-5 p-4 mb-4 border">
                    <h5 class="fontB">예약자 정보</h5>
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
                    <h5 class="fontB">체크인 시간</h5>
                    <span class="noticeStyle">가장 빠른 체크인 시간은 16:00입니다. 이전에 도착할 경우, 대기시간이 소요될 수 있습니다</span>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2 border">
                    <h5 class="fontB">포인트</h5>
                    <span class="noticeStyle">체크아웃 후 최대 <span class="styleFont">[&nbsp;<fmt:formatNumber value="${(hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children)/100*3}" pattern="###,###" />&nbsp;]포인트</span>가 적립됩니다.</span>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2 border">
                    <h5 class="fontB">결제방법</h5>
                    <span class="noticeStyle">객실 예약 확정을 위해, 입력하신 카드 정보를 암호화 후 보안방식으로 호텔에 제공할 예정입니다.</span>
                        <h5 class="fontB mgt10">전자영수증</h5>
                    <span class="noticeStyle">영수증 발행은 호텔로 직접 문의하세요</span>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2">
                    <fieldset>
                    <legend class="blind">이용약관</legend>
                        <input type="checkbox" id="agree1"><label for="agree1" class="noticeStyle dpi">&nbsp;계속 진행 시, 예약 규정, OLLEH <a href="<%= ctxPath%>/terms.p1" target="_blank">이용약관</a> 및 <a href="<%= ctxPath%>/privacy_policy.p1" target="_blank">개인정보 처리방침</a>을 모두 읽었으며 이에 동의합니다.</label>
                    </fieldset>
                </div>
                
                <div class="bg-white p-md-3 p-4 mb-2">
                    <button id="btnPayment" class="btn btn-primary btn-block text-white" onClick="goReserveSelect();">예약확인 및 결제하기</button>
                </div>
                
            </div>
		</div>
	</div>
</section>

<!-- 호텔정보 보내는 폼 -->
<form name="reserveHotelInfoFrm">
	<input type="hidden" name="hotelidx" value="${hotelroomVO.hotelidx }">
	<input type="text" name="roomidx" value="${hotelroomVO.roomidx}">
	<input type="hidden" name="checkout_date" value="${hotelroomVO.checkout_date}">
	<input type="hidden" name="checkin_date" value="${hotelroomVO.checkin_date}">
	<input type="text" name="weekPrice" value="${hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children}"><!-- 세금미포함 -->
	
	<fmt:parseNumber var="test" value="${(hotelroomVO.weekPrice*hotelroomVO.adult+hotelroomVO.weekendPrice*hotelroomVO.children)/100*10 }" integerOnly="true"/>
	<input type="text" name="weekendPrice" value="${test}"><!-- 세금 --> <!-- 정수처리 위에서 해줘야 넘어감 안그럼 400 badrequest -->

	<input type="hidden" name="hotelName" value="${hotelroomVO.hotelName}">
	<input type="hidden" name="address" value="${hotelroomVO.address}">
	<input type="hidden" name="roomType" value="${hotelroomVO.roomType}">
	<input type="hidden" name="roomName" value="${hotelroomVO.roomName}">
</form>