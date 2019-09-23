<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#changepic").click(function() {
			var url = "changepic0.p1"; /* 4 앞에 슬래시 없으면 절대경로이다.*/
			window.open(url, "POST", 
					    "left=500px, top=100px, width=300px, height=230px");
		});
		
		$("#delpic").click(function() {
			var url = "changepic.p1"; /* 4 앞에 슬래시 없으면 절대경로이다.*/
			window.open(url, "POST", 
					    "left=500px, top=100px, width=300px, height=230px");
		});
	});
</script>

<section class="site-hero inner-page overlay" style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
          <div class="col-md-10 text-center" data-aos="fade">
            <h1 class="heading mb-3">My Page</h1>
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
		<div class="col-md-5 aos-init aos-animate" data-aos="fade-up" data-aos-delay="200">
			<div class="row">
				<div class="col-md-10 ml-auto contact-info">
					<p class="loginborder"><span class="text-black"> ${loginuser.memberName}님의 페이지</span></p>
					<p><span class="text-black" onclick="location.href='<%= ctxPath%>/memberedit.p1'" style="cursor: pointer;">정보 수정하기</span></p>
					<p><span class="text-black" onclick="location.href='<%= ctxPath%>/heartlist.p1'" style="cursor: pointer;">찜목록</span></p>
					<p><span class="text-black" onclick="location.href='<%= ctxPath%>/reservelist.p1'" style="cursor: pointer;">예약목록조회</span></p>
					<p><span class="text-black" onclick="location.href='<%= ctxPath%>/fnq.p1'" style="cursor: pointer;">문의사항</span></p>
					<p><span class="text-black" onclick="location.href='<%= ctxPath%>/memberout.p1'" style="cursor: pointer;">탈퇴</span></p>
					<c:if test="${loginuser.grade ==3}">
					<p><a class="text-black" href="<%= ctxPath%>/admin_buisnessBoardList.p1">사장님 게시판</a></p>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-md-7 aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
           
			<form action="#" method="post" class="bg-white p-md-5 p-4 mb-5 border">
				<div class="row">
					<div class="col-md-6 form-group">
						<p style="text-align: center;"><img src="<%= ctxPath%>/resources/images/member/${sessionScope.loginuser.picture}" style="width: 200px; height: 250px;"></p>
					</div>
					<div class="col-md-6 form-group">
						<label class="text-black font-weight-bold" for="phone">name</label>
						<input type="text" id="phone" class="form-control " readonly value="${sessionScope.loginuser.memberName}">
						<label class="text-black font-weight-bold" for="phone">userid</label>
						<input type="text" id="phone" class="form-control " readonly value="${sessionScope.loginuser.memberId}">
						<label class="text-black font-weight-bold" for="phone">nickname</label>
						<input type="text" id="phone" class="form-control " readonly value="${sessionScope.loginuser.nickname}">
					</div>
				</div>
         
				<div class="row">
					<div class="col-md-12 form-group">
						<label class="text-black font-weight-bold" for="email">tel</label>
						<input type="email" id="email" class="form-control " readonly value="${sessionScope.loginuser.memberTel.substring(0,3)}-${sessionScope.loginuser.memberTel.substring(3,7)}-${sessionScope.loginuser.memberTel.substring(7)}">
					</div>
				</div>
         
				<div class="row">
					<div class="col-md-12 form-group">
						<label class="text-black font-weight-bold" for="email">Email</label>
						<input type="email" id="email" class="form-control " readonly="readonly" value="${sessionScope.loginuser.email}">
					</div>
				</div>

				<div class="row">
					<div class="col-md-6 form-group">
						<label class="text-black font-weight-bold" for="name">point</label>
						<input type="text" id="name" class="form-control " readonly value="${sessionScope.loginuser.point}">
					</div>
					<div class="col-md-6 form-group">
						<label class="text-black font-weight-bold" for="phone">grade</label>
						<input type="text" id="phone" class="form-control " readonly value="${sessionScope.loginuser.grade}">
					</div>
				</div>
         	</form>

			</div>
		</div>
	</div>
</section>