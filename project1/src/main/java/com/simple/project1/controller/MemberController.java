package com.simple.project1.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.simple.project1.common.FileManager;
import com.simple.project1.common.GoogleMail;
import com.simple.project1.common.MyUtil;
import com.simple.project1.common.SHA256;
import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.MemberVO;
import com.simple.project1.model.ReviewVO;
import com.simple.project1.service.InterMemberService;

@Component
@Controller
public class MemberController {

	@Autowired
	private InterMemberService service;

	@Autowired
	private FileManager fileManager;
	
	// 회원가입화면
	@RequestMapping(value = "/register.p1") 
	public ModelAndView register(HttpServletRequest request, ModelAndView mv) {
		
		mv.setViewName("member/register.tiles1");
		return mv;
	}
	
	// 아이디,닉네임,이메일 중복확인
	@RequestMapping(value = "/duplicateCheck.p1") 
	public ModelAndView duplicateCheck(HttpServletRequest request, ModelAndView mv) {
		String method = request.getMethod();
		String title = request.getParameter("title");
		String check = request.getParameter("check");
		
		if("email".equalsIgnoreCase(title))
			check += request.getParameter("email");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("title", title);
		map.put("check", check);
		
		if ("post".equalsIgnoreCase(method)) {
			if (check != null) {
				boolean isUse = service.isUse(map);// 트루가 나오면 받아서 사용가능.
				mv.addObject("isUse", isUse);
			}
		}
		
		mv.addObject("method",method);
		mv.addObject("check",check);
		mv.addObject("title",title);
		mv.setViewName("member/duplicateCheck");
		return mv;
	}
	
	// 회원가입
	@RequestMapping(value = "/memberInsert.p1") 
	public ModelAndView memberInsert_post(HttpServletRequest request, HttpServletResponse response, MemberVO membervo,ModelAndView mv) {
		
		String memberPwd = SHA256.encrypt(request.getParameter("memberPwd"));
		String tel = request.getParameter("hp1")+request.getParameter("hp2")+request.getParameter("hp3");
		String birthDay = request.getParameter("birthyyyy").substring(0,2)+request.getParameter("birthmm")+request.getParameter("birthdd");
		
		membervo.setMemberPwd(memberPwd);
		membervo.setMemberTel(tel);
		membervo.setBirthDay(birthDay);
		
		String msg = ">>실패했습니다<<";
		String loc = "javascript:history.back()";
		if(service.memberAdd(membervo)==1) { // insert 성공시
			msg = ">>가입되었습니다<<";
			loc = request.getContextPath() + "/index.p1";
		} 
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}

	// 로그인
	@RequestMapping(value = "/login.p1") 
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, MemberVO membervo) {
		String mehtod = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String loc = "javascript:history.back()";
		String msg = "아이디 또는 비밀번호가 틀립니다";
		
		if("get".equalsIgnoreCase(mehtod) && null==loginuser) {
			mv.setViewName("member/login.tiles1");
		} else if("get".equalsIgnoreCase(mehtod) && null!=loginuser) {
			msg = ">>이미 로그인 되어있습니다<<";
			mv.setViewName("msg");
		} else {
			membervo.setMemberPwd(SHA256.encrypt(membervo.getMemberPwd()));
			loginuser = service.getLogin(membervo);
			
			if(null!=loginuser) {
				if(session.getAttribute("backUrl")!=null)
					loc = (String) session.getAttribute("backUrl");
				else
					loc = request.getContextPath() + "/index.p1";
				session.setAttribute("loginuser", loginuser);
				msg = ">>로그인 되었습니다<<";
			}
			mv.setViewName("msg");
		}
		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		return mv;
	}

	// 로그아웃
	@RequestMapping(value = "/logout.p1") 
	public ModelAndView logout(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginuser");
		mv.addObject("msg",">>로그아웃 되었습니다<<");
		mv.addObject("loc",request.getContextPath() + "/index.p1");
		mv.setViewName("msg");
		return mv;
	}
	
	// 멤버페이지
	@RequestMapping(value = "/memberpage.p1") 
	public ModelAndView Login_memberpage(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		mv.setViewName("member/memberpage.tiles1");
		return mv;
	}
	
	// 정보수정페이지
	@RequestMapping(value = "/memberedit.p1") 
	public ModelAndView Login_chagepic0(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		mv.setViewName("member/memberedit.tiles1");
		return mv;
	}

	// 정보수정
	@RequestMapping(value = "/memberEidtEnd.p1") 
	public ModelAndView Login_memberEidtEnd_post(HttpServletRequest request, HttpServletResponse response,MultipartHttpServletRequest mrequest, ModelAndView mv, MemberVO membervo) {
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String memberId = loginuser.getMemberId();
		String memberPwd = SHA256.encrypt(mrequest.getParameter("memberPwd"));
		String tel = mrequest.getParameter("hp1")+mrequest.getParameter("hp2")+mrequest.getParameter("hp3");

		membervo.setMemberId(memberId);
		membervo.setMemberPwd(memberPwd);
		membervo.setMemberTel(tel);
		
		String msg = ">>변경에 실패했습니다<<";

		MultipartFile attach = membervo.getAttach();
		
		if(!attach.isEmpty()) { // 이미지 있을 경우
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resource" + File.separator + "images" + File.separator + "member";
			
			try {
			
				byte[] bytes = attach.getBytes();
				String picture = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				membervo.setPicture(picture);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
			
		
		if(service.memberEdit(membervo)==1) {
			loginuser = service.getLogin(membervo);
			session.setAttribute("loginuser", loginuser);
			
			msg = ">>변경되었습니다<<";
		}
		
		mv.addObject("loc",mrequest.getContextPath() + "/memberpage.p1");
		mv.addObject("msg",msg);
		mv.setViewName("msg");
		return mv;
	}
	
	// 회원탈퇴
	@RequestMapping(value = "/memberout.p1") 
	public ModelAndView Login_memberout_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		String method = request.getMethod();
		String msg = ">>탈퇴에 실패했습니다<<";
		String loc = request.getContextPath() + "/memberpage.p1";
		
		
		if("get".equalsIgnoreCase(method))
			mv.setViewName("member/memberout.tiles1");
		else {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			int memberidx = loginuser.getMemberidx();
			String memberPwd = loginuser.getMemberPwd();
			String ckPwd = SHA256.encrypt(request.getParameter("memberPwd"));

			if(memberPwd.equals(ckPwd)) {
				
				if(service.memberOut(memberidx)==1) {
					session.removeAttribute("loginuser");
					loc = request.getContextPath() + "/index.p1";
					msg = ">>탈퇴되었습니다<<";
				}
				
			} else {
				msg = ">>암호가 틀립니다<<";
			}
			
			mv.addObject("msg",msg);
			mv.addObject("loc",loc);
			mv.setViewName("msg");
		}
		
		return mv;
	}	
	
	// 예약정보확인 페이지
	@RequestMapping(value = "/reserve.p1") 
	public ModelAndView Login_reserve_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO reserveVO) {
		
		HotelRoomVO hotelroomVO = service.getReserveInfo(reserveVO);
		
		try { 
			int day = 0;

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        Date out = format.parse(reserveVO.getCheckout_date());
	        Date in = format.parse(reserveVO.getCheckin_date());
	        
	        long calDate = out.getTime() - in.getTime(); 
	        day = (int) (calDate / ( 24*60*60*1000)); 
	        
	        Calendar cal = Calendar.getInstance() ;
	        int dayNum = 0;
	        
	        int week = 0;
	        int weekend = 0;
	        for(int i=0;i<day;i++) {
	        	cal.setTime(in);     
		        dayNum = cal.get(Calendar.DAY_OF_WEEK);
		        if(dayNum<6)
		        	week++;
		        else
		        	weekend++;

		        in = new Date(in.getTime() + (1000*60*60*24*+1));
	        }
	        
	        hotelroomVO.setAdult(week); // 주중숙박일
	        hotelroomVO.setChildren(weekend); // 주말숙박일
	        hotelroomVO.setCheckin_date(reserveVO.getCheckin_date());
	        hotelroomVO.setCheckout_date(reserveVO.getCheckout_date());
        }
        catch(Exception e) {
	            e.printStackTrace();
        }
		
		mv.addObject("hotelroomVO",hotelroomVO);
		mv.setViewName("member/reserve.tiles1");
		return mv;
	}
	
	// 결제페이지
	@RequestMapping(value = "/paymentGateway.p1")
	public ModelAndView Login_paymentGateway_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO reserveVO) {
		mv.addObject("reserveVO",reserveVO);
		mv.setViewName("member/paymentGateway.tiles1");
		return mv;
	}
	
	// 예약목록
	@RequestMapping(value = "/reservelist.p1")
	public ModelAndView Login_reservelist(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO hotelroomVO) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		hotelroomVO.setMemberidx(loginuser.getMemberidx());
		hotelroomVO.setTotalCnt(service.getReserveCnt(loginuser.getMemberidx()));
		hotelroomVO.setSizePerPage(3);
		
		List<HotelRoomVO> reserveVO = service.getReserveList(hotelroomVO);
		
		String pagebar = "<ul>";
		hotelroomVO.setBlockSize(5);
		hotelroomVO.setAddress("reservelist");
		pagebar += MyUtil.searchPageBar(request, hotelroomVO);
		pagebar += "</ul>";
		
	    mv.addObject("pagebar",pagebar);  
		mv.addObject("reserveVO",reserveVO);
		mv.setViewName("member/reservelist.tiles1");
		return mv;
	}
	
	// 예약취소
	@RequestMapping(value = "/reserveCancel.p1")
	public ModelAndView Login_reserveCancel_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO reserveVO) {
		mv.addObject("reserveVO",reserveVO);
		mv.setViewName("member/reserveCancel.tiles1");
		return mv;
	}
	
	// 예약취소
	@RequestMapping(value = "/reserveCancelEnd.p1")
	public ModelAndView Login_reserveCancelEnd_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		String msg = ">>예약취소가 실패했습니다<<";
		String loc = "/project1/reservelist.p1";
		
		String reserveidx = request.getParameter("roomidx");
		
		if(service.setUpdateReserveCancel(reserveidx)==1)
			msg = ">>예약이 취소되었습니다<<";

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}
	
	// 예약리뷰작성
	@RequestMapping(value = "/reserveReview.p1")
	public ModelAndView Login_reserveReview_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO reserveVO) {
		mv.addObject("reserveVO",reserveVO);
		mv.setViewName("member/reserveReview.tiles1");
		return mv;
	}
	
	// 예약리뷰작성
	@RequestMapping(value = "/reserveReviewEnd.p1")
	public ModelAndView Login_reserveReviewEnd_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,MultipartHttpServletRequest mrequest, ReviewVO reviewVO) {

		String msg = ">>리뷰 작성에 실패했습니다<<";
		String loc = "/project1/memberpage.p1";
		
		reviewVO.setContent(MyUtil.replaceParameter(reviewVO.getContent()).replaceAll("\r\n", "<br/>"));
		reviewVO.setTitle(MyUtil.replaceParameter(reviewVO.getTitle()).replaceAll("\r\n", "<br/>"));
		
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		if(!attachList.isEmpty()) { 
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resource" + File.separator + "images" + File.separator + "review";
			
			byte[] bytes = null;
			String newFileName= "";
			String newFileNameList= "";
			
			try {
				for(int i=0;i<attachList.size();i++){
					bytes = attachList.get(i).getBytes();
					newFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
					newFileNameList += newFileName+",";
				}
				
				List<String> list = Arrays.asList(newFileNameList.split(","));
				reviewVO.setImgList(list);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		if(service.setInsertReview(reviewVO)==1) 
			msg=">>리뷰가 작성되었습니다<<";
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}
	
	// 예약포인트적립
	@RequestMapping(value = "/reservePoint.p1")
	public ModelAndView Login_reservePoint_post(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO reserveVO) {
		String msg = ">>포인트 적립에 실패했습니다<<";
		String loc = "/project1/reservelist.p1";
		
		reserveVO.setWeekendPrice(reserveVO.getWeekPrice()/110*3);
		
		if(service.setUpdatePoint(reserveVO)==1)
			msg = ">>포인트가 적립되었습니다<<";

		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}
	
	// 모달 - id찾기
	@RequestMapping(value = "/modalIdFind.p1") 
	public ModelAndView modalIdFind(HttpServletRequest request, ModelAndView mv, MemberVO membervo) {
		String method = request.getMethod().toUpperCase();
		
		if(method.equals("POST")) {
			String memberId = service.getFindMemberId(membervo);
			mv.addObject("memberId",memberId);
		}

		mv.addObject("method",method);
		mv.setViewName("member/modalIdFind");
		return mv;
	}
	
	// 모달 - pwd찾기
	@RequestMapping(value = "/modalPwdFind.p1") 
	public ModelAndView modalPwdFind(HttpServletRequest request, ModelAndView mv, MemberVO membervo) {
		String method = request.getMethod().toUpperCase();
		
		if(method.equals("POST")) {
			int n = 0;
			
			String memberId = service.getFindMemberId(membervo);
			if(memberId!=null && memberId.equalsIgnoreCase(membervo.getMemberId())){
				n = 1;

				GoogleMail mail = new GoogleMail();
				Random rnd = new Random();
				String certificationCode = "";

				char randchar = ' ';
				for (int i = 0; i < 5; i++) {
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certificationCode += randchar;
				}

				int randnum = 0;
				for (int i = 0; i < 7; i++) {
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certificationCode += randnum;
				}

				try {
					mail.sendmail(membervo.getEmail(), certificationCode);
					mv.addObject("certificationCode", certificationCode); 
				} catch (Exception e) {
					e.printStackTrace();
					n = -1;
				}
			} 
			mv.addObject("n", n);
			mv.addObject("memberId", membervo.getMemberId());
			mv.addObject("email", membervo.getEmail());
		}
		
		mv.addObject("method",method);
		mv.setViewName("member/modalPwdFind");
		return mv;
	}
	
	// 비밀번호 찾는 사이트
	@RequestMapping(value = "/modalChangePwd.p1") 
	public ModelAndView modalChangePwd(HttpServletRequest request, ModelAndView mv, MemberVO membervo) {
		String memberPwd = membervo.getMemberPwd();
		if(memberPwd!=null && memberPwd!="") {
			
			membervo.setMemberPwd(SHA256.encrypt(membervo.getMemberPwd()));
			String msg = ">>비밀번호 변경에 실패했습니다<<";
			
			if(service.setMemberPwd(membervo)==1) 
				msg = ">>변경 되었습니다<<";
			
			mv.addObject("msg",msg);
		}
		
		mv.addObject("memberId",membervo.getMemberId());
		mv.setViewName("member/modalChangePwd");
		return mv;
	}
	
	// 찜
	@RequestMapping(value="/addHeart.p1")
	public ModelAndView Login2_addHeart(HttpServletRequest request,HttpServletResponse response,ModelAndView mv) {
		String hotelidx = request.getParameter("hotelidx");
		HttpSession session = request.getSession();
		int memberidx = ((MemberVO)session.getAttribute("loginuser")).getMemberidx();
		
		HashMap<String, String> paramap = new HashMap<String,String>();
		paramap.put("hotelidx",hotelidx);
		paramap.put("memberidx",String.valueOf(memberidx));
		
		String msg = service.getHeart(paramap);
		String loc = "javascript:history.back()";

		String searchURL = (String) session.getAttribute("searchURL");
		if(searchURL!=null && searchURL!="")
			loc = searchURL;
		
		if("product".equalsIgnoreCase(request.getParameter("where")))
			loc = "product.p1?hotelidx="+hotelidx;

		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		mv.setViewName("msg");
		return mv;
	}

	// 찜목록
	@RequestMapping(value = "/heartlist.p1")
	public ModelAndView Login_heartlist(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO hotelroomVO) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		hotelroomVO.setMemberidx(loginuser.getMemberidx());
		hotelroomVO.setTotalCnt(service.getHeartCnt(loginuser.getMemberidx()));
		hotelroomVO.setSizePerPage(4);
		
		List<HotelRoomVO> hotelList = service.getHeartList(hotelroomVO);
		
		String pagebar = "<ul>";
		hotelroomVO.setBlockSize(5);
		hotelroomVO.setAddress("heartlist");
		pagebar += MyUtil.searchPageBar(request, hotelroomVO);
		pagebar += "</ul>";
		
		session.setAttribute("hotelList", hotelList);
		session.setAttribute("searchURL", MyUtil.getCurrentURLQuery(request));
		mv.addObject("pagebar",pagebar);  
		mv.setViewName("member/heartlist.tiles1");
		return mv;
	}
}
