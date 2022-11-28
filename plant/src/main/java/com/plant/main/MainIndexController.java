package com.plant.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MainIndexController {
	
	@GetMapping("/")
	public String mainIndex () { 
		return "main/main";
	}

}



