package com.simple.project1.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MemberDAO implements InterMemberDAO{

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public boolean isUse(HashMap<String, String> map) {
		boolean bool = false;
		int select = sql.selectOne("memberdb.isUse", map);
		if(select!=1) 
			bool = true;
		return bool;
	}

	@Override
	public int memberAdd(MemberVO membervo) {
		int n = sql.insert("memberdb.memberAdd",membervo);
		return n;
	}

	@Override
	public MemberVO getLogin(MemberVO membervo) {
		MemberVO login = sql.selectOne("memberdb.getLogin",membervo);
		return login;
	}

	@Override
	public int memberEdit(MemberVO membervo) {
		int n = sql.update("memberdb.memberEdit",membervo);
		return n;
	}

	@Override
	public int memberOut(int memberidx) {
		int n = sql.update("memberdb.memberOut",memberidx);
		return n;
	}

	@Override
	public HotelRoomVO getReserveInfo(HotelRoomVO hotelroomVO) {
		HotelRoomVO list = sql.selectOne("memberdb.getReserveInfo",hotelroomVO);
		return list;
	}

	@Override
	public List<HotelRoomVO> getReserveList(HotelRoomVO hotelroomVO) {
		List<HotelRoomVO> list = sql.selectList("memberdb.getReserveList",hotelroomVO);
		return list;
	}

	@Override
	public int getReserveCnt(int memberidx) {
		int n = sql.selectOne("memberdb.getReserveCnt",memberidx);
		return n;
	}

	@Override
	public int setUpdateReserveCancel(String reserveidx) {
		int n = sql.update("memberdb.setUpdateReserveCancel",reserveidx);
		return n;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int setInsertReview(ReviewVO reviewVO) {
		int n = sql.insert("memberdb.setInsertReview",reviewVO);
			n+= sql.update("memberdb.setUpdateReserveStatusReview",reviewVO.getReserveidx());
		if(reviewVO.getImgList()!=null) {
			for(int i=0;i<reviewVO.getImgList().size();i++) {
				n+= sql.insert("memberdb.setInsertReview_attach",reviewVO.getImgList().get(i));
			}
			return n-reviewVO.getImgList().size()-1;
		}
			
		return n-1;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int setUpdatePoint(HotelRoomVO reserveVO) {
		int n = sql.update("memberdb.setUpdateReserveStatusPoint",reserveVO.getRoomidx());
			n+= sql.update("memberdb.setUpdateMemberPoint",reserveVO.getMemberidx());
		return n/2;
	}

	@Override
	public String getFindMemberId(MemberVO membervo) {
		String memberId = sql.selectOne("memberdb.getFindMemberId",membervo);
		return memberId;
	}

	@Override
	public int setMemberPwd(MemberVO membervo) {
		int n = sql.update("memberdb.setMemberPwd",membervo);
		return n;
	}

	@Override
	public String getHeart(HashMap<String, String> paramap) {
		String result = ">>찜 추가 실패<<";
		int find = sql.selectOne("memberdb.getHeart",paramap);
		if(find==0) {
			int add = sql.insert("memberdb.setAddHeart",paramap);
			if(add==1)
				result = ">>찜목록 추가<<";
		}
		else {
			result = ">>찜목록 삭제 실패<<";
			int del = sql.update("memberdb.setDelHeart",paramap);
			if(del>0)
				result = ">>찜목록 삭제<<";
		}
			
		return result;
	}

	@Override
	public int getHeartCnt(int memberidx) {
		int n = sql.selectOne("memberdb.getHeartCnt",memberidx);
		return n;
	}

	@Override
	public List<HotelRoomVO> getHeartList(HotelRoomVO hotelroomVO) {
		List<HotelRoomVO> list = sql.selectList("memberdb.getHeartList",hotelroomVO);
		return list;
	}

	
	
	
}
