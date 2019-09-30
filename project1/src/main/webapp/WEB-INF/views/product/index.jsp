 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>

<script type="text/javascript">
$(document).ready(function(){
   	
    $("#displayList").hide();
	$("#searchWord").keyup(function(){
			
		var form_data = {searchWord:$("#searchWord").val()};
		
		$.ajax({
			url:"<%=request.getContextPath()%>/ajaxSearchWord.p1",
			type:"GET",
			data:form_data,
			dataType:"JSON",
			success:function(json) {
				
				// === 검색어 입력시 자동글 완성하기 7 ===
				if(json.length > 0) {
				
					var html = "";
					
					$.each(json, function(entryIndex, item){
						var hotelName = item.hotelName;
						var address = item.address;
						
						var len = $("#searchWord").val().length;
						var result = "";
						
						if(hotelName != null && hotelName.length > 0) {
							var indexN = hotelName.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() );
							result += "<span class='clickWord' style='display: inline-block; width: 100%;'><span class='first'>" +hotelName.substr(0, indexN)+ "</span>" + "<span class='second' style='color:#ffaa34;'>" +hotelName.substr(indexN, len)+ "</span>" + "<span class='third'>" +hotelName.substr(indexN+len)+ "</span></span>";
						}
						
						if(address != null && address.length > 0) {
							var indexA = address.toLowerCase().indexOf( $("#searchWord").val().toLowerCase() );
							result += "<span class='clickWord' style='display: inline-block; width: 100%;'><span class='first'>" +address.substr(0, indexA)+ "</span>" + "<span class='second' style='color:#ffaa34;'>" +address.substr(indexA, len)+ "</span>" + "<span class='third'>" +address.substr(indexA+len)+ "</span></span>";
						}
							html += "<span style='cursor:pointer;'>"+ result +"</span><br/>";
					});
					
					$("#displayList").html(html);
					$("#displayList").show();
					
				}
				else 
					$("#displayList").hide();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	});	
	// === 검색어 입력시 자동글 완성하기 8 ===
	$("#displayList").click(function(event){
		var word = "";
		var $target = $(event.target);
		
		if($target.is(".clickWord")) 
			word = $target.text();
		
		else if($target.is(".first")) 
			word = $target.text() + $target.next().text() + $target.next().next().text();
		
		else if($target.is(".second"))
			word = $target.prev().text() + $target.text() + $target.next().text();
		
		else if($target.is(".third")) 
			word = $target.prev().prev().text() + $target.prev().text() + $target.text();
		
		$("#searchWord").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
		
		$("#displayList").hide();
		
	});
	
			
	var rangeDate = 31; // set limit day
	var setSdate, setEdate;
	$("#checkin_date").datepicker({
	    dateFormat: 'yy-mm-dd',
	    minDate: 0,
	    onSelect: function(selectDate){
	        var stxt = selectDate.split("-");
	            stxt[1] = stxt[1] - 1;
	        var sdate = new Date(stxt[0], stxt[1], stxt[2]);
	        var edate = new Date(stxt[0], stxt[1], stxt[2]);
	            edate.setDate(sdate.getDate() + rangeDate);
	        
	        $('#checkout_date').datepicker('option', {
	            minDate: selectDate,
	            beforeShow : function () {
	                $("#checkout_date").datepicker( "option", "maxDate", edate );                
	                setSdate = selectDate;
	                console.log(setSdate)
	        }});
	        //checkout_date 설정
	    }
	    //checkin_date 선택되었을 때
	});
	            
	$("#checkout_date").datepicker({ 
	    dateFormat: 'yy-mm-dd',
	    onSelect : function(selectDate){
	        setEdate = selectDate;
	        console.log(setEdate)
	    }
	});
	$("#btnSearch").on("click", function(e){
	    
	    var t1 = $("input#checkin_date").val().split("-");
	    var t2 = $("input#checkout_date").val().split("-");
	    var t1date = new Date(t1[0], t1[1], t1[2]);
	    var t2date = new Date(t2[0], t2[1], t2[2]);
	    var diff = t2date - t1date;
	    var currDay = 24 * 60 * 60 * 1000;
	    if(parseInt(diff/currDay) > rangeDate){
	        alert("로그 조회 기간은 " + rangeDate + "일을 초과할 수 없습니다.");        
	        return false;
	    }
		var checkin_dateVal = $("input#checkin_date").val();
		var checkout_dateVal = $("input#checkout_date").val();
		checkin_dateVal = checkin_dateVal.substring(0,4) + checkin_dateVal.substring(5,7) + checkin_dateVal.substring(8);
		checkout_dateVal = checkout_dateVal.substring(0,4) + checkout_dateVal.substring(5,7) + checkout_dateVal.substring(8);
	});
	
}); // end of $(document).ready------------------------
function goSearch() {
	document.infoSearchFrm.action = "<%=request.getContextPath()%>/search.p1";
	document.infoSearchFrm.submit();
}
	
</script>

<section class="site-hero overlay"
	style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)"
	data-stellar-background-ratio="0.5">
	<div class="container">
		<div
			class="row site-hero-inner justify-content-center align-items-center">
			<div class="col-md-10 text-center" data-aos="fade-up">
				<span class="custom-caption text-uppercase text-white d-block  mb-3">
					Welcome To <span class="fa fa-star text-primary"></span> OLLEH
				</span>
				<h1 class="heading">A Best Place To Stay</h1>
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

<section class="section bg-light pb-0">
	<div class="container">

		<div class="row check-availabilty" id="next">
			<div class="block-32" data-aos="fade-up" data-aos-offset="-200">

				<form name="infoSearchFrm">
					<div class="row">
						<div class="col-md-6 mb-3 mb-lg-0 col-lg-3">
							<label for="text" class="font-weight-bold text-black">목적지</label>
							<div class="field-icon-wrap">
								<input type="text" name="searchWord" id="searchWord" class="form-control"
									placeholder="숙박명 또는 지역명을 검색" autocomplete="off">

								<!-- === 검색어 입력시 자동글 완성하기 1 === -->
								<div id="displayList"></div>
								<!-- //end 검색어 입력시 자동글 완성하기 1 -->

							</div>
						</div>
						<div class="col-md-6 mb-3 mb-md-0 col-lg-3">
							<div class="row">
								<div class="col-md-6 mb-3 mb-md-0">
									<label for="adult" class="font-weight-bold text-black">성인</label>
									<div class="field-icon-wrap">
										<div class="icon">
											<span class="ion-ios-arrow-down"></span>
										</div>
										<select name="adult" id="adults" class="form-control">
											<option value="1" selected>1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4+</option>
										</select>
									</div>
								</div>
								<div class="col-md-6 mb-3 mb-md-0">
									<label for="children" class="font-weight-bold text-black">아동</label>
									<div class="field-icon-wrap">
										<div class="icon">
											<span class="ion-ios-arrow-down"></span>
										</div>
										<select name="children" id="children" class="form-control">
											<option value="0" selected>0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6 mb-3 mb-lg-0 col-lg-2">
							<label for="checkin_date" class="font-weight-bold text-black">체크인</label>
							<div class="field-icon-wrap">
								<div class="icon">
									<span class="icon-calendar"></span>
								</div>
								<input type="text" id="checkin_date" name="checkin_date" type="date" class="form-control" style="padding-right:0;" autocomplete="off">
							</div>
						</div>
						<div class="col-md-6 mb-3 mb-lg-0 col-lg-2">
							<label for="checkout_date" class="font-weight-bold text-black">체크아웃</label>
							<div class="field-icon-wrap">
								<div class="icon">
									<span class="icon-calendar"></span>
								</div>
								<input type="text" id="checkout_date" type="date" name="checkout_date" class="form-control" style="padding-right:0;" autocomplete="off">
							</div>
						</div>
						<div class="col-md-6 col-lg-2 align-self-end">
							<button id="btnSearch" class="btn btn-primary btn-block text-white" onclick="goSearch();">검색</button>
						</div>
					</div>
				</form>
			</div>

		</div>
	</div>
</section>

<section class="section blog-post-entry bg-light">
	<div class="container">
		<div class="row justify-content-center text-center mb-5">
			<div class="col-md-7">
				<h2 class="heading">Best 숙소</h2>
				<p>퀄리티와 인테리어 디자인이 검증된 숙소 셀렉션</p>
			</div>
		</div>
		<div class="row">
		<c:if test="${hotelListBest!=null}">
			<c:forEach var="hotelvobest" items="${hotelListBest}">
				<div class="col-lg-4 col-md-6 col-sm-6 col-12 post mb-4">
					<div class="media media-custom d-block h-100">
						<a href="<%=ctxPath%>/product.p1?hotelidx=${hotelvobest.hotelidx}" class="mb-4 d-block">
							<img src="<%= ctxPath%>/resources/images/hotel/${hotelvobest.hotelImg}" style="width: 350px; height: 232px;" class="img-fluid">
						</a>
						<div class="media-body">
							<span class="meta-post">${hotelvobest.address.substring(8)}</span>
							<h2 class="mt-0 mb-3">
								<a href="<%=ctxPath%>/product.p1?hotelidx=${hotelvobest.hotelidx}" style="display: inline-block; white-space: initial;">${hotelvobest.hotelName}</a>
							</h2>
							<p>
								<span class="starAreaIn">
									<span class="starAreaOut" style="width: ${hotelvobest.starRating*14.6}px;"><span class="blind">star</span></span>
								</span>
								<c:if test="${hotelvobest.starCnt != 0}">
									<span style="font-size: 10pt;">${hotelvobest.starRating}점
												&nbsp;${hotelvobest.starCnt}개의 후기</span>
								</c:if>
								<c:if test="${hotelvobest.starCnt == 0}">
									<span style="font-size: 10pt;">아직 후기가 없습니다.</span>
								</c:if>
							</p>
							</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${hotelListBest==null}">
			<h1 class="header" style="margin: 0 auto;">~아직 베스트숙소가 선정되지 않았습니다~</h1>
		</c:if>
		</div>
	</div>
</section>

<section class="section blog-post-entry bg-light">
	<div class="container">
		<div class="row justify-content-center text-center mb-5">
			<div class="col-md-7">
				<h2 class="heading">최신 숙소</h2>
				<p>새로 오픈한 숙소를 둘러보세요.</p>
			</div>
		</div>
		<div class="row">
		<c:if test="${hotelListNew!=null}">
				<c:forEach var="hotelvonew" items="${hotelListNew}">
				<div class="col-lg-4 col-md-6 col-sm-6 col-12 post mb-4">
					<div class="media media-custom d-block h-100">
						<a href="<%=ctxPath%>/product.p1?hotelidx=${hotelvonew.hotelidx}" class="mb-4 d-block">
							<img src="<%=ctxPath%>/resources/images/hotel/${hotelvonew.hotelImg}" style="width: 350px; height: 232px;"  class="img-fluid">
						</a>
						<!-- 하단(호텔명,가격,평점) -->
						<div class="media-body">
							<span class="meta-post">${hotelvonew.address.substring(8)}</span>
							<h2 class="mt-0 mb-3">
								<a href="<%=ctxPath%>/product.p1?hotelidx=${hotelvonew.hotelidx}" style="display: inline-block; white-space: initial;">${hotelvonew.hotelName}</a>
							</h2>
							<%-- <p>${hotelvo.weekPrice}원 ~</p> --%>
							<p>
								<span class="starAreaIn">
									<span class="starAreaOut" style="width: ${hotelvonew.starRating*14.6}px;"><span class="blind">star</span></span>
								</span>
								<c:if test="${hotelvonew.starCnt != 0}">
									<span style="font-size: 10pt;">${hotelvonew.starRating}점
												&nbsp;${hotelvonew.starCnt}개의 후기</span>
								</c:if>
								<c:if test="${hotelvonew.starCnt == 0}">
									<span style="font-size: 10pt;">아직 후기가 없습니다.</span>
								</c:if>
							</p>
						</div>
					</div>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${hotelListNew==null}">
				<h1 class="header" style="margin: 0 auto;">~최신 숙소가 없습니다~</h1>
			</c:if>
		</div>
	</div>
</section>

<!-- END section -->