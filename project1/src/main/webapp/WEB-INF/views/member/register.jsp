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
		$("#memberName").focus();
		
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

		$("#memberId").bind("keyup", function(){
			alert("아이디중복확인 버튼을 클릭하여 ID중복 검사를 하세요!!");
			$(this).val("");
		}); // end of $("#memberId").bind()----------
		
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

		$("#email").blur(function(){
			var email = $(this).val();
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled",false).removeClass("bgcol"); 
				$(this).focus();
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
				$("#hp2").focus();
			}
		});// end of $("#email").blur()--------------
		
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
	  if( !$("input:radio[name=gender]").is(":checked")) {
		  alert("성별을 선택하셔야 합니다.");
		  return;
	  } 
   	  var frm = document.registerFrm;
   	  frm.method = "POST";
   	  frm.action = "memberInsert.p1";
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
							<span class="text-black">회원가입</span>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<form name="registerFrm" class="bg-white p-md-5 p-4 mb-5 border">
					<div class="row">
						<div class="col-md-12 form-group">
							<div class="row">
								<div class="col-md-12 form-group">
									<label class="text-black font-weight-bold" for="memberName" required>성명</label><span class="star">*</span> 
									<input type="text" name="memberName" id="memberName" class="form-control " required> 
									<span class="error">성명은 필수입력 사항입니다.</span>
								</div>
							</div>
							<label class="text-black font-weight-bold" for="memberId" required>회원아이디</label><span class="star">*</span> 
							<input type="text" readonly name="memberId" id="memberId" class="form-control" required>
							<!-- 아이디중복체크 -->
							<div class="col-md-12 form-group">
								<a class="styleFont" style="cursor: pointer;" id="idcheck">아이디중복체크</a>
								<span class="error">아이디는 필수입력 사항입니다.</span> 
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberPwd" required>암호</label><span class="star">*</span> 
							<input type="password" name="memberPwd" id="memberPwd" class="form-control "> 
							<span id="error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberPwdcheck"required>암호확인</label><span class="star">*</span> 
							<input type="password" name="memberPwdcheck" id="memberPwdcheck" class="form-control "> 
							<span class="error">암호가 일치하지 않습니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="nickname" required>닉네임</label><span class="star">*</span> 
							<input type="text" readonly name="nickname" id="nickname" class="form-control ">
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
							<input type="email" readonly name="email" id="email" class="form-control ">
							<!-- 이메일중복체크 -->
							<div class="col-md-12 form-group">
							<a class="styleFont" style="cursor: pointer;" id="emailcheck">이메일중복체크</a>
							<span class="error">이메일은 필수입력 사항입니다.</span>
						</div>
					</div>	
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="GENDER" required>성별</label><span class="star">*</span>
							<input type="radio" id="male" name="gender" value="1" />
							<label for="male" style="margin-left: 2%;">남자</label> 
							<input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" />
							<label for="female" style="margin-left: 2%;">여자</label> 
							<span  class="error">성별을 입력하세요</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" required>전화번호</label><span class="star">*</span> 
							<select name="hp1" id="hp1" style="width: 90px; padding: 8px;">
								<option value="010" selected>010</option>
							</select>&nbsp;-&nbsp; 
							<input type="text" name="hp2" id="hp2" size="6" maxlength="4" style="width: 90px; padding: 8px;"/>&nbsp;-&nbsp; 
							<input type="text" name="hp3" id="hp3" size="6" maxlength="4" style="width: 90px; padding: 8px;"/>&nbsp;&nbsp; 
							<span  class="error error_hp">휴대폰 형식이 아닙니다.</span>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="email" required>생년월일</label><span class="star">*</span>
							<input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 90px; padding: 8px;" required /> 
							<select id="birthmm" name="birthmm" style="width: 90px; padding: 8px;">
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
							<select id="birthdd" name="birthdd" style="width: 90px; padding: 8px;">
								<option value="01">01</option>
								<option value="02">02</option>
								<option value="03">03</option>
								<option value="04">04</option>
								<option value="05">05</option>
								<option value="06">06</option>
								<option value="07">07</option>
								<option value="08">08</option>
								<option value="09">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
							</select>
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
