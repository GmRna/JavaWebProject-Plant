package com.plant.questreply;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.plant.questcomment.QuestCommentService;

@Controller
public class QuestReplyController {

	@Autowired
	QuestReplyService service;

	@Autowired
	QuestCommentService cService;
	
	@GetMapping("/questreply/index.do")
	public String index(Model model, QuestReplyVO vo) {
		return "questreply/index";
	}
	
	@GetMapping("/questreply/write.do")
	public String write() {
		return "questreply/write";
	}

	
	@PostMapping("/questreply/insert.do")
	public String insert(QuestReplyVO vo, Model model,
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
		
		if(service.insert(vo)) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "index.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장이 실패했습니다.");
			return "common/alert";
		}
	}
	@GetMapping("/questreply/reply.do")
	public String reply(QuestReplyVO vo, Model model) {
		QuestReplyVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		return "questreply/reply";
	}
	
		@PostMapping("/questreply/reply.do")
		public String reply(QuestReplyVO vo, Model model, 
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
			
			if (service.reply(vo)) {
				model.addAttribute("msg", "정상적으로 저장되었습니다.");
				model.addAttribute("url", "index.do");
				return "common/alert";
			} else {
				model.addAttribute("msg", "저장이 실패했습니다.");
				return "common/alert";
			}
		}
		
	@GetMapping("/questreply/view.do")
	public String view(QuestReplyVO vo, Model model) {
		QuestReplyVO data = service.view(vo.getNo());
		model.addAttribute("data", data);
		
		return "questreply/view";
		
	}
	
	@GetMapping("/questreply/edit.do")
	public String edit(QuestReplyVO vo, Model model) {
		QuestReplyVO data = service.edit(vo.getNo());
		model.addAttribute("data", data);
		
		return "questreply/edit";
	}
	
	@PostMapping("/questreply/update.do")
	public String update(QuestReplyVO vo, Model model) {
		
		if(service.update(vo)) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "view.do?no="+vo.getNo());
			
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정 실패");
			return "common/alert";
			
		}
	}
	
	@GetMapping("/questreply/delete.do")
	public String delete(QuestReplyVO vo, Model model) {
		if(service.delete(vo.getNo())) {
	
		model.addAttribute("msg", "삭제되었습니다.");
		model.addAttribute("url", "index.do");
		return "common/alert";
		
	} else {
	
		model.addAttribute("msg", "삭제 실패");
		return "common/alert";
		
		
	}
	
}
}

