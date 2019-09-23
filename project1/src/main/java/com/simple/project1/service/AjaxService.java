package com.simple.project1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.InterAjaxDAO;
import com.simple.project1.model.ReviewVO;

@Service
public class AjaxService implements InterAjaxService{
	
	@Autowired
	private InterAjaxDAO dao;

	@Override
	public List<String> getHotelName(String searchWord) {
		List<String> wordList = dao.getHotelName(searchWord);
		return wordList;
	}

	@Override
	public String getHotelidx(String clickWord) {
		String hotelidx = dao.getHotelidx(clickWord);
		return hotelidx;
	}

	@Override
	public HotelRoomVO getRangePrice() {
		HotelRoomVO hotelroomVO = dao.getRangePrice();
		return hotelroomVO;
	}

	@Override
	public List<HotelRoomVO> getHotelOptionList() {
		List<HotelRoomVO> list = dao.getHotelOptionList();
		return list;
	}

	@Override
	public List<HotelRoomVO> getRoomOptionList() {
		List<HotelRoomVO> list = dao.getRoomOptionList();
		return list;
	}

	@Override
	public List<HotelRoomVO> getCategoryCodeList() {
		List<HotelRoomVO> list = dao.getCategoryCodeList();
		return list;
	}

	@Override
	public List<String> wordNameSearchView(String searchWord) {
		List<String> wordList = dao.wordNameSearchView(searchWord);
		return wordList;
	}

	@Override
	public List<String> wordAddrSearchView(String searchWord) {
		List<String> wordList = dao.wordAddrSearchView(searchWord);
		return wordList;
	}

	
	@Override
	public int getReserveCK(HotelRoomVO hotelroomVO) {
		int n = dao.getReserveCK(hotelroomVO);
		return n;
	}

	
	@Override
	public int setInsertReserve(HotelRoomVO hotelroomVO) {
		int n = dao.setInsertReserve(hotelroomVO);
		return n;
	}
	
	@Override
	public int getReviewCnt(HashMap<String, String> map) {
		int n = dao.getReviewCnt(map);
		return n;
	}
	
	@Override
	public double getReviewAvg(HashMap<String, String> map) {
		double n = dao.getReviewAvg(map);
		return n;
	}

	@Override
	public List<ReviewVO> getReviewList(HashMap<String, String> map) {
		List<ReviewVO> list = dao.getReviewList(map);
		return list;
	}

	@Override
	public List<HotelRoomVO> getTrendList() {
		List<HotelRoomVO> list = dao.getTrendList();
		return list;
	}

	@Override
	public List<HotelRoomVO> ajaxHotelChart() {
		List<HotelRoomVO> list = dao.ajaxHotelChart();
		return list;
	}

	
}
