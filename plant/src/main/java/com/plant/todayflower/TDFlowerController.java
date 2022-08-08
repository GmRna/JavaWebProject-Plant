package com.plant.todayflower;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TDFlowerController {

	@Autowired
	TDFlowerService service;
	
	// 오늘의 꽃 배너
	@GetMapping("/todayFlower.do")
	public String todayflower(Model model, TDFlowerVO vo) {
		// 지역 날짜 조회
		LocalDate now = LocalDate.now();
		// 지역 월,일 조회
//		int month = now.getMonthValue();
//		int day = now.getDayOfMonth();
		
		// 테스트
		int month = 1;
		int day = 1;
		
		// vo에 저장
		vo.setTf_month(month);
		vo.setTf_day(day);
		// model에 저장
		model.addAttribute("data", service.select(vo));
	
		return "plant/todayFlower";
	}
	
	// 오늘의 꽃 상세보기
	@GetMapping("/todayFlowerView.do")
	public String todayflowerView(Model model, TDFlowerVO vo) {
		// 지역 날짜 조회
		LocalDate now = LocalDate.now();
		// 지역 월,일 조회
//		int month = now.getMonthValue();
//		int day = now.getDayOfMonth();
		
		// 테스트
		int month = 1;
		int day = 1;
		
		// vo에 저장
		vo.setTf_month(month);
		vo.setTf_day(day);
		// model에 저장
		model.addAttribute("data", service.select(vo));
	
		return "plant/todayFlowerView";
	}
	
	
}
