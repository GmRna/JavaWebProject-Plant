package com.plant.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@GetMapping("/user/join.do")
	public String join() {
		return "plant/user/join";
	}
	
	@PostMapping("/user/join.do")
	public String join(UserVO vo, Model model, @RequestParam MultipartFile picorg, HttpServletRequest req) {
		
		if(!picorg.isEmpty()) {
			// 파일명 
			String org = picorg.getOriginalFilename();
			System.out.println("org : "+ org);
			String ext = org.substring(org.lastIndexOf(".")); 	// 확장자 
			String real = new Date().getTime()+ext;
			
			// 파일 저장
			String path = req.getRealPath("/upload/");
			try {
				picorg.transferTo(new File(path+real));
			} catch (Exception e) {}
			
			vo.setUser_plantfile_org(org);
			vo.setUser_plantfile_real(real);
		}
		int no = service.insert(vo);
		if (no > 0) {
			vo.setUser_no(no);
			model.addAttribute("msg", "정상적으로 회원가입되었습니다.");
			model.addAttribute("url", "login.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원가입오류");
			return "common/alert";
		}

	}
	
	@GetMapping("/user/emailDupCheck.do")
	public void emailDupCheck(@RequestParam String id, HttpServletResponse res) throws IOException {
		int count = service.emailDupCheck(id);
		boolean r = false;
		if (count > 0) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/user/login.do")
	public String login() {
		return "plant/user/login";
	}
	
	@PostMapping("/user/login.do")
	public String login(UserVO vo, HttpSession sess, Model model) {
		if (service.loginCheck(vo, sess)) {
			return "redirect:/plant/list.do";
		} else {
			model.addAttribute("msg", "아이디와 비밀번호를 확인해 주세요");
			return "plant/common/alert";
		}
		
	}
	
	@GetMapping("/user/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/project/board/index.do");
		return "common/alert";
	}
	
	@GetMapping("/user/findEmail.do")
	public String findEmail() {
		return "plant/user/findEmail";
	}
	
	@PostMapping("/user/findEmail.do")
	public String findEmail(Model model, UserVO param) {
		UserVO vo = service.findEmail(param);
		if (vo != null) {
			model.addAttribute("result", vo.getUser_id());
		}
		return "common/return";
	}
	
	@GetMapping("/user/findPwd.do")
	public String findPwd() {
		return "plant/user/findPwd";
	}
	
	/*
	 * @PostMapping("/user/findPwd.do") public String findPwd(Model model, UserVO
	 * param) { UserVO vo = service.findPwd(param); if (vo != null) {
	 * model.addAttribute("result", vo.getUser_email()); } return "common/return"; }
	 */
}
