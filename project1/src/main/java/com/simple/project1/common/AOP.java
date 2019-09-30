package com.simple.project1.common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class AOP {
	// 로그인 체크 
	@Pointcut("execution(public * com.simple.project1..*Controller.Login_*(..))")
	public void Login() {
	}
	// 로그인 체크 + 쿼리
	@Pointcut("execution(public * com.simple.project1..*Controller.Login2_*(..))")
	public void Login2() {
	}
	// Post 접근확인
	@Pointcut("execution(public * com.simple.project1..*Controller.*_post(..))")
	public void post() {
	}
	
	@Before("Login()")
	public void beforeLogin(JoinPoint joinPoint) {
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];
		HttpSession session = request.getSession();
		
		try {
			if (session.getAttribute("loginuser") == null) {
				request.setAttribute("msg", ">>회원전용<<");
				request.setAttribute("loc", "/project1/login.p1");
				
				String url = MyUtil.getCurrentURL(request);
				session.setAttribute("backUrl", url);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
			}
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@Before("Login2()")
	public void beforeLogin2(JoinPoint joinPoint) {
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];
		HttpSession session = request.getSession();
		
		try {
			if (session.getAttribute("loginuser") == null) {
				request.setAttribute("msg", ">>회원전용<<");
				request.setAttribute("loc", "/project1/login.p1");
				
				String url = MyUtil.getCurrentURLQuery(request);
				session.setAttribute("backUrl", url);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
			}
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@Before("post()")
	public void beforePost(JoinPoint joinPoint) {
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1];
		String method = request.getMethod();
		
		try {
			if ("get".equalsIgnoreCase(method)) {
				request.setAttribute("msg", ">>잘못된 접근<<");
				request.setAttribute("loc", "/project1/index.p1");
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				dispatcher.forward(request, response);
			}
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
	
}
