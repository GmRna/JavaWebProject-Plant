package com.plant.askreply;

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

import com.plant.member.MemberVO;


@Controller
public class AskReplyController {
	
	@Autowired
	AskReplyService service;
	
	@GetMapping("/askreply/index.do")
	public String index(Model model, AskReplyVO vo) {
		model.addAttribute("data", service.index(vo));
		
		return "/plant/askreply/index";
	}
	
	@GetMapping("/askreply/write.do")
	public String write() {
		return "/plant/askreply/write";
	}
	
	@PostMapping("/askreply/insert.do")
	public String insert(Model model, AskReplyVO vo,
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
					
					vo.setFilename_org(org);
					vo.setFilename_real(real);
				}
		HttpSession sess = req.getSession();
		MemberVO mv = (MemberVO)sess.getAttribute("logininfo");
		if(mv != null) vo.setUser_no(mv.getNo());
		
		if(service.insert(vo)) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
	} else {
		model.addAttribute("msg", "저장 실패");
		return "common/alert";
		
	}
}
	
	@GetMapping("/askreply/edit.do")
	public String edit(Model model, AskReplyVO vo) {
		AskReplyVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "/plant/askreply/edit";
	}
	
	@PostMapping("/askreply/update.do")
	public String update(Model model, AskReplyVO vo) {
		if(service.update(vo)) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "/plant/askreply/index.do");	
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 실패");
			return "common/alert";
			
		}
	}
	@GetMapping("/askreply/reply.do")
	public String reply(AskReplyVO vo, Model model) {
		AskReplyVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "/plant/askreply/reply";
	}
	
	@PostMapping("/askreply/reply.do")
	public String reply(AskReplyVO vo, Model model, 
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
			
			vo.setFilename_org(org);
			vo.setFilename_real(real);
		}
		// member_no 저장
		HttpSession sess = req.getSession();
		MemberVO mv = (MemberVO)sess.getAttribute("loginInfo");
		if (mv != null) vo.setUser_no(mv.getNo());
		if (service.reply(vo)) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장이 실패했습니다.");
			return "common/alert";
		}
	}
	
	
	@GetMapping("/askreply/view.do")
	public String view(Model model, AskReplyVO vo) {
		AskReplyVO data = service.view(vo.getNo());
		model.addAttribute("data", data);
		return "/plant/askreply/view";
	}
	
	@GetMapping("/askreply/delete.do")
	public String delete(Model model, AskReplyVO vo) {
		if(service.delete(vo.getNo())) {
			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "askreply/index.do");	
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제 실패");
			return "common/alert";
		}
	}
}
