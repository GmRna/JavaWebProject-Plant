package com.plant.freecomment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.plant.user.UserVO;



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
	public String insert(FreeCommentVO vo, Model model,
			HttpServletRequest req) {
		HttpSession sess = req.getSession();
		UserVO mv = (UserVO)sess.getAttribute("loginUserInfo");
		
		if(mv != null) vo.setUser_no(mv.getUser_no());
		
		model.addAttribute("result", service.insert(vo));
		
		return "common/return";
	}
	@GetMapping("/freecomment/delete.do")
	public String delete(FreeCommentVO vo, Model model) {
		model.addAttribute("result", service.delete(vo));
		
		return "common/return";
	}
	
}