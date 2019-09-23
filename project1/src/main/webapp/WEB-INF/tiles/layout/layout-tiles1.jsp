<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%-- === #22. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>   
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<% String ctxPath =  request.getContextPath();	%>
    
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>ollehJeju</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="" />
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto&display=swap">

<script src="https://kit.fontawesome.com/dc25e27438.js"></script>

<link rel="stylesheet" href="<%=ctxPath%>/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/animate.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/aos.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/jquery.timepicker.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/fancybox.min.css">

<link rel="stylesheet" href="<%=ctxPath%>/resources/fonts/ionicons/css/ionicons.min.css">
<link rel="stylesheet" href="<%=ctxPath%>/resources/fonts/fontawesome/css/font-awesome.min.css">

<!-- Theme Style -->
<link rel="stylesheet" href="<%=ctxPath%>/resources/css/style.css">
<link rel="stylesheet" href="<%= ctxPath%>/resources/js/jquery-ui.min.css">


<script src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<!-- 카카오지도 맵키 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=55fd286227a4e6210dc2be181c4c6306"></script>

<!-- 스마트 에디터 -->
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
	<div id="mycontainer">
	
		<div id="myheader">
			<tiles:insertAttribute name="header" />
		</div>
		
		<div id="mycontent">
			<tiles:insertAttribute name="content" />
		</div>
		
		<div id="myfooter">
			<tiles:insertAttribute name="footer" />
		</div>
		
	</div>
</body>
</html>