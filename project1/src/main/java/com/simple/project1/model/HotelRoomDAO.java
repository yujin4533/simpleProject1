package com.simple.project1.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HotelRoomDAO implements InterHotelRoomDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<HotelRoomVO> getHotelListBest() {
		List<HotelRoomVO> list = sql.selectList("productdb.getHotelListBest");
		return list;
	}
	
	@Override
	public List<HotelRoomVO> getHotelListNew() {
		List<HotelRoomVO> list = sql.selectList("productdb.getHotelListNew");
		return list;
	}

	@Override
	public int getHotelCnt(HotelRoomVO hotelVO) {
		int n = sql.selectOne("productdb.getHotelCnt",hotelVO);
		return n;
	}

	@Override
	public List<HotelRoomVO> getHotelPagingList(HotelRoomVO hotelVO) {
		List<HotelRoomVO> list = sql.selectList("productdb.getHotelPagingList",hotelVO);
		return list;
	}

	@Override
	public void setTrendView(HotelRoomVO hotelVO) {
		int n = sql.selectOne("productdb.getTrendView",hotelVO);
		if(n==0)
			n += sql.insert("productdb.setTrendView",hotelVO);
		return;
	}

	@Override
	public HotelRoomVO getHotelOne(HotelRoomVO hotelVO) {
		HotelRoomVO list = sql.selectOne("productdb.getHotelOne",hotelVO);
		return list;
	}

	@Override
	public List<HotelRoomVO> getRoomList(HotelRoomVO hotelVO) {
		List<HotelRoomVO> list = sql.selectList("productdb.getRoomList",hotelVO);
		return list;
	}

}
