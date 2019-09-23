package com.simple.project1.service;

import java.util.List;

import com.simple.project1.model.HotelRoomVO;


public interface InterAdminService {

	int hotelAdd(HotelRoomVO hotelroomvo); // 숙소등록

	int roomAdd(HotelRoomVO hotelroomvo); // 객실등록

	int getAdminHotelCnt(); // 숙소리스트 총갯수
	List<HotelRoomVO> getAdminHotelList(HotelRoomVO hotelroomvo); // 숙소 리스트

	HotelRoomVO getAdminHotelDetail(String hotelidx); // 숙소정보
	List<HotelRoomVO> getAdminRoomList(String hotelidx); // 숙소내 객실리스트

	int setProductStatus(HotelRoomVO hotelroomvo); // 상품(호텔/객실) 전체 status변경
	int setHotelStatus(HotelRoomVO hotelroomvo); // 호텔 status변경
	int setRoomStatus(HotelRoomVO hotelroomvo); // 호텔 status변경

	int getAdminReserveCnt(); // 예약리스트 총갯수
	List<HotelRoomVO> getAdminReserveList(HotelRoomVO hotelroomvo); // 예약리스트

	int setCheckIn(); // 자동체크인
	int setCheckOut(); // 자동체크아웃


}
