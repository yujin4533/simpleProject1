package com.simple.project1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.InterHotelRoomDAO;

@Service
public class HotelRoomService implements InterHotelRoomService{
	
	@Autowired
	private InterHotelRoomDAO dao;

	@Override
	public List<HotelRoomVO> getHotelListBest() {
		List<HotelRoomVO> list = dao.getHotelListBest();
		return list;
	}
	
	@Override
	public List<HotelRoomVO> getHotelListNew() {
		List<HotelRoomVO> list = dao.getHotelListNew();
		return list;
	}
	
	@Override
	public int getHotelCnt(HotelRoomVO hotelVO) {
		int n = dao.getHotelCnt(hotelVO);
		return n;
	}

	@Override
	public List<HotelRoomVO> getHotelPagingList(HotelRoomVO hotelVO) {
		List<HotelRoomVO> list = dao.getHotelPagingList(hotelVO);
		return list;
	}

	@Override
	public void setTrendView(HotelRoomVO hotelVO) {
		dao.setTrendView(hotelVO);
		return;
	}
	@Override
	public HotelRoomVO getHotelOne(HotelRoomVO hotelVO) {
		HotelRoomVO list = dao.getHotelOne(hotelVO);
		return list;
	}

	@Override
	public List<HotelRoomVO> getRoomList(HotelRoomVO hotelVO) {
		List<HotelRoomVO> list = dao.getRoomList(hotelVO);
		return list;
	}

	

}
