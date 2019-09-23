package com.simple.project1.service;

import java.util.HashMap;
import java.util.List;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.MemberVO;
import com.simple.project1.model.ReviewVO;

public interface InterMemberService {

	boolean isUse(HashMap<String, String> map); // 아이디,닉네임,이메일 중복체크

	int memberAdd(MemberVO membervo); // 회원가입

	MemberVO getLogin(MemberVO membervo); // 로그인

	int memberEdit(MemberVO membervo); // 사진변경

	int memberOut(int memberidx); // 탈퇴

	HotelRoomVO getReserveInfo(HotelRoomVO hotelroomVO); // 예약 인포

	int getReserveCnt(int memberidx); // 예약갯수
	List<HotelRoomVO> getReserveList(HotelRoomVO hotelroomVO); // 예약리스트

	int setUpdateReserveCancel(String reserveidx); // 예약취소

	int setInsertReview(ReviewVO reviewVO); // 리뷰작성

	int setUpdatePoint(HotelRoomVO reserveVO); // 포인트 적립

	String getFindMemberId(MemberVO membervo); // 아이디찾기

	int setMemberPwd(MemberVO membervo); // 비밀번호 변경

	String getHeart(HashMap<String, String> paramap); // 찜 추가/삭제 

	int getHeartCnt(int memberidx); // 찜갯수
	List<HotelRoomVO> getHeartList(HotelRoomVO hotelroomVO); // 찜리스트


}
