package com.simple.project1.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AjaxDAO implements InterAjaxDAO{
	
	@Autowired
	private SqlSessionTemplate sql;

	@Override 
	public List<String> getHotelName(String searchWord) {
		List<String> wordList = sql.selectList("ajaxdb.getHotelName",searchWord);
		return wordList;
	}

	@Override
	public String getHotelidx(String clickWord) {
		String hotelidx = sql.selectOne("ajaxdb.getHotelidx",clickWord);
		return hotelidx;
	}

	@Override
	public HotelRoomVO getRangePrice() {
		HotelRoomVO hotelroomvo = sql.selectOne("ajaxdb.getRangePrice");
		return hotelroomvo;
	}

	@Override
	public List<HotelRoomVO> getHotelOptionList() {
		List<HotelRoomVO> list = sql.selectList("ajaxdb.getHotelOptionList");
		return list;
	}

	@Override
	public List<HotelRoomVO> getRoomOptionList() {
		List<HotelRoomVO> list = sql.selectList("ajaxdb.getRoomOptionList");
		return list;
	}

	@Override
	public List<HotelRoomVO> getCategoryCodeList() {
		List<HotelRoomVO> list = sql.selectList("ajaxdb.getCategoryCodeList");
		return list;
	}

	@Override
	public List<String> wordNameSearchView(String searchWord) {
		List<String> wordList = sql.selectList("ajaxdb.wordNameSearchView", searchWord);
		return wordList;
	}

	@Override
	public List<String> wordAddrSearchView(String searchWord) {
		List<String> wordList = sql.selectList("ajaxdb.wordAddrSearchView", searchWord);
		return wordList;
	}

	@Override
	public int getReserveCK(HotelRoomVO hotelroomVO) {
		int n = sql.selectOne("ajaxdb.getReserveCK",hotelroomVO);
		return n;
	}

	@Override
	public int setInsertReserve(HotelRoomVO hotelroomVO) {
		int n = sql.insert("ajaxdb.setInsertReserve",hotelroomVO);
		return n;
	}
	
	@Override
	public int getReviewCnt(HashMap<String, String> map) {
		int n = sql.selectOne("ajaxdb.getReviewCnt",map);
		return n;
	}
	
	@Override
	public double getReviewAvg(HashMap<String, String> map) {
		double n = sql.selectOne("ajaxdb.getReviewAvg",map);
		return n;
	}

	@Override
	public List<ReviewVO> getReviewList(HashMap<String, String> map) {
		List<ReviewVO> list = sql.selectList("ajaxdb.getReviewList", map);
		return list;
	}

	@Override
	public List<HotelRoomVO> getTrendList() {
		List<HotelRoomVO> list = sql.selectList("ajaxdb.getTrendList");
		return list;
	}

	@Override
	public List<HotelRoomVO> ajaxHotelChart() {
		List<HotelRoomVO> list = sql.selectList("ajaxdb.ajaxHotelChart");
		return list;
	}
	
	
}
