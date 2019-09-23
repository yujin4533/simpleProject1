package com.simple.project1.model;

import java.util.List;

public class ReviewVO {
	
	private String nickName;
	private String picture;
	private String title;
	private String content;
	private String reviewRegDate;
	private String reviewImg;
	private int memberidx;
	private int reviewidx;
	private int reserveidx;
	private int hotelidx;
	private int reviewStatus;
	private double star;
	
	private List<String> imgList;
	
	public ReviewVO() {}

	public ReviewVO(String nickName, String picture, String title, String content, String reviewRegDate,String reviewImg , int memberidx, int reviewidx, int reserveidx,
			int hotelidx, int reviewStatus, double star, List<String> imgList) {
		super();
		this.picture = picture;
		this.picture = picture;
		this.title = title;
		this.content = content;
		this.reviewRegDate = reviewRegDate;
		this.reviewImg = reviewImg;
		this.memberidx = memberidx;
		this.reviewidx = reviewidx;
		this.reserveidx = reserveidx;
		this.hotelidx = hotelidx;
		this.reviewStatus = reviewStatus;
		this.star = star;
		this.imgList = imgList;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getreviewRegDate() {
		return reviewRegDate;
	}

	public void setreviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}

	public String getReviewImg() {
		return reviewImg;
	}

	public void setReviewImg(String reviewImg) {
		this.reviewImg = reviewImg;
	}

	public int getMemberidx() {
		return memberidx;
	}

	public void setMemberidx(int memberidx) {
		this.memberidx = memberidx;
	}

	public int getReviewidx() {
		return reviewidx;
	}

	public void setReviewidx(int reviewidx) {
		this.reviewidx = reviewidx;
	}

	public int getReserveidx() {
		return reserveidx;
	}

	public void setReserveidx(int reserveidx) {
		this.reserveidx = reserveidx;
	}

	public int getHotelidx() {
		return hotelidx;
	}

	public void setHotelidx(int hotelidx) {
		this.hotelidx = hotelidx;
	}

	public int getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(int reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public double getStar() {
		return star;
	}

	public void setStar(double star) {
		this.star = star;
	}

	public List<String> getImgList() {
		return imgList;
	}

	public void setImgList(List<String> imgList) {
		this.imgList = imgList;
	}
	
	
	

}
