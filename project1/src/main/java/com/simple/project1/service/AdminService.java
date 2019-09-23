package com.simple.project1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.InterAdminDAO;

@Service
public class AdminService implements InterAdminService{
	
	@Autowired
	private InterAdminDAO dao;

	@Override // 숙소 등록
	public int hotelAdd(HotelRoomVO hotelroomvo) {
		int n = dao.hotelAdd(hotelroomvo);
		return n;
	}

	@Override
	public int roomAdd(HotelRoomVO hotelroomvo) {
		int n = dao.roomAdd(hotelroomvo);
		return n;
	}
	
	@Override
	public int getAdminHotelCnt() {
		int n = dao.getAdminHotelCnt();
		return n;
	}

	@Override
	public List<HotelRoomVO> getAdminHotelList(HotelRoomVO hotelroomvo) {
		List<HotelRoomVO> list = dao.getAdminHotelList(hotelroomvo);
		return list;
	}

	@Override
	public HotelRoomVO getAdminHotelDetail(String hotelidx) {
		HotelRoomVO list = dao.getAdminHotelDetail(hotelidx);
		return list;
	}

	@Override
	public List<HotelRoomVO> getAdminRoomList(String hotelidx) {
		List<HotelRoomVO> list = dao.getAdminRoomList(hotelidx);
		return list;
	}

	@Override
	public int setProductStatus(HotelRoomVO hotelroomvo) {
		int n = dao.setProductStatus(hotelroomvo);
		return n;
	}
	
	@Override
	public int setHotelStatus(HotelRoomVO hotelroomvo) {
		int n = dao.setHotelStatus(hotelroomvo);
		return n;
	}
	
	@Override
	public int setRoomStatus(HotelRoomVO hotelroomvo) {
		int n = dao.setRoomStatus(hotelroomvo);
		return n;
	}

	@Override
	public int getAdminReserveCnt() {
		int n = dao.getAdminReserveCnt();
		return n;
	}

	@Override
	public List<HotelRoomVO> getAdminReserveList(HotelRoomVO hotelroomvo) {
		List<HotelRoomVO> list = dao.getAdminReserveList(hotelroomvo);
		return list;
	}

	@Override
	public int setCheckIn() {
		int n = dao.setCheckIn();
		return n;
	}

	@Override
	public int setCheckOut() {
		int n = dao.setCheckOut();
		return n;
	}
	
}
