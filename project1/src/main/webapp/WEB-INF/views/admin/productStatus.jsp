
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
            <h1 class="heading mb-3">Accommodation List</h1>
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
							<th style="width: 310px; text-align: center;">숙소명</th>
							<th style="width: 310px;  text-align: center;">주소</th>
							<th style="width: 180px; text-align: center;">번호</th>
							<th style="width: 180px;  text-align: center;">등록일</th>
							<th style="width: 90px;  text-align: center;">공개여부</th>
						</tr>
						<c:if test="${hotelList!=null}">
							<c:forEach var="list" items="${hotelList}">
								<tr>
									<th style="width: 30px;  text-align: center;">${list.hotelidx}</th>
									<th style="width: 310px; text-align: center; cursor: pointer;" onclick="goDetail('${list.hotelidx}')">${list.hotelName}</th>
									<th style="width: 310px;  text-align: center;">${list.address.substring(8)}</th>
									<th style="width: 180px; text-align: center;">${list.businessTel.substring(0,3)}-${list.businessTel.substring(3,7)}-${list.businessTel.substring(7)}</th>
									<th style="width: 180px;  text-align: center;">${list.hotelRegDay.substring(0,10)}</th>
									<c:if test="${list.hotelStatus==0}">
										<th style="width: 90px;  text-align: center;">비공개</th>
									</c:if>
									<c:if test="${list.hotelStatus==1}">
										<th style="width: 90px;  text-align: center;">공개</th>
									</c:if>
									<c:if test="${list.hotelStatus==2}">
										<th style="width: 90px;  text-align: center;">리모델링</th>
									</c:if>
									<c:if test="${list.hotelStatus==4}">
										<th style="width: 90px;  text-align: center;">삭제</th>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					<form name="hotelidxFrm" action="/project1/productStatusDetail.p1">
						<input type="hidden" name="hotelidx" value="">
					</form>
					<div class="col-12">
						<div class="custom-pagination">
							<ul class="list-unstyled" id="pagebar">
								<c:if test="${pagebar!=null}">
									${pagebar}
								</c:if>
							</ul>
						</div>
					</div>					
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