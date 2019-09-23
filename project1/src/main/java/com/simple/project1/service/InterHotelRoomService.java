package com.simple.project1.service;

import java.util.List;

import com.simple.project1.model.HotelRoomVO;

public interface InterHotelRoomService {

	List<HotelRoomVO> getHotelListBest(); // 베스트숙소(예약순)
	List<HotelRoomVO> getHotelListNew(); // 최신숙소

	int getHotelCnt(HotelRoomVO hotelVO); // 숙소 총갯수
	List<HotelRoomVO> getHotelPagingList(HotelRoomVO hotelVO); // 페이징한 숙소리스트
	
	void setTrendView(HotelRoomVO hotelVO); // 상세페이지 접속시 조회수
	HotelRoomVO getHotelOne(HotelRoomVO hotelVO); // 상세페이지 호텔
	List<HotelRoomVO> getRoomList(HotelRoomVO hotelVO); // 상세페이지 룸리스트


}
