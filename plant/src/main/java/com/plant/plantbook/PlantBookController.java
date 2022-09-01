package com.plant.plantbook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PlantBookController {
	
	@GetMapping("/plant/plantbook.do")
	public String main () {
		return "plant/plantbook/plantbook";
	}
	@GetMapping("/plant/plantbook3.do")
	public String main3 () {
		return "plant/plantbook/plantbook2";
	}

	@GetMapping("/plant/plantbook2.do")
	public String main2 () {
		return "plant/plantbook/ajax_local_callback";
	}
	
	/*
	 * @GetMapping("/plant/plantbook3.do") public String main3 () { return
	 * "plant/plantbook/varietyList"; }
	 */
}
