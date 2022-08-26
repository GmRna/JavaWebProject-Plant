package com.plant.freecomment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FreeCommentController{
	
	@Autowired
	FreeCommentService service;
	
	@GetMapping("/freecomment/list.do")
	public String list(FreeCommentVO vo, Model model) {
		model.addAttribute("freecomment", service.index(vo));
		
		return "common/freecomment";
	}
	@GetMapping("/freecomment/insert.do")
	public String insert(FreeCommentVO vo, Model model) {
		model.addAttribute("result", service.insert(vo));
		
		return "common/return";
	}
	@GetMapping("/freecomment/delete.do")
	public String delete(FreeCommentVO vo, Model model) {
		model.addAttribute("result", service.delete(vo));
		
		return "common/return";
	}
	
}