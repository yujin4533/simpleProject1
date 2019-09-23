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

    	$(".error").hide();
    	$("#error_passwd").hide();
    	 
		$("#memberPwd").blur(function(){
			var passwd = $(this).val();
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			var bool = regExp_PW.test(passwd);
			
			if(!bool) {
				$("#error_passwd").show();
				$(":input").attr("disabled",true).addClass("bgcol"); 
				$(this).attr("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else {
				$("#error_passwd").hide();
				$(":input").attr("disabled",false).removeClass("bgcol"); 
				$("#checkPwd").focus();
			} 
		}); // end of $("#memberPwd").blur()---------------

 		
    	$("#checkPwd").blur(function(){
 			var passwd = $("#memberPwd").val();
 			var passwdCheck = $(this).val();
 			
 			if(passwd != passwdCheck) {
 				$(this).parent().find(".error").show();
 				$(":input").attr("disabled",true).addClass("bgcol");
 				$(this).attr("disabled",false).removeClass("bgcol");
 				$("#memberPwd").attr("disabled",false).removeClass("bgcol");
 				$("#memberPwd").focus();
 			}
 			else {
 				$(this).parent().find(".error").hide();
 				$(":input").attr("disabled",false).removeClass("bgcol");
 			}
     
     	}); 
		
     });
    
	function goChange() {
		passwd = document.changeFrm.memberPwd.value.trim();
		checkPwd = document.changeFrm.checkPwd.value.trim();
		if(passwd == "") {
		 	alert("비밀번호를 입력해주세요");
			$("#memberPwd").val(""); 
			$("#memberPwd").focus();
			return;
		}
		
		if(checkPwd =="") {
			alert("암호확인을 입력해주세요");
			$("#checkPwd").val(""); 
			$("#checkPwd").focus();
			return;
		}
		 
		var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
		var bool = regExp_PW.test(passwd);
		
		if(!bool) {
			alert("암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.");
			return;			
		}
		
		if(passwd != checkPwd){
			alert("암호가 일치하지 않습니다.");
			return;			
		}
			
		document.changeFrm.submit();
    }
</script>
<form name="changeFrm" method="post" action="/project1/modalChangePwd.p1" class="bg-white p-md-5 p-4 mb-5 border">
	<c:if test="${msg==null or msg==''}">
		<input type="hidden" name="memberId" value="${memberId}">
		<div class="row">
			<div class="col-md-12 form-group">
				<label class="text-black font-weight-bold" for="memberPwd" >암호</label> 
				<input type="password" name="memberPwd" id="memberPwd" class="form-control " required="required"> 
				<span id="error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 form-group">
				<label class="text-black font-weight-bold" for="checkPwd">암호확인</label> 
				<input type="password" name="checkPwd" id="checkPwd" class="form-control " required> 
				<span class="error">암호가 일치하지 않습니다.</span>
			</div>
		</div>
	
		<div class="col-md-12 form-group taC mgt10">
			<input type="submit" value="변경" id="btnFind" class="btn btnModal text-white py-3 mx-2 font-weight-bold">
		</div>
	</c:if>
	<c:if test="${msg!=null and msg!=''}">
		<div id="div_findResult" align="center">
			<br><br><br>
			<span style="font-size: 20pt; font-weight: bold;">${msg}</span>
		</div>
	</c:if>
	
</form>