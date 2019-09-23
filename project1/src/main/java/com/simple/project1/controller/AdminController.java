package com.simple.project1.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.simple.project1.common.FileManager;
import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.service.InterAdminService;

@Component
@Controller
public class AdminController {
	
	@Autowired
	private InterAdminService service;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "/hotelReg.p1") // 호텔등록
	public ModelAndView hotelReg(ModelAndView mv) {
		
		mv.setViewName("admin/hotelReg.tiles1");
		return mv;
	}
	
	@RequestMapping(value = "/hotelRegEnd.p1", method={RequestMethod.POST}) //호텔등록End
	public ModelAndView hotelRegEnd(HotelRoomVO hotelroomvo, MultipartHttpServletRequest mrequest,ModelAndView mv) {
		
		MultipartFile attach = hotelroomvo.getAttach();
		
		if(!attach.isEmpty()) { // 이미지 있을 경우
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resource" + File.separator + "images" + File.separator + "hotel";
			
			try {
			
				byte[] bytes = attach.getBytes();
				String hotelImg = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				hotelroomvo.setHotelImg(hotelImg);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		String msg = ">>실패했습니다<<";
		String loc = "javascript:history.back()";
		if(service.hotelAdd(hotelroomvo)==1) { // insert 성공시
			msg = ">>숙소를 등록했습니다<<";
			loc = mrequest.getContextPath() + "/roomReg.p1";
		} 
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}

	@RequestMapping(value = "/roomReg.p1") // 호텔등록
	public ModelAndView roomReg(ModelAndView mv) {
		
		mv.setViewName("admin/roomReg.tiles1");
		return mv;
	}
	
	@RequestMapping(value = "/roomRegEnd.p1", method={RequestMethod.POST}) //객실등록End
	public ModelAndView roomRegEnd(HotelRoomVO hotelroomvo, MultipartHttpServletRequest mrequest,ModelAndView mv) {
		
		MultipartFile attach = hotelroomvo.getAttach();
		
		if(!attach.isEmpty()) { // 이미지 있을 경우
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resource" + File.separator + "images" + File.separator + "room";
			
			try {

				byte[] bytes = attach.getBytes();
				String roomImg = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				hotelroomvo.setRoomImg(roomImg);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		String[] roomOptionArr = mrequest.getParameterValues("roomOption");
		String roomOption = "";
		for(int i=0; i<roomOptionArr.length; i++) {
			String comma = (i < roomOptionArr.length-1)?",":"";
			roomOption += roomOptionArr[i]+comma;
		}
		
		hotelroomvo.setRoomOption(roomOption);
		hotelroomvo.setRoomType(mrequest.getParameter("bedCnt")+mrequest.getParameter("peopleCnt"));

		String msg = ">>실패했습니다<<";
		String loc = "javascript:history.back()";
		if(service.roomAdd(hotelroomvo)==1) { // insert 성공시
			msg = ">>객실을 등록했습니다<<";
			loc = mrequest.getContextPath() + "/index.p1";
		} 
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("msg");
		return mv;
	}
	
	@RequestMapping(value = "/productStatus.p1") // 숙소 리스트
	public ModelAndView productStatus(ModelAndView mv, HotelRoomVO hotelroomvo) {
		hotelroomvo.setTotalCnt(service.getAdminHotelCnt());
		hotelroomvo.setSizePerPage(15);
		List<HotelRoomVO> hotelList = service.getAdminHotelList(hotelroomvo);
		mv.addObject("hotelList",hotelList);
		mv.setViewName("admin/productStatus.tiles1");
		return mv;
	}
	
	@RequestMapping(value = "/productStatusDetail.p1") // 숙소 상태변경페이지
	public ModelAndView productStatusDetail(HttpServletRequest request, ModelAndView mv) {
		String hotelidx = request.getParameter("hotelidx");
		
		HotelRoomVO hotelDetail = service.getAdminHotelDetail(hotelidx);
		List<HotelRoomVO> roomList = service.getAdminRoomList(hotelidx);

		mv.addObject("hotelDetail",hotelDetail);
		mv.addObject("roomList",roomList);
		mv.setViewName("admin/productStatusDetail.tiles1");
		return mv;
	}

	@RequestMapping(value = "/productChange.p1", method={RequestMethod.POST}) // 호텔 또는 객실 변경
	public ModelAndView productChange(HotelRoomVO hotelroomvo, HttpServletRequest request,ModelAndView mv) {
		String msg = ">>실패했습니다<<";
		int n = 0;
		
		if(hotelroomvo.getHotelName()!="") 
			n = service.setProductStatus(hotelroomvo);
		else {
			if(hotelroomvo.getRoomidx()==0) 
				n = service.setHotelStatus(hotelroomvo);
			else 
				n = service.setRoomStatus(hotelroomvo); 
		}
		
		if(n>0)
			msg = ">>변경되었습니다<<";
		
		mv.addObject("msg",msg);
		mv.addObject("loc","javascript:history.back()");
		mv.setViewName("msg");
		return mv;
	}
	
//	@Scheduled(cron="*/30 * * * * *")
	@Scheduled(cron="0 * 20 * * *")
	public void taskSchedulerCheckIn() {
		Logger checkIn= LoggerFactory.getLogger("checkInLogger");
		try {
			checkIn.debug("CHECKIN - START ");
			int n = service.setCheckIn();
			if(n>=0)
				checkIn.debug("CHECKIN  "+n+" Succ");
			else
				checkIn.debug("CHECKIN - Fail");
		} catch (Exception ex) {
		    ex.printStackTrace();
		    checkIn.debug("CHECKIN - Fail");
		}		
		checkIn.debug("CHECKIN - END ");		
	}

//	@Scheduled(cron="*/35 * * * * *")
	@Scheduled(cron="0 * 14 * * *")
	public void taskSchedulerCheckOut() {
		Logger checkOut= LoggerFactory.getLogger("checkOutLogger");
		try {
			checkOut.debug("CHECKOUT - START ");
			int n = service.setCheckOut();
			if(n>=0)
				checkOut.debug("CHECKOUT "+n+" Succ");
			else
				checkOut.debug("CHECKOUT - Fail");
		} catch (Exception ex) {
			ex.printStackTrace();
			checkOut.debug("CHECKOUT - Fail");
		}		
		checkOut.debug("CHECKOUT - END ");		
	}
	
	@RequestMapping(value = "/adminReserveList.p1") // 숙소 상태변경페이지
	public ModelAndView adminReserveList(HttpServletRequest request, ModelAndView mv,HotelRoomVO hotelroomvo) {
		hotelroomvo.setTotalCnt(service.getAdminReserveCnt());
		hotelroomvo.setSizePerPage(15);
		List<HotelRoomVO> resreveList = service.getAdminReserveList(hotelroomvo);
		mv.addObject("resreveList",resreveList);
		mv.setViewName("admin/adminReserveList.tiles1");
		return mv;
	}
	
	@RequestMapping(value = "/productChart.p1") // 숙소통계 페이지
	public ModelAndView productChart(ModelAndView mv) {
		
		mv.setViewName("admin/productChart.tiles1");
		return mv;
	}

	
}
