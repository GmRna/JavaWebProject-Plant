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

import com.plant.user.UserVO;
import com.plant.user.UserVO;

@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@GetMapping("/user/list.do")
	public String list(Model model, UserVO vo) {
		model.addAttribute("data", service.index(vo));
		return "/plant/user/list";
	}
	
	@GetMapping("/user/view.do")
	public String view(UserVO vo, Model model) {		
		UserVO data = service.view(vo.getUser_no());
		model.addAttribute("data", data);
		return "/plant/user/view";
	}
	
	@RequestMapping("/user/detail")
	public String detail(UserVO vo, Model model) {
		UserVO data = service.detail(vo.getUser_no());
		model.addAttribute("vo", data);
		return "/plant/user/detail";
	}
	
	@RequestMapping("/user/myInfo")
	public String myInfo(UserVO vo, Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		vo = (UserVO) sess.getAttribute("loginUserInfo");
		UserVO data = service.myInfo(vo.getUser_id());
		model.addAttribute("vo", data);
		return "/plant/user/myInfo";
	}
	
	@GetMapping("/user/edit.do")
	public String edit(UserVO vo, Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		vo = (UserVO) sess.getAttribute("loginUserInfo");
		UserVO data = service.myInfo(vo.getUser_id());
		model.addAttribute("vo", data);
		return "/plant/user/edit";
	}
	
	@PostMapping("/user/edit.do")
	public String edit(UserVO vo, Model model, @RequestParam MultipartFile picorg, HttpServletRequest req) {
		
		System.out.print("vo"+vo.getUser_plantfile_org());
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
		int no = service.edit(vo);
		if (no > 0) {
			vo.setUser_no(no);
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "/plant/user/myInfo.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 오류");
			return "common/alert";
		}
	}
	
	@GetMapping("/user/delete.do")
	public String delete(UserVO vo, Model model) {
		if(service.delete(vo.getUser_no())) {
		
		model.addAttribute("msg", "탈퇴처리되었습니다.");
		model.addAttribute("url", "list.do");
		return "common/alert";
		} else {
		model.addAttribute("msg", "탈퇴 실패");
		return "common/alert";
		}
	}
	
	@GetMapping("/user/join.do")
	public String join() {
		return "/plant/user/join";
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
			model.addAttribute("url", "welcome.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원가입오류");
			return "common/alert";
		}

	}
	
	@GetMapping("/user/welcome.do")
	public String welcome() {
		return "/plant/user/welcome";
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
	
	@GetMapping("/user/nickDupCheck.do")
	public void nickDupCheck(@RequestParam String id, HttpServletResponse res) throws IOException {
		int count = service.nickDupCheck(id);
		boolean r = false;
		if (count > 0) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	// 로그인 창
	@GetMapping("/user/login.do")
	public String login() {
		return "/plant/user/login";
	}
	
	@PostMapping("/user/login.do")
	public String login(UserVO vo, HttpSession sess, Model model) {
		if (service.loginCheck(vo, sess)) {
			return "redirect:/main/index.do";
		} else {
			model.addAttribute("msg", "아이디와 비밀번호를 확인해 주세요");
			return "common/alert";
		}
		
	}
	
	@GetMapping("/user/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "plant/main/index.do");
		return "common/alert";
	}
	
	@GetMapping("/user/findEmail.do")
	public String findEmail() {
		return "/plant/user/findEmail";
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
		return "/plant/user/findPwd";
	}
	
	@PostMapping("/user/findPwd.do")
	public String findPwd(Model model, UserVO param) {
		UserVO vo = service.findPwd(param);
		if (vo != null) {
			model.addAttribute("result", vo.getUser_email());
		}
		return "common/return";
	}
	

}
