package com.plant.reserve;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReserveController {

	@Autowired
	ReserveService service;
	 
	// 가드너 검색 사이트
	@GetMapping("/reserve/searchGardener.do")
	public String searchGdGet(Model model, ReserveVO vo) {
		model.addAttribute("major", service.majorList(vo)); // 케어종목 리스트 조회
	return "plant/reserve/searchGardener";
	}
	
	// 프로필 카드
	@GetMapping("/reserve/profileCard.do")
	public String profileCard(Model model, ReserveVO vo) {
		List<ReserveVO> list = service.searchGd(vo); // 가드너 검색
		model.addAttribute("profile", list); 
		return "plant/reserve/profileCard";
	}
	
	// 대표후기 및 예약시간 가져오기
	@GetMapping("/reserve/riviewAndReservable.do")
	public String riviewAndReservable(Model model, ReserveVO vo) {
		List<ReserveVO> list = service.searchGdReview(vo); // 가드너 리뷰 조회
		model.addAttribute("review", list); 
		model.addAttribute("reservable", service.searchGdReservable(vo)); // 가드너 예약시간 가져오기
		return "plant/reserve/riviewAndReservable";
	}
	
	// 가드너 상세보기
	@GetMapping("/reserve/profileView.do")
	public String profileView(Model model, ReserveVO vo) {
		model.addAttribute("data", service.viewGd(vo)); // 가드너 상세 정보 조회
		model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
		return "plant/reserve/profileView";
	}
	
}
