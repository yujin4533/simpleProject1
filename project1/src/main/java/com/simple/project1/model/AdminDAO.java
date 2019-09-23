package com.simple.project1.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO implements InterAdminDAO{

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public int hotelAdd(HotelRoomVO hotelroomvo) {
		int n = sql.insert("admindb.hotelAdd",hotelroomvo);
		return n;
	}

	@Override
	public int roomAdd(HotelRoomVO hotelroomvo) {
		int n = sql.insert("admindb.roomAdd",hotelroomvo);
		return n;
	}

	@Override
	public int getAdminHotelCnt() {
		int n = sql.selectOne("admindb.getAdminHotelCnt");
		return n;
	}

	@Override
	public List<HotelRoomVO> getAdminHotelList(HotelRoomVO hotelroomvo) {
		List<HotelRoomVO> list = sql.selectList("admindb.getAdminHotelList",hotelroomvo);
		return list;
	}

	@Override
	public HotelRoomVO getAdminHotelDetail(String hotelidx) {
		HotelRoomVO list = sql.selectOne("admindb.getAdminHotelDetail",hotelidx);
		return list;
	}

	@Override
	public List<HotelRoomVO> getAdminRoomList(String hotelidx) {
		List<HotelRoomVO> list = sql.selectList("admindb.getAdminRoomList",hotelidx);
		return list;
	}

	@Override
	public int setProductStatus(HotelRoomVO hotelroomvo) {
		int n = sql.update("admindb.setHotelStatus",hotelroomvo);
		int m = sql.update("admindb.setRoomStatus",hotelroomvo);
		return n*m;
	}
	
	@Override
	public int setHotelStatus(HotelRoomVO hotelroomvo) {
		int n = sql.update("admindb.setHotelStatus",hotelroomvo);
		return n;
	}
	
	@Override
	public int setRoomStatus(HotelRoomVO hotelroomvo) {
		int n = sql.update("admindb.setRoomStatus",hotelroomvo);
		return n;
	}

	@Override
	public int getAdminReserveCnt() {
		int n = sql.selectOne("admindb.getAdminReserveCnt");
		return n;
	}

	@Override
	public List<HotelRoomVO> getAdminReserveList(HotelRoomVO hotelroomvo) {
		List<HotelRoomVO> list = sql.selectList("admindb.getAdminReserveList",hotelroomvo);
		return list;
	}

	@Override
	public int setCheckIn() {
		int cnt  = sql.update("admindb.setCheckIn");
		int n = sql.selectOne("admindb.getCheckIn");
		if(n==0)
			return cnt;
		else
			return -1;
	}

	@Override
	public int setCheckOut() {
		int cnt  = sql.update("admindb.setCheckOut");
		int n = sql.selectOne("admindb.getCheckOut");
		if(n==0)
			return cnt;
		else
			return -1;
	}
	
}
