<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>x
<script type="text/javascript">

	$(document).ready(function(){
		
		
	});
	

	function changeChart(val) {
		$("#chart_product").empty();
		if("hotelStatus"==val){
			$.ajax({
				url: "ajaxHotelChart.p1",
				dataType: "JSON" ,
				success: function(json){
				
					if(json.length > 0) {
						var resultArr = [];
						for(var i=0; i<json.length; i++){
							var obj = {name:json[i].categoryName , y:Number(json[i].categoryCode)};
							resultArr.push(obj); 
						}
						Highcharts.chart('chart_product', {
						    chart: {
						        type: 'pie'
						    },
						    title: {
						        text: '숙소종류별'
						    },
						    xAxis: {
						        type: 'category',
						        labels: {
						            rotation: -45,
 						            style: {
						                fontSize: '13px',
						                fontFamily: 'Verdana, sans-serif'
						            }
						        }
						    },
						    yAxis: {
						        min: 0,
						        title: {
						            text: 'Population '
						        }
						    },
						    legend: {
						        enabled: false
						    },
						    tooltip: {
						        pointFormat: '{point.name}: {point.y}개'
						    },
						    series: [{
						        name: 'Population',
						        data: resultArr	    ,
						        dataLabels: {
						            enabled: true,
						            rotation: -90,
						            color: '#FFFFFF',
						            align: 'right',
						            format: '{point.name} : {point.y}', // one decimal
						            y: 10, // 10 pixels down from the top
						            style: {
						                fontSize: '13px',
						                fontFamily: 'Verdana, sans-serif'
						            }
						        }
						    }]
						});
					}
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}
		
		if(val=="dfasdgs"){
				$.ajax({
				 	url:"admin_categoryProductJSON.go",
				 	dataType: "JSON",
					success: function(json){
					 
					 	$("#chart_product").empty();
						
						var resultArr = [];
						for(var i=0; i<json.length; i++){
							var obj = {name:json[i].largecategoryname , y:Number(json[i].cnt)};
							resultArr.push(obj); 
						}
				 
						Highcharts.chart('chart_product', {
						    chart: {
						        type: 'column'
						    },
						    title: {
						        text: '종류별'
						    },
						    subtitle: {
						        text: '현재'
						    },
					    	xAxis: {
								type: 'category',
					        	labels: {
							    	rotation: -45,
							        style: {
							        	fontSize: '13px',
							            fontFamily: 'Verdana, sans-serif'
							    	}
								}
						    },
						    yAxis: {
						        min: 0,
						        title: {
						            text: 'Population '
						        }
						    },
						    legend: {
						        enabled: false
						    },
						    tooltip: {
						        pointFormat: '{point.y:.1f} '
						    },
						    series: [{
						        name: 'Population',
						        data: resultArr	    ,
					        dataLabels: {
						        enabled: true,
						        rotation: -90,
						        color: '#FFFFFF',
						        align: 'right',
						        format: '{point.y:.1f}', // one decimal
						        y: 10, // 10 pixels down from the top
						        style: {
							        fontSize: '13px',
							    	fontFamily: 'Verdana, sans-serif'
								}
							}
						}]
					});
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}
	 			
	 } 
	

// 	var ctx = document.getElementById("myChart").getContext('2d');
// 	var myChart = new Chart(ctx, {
// 	    type: 'bar',
// 	    data: {
// 	        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
// 	        datasets: [{
// 	            label: '# of Votes',
// 	            data: [12, 19, 3, 5, 2, 3],
// 	            backgroundColor: [
// 	                'rgba(255, 99, 132, 0.2)',
// 	                'rgba(54, 162, 235, 0.2)',
// 	                'rgba(255, 206, 86, 0.2)',
// 	                'rgba(75, 192, 192, 0.2)',
// 	                'rgba(153, 102, 255, 0.2)',
// 	                'rgba(255, 159, 64, 0.2)'
// 	            ],
// 	            borderColor: [
// 	                'rgba(255,99,132,1)',
// 	                'rgba(54, 162, 235, 1)',
// 	                'rgba(255, 206, 86, 1)',
// 	                'rgba(75, 192, 192, 1)',
// 	                'rgba(153, 102, 255, 1)',
// 	                'rgba(255, 159, 64, 1)'
// 	            ],
// 	            borderWidth: 1
// 	        }]
// 	    },
// 	    options: {
// 	        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
// 	        scales: {
// 	            yAxes: [{
// 	                ticks: {
// 	                    beginAtZero:true
// 	                }
// 	            }]
// 	        }
// 	    }
// 	});
</script>  
    
    
    
<section class="site-hero inner-page overlay" style="background-image: url(/project1/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
          <div class="col-md-10 text-center" data-aos="fade">
            <h1 class="heading mb-3">Product Chart</h1>
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
			<div class="col-md-6 " >
				<form name="hotelidxFrm" action="/project1/productStatusDetail.p1">
					<select name="productType" id="productType" class="form-control col-md-3 col-sm-3" onchange="changeChart(this.value)">
						<option value="">항목선택</option>
						<option value="hotelStatus">숙소현황</option>
						<option value="hoteleeeStatus">숙소상세현황</option>
						<option value="roomStatus">객실현황</option>
						<option value="hoteleeeStatus">객실상세현황</option>
					</select>
					<div id="chart_product" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
				</form>
			</div>
		</div>
	</div>
</section>