package com.board.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/scrap")
	public String scrap() {
		return "index";
	}

//로그아웃기능 .
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/signup")
	public String signup(HttpSession session) {
		System.out.println();
		//회원가입 창에서 로그인 할 경우 인덱스 페이지로 이
		boolean login = session.getAttribute("id") != null;
		if(login) {
			return "index";
		}
		
		return "signup";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "signup";
	}
	
	@GetMapping("/write")
	public String write() {
		return "write";
	}
	
	@GetMapping("/detail")
	public String detail() {
		return "detail";
	}
	
}
