<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath =  request.getContextPath();%>
<%-- ======= #27. tiles1 중 footer 페이지 만들기  ======= --%>

<footer class="section footer-section">
	<div class="container">
		<div class="row pt-5">
			<p class="col-md-12 text-center">
				Copyright &copy;
				<script>
					document.write(new Date().getFullYear());
				</script>
				All rights reserved | This hompage is made with <i
					class="icon-heart-o" aria-hidden="true"></i> by <a href="<%=ctxPath%>/admin_adminLogin.p1">OLLEH</a>
			</p>
		</div>
	</div>
</footer>

<script src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script src="<%=ctxPath%>/resources/js/jquery-migrate-3.0.1.min.js"></script>
<script src="<%=ctxPath%>/resources/js/popper.min.js"></script>
<script src="<%=ctxPath%>/resources/js/bootstrap.min.js"></script>
<script src="<%=ctxPath%>/resources/js/owl.carousel.min.js"></script>
<script src="<%=ctxPath%>/resources/js/jquery.stellar.min.js"></script>
<script src="<%=ctxPath%>/resources/js/jquery.fancybox.min.js"></script>


<script src="<%=ctxPath%>/resources/js/aos.js"></script>

<script src="<%=ctxPath%>/resources/js/bootstrap-datepicker.js"></script>
<script src="<%=ctxPath%>/resources/js/jquery.timepicker.min.js"></script>

<script src="<%=ctxPath%>/resources/js/main.js"></script>