package com.simple.project1.model;

import java.util.List;

public interface InterHotelRoomDAO {

	List<HotelRoomVO> getHotelListBest();
	List<HotelRoomVO> getHotelListNew();

	int getHotelCnt(HotelRoomVO hotelVO);
	List<HotelRoomVO> getHotelPagingList(HotelRoomVO hotelVO);

	void setTrendView(HotelRoomVO hotelVO);
	HotelRoomVO getHotelOne(HotelRoomVO hotelVO);
	List<HotelRoomVO> getRoomList(HotelRoomVO hotelVO);


}
