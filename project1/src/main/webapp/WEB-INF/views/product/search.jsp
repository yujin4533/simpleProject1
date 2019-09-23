<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
/*  .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;} */
.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}
/* .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')} */
.info .link {
	color: #5085BB;
}

.radius_border {
	border: 1px solid #919191;
	border-radius: 5px;
}

.custom_zoomcontrol { /* position:absolute; */
	top: 50px;
	right: 10px;
	width: 36px;
	height: 80px;
	overflow: hidden;
	z-index: 1;
	background-color: #f5f5f5;
}

.custom_zoomcontrol span {
	display: block;
	width: 36px;
	height: 40px;
	text-align: center;
	cursor: pointer;
}

.custom_zoomcontrol span img {
	width: 15px;
	height: 15px;
	padding: 12px 0;
	border: none;
}

.custom_zoomcontrol span:first-child {
	border-bottom: 1px solid #bfbfbf;
}

._gig1e7 {
	width: 100% !important;
	height: 100% !important;
	padding-top: 8px !important;
	padding-bottom: 12px !important;
}

.hotelAddr {
	font-size: 12px;
}

.hotelName {
	font-size: 18px;
	font-weight: bold;
}

.hotelPrice {
	font-size: 14px;
}

.hotelStar {
	font-size: 12px;
}

.hotelBox {
	padding: 8px 8px 12px;
}

button#btn_heart {
	padding: 8px;
	margin: -8px;
	border: none;
	background-color: transparent;
	/* border: 1px solid red; */
	position: absolute;
	right: 18px;
	top: 10px;
	color: #af3d3d;
	font-size: 22px;
}

.heartAreaIn {
	background: url(<%=request.getContextPath()%>/resources/images/heart_bgb.png);
	background-size: 22px 22px;
	display: inline-flex;
	width: 22px;
	height: 22px;
}

.heartAreaOut {
	background: url(<%=request.getContextPath()%>/resources/images/heart_bg.png);
	background-size: 22px 22px;
	display: inline-flex;
	width: 22px;
	height: 22px;
}

</style>

<script type="text/javascript">

map = null;

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
	
	$("#displayList2").hide();
	$("#hotelName").keyup(function(){
		
	var form_data2 = {searchWord:$("#hotelName").val()};
		
	$.ajax({
		url:"<%=request.getContextPath()%>/ajaxSearchWord.p1",
		type:"GET",
		data:form_data2,
		dataType:"JSON",
		success:function(json) {
				
			// === 검색어 입력시 자동글 완성하기 7 ===
			if(json.length > 0) {
				
				var html = "";
					
				$.each(json, function(entryIndex, item){
					var name = item.hotelName;
						
					var len = $("#hotelName").val().length;
					var result = "";
						
					if(name != null && name.length > 0) {
						var indexN = name.toLowerCase().indexOf( $("#hotelName").val().toLowerCase() );
						result += "<span class='clickWord' style='display: inline-block; width: 100%;'><span class='first'>" +name.substr(0, indexN)+ "</span>" + "<span class='second' style='color:#ffaa34;'>" +name.substr(indexN, len)+ "</span>" + "<span class='third'>" +name.substr(indexN+len)+ "</span></span>";
					}
					
					html += "<span style='cursor:pointer;'>"+ result +"</span><br/>";
					
				});
					
				$("#displayList2").html(html);
				$("#displayList2").show();
					
			} else {
					// 검색된 데이터가 존재하지 않을 경우
				$("#displayList2").hide();
			}
				
		},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	});	
	// === 검색어 입력시 자동글 완성하기 8 ===
	$("#displayList2").click(function(event){
		var word = "";
		var $target = $(event.target);
		
		if($target.is(".clickWord")) {
			word = $target.text();
		}
		else if($target.is(".first")) {
			word = $target.text() + $target.next().text() + $target.next().next().text();
		}
		else if($target.is(".second")) {
			word = $target.prev().text() + $target.text() + $target.next().text();
		}
		else if($target.is(".third")) {
			word = $target.prev().prev().text() + $target.prev().text() + $target.text();
		}	
		$("#hotelName").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
		
		$("#displayList2").hide();
			
	});


	

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(33.381788, 126.544377), // 지도의 중심좌표
		level: 9 // 지도의 확대 레벨
	};  
   
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var geocoder = new kakao.maps.services.Geocoder();
      
	$.ajax({ // 지도 ajax 처리
		url:"/project1/ajaxSearchMap.p1",
		type:"GET",
		dataType:"JSON",
		success:function(json){

		if(json.length > 0) { 
                
			var html = "";
			content = "";
			cnt = 0;
             
			$.each(json, function(entryIndex, item){
            	var hotelidx = item.hotelidx;
				var address = item.address;
                var hotelName = item.hotelName;
                var hotelImg = item.hotelImg;
                var weekPrice = item.weekPrice;
                cnt++;
                   
                geocoder.addressSearch(address, function(result, status) {

					if (status === kakao.maps.services.Status.OK) {

                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					var marker = new kakao.maps.Marker({
                    	map: map,
                        position: coords,
                        clickable: true
					});

                    var iwContent = '<div class="wrap">' + 
                    				'    <div class="info">' + 
                           			'        <div class="title">' + 
                           			'            '+hotelName + 
			                        '        </div>' + 
			                        '        <div class="body">' + 
			                        '            <div class="img ">' +
			                        '                <img src="/project1/resources/images/hotel/'+hotelImg+'" width="73" height="70">' +
			                        '           </div>' + 
			                        '            <div class="desc">' + 
			                        '                <div class="ellipsis">'+address.substring(8)+'</div>' +
			                        '                <div><a href="/project1/product.p1?hotelidx='+hotelidx+'" target="_blank" class="link">상세조회</a></div>' + 
			                        '            </div>' + 
			                        '        </div>' + 
			                        '    </div>' +    
			                         '</div>';//,
					iwRemoveable = true;
                           
                    var infowindow = new kakao.maps.InfoWindow({
                    	content : iwContent,
                        removable : iwRemoveable
					});
                           
                    kakao.maps.event.addListener(marker,'click',function(){
                    	infowindow.open(map,marker);
                    })
                           
                         
                    var overlay = new kakao.maps.CustomOverlay({
                    	content: content,
                        map: map,
                        position: marker.getPosition()       
                    });
                           
                    kakao.maps.event.addListener(marker, 'click', function() {
                        overlay.setMap(map);
                    });
                           
                    if(cnt==1)
                        map.setCenter(coords);
					} 
                }); 
			});
		}
	},
	    error: function(request, status, error){
	    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
    }); // 지도 ajax 처리
    
    
    hotelOptionList = '${hotelVO.hotelOption}'.split(',');
    roomOptionList = '${hotelVO.roomOption}'.split(',');
    categoryCodeList = '${hotelVO.categoryCode}'.split(',');
    
	$.ajax({ // 서브서치 부분 ajax처리
		url:"/project1/ajaxSearchOption.p1",
		type:"GET",
		dataType:"JSON",
		success:function(json){
			if(json.length > 0) { 
		   		
				categoryCodeDiv = "";
         		hotelOptionDiv = "";
         		roomOptionDiv = "";
		   		
         		$.each(json, function(entryIndex, item){
         			minPrice = item.minPrice;
         			maxPrice = item.maxPrice;
         			categoryCode = item.categoryCode;
         			categoryName = item.categoryName;
         			hotelOption = item.hotelOption;
         			roomOption = item.roomOption;
         		
					if(	minPrice != null && maxPrice != null) {
						$("#minPrice").val(Number('${hotelVO.minPrice}'));
     	 				$("#maxPrice").val(Number('${hotelVO.maxPrice}'));

     	 				$("#price-range").slider({
      	                	range: true,
       	                	min: Number(minPrice),
      	                	max: Number(maxPrice),
      	                	values: [Number('${hotelVO.minPrice}'), Number('${hotelVO.maxPrice}')],
      	                	slide: function(event, ui) {
      	                    $("#priceAmount").val("￦" + ui.values[0] + " - ￦" + ui.values[1]);
	        	 			$("#minPrice").val(ui.values[0]);
	        	 			$("#maxPrice").val(ui.values[1]);
      	                } 
      	            });

     	 			$("#priceAmount").val("￦" + $("#price-range").slider("values", 0) + " - ￦" + $("#price-range").slider("values", 1));
     	 			
         			}
         		
         			if(categoryCode != null && categoryCode.length > 0) {
						bool = false;            			
         				if(categoryCodeList!=null){
         					for ( var i in categoryCode+1 ) {
         				 		if(categoryCodeList[i]==categoryCode){
	         				 		bool=true;
	         				 		break;
         				 		}
         				 	}//for문
         					categoryCodeDiv += '<li class="">'+
				            						'       <input type="checkbox" name="categoryCode" value="'+categoryCode+'" id="'+categoryCode;
         					if(bool)
         						categoryCodeDiv += '" checked>';
        					else
         						categoryCodeDiv += '" >';
         					
         					categoryCodeDiv += '   <label for="'+categoryCode+'" >'+categoryName+'</label>'+
			                    			   '</li>';
         					 
         				} else {//categoryCodeList있을때 
		           			categoryCodeDiv += '<li class="">'+
							                   '       <input type="checkbox" name="categoryCode" value="'+categoryCode+'" id="'+categoryCode+'" >'+
							                   '   <label for="'+categoryCode+'" >'+categoryName+'</label>'+
							                   '</li>';
         				}
	        		}

         			if(hotelOption != null && hotelOption.length > 0) {
         				bool = false;            			
             			if(hotelOptionList!=null){
             				for ( var i in hotelOption+1 ) {
             					if(hotelOptionList[i]==hotelOption){
             				 		bool=true;
             				 		break;
             				 	}
             				}//for문
	                	
	             			hotelOptionDiv += '<li class="">'+
		    							  '       <input type="checkbox" name="hotelOption" value="'+hotelOption+'" id="h'+hotelOption;
	             			
	             			if(bool)
	             				hotelOptionDiv += '" checked>';
	            			else
	            				hotelOptionDiv += '" >';
	             			
	            			hotelOptionDiv += '   <label for="h'+hotelOption+'" >'+hotelOption+'</label>'+
				            			  	  '</li>';
	             					 
             			} else {//categoryCodeList있을때 
             				hotelOptionDiv += '<li class="">'+
				                  		      '       <input type="checkbox" name="hotelOption" value="'+hotelOption+'" id="h'+hotelOption+'" >'+
						                      '   <label for="h'+hotelOption+'" >'+hotelOption+'</label>'+
						                      '</li>';
             			}
         			}
         			
         			if(roomOption != null && roomOption.length > 0) {
         				bool = false;            			
         				if(roomOptionList!=null){
         					for ( var i in roomOption ) {
         				 		if(roomOptionList[i]==roomOption){
         				 			bool=true;
         				 			break;
         				 		}
         				 	}//for문
             				
         				 	roomOptionDiv += '<li class="">'+
 				            		      '        <input type="checkbox" name="roomOption" value="'+roomOption+'" id="r'+roomOption;
         					 
         				 	if(bool)
         						roomOptionDiv += '" checked>';
        					else
        						roomOptionDiv += '" >';
         					 	roomOptionDiv +=  '   <label for="r'+roomOption+'" >'+roomOption+'</label>'+
						        			   '</li>';
         					 
         				} else {//categoryCodeList있을때 
         					roomOptionDiv += '<li class="">'+
					        			  '       <input type="checkbox" name="roomOption" value="'+roomOption+'" id="r'+roomOption+'" >'+
					          			  '   <label for="r'+roomOption+'" >'+roomOption+'</label>'+
					          			  '</li>';
         				}
         			}
         		
         		})
        
        		$("#categoryCodeAjax").html(categoryCodeDiv);
        		$("#hotelAjax").html(hotelOptionDiv);
        		$("#roomAjax").html(roomOptionDiv);
			}	
		},
		error: function(request, status, error){
        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	}); // 서브서치 부분 ajax처리 

	// 별점범위 슬라이더바
	$("#minStar").val(Number('${hotelVO.minStar}'));
	$("#maxStar").val(Number('${hotelVO.maxStar}'));
	
	$("#star-range").slider({
            range: true,
            min: 0,
            max: 10,
            values: [Number('${hotelVO.minStar}')*2, Number('${hotelVO.maxStar}')*2],
            slide: function(event, ui) {
                $("#starAmount").val( ui.values[0]*0.5 + "점 - " + ui.values[1]*0.5 +"점");
				$("#minStar").val(ui.values[0]*0.5);
				$("#maxStar").val(ui.values[1]*0.5);
            }
        });
        $("#starAmount").val($("#star-range").slider("values", 0)*0.5+ "점 - " + $("#star-range").slider("values", 1)*0.5+"점");

	
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
	
	
}); // ready

function goSearch() { // 메인검색
	document.infoSearchFrm.action = "<%=request.getContextPath()%>/search.p1";
	document.infoSearchFrm.submit();
}

function goSubSearch(){ // 옵션검색
	document.subSearchFrm.action = "<%=request.getContextPath()%>/search.p1";
	document.subSearchFrm.submit();
}

function goProduct(hotelidx){ // 상품페이지 이동
	document.hotelidxFrm.hotelidx.value = hotelidx;
	document.hotelidxFrm.action = "<%=request.getContextPath()%>/product.p1";
	document.hotelidxFrm.submit();
}
</script>

<section class="site-hero inner-page overlay"
	style="background-image: url(/project1/resources/images/hero_4.jpg)"
	data-stellar-background-ratio="0.5">
	<div class="container">
		<div
			class="row site-hero-inner justify-content-center align-items-center">
			<div class="col-md-10 text-center" data-aos="fade">
				<h1 class="heading mb-3">Hotel</h1>
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

<section class="section pb-4">
	<form name="hotelidxFrm">
		<input type="hidden" name="hotelidx">
		<input type="hidden" name="checkout_date" value="${hotelVO.checkout_date}"> 
		<input type="hidden" name="checkin_date" value="${hotelVO.checkin_date}"> 
		<input type="hidden" name="children" value="${hotelVO.children}">
		<input type="hidden" name="adult" value="${hotelVO.adult}">
			
	</form>
	<div class="container">
		<div class="row check-availabilty" id="next">
			<div class="block-32">

				<form name="infoSearchFrm">
					<div class="row">
						<div class="col-md-6 mb-3 mb-lg-0 col-lg-3">
							<label for="text" class="font-weight-bold text-black">목적지</label>
							<div class="field-icon-wrap">
								<input type="text" id="searchWord" class="form-control"
									name="searchWord" value="${hotelVO.searchWord}"
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
										<select name="adult" id="adults" class="form-control">
											<c:forEach var="i" begin="1" end="4">
												<c:if test="${hotelVO.adult==i}">
													<option value="${i}" selected>${i}</option>
												</c:if>
												<c:if test="${hotelVO.adult!=i}">
													<option value="${i}">${i}</option>
												</c:if>
											</c:forEach>
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
											<c:forEach var="i" begin="0" end="3">
												<c:if test="${hotelVO.children==i}">
													<option value="${i}" selected>${i}</option>
												</c:if>
												<c:if test="${hotelVO.children!=i}">
													<option value="${i}">${i}</option>
												</c:if>
											</c:forEach>
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
								<input value="${hotelVO.checkin_date}" type="text"
									id="checkin_date" name="checkin_date" type="date"
									class="form-control" style="padding-right: 0;"
									autocomplete="off">
							</div>
						</div>
						<div class="col-md-6 mb-3 mb-lg-0 col-lg-2">
							<label for="checkout_date" class="font-weight-bold text-black">체크아웃</label>
							<div class="field-icon-wrap">
								<div class="icon">
									<span class="icon-calendar"></span>
								</div>
								<input value="${hotelVO.checkout_date}" type="text"
									id="checkout_date" type="date" name="checkout_date"
									class="form-control" style="padding-right: 0;"
									autocomplete="off">
							</div>
						</div>
						<div class="col-md-6 col-lg-2 align-self-end">
							<button id="btnSubSearch"
								class="btn btn-primary btn-block text-white" onclick="goSearch();">검색</button>
						</div>
					</div>
				</form>
			</div>

		</div>
	</div>
</section>

<section class="section section_map">
	<div class="container">
		<div class="row">
			<div class="map_wrap col-md-12">
				<div id="map" style="height: 680px; margin: 0 auto;"
					class="block-32 aos-init aos-animate"></div>
			</div>
		</div>
	</div>
</section>

<section class="section bg-light">
<!-- 	<div class="container"> -->
<!-- 		<div class="row" id="sortDiv"> -->
<!-- 			<select name="sort" id="sort" class="form-control col-md-3 col-sm-3" -->
<!-- 				style="margin-left: 68.3%;" onchange="changeSort(this.value)"> -->
<%-- 				<c:if test="${hotelVO.sort!=null}"> --%>
<%-- 					<c:if --%>
<%-- 						test="${hotelVO.sort=='largecategoryontioncode' or hotelVO.sort==''}"> --%>
<!-- 						<option value="largecategoryontioncode" selected>상품목록순</option> -->
<!-- 						<option value="weekPrice">가격순정렬</option> -->
<!-- 						<option value="star">별점순정렬</option> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${hotelVO.sort=='weekPrice'}"> --%>
<!-- 						<option value="largecategoryontioncode">상품목록순</option> -->
<!-- 						<option value="weekPrice" selected>가격순정렬</option> -->
<!-- 						<option value="star">별점순정렬</option> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${hotelVO.sort=='star'}"> --%>
<!-- 						<option value="largecategoryontioncode">상품목록순</option> -->
<!-- 						<option value="weekPrice" selected>가격순정렬</option> -->
<!-- 						<option value="star" selected>별점순정렬</option> -->
<%-- 					</c:if> --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${hotelVO.sort==null}"> --%>
<!-- 					<option value="largecategoryontioncode" selected>상품목록순</option> -->
<!-- 					<option value="weekPrice">가격순정렬</option> -->
<!-- 					<option value="star">별점순정렬</option> -->
<%-- 				</c:if> --%>
<!-- 			</select> -->
<!-- 		</div> -->
<!-- 	</div> -->

	<div class="container">
		<div class="row">
			<div class="col-md-3 col-sm-5">
				<form name="subSearchFrm">
					<input type="hidden" name="searchWord" value="${hotelVO.searchWord}"> 
<%-- 					<input type="hidden" name="sort" value="${hotelVO.sort}">  --%>
					<input type="hidden" name="checkout_date" value="${hotelVO.checkout_date}"> 
					<input type="hidden" name="checkin_date" value="${hotelVO.checkin_date}"> 
					<input type="hidden" name="children" value="${hotelVO.children}">
					<input type="hidden" name="adult" value="${hotelVO.adult}">

					<fieldset>
						<h4 aria-expanded="true" role="button" tabindex="0" style="margin-bottom: 15px;">옵션으로 검색</h4>
						<div>
							<input type="text" id="hotelName" class="form-control" name="hotelName" value="${hotelVO.hotelName}" placeholder="숙박명 " autocomplete="off">
							<div id="displayList2"></div>
							<button id="optionSearch" class="btn btn-primary btn-block text-white" style="margin-top: 8px; margin-bottom: 16px;">숙박명으로 검색하기</button>
						</div>
					</fieldset>
					<div data-field-collection="non-name">
						<fieldset>
							<h4 aria-expanded="true" role="button" tabindex="0">1박 요금</h4>
							<div id="filter-price-contents" class="filter-contents">
								<div id="price-range"></div>
								<input type="hidden" id="minPrice" value="" name="minPrice">
								<input type="hidden" id="maxPrice" value="" name="maxPrice">
								<input type="text" id="priceAmount" readonly style="border: 0; color: #f6931f; font-weight: bold; background: transparent;">
							</div>
						</fieldset>
						<fieldset>
							<h4 aria-expanded="true" role="button" tabindex="0"
								aria-controls="filter-guest-rating-contents">고객 평점</h4>
							<div id="filter-guest-rating-contents" class="filter-contents">
								<div id="star-range"></div>
								<input type="hidden" id="minStar" value="" name="minStar">
								<input type="hidden" id="maxStar" value="" name="maxStar">
								<input type="text" id="starAmount" readonly style="border: 0; color: #f6931f; font-weight: bold; background: transparent;">
							</div>
						</fieldset>
						<fieldset>
							<h4 aria-expanded="false" role="button" tabindex="0">숙박 시설
								유형</h4>
							<div>
								<ul class="list-unstyled link" id="categoryCodeAjax"></ul>
							</div>
						</fieldset>
						<fieldset>
							<h4 aria-expanded="false" role="button" tabindex="0">숙박시설</h4>
							<div>
								<ul id="hotelAjax" class="list-unstyled link"></ul>
							</div>
						</fieldset>
						<fieldset>
							<h4 aria-expanded="false" role="button" tabindex="0">객실시설</h4>
							<div>
								<ul id="roomAjax" class="list-unstyled link"></ul>
							</div>
						</fieldset>
					</div>
					<button type="button" id="optionSearch" onclick="goSubSearch()"
						class="btn btn-primary btn-block text-white"
						style="margin-top: 8px; margin-bottom: 16px;">옵션으로 검색</button>
				</form>
			</div>
			<div class="col-md-9 aos-animate col-sm-7">
				<div>
					<div class="row" id="hotelList">

						<c:if test="${hotelList!=null}">
							<c:forEach var="vo" items="${hotelList}">
								<div class="col-lg-4 col-md-6 col-sm-12 hotelBox ">
									<!-- 상단(이미지,찜하트) -->
									<div style="position: relative;">
										<button type="button" style="cursor: pointer;"
											onclick="location.href='/project1/addHeart.p1?hotelidx=${vo.hotelidx}'"
											class="heart" id="btn_heart${status}" aria-busy="false"
											style="padding: 8px; margin: -8px; border: none; background-color: transparent;">
											<span class="heartAreaOut"> 
												<c:if test="${vo.heart==1}"> 
													<span class="heartAreaIn" style="width: 22px;">
														<span class="blind">heart</span>
 													</span>
 												</c:if> 
											</span>
										</button>
										<img src="/project1/resources/images/hotel/${vo.hotelImg}"
											style="width: 270px; height: 180px; cursor: pointer;"
											onclick="goProduct('${vo.hotelidx}')">
									</div>
									<!-- 하단(설명,호텔명,가격,평점) -->
									<div style="padding: 12px 0 0 0;">
										<div class="hotelAddr meta-post">${vo.address.substring(8)}</div>
										<div class="hotelName" style="cursor: pointer;"
											onclick="goProduct('${vo.hotelidx}')">${vo.hotelName}</div>
										<div class="hotelPrice">
											<fmt:formatNumber value="${vo.weekPrice}" pattern="###,###" />
											원 ~
										</div>

										<c:if test="${vo.starCnt != 0}">
											<span class="starAreaIn"> <span class="starAreaOut"
												style="width: ${vo.starRating*14.6}px;"><span class="blind">star</span></span>
											</span>
											<span style="font-size: 10pt;">${vo.starRating}점
												&nbsp;${vo.starCnt}개의 후기</span>
										</c:if>
										<c:if test="${vo.starCnt==0}">
											<span class="starAreaIn"> </span>
											<span style="font-size: 10pt;">아직 후기가 없습니다.</span>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${hotelList==null}">
							<h1 class="header" style="margin: 0 auto;">~조건에 일치하는 상품이 없습니다~</h1>
						</c:if>

					</div>

					<div class="col-12">
						<div class="custom-pagination">
							<ul class="list-unstyled" id="pagebar">
								<c:if test="${pagebar!=null}">
									${pagebar}
								</c:if>
							</ul>
						</div>
					</div>


				</div>

			</div>
		</div>
	</div>
</section>