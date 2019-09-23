<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath(); //  /MyMVC
%>    
   
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath()%>/resources/js/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>중복 ID 검사하기</title>
<script type="text/javascript">
	
	$(document).ready(function(){
		$("#error").hide();
		$("#emailerror").hide();
		
	});// end of $(document).ready(function(){ })-----------------
	
	
	function goCheck() {
		var check = $("#check").val().trim();
		
		if(check == "") {
			$("#error").show();
			$("#check").val("");
			$("#check").focus();
			
			return;
		}
		else {
			$("#error").hide();
			
			var frm = document.frmIdcheck;
			frm.method = "post";
			frm.action = "duplicateCheck.p1";
			frm.submit();
		}
		
	}// end of function goCheck()------------------
	
	
	function setUse(check) {
	    $(opener.document).find('#${title}').val(check);
		self.close();
	}
	
</script>

</head>
<body>

	<c:if test="${method =='GET'}">
	<form name="frmIdcheck">
		<table style="width: 95%; height: 100px;">
			<tr>
				<td style="text-align: center;">
					<input type="hidden" name="title" value="${title}">
					${title}를 입력하세요<br style="line-height: 200%;"/>					
					<input type="text" name="check" id="check" size="20" maxlength="20" class="box" />
					<c:if test="${title =='email'}">
						<select id="email" name="email">
							<option value="@naver.com">@naver.com</option>
							<option value="@gmail.com">@gmail.com</option>
							<option value="@daum.com">@daum.com</option>
						</select>
					</c:if>
					<br style="line-height: 300%;"/>
					<span id="error" style="color: red; font-size: 12pt; font-weight: bold;">공란입니다</span><br/> 
					<button type="button" class="box" onclick="goCheck();" >확인</button>     
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${method =='POST'}">
		<c:if test="${isUse == true}">

			<div align="center">
			    <br style="line-height: 400%"/>
				[<span style="color: red; font-weight: bold;">${check}</span>] 사용가능합니다.
				<br/><br/><br/>
				<button type="button" class="box" onclick="setUse('${check}')">닫기</button>
			</div>
			</c:if>
		
		<c:if test="${isUse == false}">
			<div align="center">
			  [<span style="color: red; font-weight: bold;">${check}</span>] 는 이미 사용중입니다.
			  <br/><br/>
			  <form name="frmIdcheck">
				<table style="width: 95%; height: 100px;">
					<tr>
						<td style="text-align: center;">
				            ${title}를 입력하세요  <br style="line-height: 200%;"/>
				            <input type="hidden" name="title" value="${title}">							    					     
							<input type="text" name="check" id="check" size="20" maxlength="20" class="box" /><br style="line-height: 300%;"/>  
							<span id="error" style="color: red; font-size: 12pt; font-weight: bold;">공란입니다</span><br/> 
							<button type="button" class="box" onclick="goCheck();" >확인</button>     
						</td>
					</tr>
				</table>
			</form>
		</div>
	</c:if>			
</c:if>	
</body>
</html>