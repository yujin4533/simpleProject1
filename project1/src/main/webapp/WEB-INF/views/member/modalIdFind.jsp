<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath();
%>    
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("#error").hide(); 
		var method = "${method}";
	
	    if(method == "GET") {
			$("#div_findResult").hide();
			$("#btnFind").show();
	    } else {
	    	$("#memberName").val("${memberName}").attr("disabled",true);
	    	$("#email").val("${email}").attr("disabled",true);
	    	$("#error2").hide();
	    	$("#div_findResult").show();
	    	$("#btnFind").hide();
	    }
	    
		$("#btnFind").click(function(){
			
			var nameVal = $("#memberName").val().trim();
			var emailVal = $("#email").val().trim();
			
			if(nameVal != "" && emailVal != "") 
				document.idFindFrm.submit();
			else 
				alert(">>입력해주세요<<");
			
		});
		
		
	});// end of $(document).ready(function(){ })-----------------
	
</script>
<form name="idFindFrm" method="post" action="/project1/modalIdFind.p1">
	<div class="row">
		<div class="col-md-12 form-group">
			<label class="text-black font-weight-bold" for="memberName">성명</label>
			<input type="text" name="memberName" id="memberName" class="form-control" placeholder="홍길동" required />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 form-group">
			<label class="text-black font-weight-bold" for="email">이메일</label>
			<input type="text" name="email" id="email" class="form-control" placeholder="abc@def.com" required />
		</div>
	</div>
	<c:if test='${method == "GET"}'>
		<span id="error" style="color: red;">사용자 정보가 없습니다.</span>
		<div class="col-md-12 form-group taC mgt10">
			<input type="button" value="찾기" id="btnFind" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
		</div>
    </c:if>
    <c:if test='${memberId==""or memberId==null}'>
    	<div class="col-md-12 form-group taC mgt10">
			<span style="color: red;">사용자 정보가 없습니다.</span>
		</div>
	</c:if> 
	<c:if test='${memberId!=""and !"".equals(memberId)}'>
		<span id="div_findResult">
			<div class="col-md-12 form-group taC mgt10">
				<label class="text-black font-weight-bold" s>ID</label> : <span style="color: #ffaa34; font-size: 16pt; font-weight: bold;">${memberId}</span> 
			</div>
		</span>
	</c:if>
</form>