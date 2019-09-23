package com.simple.project1.model;

import java.util.List;

public interface InterAdminDAO {

	int hotelAdd(HotelRoomVO hotelroomvo); // 호텔등록

	int roomAdd(HotelRoomVO hotelroomvo);

	int getAdminHotelCnt();
	List<HotelRoomVO> getAdminHotelList(HotelRoomVO hotelroomvo);

	HotelRoomVO getAdminHotelDetail(String hotelidx);
	List<HotelRoomVO> getAdminRoomList(String hotelidx);

	int setProductStatus(HotelRoomVO hotelroomvo);
	int setHotelStatus(HotelRoomVO hotelroomvo);
	int setRoomStatus(HotelRoomVO hotelroomvo);

	int getAdminReserveCnt();
	List<HotelRoomVO> getAdminReserveList(HotelRoomVO hotelroomvo);

	int setCheckIn();
	int setCheckOut();


}
