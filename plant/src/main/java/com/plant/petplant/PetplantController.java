package com.plant.petplant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PetplantController {

	
	@Autowired
	PetplantService service;
	
	@GetMapping("/plant/write.do")
	public String plantwrite() {
		return "plant/write";
	}
	
	
	@GetMapping("/plant/list.do")
	public String petPlantList(Model model, PetplantVO vo) {
		model.addAttribute("list", service.list(vo));
		
		return "plant/list";
	}
}
