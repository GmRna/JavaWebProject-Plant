package com.plant.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@GetMapping("/member/join.do")
	public String join() {
		return "/plant/member/join";
	}
	@PostMapping("/member/join.do")
	public String join(MemberVO vo, Model model) {
		if(service.insert(vo) > 0) {
			model.addAttribute("msg", "회원가입 되었습니다.");
			model.addAttribute("url", "login.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원가입 오류");
			return "common/alert";
		}
		
	}
	@GetMapping("/member/login.do")
	public String login() {
		return "/plant/member/login";
	}
	@PostMapping("/member/login.do")
	public String login(MemberVO vo, HttpSession sess, Model model) {
		if(service.loginCheck(vo, sess)) {
			return "redirect:/ask/index.do";
		} else {
			model.addAttribute("msg", "이메일 또는 비밀번호를 확인해주세요");
			return "common/alert";
		}
	}
	
	
	}
	