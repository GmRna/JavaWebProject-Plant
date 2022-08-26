package com.plant.questcomment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class QuestCommentController {
	
	@Autowired
	QuestCommentService service;
	
	@GetMapping("/questcomment/list.do")
	public String list(QuestCommentVO vo, Model model) {
		model.addAttribute("questcomment", service.index(vo));
		
		return "common/questcomment";
		
	}

	@GetMapping("/questcomment/insert.do")
	public String insert(QuestCommentVO vo, Model model) {
		model.addAttribute("result", service.insert(vo));
		return "common/return";
		
	}
	@GetMapping("/questcomment/delete.do")
	public String delete(QuestCommentVO vo, Model model) {
		model.addAttribute("result", service.delete(vo));
		return "common/return";
		
	}
	
	
	
}