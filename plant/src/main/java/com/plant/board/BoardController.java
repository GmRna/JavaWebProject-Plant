package com.plant.board;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.plant.comment.CommentService;
import com.plant.comment.CommentVO;
import com.plant.user.UserVO;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@Autowired
	CommentService cService;
	
	@GetMapping("/board/index.do")
	public String index(Model model, BoardVO vo) {
		model.addAttribute("data", service.index(vo));
		return "board/index";
	}
	
	@GetMapping("/board/write.do")
	public String write() {
		return "/board/write";
	}
	
	@PostMapping("/board/insert.do")
	public String insert(BoardVO vo, Model model, @RequestParam MultipartFile filename, HttpServletRequest req) {
		// 첨부 파일 처리
		if(!filename.isEmpty()) {
			// 파일명 
			String org = filename.getOriginalFilename();
			String ext = org.substring(org.lastIndexOf(".")); 	// 확장자 
			String real = new Date().getTime()+ext;
			
			// 파일 저장
			String path = req.getRealPath("/upload/");
			try {
			filename.transferTo(new File(path+real));
			} catch (Exception e) {}
			
			vo.setFilename_org(org);
			vo.setFilename_real(real);
		}
		// member_no 저장
		//// 게시판 등록할 때 member_no 넣어주는 방법
		HttpSession sess = req.getSession();
		UserVO mv = (UserVO)sess.getAttribute("loginInfo");
		vo.setMember_no(mv.getUser_no());
		if (service.insert(vo)) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장에 실패하였습니다.");
			return "common/alert";
		}
	}
	
	@GetMapping("/board/view.do")
	public String view(BoardVO vo, Model model) {
		BoardVO data = service.view(vo.getNo());
		model.addAttribute("data", data);
		return "board/view";
	}
	
	@GetMapping("/board/edit.do")
	public String edit(BoardVO vo, Model model) {
		BoardVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "board/edit";
	}
	
	@PostMapping("/board/update.do")
	public String update(BoardVO vo, Model model) {
		if (service.update(vo)) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "view.do?no="+vo.getNo());
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 실패");
			return "common/alert";
		}
	}
	
	
	@GetMapping("/board/delete.do")
	public String delete(BoardVO vo, Model model) {
		if (service.delete(vo.getNo())) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제 실패");
			return "common/alert";
		}
	}
	
	@GetMapping("/board/admin.do")
	public String admin() {
		return "/board/admin";
	}
	
	@GetMapping("/board/gd.do")
	public String gd() {
		return "/board/gd";
	}

}
