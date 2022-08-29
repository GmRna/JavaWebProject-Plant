package com.plant.quest;

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
import com.plant.questcomment.QuestCommentService;

@Controller
public class QuestController {
	
	@Autowired
	QuestService service;
	
	@Autowired
	QuestCommentService qcService;
	
	@GetMapping("/quest/index.do")
	public String index(Model model, QuestVO vo) {
		
		model.addAttribute("data", service.index(vo));
		return "/plant/quest/index";
	}
	
	@GetMapping("quest/write.do")
	public String write() {
		
		return "/plant/quest/write";
	}
	
	@PostMapping("/quest/insert.do")
	public String insert(QuestVO vo, Model model,
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
			
			vo.setQuest_filenameorg(org);
			vo.setQuest_filenamereal(real);
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
	
	@GetMapping("/quest/view.do")
	public String view(QuestVO vo,Model model ) {
		
		QuestVO data = service.view(vo.getQuest_no());
		model.addAttribute("data", data);
		return "/plant/quest/view";
		
	}
	
	@PostMapping("/quest/update.do")
	public String update(QuestVO vo, Model model) {
		
		if(service.update(vo)) {
		
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "view.do?quest_no="+vo.getQuest_no());
			
			return "common/alert";
			
		} else {
			model.addAttribute("msg", "수정실패");
			return "common/alert";
			
		}
	}
	
	@GetMapping("/quest/edit.do")
	public String edit(QuestVO vo, Model model) {
		QuestVO data = service.edit(vo.getQuest_no());
		model.addAttribute("data", data);
		
		return "/plant/quest/edit";
	}
	
	@GetMapping("/quest/delete.do")
	public String delete(QuestVO vo, Model model) {
		if(service.delete(vo.getQuest_no())) {
			
			model.addAttribute("msg", "삭제되었습니다.");
			model.addAttribute("url", "index.do");
			
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제실패");
			return "common/alert";
			
		}
	}


}
	


