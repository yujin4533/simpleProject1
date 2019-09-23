package com.simple.project1.common;

import javax.servlet.http.HttpServletRequest;

import com.simple.project1.model.HotelRoomVO;

public class MyUtil {
	
	public static String searchPageBar(HttpServletRequest request, HotelRoomVO vo) {
		String searchVO = "";
		
		if("search".equals(vo.getAddress())) {

			if(vo.getSearchWord()!=null) { 
				searchVO += "&searchWord="+vo.getSearchWord();
			}
			if(vo.getCheckin_date()!=null) { 
				searchVO += "&checkin_date="+vo.getCheckin_date();
			}
			if(vo.getCheckout_date()!=null) { 
				searchVO += "&checkout_date="+vo.getCheckout_date();
			}
			if(vo.getAdult()!=0) { 
				searchVO += "&adult="+vo.getAdult();
			}
			if(vo.getChildren()!=0) { 
				searchVO += "&children="+vo.getChildren();
			}
			if(vo.getSort()!=null) { 
				searchVO += "&sort="+vo.getSort();
			}
			if(vo.getHotelName()!=null) { 
				searchVO += "&hotelName="+vo.getHotelName();
			}
			if(vo.getMinPrice()!=0) {
				searchVO += "&minPrice="+vo.getMinPrice();
			}
			if(vo.getMaxPrice()!=0) {
				searchVO += "&maxPrice="+vo.getMaxPrice();
			}
			if(vo.getMinStar()!=0) {
				searchVO += "&minStar="+vo.getMinStar();
			}
			if(vo.getMaxStar()!=0) {
				searchVO += "&maxStar="+vo.getMaxStar();
			}
			
			if(vo.getHotelOptionList()!=null) { 
				for(int i=0;i<vo.getHotelOptionList().length;i++) { 
					searchVO +="&hotelOption="+vo.getHotelOptionList()[i];
				}
			}
			if(vo.getRoomOptionList()!=null) { 
				for(int i=0;i<vo.getRoomOptionList().length;i++) { 
					searchVO +="&roomOption="+vo.getRoomOptionList()[i];
				}
			}
			if(vo.getCategoryCodeList()!=null) { 
				for(int i=0;i<vo.getCategoryCodeList().length;i++) { 
					searchVO +="&categoryCode="+vo.getCategoryCodeList()[i];
				}
			}
			
		} 
		
		String pageBar = "";
		int loop = 1;
		int pageNo = ((vo.getCurrentShowPage()-1)/vo.getBlockSize())*vo.getBlockSize()+1;
		
		if(pageNo!=1)
			pageBar+= "<li><a href='/project1/"+vo.getAddress()+".p1?currentShowPage="+(pageNo-1)+searchVO+"'><<</a></li>";
		
		while( !(loop>vo.getBlockSize() || pageNo>vo.getTotalPage()) ) {
			// 1>5 || 1>5
			if(pageNo == vo.getCurrentShowPage()) 
				pageBar += "<li class='active'><span>"+pageNo+"</span></li>";
			
			else 
				pageBar += "<li><a href='/project1/"+vo.getAddress()+".p1?currentShowPage="+pageNo+searchVO+"'>"+pageNo+"</a><li/>"; 
			
			loop++;
			pageNo++;
		}
		
		if( !(pageNo>vo.getTotalPage()) ) 
			pageBar += "<li><a href='/project1/"+vo.getAddress()+".p1?currentShowPage="+pageNo+searchVO+"'>>></a></li>"; 
		
		
		return pageBar;
	}
	
//  스크립트공격대비용 시큐어 코드
	public static String replaceParameter(String param) {
		String result = param;
		
		if(param != null) {
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("\"", "&quot;");
		}
		
		return result;
	}

	public static String getCurrentURL(HttpServletRequest request) {
		String currentURL = request.getRequestURL().toString(); // url주소
		String ctxPath = request.getContextPath(); // /project1
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		currentURL = currentURL.substring(beginIndex+1); // ctxPath앞 자르기
		
		return currentURL;
	}

	public static String getCurrentURLQuery(HttpServletRequest request) {
		String currentURL = request.getRequestURL().toString(); // url주소
		String queryString = request.getQueryString(); // ?뒤
		currentURL += "?"+queryString;
		String ctxPath = request.getContextPath(); // /project1
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		currentURL = currentURL.substring(beginIndex+1); // ctxPath앞 자르기
		
		return currentURL;
	}

	

}
