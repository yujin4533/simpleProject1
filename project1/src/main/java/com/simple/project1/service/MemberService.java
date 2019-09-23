package com.simple.project1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.InterMemberDAO;
import com.simple.project1.model.MemberVO;
import com.simple.project1.model.ReviewVO;

@Service
public class MemberService implements InterMemberService{

	@Autowired
	private InterMemberDAO dao;
	
	@Override
	public boolean isUse(HashMap<String, String> map) {
		boolean n = dao.isUse(map);
		return n;
	}

	@Override
	public int memberAdd(MemberVO membervo) {
		int n = dao.memberAdd(membervo);
		return n;
	}

	@Override
	public MemberVO getLogin(MemberVO membervo) {
		MemberVO login = dao.getLogin(membervo);
		return login;
	}

	@Override
	public int memberEdit(MemberVO membervo) {
		int n = dao.memberEdit(membervo);
		return n;
	}

	@Override
	public int memberOut(int memberidx) {
		int n = dao.memberOut(memberidx);
		return n;
	}

	@Override
	public HotelRoomVO getReserveInfo(HotelRoomVO hotelroomVO) {
		HotelRoomVO list = dao.getReserveInfo(hotelroomVO);
		return list;
	}

	@Override
	public List<HotelRoomVO> getReserveList(HotelRoomVO hotelroomVO) {
		List<HotelRoomVO> list = dao.getReserveList(hotelroomVO);
		return list;
	}
	
	@Override
	public int getReserveCnt(int memberidx) {
		int n = dao.getReserveCnt(memberidx);
		return n;
	}

	@Override
	public int setUpdateReserveCancel(String reserveidx) {
		int n = dao.setUpdateReserveCancel(reserveidx);
		return n;
	}

	@Override
	public int setInsertReview(ReviewVO reviewVO) {
		int n = dao.setInsertReview(reviewVO);
		return n;
	}

	@Override
	public int setUpdatePoint(HotelRoomVO reserveVO) {
		int n = dao.setUpdatePoint(reserveVO);
		return n;
	}

	@Override
	public String getFindMemberId(MemberVO membervo) {
		String memberId = dao.getFindMemberId(membervo);
		return memberId;
	}

	@Override
	public int setMemberPwd(MemberVO membervo) {
		int n = dao.setMemberPwd(membervo);
		return n;
	}

	@Override
	public String getHeart(HashMap<String, String> paramap) {
		String n = dao.getHeart(paramap);
		return n;
	}

	@Override
	public int getHeartCnt(int memberidx) {
		int n = dao.getHeartCnt(memberidx);
		return n;
	}

	@Override
	public List<HotelRoomVO> getHeartList(HotelRoomVO hotelroomVO) {
		List<HotelRoomVO> list = dao.getHeartList(hotelroomVO);
		return list;
	}


}
