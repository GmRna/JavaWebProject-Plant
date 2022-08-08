package com.plant.reserve;

import java.time.LocalDate;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReserveController {

	@Autowired
	ReserveService service;
	 
	// 가드너 검색
	@GetMapping("/reserve/searchGardener.do")
	public String searchGd(Model model, ReserveVO vo) {
		model.addAttribute("data", service.searchGd(vo)); // 가드너 검색
		model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
		model.addAttribute("major", service.majorList(vo)); // 케어종목 리스트 조회
	return "plant/reserve/searchGardener";
	}
	
	// 
	
}
