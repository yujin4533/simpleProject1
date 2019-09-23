<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    
		var method = "${method}";
	
	    if(method == "GET") 
			$("#div_findResult").hide();
	    else {
			$("#btnFind").hide();
	    	$("#memberId").val("${memberId}");
	    	$("#email").val("${email}");
	    	$("#div_findResult").show();
	    }

		$("#btnConfirmCode").click(function(){
			
			if($("#input_confirmCode").val()!='${certificationCode}'){
				alert(">>인증번호가 틀립니다<<");
				$("#input_confirmCode").val()="";
				$("#input_confirmCode").focus();
				return;
			}
			
			document.goChangePwd.submit();
		});
	    
	});
	
</script>
<form name="goChangePwd" method="post" action="/project1/modalChangePwd.p1"><input type="hidden" name="memberId" value="${memberId}"></form>
<form name="pwdFindFrm" method="post" action="/project1/modalPwdFind.p1">
	<div class="row">
		<div class="col-md-12 form-group">
			<label class="text-black font-weight-bold" for="memberId">아이디</label>
			<input type="text" name="memberId" id="memberId" class="form-control" placeholder="ID" required />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 form-group">
			<label class="text-black font-weight-bold" for="email">이메일</label>
			<input type="text" name="email" id="email" class="form-control" placeholder="abc@def.com" required />
		</div>
	</div>

	<div id="div_findResult" align="center">
		<c:if test="${n==1}">
			<div id="pwdConfirmCodeDiv">
				<span style="font-size: 10pt;">인증코드가 ${email}로 발송되었습니다.</span><br />
				<span style="font-size: 10pt;">인증코드를 입력해주세요</span><br /> <input
					type="text" name="input_confirmCode" id="input_confirmCode"
					required /> <br />
				<br />
				<input type="button" value="인증하기" id="btnConfirmCode" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
			</div>
		</c:if>


	</div>

	<c:if test="${n==-1}">
		<span style="font-size: 10pt;color: red;">메일 발송에 실패했습니다.</span><br />
		<span style="font-size: 10pt;">다시 시도해주세요</span>
		<div class="col-md-12 form-group taC mgt10">
			<input type="submit" value="찾기" id="btnFind" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
		</div>
	</c:if>
	<c:if test="${n==0}">
		<span style="color: red;">사용자 정보가 없습니다.</span>
		<div class="col-md-12 form-group taC mgt10">
			<input type="submit" value="찾기" id="btnFind" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
		</div>
	</c:if>

	<div class="col-md-12 form-group taC mgt10">
		<input type="submit" value="찾기" id="btnFind" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
	</div>
	
	
</form>