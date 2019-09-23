package com.simple.project1.model;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	// only member table
	private int memberidx;
    private String memberId;
    private String nickname;
    private String memberPwd;
    private String memberName;
    private String email;
    private String birthDay;
    private String memberTel;
    private int gender;
    private String registerDay; 
    private int status;
    private int grade;
    private int point;
    private String picture;
    private String finalLogin;
    private String finalPwd;
    
    // only reserve table
    private int reserveidx;
    private String reserveDate;
    private int hotelidx;
    private String hotelName;
    private int roomidx;
    private String roomName;
    private String checkin;
    private String checkout;
    private int price;
    private int vat;
    private int reserveStatus;
    
    private MultipartFile attach;
    
    public MemberVO() {}

	public MemberVO(int memberidx, String memberId, String nickname, String memberPwd, String memberName, String email,
			String birthDay, String memberTel, int gender, String registerDay, int status, int grade, int point,
			String picture, String finalLogin, String finalPwd, int reserveidx, String reserveDate, int hotelidx,
			String hotelName,int roomidx, String roomName, String checkin, String checkout, int price, int vat, int reserveStatus, MultipartFile attach) {
		super();
		this.memberidx = memberidx;
		this.memberId = memberId;
		this.nickname = nickname;
		this.memberPwd = memberPwd;
		this.memberName = memberName;
		this.email = email;
		this.birthDay = birthDay;
		this.memberTel = memberTel;
		this.gender = gender;
		this.registerDay = registerDay;
		this.status = status;
		this.grade = grade;
		this.point = point;
		this.picture = picture;
		this.finalLogin = finalLogin;
		this.finalPwd = finalPwd;
		this.reserveidx = reserveidx;
		this.reserveDate = reserveDate;
		this.hotelidx = hotelidx;
		this.roomidx = roomidx;
		this.hotelName = hotelName;
		this.roomName = roomName;
		this.checkin = checkin;
		this.checkout = checkout;
		this.price = price;
		this.vat = vat;
		this.reserveStatus = reserveStatus;
		this.attach = attach;
	}

	public int getMemberidx() {
		return memberidx;
	}

	public void setMemberidx(int memberidx) {
		this.memberidx = memberidx;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMemberPwd() {
		return memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public String getMemberTel() {
		return memberTel;
	}

	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getRegisterDay() {
		return registerDay;
	}

	public void setRegisterDay(String registerDay) {
		this.registerDay = registerDay;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getFinalLogin() {
		return finalLogin;
	}

	public void setFinalLogin(String finalLogin) {
		this.finalLogin = finalLogin;
	}

	public String getFinalPwd() {
		return finalPwd;
	}

	public void setFinalPwd(String finalPwd) {
		this.finalPwd = finalPwd;
	}

	public int getReserveidx() {
		return reserveidx;
	}

	public void setReserveidx(int reserveidx) {
		this.reserveidx = reserveidx;
	}

	public String getReserveDate() {
		return reserveDate;
	}

	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}

	public int getHotelidx() {
		return hotelidx;
	}

	public void setHotelidx(int hotelidx) {
		this.hotelidx = hotelidx;
	}
	
	public String getHotelName() {
		return hotelName;
	}
	
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public int getRoomidx() {
		return roomidx;
	}

	public void setRoomidx(int roomidx) {
		this.roomidx = roomidx;
	}

	public String getRoomName() {
		return roomName;
	}
	
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getCheckin() {
		return checkin;
	}

	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}

	public String getCheckout() {
		return checkout;
	}

	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getVat() {
		return vat;
	}

	public void setVat(int vat) {
		this.vat = vat;
	}

	public int getReserveStatus() {
		return reserveStatus;
	}

	public void setReserveStatus(int reserveStatus) {
		this.reserveStatus = reserveStatus;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

}
