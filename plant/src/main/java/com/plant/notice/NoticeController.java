package com.plant.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService service;
	
	@GetMapping("/notice/index.do")
	public String index(Model model, NoticeVO vo) {
		model.addAttribute("data", service.index(vo));
	
		return "/plant/notice/index";
	}
	
	
	@GetMapping("/notice/write.do")
	public String write() {
		
		return "/plant/notice/write";
	}
	@PostMapping("/notice/write.do")
	public String insert(NoticeVO vo, Model model) {
		//System.out.println("타이틀 : " + vo.getNotice_title());
		if (service.insert(vo)) {
			model.addAttribute("msg", "저장완료");
			model.addAttribute("url", "index.do");
			
			return "common/alert";
		} else {
			model.addAttribute("msg", "저장실패");
			
			return "common/alert";
		}
		
	}
	
	@GetMapping("/notice/view.do")
	public String view(NoticeVO vo, Model model) {
		
		NoticeVO data = service.view(vo.getNotice_no());
		model.addAttribute("data", data);
		return "/plant/notice/view";
	}
	
	@GetMapping("/notice/edit.do")
	public String edit(NoticeVO vo, Model model) {
		
		NoticeVO data = service.edit(vo.getNotice_no());
		model.addAttribute("data", data);
		return "/plant/notice/edit";
	}
	
	@PostMapping("/notice/update.do")
	public String update(NoticeVO vo, Model model) {
		if(service.update(vo)) {
			model.addAttribute("msg", "수정완료");
			model.addAttribute("url", "view.do?notice_no="+vo.getNotice_no());
			return "common/alert";
		} else {
			model.addAttribute("msg", "수정실패");
			return "common/alert";
					
		}
	}
	
	@GetMapping("/notice/delete.do")
	public String delete(NoticeVO vo, Model model) {
		if(service.delete(vo.getNotice_no())) {
		
		model.addAttribute("msg", "삭제되었습니다.");
		model.addAttribute("url", "index.do");
		return "common/alert";
	} else {
		model.addAttribute("msg", "삭제실패");
		return "common/alert";
	}
}
		
}
	

