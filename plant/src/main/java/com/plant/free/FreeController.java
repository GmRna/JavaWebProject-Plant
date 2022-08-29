package com.plant.free;

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

import com.plant.freecomment.FreeCommentService;
import com.plant.member.MemberVO;

@Controller
public class FreeController {
	
	@Autowired
	FreeService service;
	
	@Autowired
	FreeCommentService fcservice;
	
	@GetMapping("/free/index.do")
	public String index(Model model, FreeVO vo) {
		model.addAttribute("data", service.index(vo));
		
		return "/plant/free/index";
	}
	
	@GetMapping("/free/write.do")
	public String write() {
		
		return "/plant/free/write";
	}
	@PostMapping("/free/write.do")
	public String insert(FreeVO vo, Model model) {
		//System.out.println("타이틀 : " + vo.getfree_title());
		if (service.insert(vo)) {
			model.addAttribute("msg", "저장완료");
			model.addAttribute("url", "index.do");
			
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장실패");
			
			return "common/alert";
		}
		
	}
	
	@PostMapping("/free/insert.do")
	public String insert(FreeVO vo, Model model,
			@RequestParam MultipartFile filename,
			HttpServletRequest req) {
		
		// 첨부파일 처리
		if (!filename.isEmpty()) {
			// 파일명 구하기
			String org = filename.getOriginalFilename();
			String ext = org.substring(org.lastIndexOf(".")); // 확장자
			String real = new Date().getTime()+ext;
			
			// 파일저장
			String path = req.getRealPath("/upload/");
			try {
			filename.transferTo(new File(path+real));
			} catch (Exception e) {}
			
			vo.setFree_filenameorg(org);
			vo.setFree_filenamereal(real);
		}
		HttpSession sess = req.getSession();
		MemberVO mv = (MemberVO)sess.getAttribute("loginInfo");
		
		vo.setUser_no(mv.getNo());
		
		if(service.insert(vo)) {
			model.addAttribute("msg", "저장되었습니다.");
			model.addAttribute("url", "index.do");

			return "common/alert";

		} else {
			
			model.addAttribute("msg", "저장에 실패하였습니다.");
			return "common/alert";
			
		}
	}
		
	@GetMapping("/free/view.do")
	public String view(FreeVO vo, Model model) {
		FreeVO data = service.view(vo.getFree_no());
		model.addAttribute("data", data);
		
		return "/plant/free/view";
	}
	
	@GetMapping("/free/edit.do")
	public String edit(FreeVO vo, Model model) {
		FreeVO data = service.edit(vo.getFree_no());
		model.addAttribute("data", data);
		
		return "/plant/free/edit";
	}
	@PostMapping("/free/update.do")
	public String update(FreeVO vo, Model model) {
		if(service.update(vo)) {
			model.addAttribute("msg", "수정완료");
			model.addAttribute("url", "view.do?free_no="+vo.getFree_no());
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정실패");
			return "common/alert";
					
		}
	}
	@GetMapping("/free/delete.do")
	public String delete(FreeVO vo, Model model) {
		if (service.delete(vo.getFree_no())) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제실패");
			return "common/alert";
		}
	}
}


