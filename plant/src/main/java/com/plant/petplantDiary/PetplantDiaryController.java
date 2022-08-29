package com.plant.petplantDiary;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.plant.plantbookreq.PlantBookreqService;
import com.plant.plantbookreq.PlantBookreqVO;
import com.plant.user.UserVO;

@Controller
public class PetplantDiaryController {

	@Autowired
	PetplantDiaryService service;
	
	// 반려식물 관찰일지 - 쓰기
	@GetMapping("/petplantDiary/writeDiary.do")
	public String write () {
		return "plant/petplantDiary/petplantDiarywrite";
	}
	
	// 반려식물 관찰일지 - 등록된 반려식물 데이터 가져오기
	@PostMapping(value="/petplantDiary/userplant.do" ,  produces = "application/json; charset=utf8")
	@ResponseBody
	public PetplantDiaryVO userplant (PetplantDiaryVO vo , HttpServletRequest req) {
		
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");

		vo.setUser_no(user.getUser_no());
		
		PetplantDiaryVO plant = service.userplant(vo.getUser_no());
		
		return plant;
	}
	
	@PostMapping("/petplantDiary/insertDiary.do")
	public String insert (PetplantDiaryVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		if(!file.isEmpty()) {
			String fileorg = file.getOriginalFilename();
			String fileext = fileorg.substring(fileorg.lastIndexOf("."));
			String filereal = new Date().getTime()+fileext;
			
			String path = req.getRealPath("/upload");
			
			try {
				System.out.println("파일저장");
				file.transferTo(new File(path+filereal));
			
			} catch (Exception e) {
				System.out.println("파일 저장 실패" + e);
			}
			
			vo.setFilename_org(fileorg);
			vo.setFilename_real(filereal);
		}
		
		if(service.insertDiary(vo) == 1) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "listDiary.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패.");
			return "common/alert";
		}
		
	}
}
