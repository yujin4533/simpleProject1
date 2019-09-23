package com.simple.project1.service;

import java.util.HashMap;
import java.util.List;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.ReviewVO;

public interface InterAjaxService {

	List<String> getHotelName(String searchWord); // 객실 등록시 숙소명 자동완성

	String getHotelidx(String clickWord); // 숙소명으로 hotelidx 따오기

	HotelRoomVO getRangePrice(); // 서브서치 가격범위
	List<HotelRoomVO> getHotelOptionList(); // 서브서치 호텔옵션
	List<HotelRoomVO> getRoomOptionList(); // 서브서치 객실옵션
	List<HotelRoomVO> getCategoryCodeList(); // 서브서치 숙소종류

	List<String> wordNameSearchView(String searchWord); // 검색어 자동완성 숙소명
	List<String> wordAddrSearchView(String searchWord); // 검색어 자동완성 주소명

	int getReserveCK(HotelRoomVO hotelroomVO); // 예약결제 전 중간예약자 유무 확인

	int setInsertReserve(HotelRoomVO hotelroomVO); // 결제 후 예약테이블 삽입

	int getReviewCnt(HashMap<String, String> map); // 상세페이지 리뷰 갯수
	double getReviewAvg(HashMap<String, String> map); // 상세페이지 리뷰 평균
	List<ReviewVO> getReviewList(HashMap<String, String> map); // 상세페이지 리뷰

	List<HotelRoomVO> getTrendList(); // 조회순으로 실시간호텔

	List<HotelRoomVO> ajaxHotelChart(); // 상품코드별 차트



}
