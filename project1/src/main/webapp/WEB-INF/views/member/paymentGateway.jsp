<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	var IMP = window.IMP;     // 생략가능
	IMP.init('imp58532161');  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 
	
	// 결제요청하기
	IMP.request_pay({
	    pg : 'html5_inicis', // 결제방식 PG사 구분
	    pay_method : 'card',	// 결제 수단
	    merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
	    name : '결제테스트(주문금액|주문명)',	 	// 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
	    amount : '${reserveVO.weekPrice+reserveVO.weekendPrice}',	  		// 결제 금액 number 타입. 필수항목. 
	    buyer_email : '${sessionScope.loginuser.email}',  			// 구매자 email
	    buyer_name : '${sessionScope.loginuser.memberName}',	  			// 구매자 이름 
	    buyer_tel : '${sessionScope.loginuser.memberTel}',    			// 구매자 전화번호 (필수항목)
	    buyer_addr : '',  
	    buyer_postcode : '',
	    m_redirect_url : 'localhost:9090/<%= request.getContextPath()%>/ajaxInsertReserve.p1'
	 }, function(rsp) {
	
		if ( rsp.success ) { // PC 데스크탑용
			
			var form_data = $("form[name=reserveHotelInfoFrm]").serialize();
			
			$.ajax({
				url:"<%= request.getContextPath()%>/ajaxInsertReserve.p1",
				data:form_data,
				type:"POST",
				dataType:"JSON",
				success:function(json){
					alert(json.msg);
					window.opener.top.location.href="<%= request.getContextPath()%>/memberpage.p1";
			        window.close(); 
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
	
	     } else {
			alert("결제에 실패하였습니다.");
			window.opener.top.location.href="<%= request.getContextPath()%>/product.p1?hotelidx=${reserveVO.hotelidx}"; 
			window.close();
	    }
	 
	}); // end of IMP.request_pay()----------------------------

}); // end of $(document).ready()-----------------------------

</script>
</head>	

<body>
	<form name="reserveHotelInfoFrm">
		<input type="hidden" name="memberidx" value="${sessionScope.loginuser.memberidx}">
		<input type="hidden" name="hotelidx" value="${reserveVO.hotelidx}">
		<input type="hidden" name="roomidx" value="${reserveVO.roomidx}">
		<input type="hidden" name="weekPrice" value="${reserveVO.weekPrice}">
		<input type="hidden" name="weekendPrice" value="${reserveVO.weekendPrice}">
		<input type="hidden" name="checkin_date" value="${reserveVO.checkin_date}">
		<input type="hidden" name="checkout_date" value="${reserveVO.checkout_date}">
		
		<input type="hidden" name="hotelName" value="${reserveVO.hotelName}">
		<input type="hidden" name="address" value="${reserveVO.address}">
		<input type="hidden" name="roomType" value="${reserveVO.roomType}">
		<input type="hidden" name="roomName" value="${reserveVO.roomName}">
    </form>
</body>
</html>
