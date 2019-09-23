package com.simple.project1.model;

import java.util.HashMap;
import java.util.List;

public interface InterAjaxDAO {

	List<String> getHotelName(String searchWord);

	String getHotelidx(String clickWord);

	HotelRoomVO getRangePrice();
	List<HotelRoomVO> getHotelOptionList();
	List<HotelRoomVO> getRoomOptionList();
	List<HotelRoomVO> getCategoryCodeList();

	List<String> wordNameSearchView(String searchWord);
	List<String> wordAddrSearchView(String searchWord);

	int getReserveCK(HotelRoomVO hotelroomVO);

	int setInsertReserve(HotelRoomVO hotelroomVO);

	int getReviewCnt(HashMap<String, String> map);
	double getReviewAvg(HashMap<String, String> map);
	List<ReviewVO> getReviewList(HashMap<String, String> map);

	List<HotelRoomVO> getTrendList();

	List<HotelRoomVO> ajaxHotelChart();



}
