package com.plant.gd;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.plant.comment.CommentService;
import com.plant.comment.CommentVO;
import com.plant.gd.GdVO;
import com.plant.user.UserVO;
import com.plant.gd.GdVO;
import com.plant.gd.GdVO;

@Controller
public class GdController {
	
	@Autowired
	GdService service;
	
	@GetMapping("/gd/list.do")
	public String index(Model model, GdVO vo) {
		model.addAttribute("data", service.index(vo));
	
		return "/plant/gd/list";
	}
	
	@GetMapping("/gd/view.do")
	public String view(GdVO vo, Model model) {
		
		GdVO data = service.view(vo.getGd_no());
		model.addAttribute("data", data);
		return "/plant/gd/view";
	}
	
	@RequestMapping("/gd/detail")
	public String detail(GdVO vo, Model model) {
		GdVO data = service.detail(vo.getGd_no());
		model.addAttribute("vo", data);
		return "/plant/gd/detail";
	}
	
	@GetMapping("/gd/join.do")
	public String join() {
		return "/plant/gd/join";
	}
	
	@PostMapping("/gd/join.do")
	public String join(GdVO vo, Model model, @RequestParam MultipartFile picorg, HttpServletRequest req) {
		
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
			
			vo.setGd_picorg(org);
			vo.setGd_picreal(real);
		}
		int no = service.insert(vo);
		if (no > 0) {
			vo.setGd_no(no);
			service.insertcar(vo);
			service.insertcer(vo);
			model.addAttribute("msg", "정상적으로 회원가입되었습니다.");
			model.addAttribute("url", "/plant/gd/welcome.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원가입오류");
			return "common/alert";
		}
	}
	
	@GetMapping("/gd/welcome.do")
	public String welcome() {
		return "/plant/gd/welcome";
	}
	
	@GetMapping("/gd/emailDupCheck.do")
	public void emailDupCheck(@RequestParam String id, HttpServletResponse res) throws IOException {
		int count = service.emailDupCheck(id);
		boolean r = false;
		if (count > 0) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/gd/login.do")
	public String login() {
		return "/plant/gd/login";
	}
	
	@RequestMapping("/gd/myInfo")
	public String myInfo(GdVO vo, Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		vo = (GdVO) sess.getAttribute("loginGdInfo");
		GdVO data = service.myInfo(vo.getGd_id());
		model.addAttribute("vo", data);
		return "/plant/gd/myInfo";
	}
	
	@GetMapping("/gd/delete.do")
	public String delete(GdVO vo, Model model) {
		if(service.delete(vo.getGd_no())) {
		
		model.addAttribute("msg", "삭제되었습니다.");
		model.addAttribute("url", "list.do");
		return "common/alert";
		} else {
		model.addAttribute("msg", "삭제실패");
		return "common/alert";
		}
	}
	
	@GetMapping("/gd/edit.do")
	public String edit(GdVO vo, Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		vo = (GdVO) sess.getAttribute("loginGdInfo");
		GdVO data = service.myInfo(vo.getGd_id());
		model.addAttribute("vo", data);
		service.delete(vo.getGd_no());
		return "/plant/gd/edit";
	}
	
	@PostMapping("/gd/edit.do")
	public String edit(GdVO vo, Model model, @RequestParam MultipartFile picorg, HttpServletRequest req) {
		
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
			
			vo.setGd_picorg(org);
			vo.setGd_picreal(real);
		}
		int no = service.insert2(vo);
		if (no > 0) {
			vo.setGd_no(no);
			service.insertcar2(vo);
			service.insertcer2(vo);
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "/plant/gd/login.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원 정보 수정 오류");
			return "common/alert";
		}
	}
	
	@GetMapping("/gd/access.do")
	public String access(GdVO vo, Model model, HttpServletRequest req) {
		GdVO data = service.access(vo.getGd_id());
		model.addAttribute("vo", data);
		return "/plant/gd/access";
	}

	
	@PostMapping("/gd/login")
	public String login(GdVO vo, HttpSession sess, Model model, HttpServletRequest req) {		
		service.loginCheck(vo, sess);
		//GdVO dbData = service.getInfo(vo.getGd_id());
		vo = (GdVO) sess.getAttribute("loginGdInfo");
		
		if(vo.getGd_acc() == 0) {
			model.addAttribute("msg", "승인대기 중입니다.");
			return "common/alert";
		}else if (vo.getGd_acc() == 1) {
			return "redirect:/main/index.do";
		}else if(vo.getGd_acc() == 2){
			model.addAttribute("msg", "가입 요청이 거절된 아이디입니다.");
			return "common/alert";
		}else if(vo.getGd_acc() == 3){
			model.addAttribute("msg", "사용 정지된 아이디입니다.");
			return "common/alert";
		} else {
		model.addAttribute("msg", "아이디와 비밀번호를 확인해 주세요");
		return "common/alert";
		}


	}	
	
	@GetMapping("/gd/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/plant/gd/login.do");
		return "common/alert";
	}
	
	@GetMapping("/gd/findEmail.do")
	public String findEmail() {
		return "/plant/gd/findEmail";
	}
	
	@PostMapping("/gd/findEmail.do")
	public String findEmail(Model model, GdVO param) {
		GdVO vo = service.findEmail(param);
		if (vo != null) {
			model.addAttribute("result", vo.getGd_id());
		}
		return "common/return";
	}
	  
	@GetMapping("/gd/findPwd.do")
	public String findPwd() {
		return "/plant/gd/findPwd";
	}
	
	@PostMapping("/gd/findPwd.do")
	public String findPwd(Model model, GdVO param) {
		GdVO vo = service.findPwd(param);
		if (vo != null) {
			model.addAttribute("result", vo.getGd_email());
		}
		return "common/return";
	}
	
	
}
