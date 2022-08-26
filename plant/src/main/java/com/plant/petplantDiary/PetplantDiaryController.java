package com.plant.petplantDiary;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.plant.plantbookreq.PlantBookreqService;
import com.plant.user.UserVO;

@Controller
public class PetplantDiaryController {

	@Autowired
	PetplantDiaryService service;
	
	@GetMapping("/petplantDiary/writeDiary.do")
	public String write () {
		return "plant/petplantDiary/petplantDiarywrite";
	}
	
	@PostMapping(value="/petplantDiary/userplant.do" ,  produces = "application/json; charset=utf8")
	@ResponseBody
	public PetplantDiaryVO userplant (PetplantDiaryVO vo , HttpServletRequest req) {
		
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginInfo");

		vo.setUser_no(user.getUser_no());
		
		PetplantDiaryVO plant = service.userplant(vo.getUser_no());
		
		return plant;
	}
}
