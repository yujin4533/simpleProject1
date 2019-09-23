package com.simple.project1.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.simple.project1.common.MyUtil;
import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.MemberVO;
import com.simple.project1.service.InterAdminService;
import com.simple.project1.service.InterHotelRoomService;

@Component
@Controller
public class HotelRoomController {
	
	@Autowired
	private InterHotelRoomService service;
	
	@RequestMapping(value = "/index.p1") //메인화면
	public ModelAndView index(HttpServletRequest request, ModelAndView mv) {
		List<HotelRoomVO> hotelListBest = service.getHotelListBest();
		List<HotelRoomVO> hotelListNew = service.getHotelListNew();
		mv.addObject("hotelListNew",hotelListNew);
		mv.addObject("hotelListBest",hotelListBest);
		mv.setViewName("product/index.tiles1");
		return mv;
	}
	
	@RequestMapping(value="/search.p1") //검색화면
	public ModelAndView roomSearch(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO hotelVO ) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser!=null)
			hotelVO.setMemberidx(loginuser.getMemberidx());
		
		hotelVO.setTotalCnt(service.getHotelCnt(hotelVO));
		hotelVO.setSizePerPage(15);
		List<HotelRoomVO> hotelList = service.getHotelPagingList(hotelVO);
		
		String pagebar = "<ul>";
		hotelVO.setBlockSize(5);
		hotelVO.setAddress("search");
		pagebar += MyUtil.searchPageBar(request, hotelVO);
		pagebar += "</ul>";
		
	    mv.addObject("pagebar",pagebar);  
		mv.addObject("hotelVO",hotelVO);
		session.setAttribute("hotelList", hotelList);
		session.setAttribute("searchURL", MyUtil.getCurrentURLQuery(request));
//		mv.addObject("hotelList",hotelList);
		mv.setViewName("product/search.tiles1");
		return mv;
	}
	
	@RequestMapping(value="/product.p1") // 상세화면
	public ModelAndView product(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, HotelRoomVO hotelVO ) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser!=null) {
			hotelVO.setMemberidx(loginuser.getMemberidx());
			service.setTrendView(hotelVO);
		}
		
		HotelRoomVO hotelOne = service.getHotelOne(hotelVO);
		List<HotelRoomVO> roomList = service.getRoomList(hotelVO);
		
		mv.addObject("hotelVO",hotelVO);
		mv.addObject("hotelOne",hotelOne);
		mv.addObject("roomList",roomList);
		mv.setViewName("product/product.tiles1");
		return mv;
	}
	
	
	
}
