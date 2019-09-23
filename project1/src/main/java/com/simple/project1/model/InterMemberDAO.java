package com.simple.project1.model;

import java.util.HashMap;
import java.util.List;

public interface InterMemberDAO {

	boolean isUse(HashMap<String, String> map);

	int memberAdd(MemberVO membervo);

	MemberVO getLogin(MemberVO membervo);

	int memberEdit(MemberVO membervo);

	int memberOut(int memberidx);

	HotelRoomVO getReserveInfo(HotelRoomVO hotelroomVO);

	int getReserveCnt(int memberidx);
	List<HotelRoomVO> getReserveList(HotelRoomVO hotelroomVO);

	int setUpdateReserveCancel(String reserveidx);

	int setInsertReview(ReviewVO reviewVO);

	int setUpdatePoint(HotelRoomVO reserveVO);

	String getFindMemberId(MemberVO membervo);

	int setMemberPwd(MemberVO membervo);

	String getHeart(HashMap<String, String> paramap);

	int getHeartCnt(int memberidx);

	List<HotelRoomVO> getHeartList(HotelRoomVO hotelroomVO);


}
