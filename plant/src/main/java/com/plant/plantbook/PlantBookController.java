package com.plant.plantbook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PlantBookController {
	
	@GetMapping("/plantbook/plantbook.do")
	public String main () {
		return "plant/plantbook/plantbook";
	}
	
	@GetMapping("/plantbook/search.do")
	public String search() {
		return "plant/plantbook/search";
	}
	
	
	@GetMapping("/plantbook/plantbook3.do")
	public String main3 () {
		return "plant/plantbook/plantbook2";
	}

	@GetMapping("/plantbook/plantbook2.do")
	public String main2 () {
		return "plant/plantbook/ajax_local_callback";
	}
	
	/*
	 * @GetMapping("/plant/plantbook3.do") public String main3 () { return
	 * "plant/plantbook/varietyList"; }
	 */
}
