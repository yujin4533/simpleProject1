package com.simple.project1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.simple.project1.common.GoogleMail;
import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.MemberVO;
import com.simple.project1.model.ReviewVO;
import com.simple.project1.service.InterAdminService;
import com.simple.project1.service.InterAjaxService;

@Component
@Controller
public class AjaxController {
	
	@Autowired
	private InterAjaxService service;
	
	@RequestMapping(value="/ajaxWordSearch.p1", produces="text/plain;charset=UTF-8" )
	@ResponseBody
	public String ajaxWordSearch(HttpServletRequest request) {
		String searchWord = request.getParameter("searchWord");
		List<String> wordNameList = null;
		
		if(searchWord!="") {
			wordNameList = service.getHotelName(searchWord);
		}
		JSONArray jsonArr = new JSONArray();

		if(wordNameList != null) {
			for(String hotelName : wordNameList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelName", hotelName);
				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/ajaxHotelidx.p1", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxHotelidx(HttpServletRequest request) {
		String clickWord = request.getParameter("searchWord");
		String hotelidx = null;
		
		if(clickWord!="" && clickWord!=null) {
			hotelidx = service.getHotelidx(clickWord);
		}

		JSONArray jsonArr = new JSONArray();

		if(hotelidx != null) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelidx", hotelidx);
				
				jsonArr.put(jsonObj);
		}

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/ajaxSearchMap.p1", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxSearchMap(HttpServletRequest request) {
		
		JSONArray jsonArr = new JSONArray();
		
		HttpSession session = request.getSession();
		List<HotelRoomVO> hotelList = (List<HotelRoomVO>) session.getAttribute("hotelList");
		session.removeAttribute("hotelList");
		
		if(hotelList!=null) {
			for(HotelRoomVO list : hotelList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelidx", list.getHotelidx());
				jsonObj.put("address", list.getAddress());
				jsonObj.put("hotelName", list.getHotelName());
				jsonObj.put("hotelImg", list.getHotelImg());
				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/ajaxSearchOption.p1", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxSearchOption(HttpServletRequest request) {
		
		JSONArray jsonArr = new JSONArray();
		
		HotelRoomVO rangePrice = service.getRangePrice();
		List<HotelRoomVO> hotelOptionList = service.getHotelOptionList();
		List<HotelRoomVO> roomOptionList = service.getRoomOptionList();
		List<HotelRoomVO> categoryCodeList = service.getCategoryCodeList();
		
		if(rangePrice!=null) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("minPrice", rangePrice.getMinPrice());
			jsonObj.put("maxPrice", rangePrice.getMaxPrice());
			jsonArr.put(jsonObj);
		}
		
		if(categoryCodeList!=null) {
			for(HotelRoomVO hrvo : categoryCodeList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("categoryCode", hrvo.getCategoryCode());
				jsonObj.put("categoryName", hrvo.getCategoryName());
				jsonArr.put(jsonObj);
			}
		}
		
		if(roomOptionList!=null) {
			for(HotelRoomVO hrvo : roomOptionList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("roomOption", hrvo.getRoomOption());
				jsonArr.put(jsonObj);
			}
		}
		
		if(hotelOptionList!=null) {
			for(HotelRoomVO hrvo : hotelOptionList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelOption", hrvo.getHotelOption());
				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/ajaxSearchWord.p1", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxSearchWord(HttpServletRequest request) {
		String searchWord = request.getParameter("searchWord");

		List<String> wordNameList = null;
		List<String> wordAddrList = null;
		
		if(searchWord!="") {
			wordNameList = service.wordNameSearchView(searchWord);
			wordAddrList = service.wordAddrSearchView(searchWord);
		}
		
		JSONArray jsonArr = new JSONArray();

		if(wordNameList != null) {
			for(String name : wordNameList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelName", name);
				jsonArr.put(jsonObj);
			}
		}

		if(wordAddrList != null) {
			for(String addr : wordAddrList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("address", addr);
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	@RequestMapping(value = "/ajaxReserveCk.p1", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ajaxReserveCk(HttpServletRequest request, HotelRoomVO reserveVO) {
		
		int n= service.getReserveCK(reserveVO);
		
		JSONObject jsonObj = new JSONObject();
		String msg = "예약가능한 방이 없습니다. 다른 날짜를 선택해 주세요!!\n숙박 상세페이지로 넘어갑니다.";
		
		if(n==0) 
			msg = "OK";
		
		jsonObj.put("msg", msg);
		String result = jsonObj.toString();
		return result;
	}
	
	@RequestMapping(value="/ajaxInsertReserve.p1", produces="text/plain;charset=UTF-8" )
	@ResponseBody
	public String ajaxInsertReserve(HttpServletRequest request, HotelRoomVO reserveVO) {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		JSONObject jsonObj = new JSONObject();
		GoogleMail mail = new GoogleMail();
		
		if(service.setInsertReserve(reserveVO)==1)
			jsonObj.put("msg", "결제 되었습니다.");
		else
			jsonObj.put("msg", "결제는 되었으나, 예약이 안되었으니 관리자에게 문의하세요.");
		
		try {
			mail.sendmailReserve(loginuser,reserveVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return jsonObj.toString();
	}
	
	@RequestMapping(value="/ajaxReview.p1", produces="text/plain;charset=UTF-8" )
	@ResponseBody
	public String ajaxReview(HttpServletRequest request, HotelRoomVO reserveVO) {
		
		JSONArray jsonArr = new JSONArray();

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("hotelidx", request.getParameter("hotelidx"));
		
		int reviewCnt = service.getReviewCnt(map);
		double reviewAvg = service.getReviewAvg(map);

		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("reviewCnt", reviewCnt);
		jsonObj.put("reviewAvg", reviewAvg);
		jsonArr.put(jsonObj);
		
		if(reviewCnt>0) {
			map.put("sort", "star");
			List<ReviewVO> sreviewList = service.getReviewList(map);
			for(ReviewVO vo : sreviewList) {
				JSONObject jsonObj2 = new JSONObject();
				jsonObj2.put("snickName", vo.getNickName());
				jsonObj2.put("spicture", vo.getPicture());
				jsonObj2.put("stitle", vo.getTitle());
				jsonObj2.put("scontent", vo.getContent());
				jsonObj2.put("sstar", vo.getStar());
				jsonObj2.put("sreviewImg", vo.getReviewImg());
				jsonObj2.put("sreviewRegDate", vo.getreviewRegDate().substring(0,10));
				jsonArr.put(jsonObj2);
			}
			map.remove("sort");

			map.put("sort", "star desc");
			List<ReviewVO> SreviewList = service.getReviewList(map);
			for(ReviewVO vo : SreviewList) {
				JSONObject jsonObj2 = new JSONObject();
				jsonObj2.put("SnickName", vo.getNickName());
				jsonObj2.put("Spicture", vo.getPicture());
				jsonObj2.put("Stitle", vo.getTitle());
				jsonObj2.put("Scontent", vo.getContent());
				jsonObj2.put("Sstar", vo.getStar());
				jsonObj2.put("SreviewImg", vo.getReviewImg());
				jsonObj2.put("SreviewRegDate", vo.getreviewRegDate().substring(0,10));
				jsonArr.put(jsonObj2);
			}
			map.remove("sort");
			
			map.put("sort", "reviewRegDate desc");
			List<ReviewVO> RreviewList = service.getReviewList(map);
			for(ReviewVO vo : RreviewList) {
				JSONObject jsonObj2 = new JSONObject();
				jsonObj2.put("RnickName", vo.getNickName());
				jsonObj2.put("Rpicture", vo.getPicture());
				jsonObj2.put("Rtitle", vo.getTitle());
				jsonObj2.put("Rcontent", vo.getContent());
				jsonObj2.put("Rstar", vo.getStar());
				jsonObj2.put("RreviewImg", vo.getReviewImg());
				jsonObj2.put("RreviewRegDate", vo.getreviewRegDate().substring(0,10));
				jsonArr.put(jsonObj2);
			}
			map.remove("sort");
			
		}
	
		return jsonArr.toString();
	}

	@RequestMapping(value="/ajaxTrendList.p1", produces="text/plain;charset=UTF-8" )
	@ResponseBody
	public String ajaxTrendList(HttpServletRequest request) {
		
		List<HotelRoomVO> hotelList = service.getTrendList();
		
		JSONArray jsonArr = new JSONArray();
		
		if(hotelList!=null) {
			for(HotelRoomVO hotelRoomVO : hotelList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("hotelidx", hotelRoomVO.getHotelidx());
				jsonObj.put("hotelName", hotelRoomVO.getHotelName());
				jsonObj.put("cnt", hotelRoomVO.getHotelStatus());
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}

	@RequestMapping(value="/ajaxWeatherXML.p1", produces="text/plain;charset=UTF-8" )
	public String ajaxWeatherXML(HttpServletRequest request) {
		return "product/weatherXML";
	}

	@RequestMapping(value="/ajaxHotelChart.p1", produces="text/plain;charset=UTF-8" )
	@ResponseBody
	public String ajaxHotelChart(HttpServletRequest request) {
		List<HotelRoomVO> productChart = service.ajaxHotelChart();
		JsonArray jsonArr = new JsonArray();

		if(productChart != null) {
			for(HotelRoomVO product : productChart) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("categoryName", product.getCategoryName());
				jsonObj.addProperty("categoryCode", product.getCategoryCode());
				jsonObj.addProperty("categoryCode", product.getTotalCnt());
				jsonObj.addProperty("categoryCode", product.getHotelStatus());
				jsonObj.addProperty("categoryCode", product.getRoomStatus());
				jsonArr.add(jsonObj);
			}
		}

		return new Gson().toJson(jsonArr);
	}
	
}
