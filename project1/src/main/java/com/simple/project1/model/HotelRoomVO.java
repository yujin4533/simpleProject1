package com.simple.project1.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class HotelRoomVO {
	
	// for hotel
	private String categoryCode;
	private int hotelidx;
	private String hotelName;
	private String address;
	private String businessTel;
	private String hotelOption;
	private String hotelInfo;
	private String hotelImg;
	private String hotelRegDay;
	private int hotelStatus;

	// for room
	private int roomidx;
	private String roomName;
	private String roomType;
	private String roomImg;
	private String roomOption;
	private String roomInfo;
	private int weekendPrice;
	private int weekPrice;
	private String roomPeriod1;
	private String roomPeriod2;
	private int roomStatus;
	
	private MultipartFile attach;
	
	// for heartList
	private int memberidx;
	private int heart;
	
	// for search paging
	private int totalCnt;
	private int currentShowPage;
	private int blockSize;
	private int sizePerPage;
	
	// hotel scope
	private double starRating;
	private int starCnt;
	
	// for searching
	private String searchWord;
	private String checkin_date;
	private String checkout_date;
	private int adult;
	private int children;
	
	private String sort;
	
	// for search option
	private int minPrice;
	private int maxPrice;
	private double minStar;
	private double maxStar;
	
	private String categoryName;
	
	private String[] hotelOptionList;
	private String[] roomOptionList;
	private String[] categoryCodeList;
	
	public HotelRoomVO() {}

	public HotelRoomVO(String categoryCode, int hotelidx, String hotelName, String address, String businessTel,
			String hotelOption, String hotelInfo, String hotelImg, String hotelRegDay, int hotelStatus, int roomidx,
			String roomName, String roomType, String roomImg, String roomOption, String roomInfo, int weekendPrice,
			int weekPrice, String roomPeriod1, String roomPeriod2, int roomStatus, int memberidx, int heart,
			int totalCnt, int currentShowPage, int blockSize, int sizePerPage, double starRating, int starCnt,
			String searchWord, String checkin_date, String checkout_date, int adult, int children, String sort,
			int minPrice, int maxPrice, double minStar, double maxStar, String categoryName, String[] hotelOptionList,
			String[] roomOptionList, String[] categoryCodeList) {
		super();
		this.categoryCode = categoryCode;
		this.hotelidx = hotelidx;
		this.hotelName = hotelName;
		this.address = address;
		this.businessTel = businessTel;
		this.hotelOption = hotelOption;
		this.hotelInfo = hotelInfo;
		this.hotelImg = hotelImg;
		this.hotelRegDay = hotelRegDay;
		this.hotelStatus = hotelStatus;
		this.roomidx = roomidx;
		this.roomName = roomName;
		this.roomType = roomType;
		this.roomImg = roomImg;
		this.roomOption = roomOption;
		this.roomInfo = roomInfo;
		this.weekendPrice = weekendPrice;
		this.weekPrice = weekPrice;
		this.roomPeriod1 = roomPeriod1;
		this.roomPeriod2 = roomPeriod2;
		this.roomStatus = roomStatus;
		this.memberidx = memberidx;
		this.heart = heart;
		this.totalCnt = totalCnt;
		this.currentShowPage = currentShowPage;
		this.blockSize = blockSize;
		this.sizePerPage = sizePerPage;
		this.starRating = starRating;
		this.starCnt = starCnt;
		this.searchWord = searchWord;
		this.checkin_date = checkin_date;
		this.checkout_date = checkout_date;
		this.adult = adult;
		this.children = children;
		this.sort = sort;
		this.minPrice = minPrice;
		this.maxPrice = maxPrice;
		this.minStar = minStar;
		this.maxStar = maxStar;
		this.categoryName = categoryName;
		this.hotelOptionList = hotelOptionList;
		this.roomOptionList = roomOptionList;
		this.categoryCodeList = categoryCodeList;
	}

	public String getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}

	public int getHotelidx() {
		return hotelidx;
	}

	public void setHotelidx(int hotelidx) {
		this.hotelidx = hotelidx;
	}

	public String getHotelName() {
		return hotelName!=null?hotelName:"";
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBusinessTel() {
		return businessTel;
	}

	public void setBusinessTel(String businessTel) {
		this.businessTel = businessTel;
	}

	public String getHotelOption() {
		return hotelOption;
	}

	public void setHotelOption(String hotelOption) {
		this.hotelOption = hotelOption;
	}

	public String getHotelInfo() {
		return hotelInfo;
	}

	public void setHotelInfo(String hotelInfo) {
		this.hotelInfo = hotelInfo;
	}

	public String getHotelImg() {
		return hotelImg;
	}

	public void setHotelImg(String hotelImg) {
		this.hotelImg = hotelImg;
	}

	public String getHotelRegDay() {
		return hotelRegDay;
	}

	public void setHotelRegDay(String hotelRegDay) {
		this.hotelRegDay = hotelRegDay;
	}

	public int getHotelStatus() {
		return hotelStatus;
	}

	public void setHotelStatus(int hotelStatus) {
		this.hotelStatus = hotelStatus;
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

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public String getRoomImg() {
		return roomImg;
	}

	public void setRoomImg(String roomImg) {
		this.roomImg = roomImg;
	}

	public String getRoomOption() {
		return roomOption;
	}

	public void setRoomOption(String roomOption) {
		this.roomOption = roomOption;
	}

	public String getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}

	public int getWeekendPrice() {
		return weekendPrice;
	}

	public void setWeekendPrice(int weekendPrice) {
		this.weekendPrice = weekendPrice;
	}

	public int getWeekPrice() {
		return weekPrice;
	}

	public void setWeekPrice(int weekPrice) {
		this.weekPrice = weekPrice;
	}

	public String getRoomPeriod1() {
		return roomPeriod1;
	}

	public void setRoomPeriod1(String roomPeriod1) {
		this.roomPeriod1 = roomPeriod1;
	}

	public String getRoomPeriod2() {
		return roomPeriod2;
	}

	public void setRoomPeriod2(String roomPeriod2) {
		this.roomPeriod2 = roomPeriod2;
	}

	public int getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(int roomStatus) {
		this.roomStatus = roomStatus;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public int getMemberidx() {
		return memberidx;
	}

	public void setMemberidx(int memberidx) {
		this.memberidx = memberidx;
	}

	public int getHeart() {
		return heart;
	}

	public void setHeart(int heart) {
		this.heart = heart;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getTotalPage() {
		return (int)Math.ceil((double)totalCnt/sizePerPage);
	}

	public int getCurrentShowPage() {
		return currentShowPage;
	}

	public void setCurrentShowPage(int currentShowPage) {
		this.currentShowPage = currentShowPage;
	}

	public int getStartRno() {
		if(currentShowPage<1)
			currentShowPage = 1;
		return (currentShowPage-1)*sizePerPage+1;
	}

	public int getEndRno() {
		return getStartRno()+sizePerPage-1;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getSizePerPage() {
		return sizePerPage;
	}

	public void setSizePerPage(int sizePerPage) {
		this.sizePerPage = sizePerPage;
	}

	public double getStarRating() {
		return starRating;
	}

	public void setStarRating(double starRating) {
		this.starRating = starRating;
	}

	public int getStarCnt() {
		return starCnt;
	}

	public void setStarCnt(int starCnt) {
		this.starCnt = starCnt;
	}

	public String getSearchWord() {
		return searchWord!=null?searchWord:"";
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getCheckin_date() {
		return checkin_date!=null?checkin_date:"";
	}

	public void setCheckin_date(String checkin_date) {
		this.checkin_date = checkin_date;
	}

	public String getCheckout_date() {
		return checkout_date!=null?checkout_date:"";
	}

	public void setCheckout_date(String checkout_date) {
		this.checkout_date = checkout_date;
	}
	
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	Calendar c1 = Calendar.getInstance();
	String str_today = dateFormat.format(c1.getTime());
			
	Date today;
	Date checkinDate;
	Date checkOutDate;
	int calDate;
	
	public int getCancel() {
		try {
			today = dateFormat.parse(str_today);
			checkinDate = dateFormat.parse(checkin_date); 
			checkOutDate = dateFormat.parse(checkout_date); 
			long cal = checkinDate.getTime()-today.getTime();
			if(cal>0) 
				calDate = (int)cal/(24*60*60*1000);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return calDate;
	}
	
	public int getReviewWrite() {
		try {
			today = dateFormat.parse(str_today);
			checkinDate = dateFormat.parse(checkin_date);
			checkOutDate = dateFormat.parse(checkout_date);
			long cal = today.getTime()-checkOutDate.getTime();
			calDate = (int)cal/(24*60*60*1000);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return calDate;
	}

	public int getAdult() {
		return adult!=0?adult:1;
	}

	public void setAdult(int adult) {
		this.adult = adult;
	}

	public int getChildren() {
		return children!=0?children:0;
	}

	public void setChildren(int children) {
		this.children = children;
	}

	public int getPer() {
		return adult+children/2;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}

	public int getMaxPrice() {
		return maxPrice!=0?maxPrice:9999999;
	}

	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}

	public double getMinStar() {
		return minStar!=0?minStar:0;
	}

	public void setMinStar(double minStar) {
		this.minStar = minStar;
	}

	public double getMaxStar() {
		return maxStar!=0?maxStar:5;
	}

	public void setMaxStar(double maxStar) {
		this.maxStar = maxStar;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String[] getHotelOptionList() {
		if(hotelOption!=null)
			hotelOptionList = hotelOption.split(",");
		return hotelOptionList;
	}

	public void setHotelOptionList(String[] hotelOptionList) {
		this.hotelOptionList = hotelOptionList;
	}

	public String[] getRoomOptionList() {
		if(roomOption!=null)
			roomOptionList = roomOption.split(",");
		return roomOptionList;
	}

	public void setRoomOptionList(String[] roomOptionList) {
		this.roomOptionList = roomOptionList;
	}

	public String[] getCategoryCodeList() {
		if(categoryCode!=null)
			categoryCodeList = categoryCode.split(",");
		return categoryCodeList;
	}

	public void setCategoryCodeList(String[] categoryCodeList) {
		this.categoryCodeList = categoryCodeList;
	}
	
	
}
