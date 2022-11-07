package com.plant.plantType;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.plant.petplantDiary.PetplantDiaryVO;

@Controller
public class PlantTypeController {

	@Autowired
	PlantTypeService service;
	
	// 품종 대분류  
	@GetMapping("/plantType/plantStypeF.do")
	public String plantStypeF (Model model , @RequestParam String stype, HttpServletRequest req) {
		model.addAttribute("stype", service.plantStypeF(stype));
		model.addAttribute("msg", "대분류");
		return "common/plantType";
	}
	
	// 품종 소분류 -> 선택
	@GetMapping("/plantType/plantStypeF2.do")
	public String plantStypeS (Model model , @RequestParam String stype,HttpServletRequest req) {
		model.addAttribute("stype", service.plantStypeS(stype));
		model.addAttribute("msg", "소분류");
		return "common/plantType";
	}
}
