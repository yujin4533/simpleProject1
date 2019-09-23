<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
@media ( min-width : 769px) and ( max-width : 991px) {
	.custom-border {
		/* border: solid 1px red; */
		
	}
	.custom-loginFrm {
		margin: 40px 0 0 0;
	}
	.custom-input {
		padding: 0 0 30px 0;
	}
	.custom-login-submit {
		padding: 45px 0 0 20px;
	}
}

@media ( min-width : 992px) {
	.custom-border {
		/* border: solid 1px red; */
		
	}
	.custom-loginFrm {
		margin: 40px 0 0 0;
	}
	.custom-input {
		padding: 0 0 30px 0;
	}
	.custom-login-submit {
		padding: 45px 0 0 20px;
	}
}
</style>

<script type="text/javascript">
 
     $(document).ready(function(){
    	 
    	 $("#btnLOGIN").click(function() {
    		 func_Login();
    	 }); // end of $("#btnLOGIN").click();-----------------------
    	 
    	 $("#memberPwd").keydown(function(event){
  			
  			if(event.keyCode == 13) { // 엔터를 했을 경우
  				func_Login();
  			}
    	 }); // end of $("#memberPwd").keydown();-----------------------	
    	 
    }); // end of $(document).ready()---------------------------	 

    
    function func_Login() {
    		 
		 var memberId = $("#memberId").val(); 
		 var memberPwd = $("#memberPwd").val(); 
		
		 if(memberId.trim()=="") {
		 	 alert("아이디를 입력하세요!!");
			 $("#memberId").val(""); 
			 $("#memberId").focus();
			 return;
					
			 }
		 
		
		 if(memberPwd.trim()=="") {
			 alert("비밀번호를 입력하세요!!");
			 $("#memberPwd").val(""); 
			 $("#memberPwd").focus();
			 return;
		 }

		 var frm = document.loginFrm;
		 
		 frm.action = "<%=ctxPath%>/login.p1";
		 frm.method = "POST";
		 frm.submit();
		 
    } // end of function func_Login(event)-----------------------------
    function func_register() { 
    	
    }
</script>

<section class="site-hero inner-page overlay" style="background-image: url(<%=ctxPath%>/resources/images/hero_4.jpg)" data-stellar-background-ratio="0.5">
	<div class="container">
		<div class="row site-hero-inner justify-content-center align-items-center">
			<div class="col-md-10 text-center" data-aos="fade">
				<h1 class="heading mb-3">로그인</h1>
			</div>
		</div>
	</div>

	<a class="mouse smoothscroll" href="#next">
		<div class="mouse-icon">
			<span class="mouse-wheel"></span>
		</div>
	</a>
</section>


<section class="section contact-section" id="next">
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<div class="row">
					<div class="col-md-10 ml-auto contact-info">
						<p class="loginborder">
							<span class="text-black">로그인</span>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<form name="loginFrm" method="post"	class="bg-white p-md-5 p-4 mb-5 border">

					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberId">아이디</label>
							<input type="text" id="memberId" name="memberId" class="form-control ">
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 form-group">
							<label class="text-black font-weight-bold" for="memberPwd">비밀번호</label>
							<input type="password" id="memberPwd" name="memberPwd" class="form-control ">
						</div>
					</div>

					<div class="row">
						<div class="col-md-12 form-group taC">
							<input type="button" value="로그인" onclick="func_Login();" class="btn btn-primary text-white py-3 mx-2 font-weight-bold">
							<input type="button" value="회원가입" onclick="location.href='/project1/register.p1'" class="btn btn-primary text-white py-3 mx-2 font-weight-bold">
						</div>
						<div class="col-md-12 form-group taC styleAfter">
							<a style="cursor: pointer;" data-toggle="modal" data-target="#memberIdfind" data-dismiss="modal" data-backdrop="static">아이디찾기</a> 
							<a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
						</div>
					</div>
				</form>
			</div>
			
			<%-- ****** 아이디 찾기 Modal ****** --%>
			<div class="modal fade" id="memberIdfind" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">아이디 찾기</h4>
							<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body" style="width: 100%;">
							<div id="idFind">
								<iframe style="border: none; width: 100%; height: 250px;" src="/project1/modalIdFind.p1" scrolling="no"></iframe>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" onClick="history.go(0)" class="btn btn-default myclose" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			
			<%-- ****** 비밀번호 찾기 Modal ****** --%>
			<div class="modal fade" id="passwdFind" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">비밀번호 찾기</h4>
							<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div id="pwFind">
								<iframe style="border: none; width: 100%; height: 350px;" src="/project1/modalPwdFind.p1" scrolling="no"></iframe>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" onClick="history.go(0)" class="btn btn-default myclose" data-dismiss="modal">Close</button>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>
</section>