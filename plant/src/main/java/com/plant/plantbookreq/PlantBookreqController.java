package com.plant.plantbookreq;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.introspect.TypeResolutionContext.Empty;
import com.plant.admin.AdminVO;
import com.plant.user.UserVO;

@Controller
public class PlantBookreqController {
	
	@Autowired
	PlantBookreqService service;
	
	
	//식물 도감 요청 게시판 리스트
	@GetMapping("/plantbookreq/listBookreq.do")
	public String pbreqList(PlantBookreqVO vo , Model model) {
		model.addAttribute("reqlist", service.listBookreq(vo));
		return "plant/plantbookreq/plantBookreqlist";
	}
	
	// 식물 도감 요청 - 작성자 작성
	@GetMapping("/plantbookreq/writeBookreq.do")
	public String pbreqwrite() {
		return "plant/plantbookreq/plantBookreqwrite";
	}
	// 식물 도감 요청 - 작성자 디테일
	@GetMapping("/plantbookreq/viewBookreq.do")
	public String pbreqview(PlantBookreqVO vo , Model model) {
		model.addAttribute("reqlist", service.viewBookreq(vo));
		return "plant/plantbookreq/plantBookreqview";
	}
	
	// 식물 도감 요청 - 관리자 답변 폼
	@GetMapping("/plantbookreq/adminreplyBookreq.do")
	public String adminreplyBookreq(PlantBookreqVO vo , Model model) {
		System.out.println("vo : "+vo.getPbreq_no());
		model.addAttribute("reqlist", service.viewBookreq(vo));
		return "plant/plantbookreq/plantBookreqwriteAdmin";
	}
	

	@PostMapping("/plantbookreq/insertBookreq.do")
	public String insert (PlantBookreqVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
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
		
		if(user != null) {
			vo.setUser_no(user.getUser_no());
		}
		
		int no = service.insertBookreq(vo);
		if(no > 0) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "listBookreq.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패.");
			return "common/alert";
		}
	}
	
	// 식물 도감 요청 - 관리자 답변 작성
	@PostMapping("/plantbookreq/insertAdminBookreq.do")
	public String insertAdmin (PlantBookreqVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		
		vo.setPbreq_gno(vo.getPbreq_no());
		
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
		
		int adno = service.insertadmin(vo);
		
		if(adno > 0) {
			model.addAttribute("msg", "정상적으로 답변이 저장되었습니다.");
			model.addAttribute("url", "listBookreq.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패.");
			return "common/alert";
		}
	}
	
}
