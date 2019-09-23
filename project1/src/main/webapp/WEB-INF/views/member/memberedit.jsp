 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		var now = new Date(); 
		console.log(now.getFullYear());
				
		$(".error").hide();
		$("#error_passwd").hide();
		
		$(".form-control").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data == "") {
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true).addClass("bgcol"); 
					$(this).attr("disabled",false).removeClass("bgcol");
					$(this).focus();
				}
				else {
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false).removeClass("bgcol"); 
				}
			});
		}); // end of $(".form-control").each()-------
		// 선택자의 갯수만큼 반복처리를 해주는 것이다.

		$("#idcheck").click(function() {
			var url = "duplicateCheck.p1?title=memberId"; /* 4 앞에 슬래시 없으면 절대경로이다.*/
			window.open(url, "GET", 
					    "left=500px, top=100px, width=300px, height=230px");
		});// end of $("#idcheck").click()------------

		$("#nickname").bind("keyup", function(){
			alert("닉네임 중복확인 버튼을 클릭하여 닉네임 검사를 하세요!!");
			$(this).val("");
		}); // end of $("#nickname").bind()----------

		$("#nicknamecheck").click(function() {
			var url = "duplicateCheck.p1?title=nickname"; /* 4 앞에 슬래시 없으면 절대경로이다.*/
			window.open(url, "GET", 
					    "left=500px, top=100px, width=300px, height=230px");
			$("#EMAIL").focus();
		});// end of $("#nicknamecheck").click()------------
		
		$("#emailcheck").click(function() {
			var url = "duplicateCheck.p1?title=email"; /* 4 앞에 슬래시 없으면 절대경로이다.*/
			window.open(url, "GET", 
					    "left=500px, top=100px, width=300px, height=230px");
		});// end of $("#nicknamecheck").click()------------

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
				$("#memberPwdcheck").focus();
			} 
		}); // end of $("#memberPwd").blur()---------------
		
		$("#memberPwdcheck").blur(function(){
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
				$("#nickname").focus();
			}
			
		});// end of $("#memberPwdcheck").blur()--------------

		$("#hp2").blur(function(){
			var hp2 = $(this).val();
			var bool1 = false;
			var regExp_HP2a = /^[1-9][0-9][0-9]$/g;
			var bool1 = regExp_HP2a.test(hp2);
			
			var bool2 = false;
			var regExp_HP2b = /^[0-9][0-9][0-9][0-9]$/g;
			var bool2 = regExp_HP2b.test(hp2);
			
			if( !(bool1 || bool2) ) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
				$("#hp3").focus();
			}
			
		});// end of $("#hp2").blur()-------------
		
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			var regExp_HP3 = /^\d{4}$/g;
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
				$("#hp3").focus();
			}			
		});// end of $("#hp3").blur()-------------

	}); // end of $(document).ready()-------------------
	
	
	function goRegister(event) {
		var memberPwd = $("#memberPwd").val();
		var memberPwdcheck = $("#memberPwdcheck").val();
		
		if(memberPwd=="" || memberPwdcheck==""){
			alert("암호를 입력해주세요")
			return;
		}
		
		
		var frm = document.editFrm;
		frm.method = "POST";
		frm.action = "memberEidtEnd.p1";
		frm.submit();
	}// end of function goRegister(event)----------
	
</script>


<section class="site-hero inner-page overlay" style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row site-hero-inner justify-content-center align-items-center">
          <div class="col-md-10 text-center" data-aos="fade">
            <h1 class="heading mb-3">register</h1>
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
			<div class="col-md-5">
				<div class="row">
					<div class="col-md-10 ml-auto contact-info">
						<p class="loginborder">
							<span class="text-black">${sessionScope.loginuser.memberId}님 정보수정</span>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<form name="editFrm" class="bg-white p-md-5 p-4 mb-5 border" enctype="multipart/form-data" >
					<div class="row">
						<div class="col-md-6 form-group">
							<p style="text-align: center;"><img src="<%= ctxPath%>/resources/images/member/${sessionScope.loginuser.picture}" style="width: 200px; height: 250px;"></p>
							<label class="text-black font-weight-bold" for="attach" >사진변경</label><span class="star">*</span> 
							<input type="file" name="attach" id="attach" class="form-control " >
						</div>
						<div class="col-md-6 form-group">
							<div class="row">
								<div class="col-md-12 form-group">
									<label class="text-black font-weight-bold" for="memberName" required >성명</label><span class="star">*</span> 
									<input type="text" name="memberName" id="memberName" class="form-control " value="${sessionScope.loginuser.memberName}" required> 
									<span class="error">성명은 필수입력 사항입니다.</span>
								</div>
							</div>
							<label class="text-black font-weight-bold" for="nickname" required>닉네임</label><span class="star">*</span> 
							<input type="text" name="nickname" id="nickname" class="form-control " value="${sessionScope.loginuser.nickname}" readonly>
							<!-- 닉네임중복체크 -->
							<div class="col-md-12 form-group">
							<a class="styleFont" style="cursor: pointer;" id="nicknamecheck">닉네임중복체크</a>
							<span class="error">닉네임은 필수입력 사항입니다.</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="email" required>Email</label> <span class="star">*</span>
							<input type="email" name="email" id="email" class="form-control " value="${sessionScope.loginuser.email}" readonly>
							<!-- 이메일중복체크 -->
							<div class="col-md-12 form-group">
							<a class="styleFont" style="cursor: pointer;" id="emailcheck">이메일중복체크</a>
							<span class="error">이메일은 필수입력 사항입니다.</span>
						</div>
					</div>	
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" required>전화번호</label> <span class="star">*</span><br> 
							<select name="hp1" id="hp1" style="width: 90px; padding: 8px;">
								<option value="010" selected>010</option>
							</select>&nbsp;-&nbsp; 
							<input type="text" name="hp2" id="hp2" size="6" maxlength="4" style="width: 90px; padding: 8px;" value="${sessionScope.loginuser.memberTel.substring(3,7)}"/>&nbsp;-&nbsp; 
							<input type="text" name="hp3" id="hp3" size="6" maxlength="4" style="width: 90px; padding: 8px;" value="${sessionScope.loginuser.memberTel.substring(7)}"/>&nbsp;&nbsp; 
							<span  class="error error_hp">휴대폰 형식이 아닙니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberPwd" required>암호</label><span class="star">*</span> 
							<input type="password" name="memberPwd" id="memberPwd" class="form-control " required> 
							<span id="error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberPwdcheck"required>암호확인</label><span class="star">*</span> 
							<input type="password" name="memberPwdcheck" id="memberPwdcheck" class="form-control " required> 
							<span class="error">암호가 일치하지 않습니다.</span>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12 form-group taC">
							<input type="button" id="btnRegister" value="submit" class="btn btn-primary text-white py-3 px-5 font-weight-bold" onClick="goRegister(event);">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>
