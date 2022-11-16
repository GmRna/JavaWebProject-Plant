package com.plant.questcomment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.plant.user.UserVO;


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
	public String insert(QuestCommentVO vo, Model model, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		if(user != null) {
			vo.setUser_no(user.getUser_no());
		}
		
		model.addAttribute("result", service.insert(vo));
		return "common/return";
		
	}
	@GetMapping("/questcomment/delete.do")
	public String delete(QuestCommentVO vo, Model model) {
		model.addAttribute("result", service.delete(vo));
		return "common/return";
		
	}
	
	
	
}