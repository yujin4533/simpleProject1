
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
	.subjectStyle {
		font-weight: bold;
		cursor: pointer;
	}
	
</style>
    
<script type="text/javascript">

	$(document).ready(function(){
		
		
	}); // end of $(document).ready()-------------------

	function goDetail(hotelidx){
		
		hotelidxFrm = document.hotelidxFrm;
		hotelidxFrm.hotelidx.value = hotelidx;
		hotelidxFrm .submit();
		
	}
	
</script>  
    
    
    
<section class="site-hero inner-page overlay" style="background-image: url(/project1/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
          <div class="col-md-10 text-center" data-aos="fade">
            <h1 class="heading mb-3">Reserve List</h1>
            <ul class="custom-breadcrumbs mb-4">
            </ul>
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
			<div class="col-md-12 aos-init aos-animate" data-aos="fade-up" data-aos-delay="100" >
				<div style="padding-left: 3%;" class= "bg-white p-md-5 p-4 mb-5">
					<table class="table table-hover">
						<tr>
							<th style="width: 30px;  text-align: center;">idx</th>
							<th style="width: 80px;  text-align: center;">예약자</th>
							<th style="width: 180px;  text-align: center;">예약일</th>
							<th style="width: 310px; text-align: center;">숙소</th>
							<th style="width: 180px; text-align: center;">가격</th>
							<th style="width: 180px;  text-align: center;">체크인/아웃</th>
							<th style="width: 90px;  text-align: center;">예약상태</th>
						</tr>
						<c:if test="${resreveList!=null}">
							<c:forEach var="list" items="${resreveList}">
								<tr>
									<th style="width: 30px;  text-align: center;">${list.roomidx}</th>
									<th style="width: 80px;  text-align: center;">${list.categoryName}</th>
									<th style="width: 180px;  text-align: center;">${list.hotelRegDay.substring(0,10)}</th>
									<th style="width: 310px; text-align: center;">${list.hotelName}&nbsp;/&nbsp;${list.roomName}</th>
									<th style="width: 180px; text-align: center;">${list.weekPrice+list.weekendPrice}</th>
									<th style="width: 180px;  text-align: center;">${list.checkin_date.substring(0,10)}<br>${list.checkout_date.substring(0,10)}</th>
									<c:if test="${list.roomStatus==0}">
										<th style="width: 90px;  text-align: center;">취소</th>
									</c:if>
									<c:if test="${list.roomStatus==1 and list.cancel>0}">
										<th style="width: 90px;  text-align: center;">예약</th>
									</c:if>
									<c:if test="${list.roomStatus==1 and list.cancel<=0}">
										<th style="width: 90px;  text-align: center; color: red;">체크인</th>
									</c:if>
									<c:if test="${list.roomStatus==2 and list.reviewWrite<0}">
										<th style="width: 90px;  text-align: center;">체크인</th>
									</c:if>
									<c:if test="${list.roomStatus==2 and list.reviewWrite>=0}">
										<th style="width: 90px;  text-align: center; color: red;">아웃</th>
									</c:if>
									<c:if test="${list.roomStatus==3}">
										<th style="width: 90px;  text-align: center;">아웃</th>
									</c:if>
									<c:if test="${list.roomStatus==4}">
										<th style="width: 90px;  text-align: center;">리뷰</th>
									</c:if>
									<c:if test="${list.roomStatus==5}">
										<th style="width: 90px;  text-align: center;">포인트</th>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					<div class="col-12">
						<div class="custom-pagination">
							<ul class="list-unstyled" id="pagebar">
								<c:if test="${pagebar!=null}">
									${pagebar}
								</c:if>
							</ul>
						</div>
					</div>	
					<form name="hotelidxFrm" action="/project1/productStatusDetail.p1">
						<input type="hidden" name="hotelidx" value="">
					</form>
					<form name="searchFrm" style="text-align: center;">
						<select style="width:80px; height: 40px;">
							<option>숙소명</option>
						</select>
						<input type="text" style="height: 40px; margin: 20px;" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
						<button type="button" onclick="goSearch()" class= "btn btn-primary text-white py-2 px-4 font-weight-bold" style="padding: 0;">검색</button>
					</form>
			
				</div>
			</div>
		</div>
	</div>
</section>