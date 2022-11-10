package com.plant.plantbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.plant.user.UserVO;

@Controller
public class PlantBookController {
	
	@Autowired
	PlantBookService service;
	
	@GetMapping("/plantbook/plantbook.do")
	public String main () {
		return "plant/plantbook/plantbook";
	}
	@GetMapping("/plantbook/plantbook2.do")
	public String main2 () {
		return "plant/plantbook/ajax_local_callback";
	}
	
	
	
	@GetMapping("/plantbook/main.do")
	public String bookmain() {
		return "plant/plantbook/plantbookmain";
	}
	
	
	@GetMapping("/plantbook/search.do")
	public String search(PlantBookVO vo, @RequestParam String sword , Model model) {
		vo.setSword(sword);
		model.addAttribute("list", service.searchWord(vo));
		return "plant/plantbook/searchResult";
	}
	
	@GetMapping("/plantbook/plantbookview.do")
	public String view (int no, Model model) {
		model.addAttribute("list" , service.viewbook(no));
		return "plant/plantbook/plantbookview";
	}
	
	
	@PostMapping("/plantbook/checkbook.do")
	@ResponseBody
	public int checkbook (@RequestParam int plantbook_no, HttpServletRequest req, PlantBookVO vo) {
		int data = 0;
		
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		if (user != null) {
			vo.setUser_no(user.getUser_no());
		}
		
		int count = service.checkbook(plantbook_no);
		if (count == 0 ) {
			service.insertbook(plantbook_no);
			data = 1;
			System.out.println("담기"+data);
		}else {
			service.deletebook(plantbook_no);
			data = 0;
			System.out.println("해제"+data);
		}
		return data;
	}
	
}
