package com.plant.petplantDiary;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
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

import retrofit2.http.POST;

@Controller
public class PetplantDiaryController {

	@Autowired
	PetplantDiaryService service;
	
	
	// 반려식물 관찰일지 - 리스트
	@GetMapping("/petplantDiary/listDiary.do")
	public String petplantDiarylist (PetplantDiaryVO vo, Model model, HttpServletRequest req) {
		// 유저번호 가져오기
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");

		vo.setUser_no(user.getUser_no());
		
		model.addAttribute("diarylist" , service.listDiary(vo));
		
		return "plant/petplantDiary/petplantDiarylist";
	}
	
	
	// 반려식물 관찰일지 - 상세 리스트
	@GetMapping("/petplantDiary/listdetDiary.do")
	public String petplantdetDiarylist (PetplantDiaryVO vo, Model model, HttpServletRequest req) {
		// 유저번호 가져오기
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		vo.setUser_no(user.getUser_no());
		System.out.println("안넘어 오니~" + vo.getDiary_gno() + vo.getUser_plantname());
		
		model.addAttribute("diarylist" , service.listdetDiary(vo));
		
		return "plant/petplantDiary/petplantDiarylistdet";
	}
		
	
	// 반려식물 관찰일지 - 쓰기 폼
	@GetMapping("/petplantDiary/writeDiary.do")
	public String writeDiary () {
		return "plant/petplantDiary/petplantDiarywrite";
	}
	
	// 반려식물 관찰일지 - 쓰기 두번째 쓰기 폼
	@PostMapping("/petplantDiary/writedetDiary.do")
	public String writedetDiary (PetplantDiaryVO vo, Model model) {
		System.out.println("vo : " +vo.getUser_plantname());
		model.addAttribute("vo", vo);
		return "plant/petplantDiary/petplantDiarywritedet";
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
	
/*	
	// 반려식물 관찰일지 - 품종 소분류 
	@PostMapping(value="/petplantDiary/plantStypeF.do" ,  produces = "application/json; charset=utf8")
	@ResponseBody
	public Map plantStypeF (PetplantDiaryVO vo , @RequestParam String stype, HttpServletRequest req) {
		Map map = service.plantStypeF(stype);
		return map;
	}
	
	// 반려식물 관찰일지 - 품종 소분류 -> 선택
	@PostMapping("/petplantDiary/plantStypeF2.do")
	@ResponseBody
	public Map plantStypeS (PetplantDiaryVO vo , @RequestParam String stype,HttpServletRequest req) {
		Map map = service.plantStypeS(stype);
		return map;
	}
*/
	
	// 반려식물 관찰일지 - 첫 저장
	@PostMapping("/petplantDiary/insertDiary.do")
	public String insert (PetplantDiaryVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		if(!file.isEmpty()) {
			String fileorg = file.getOriginalFilename();
			System.out.println("파일 이름 : " + fileorg);
			String fileext = fileorg.substring(fileorg.lastIndexOf("."));
			String filereal = new Date().getTime()+fileext;
			
			String path = req.getRealPath("/upload");
			
			try {
				System.out.println("파일저장");
				file.transferTo(new File(path+filereal));
			
			} catch (Exception e) {
				System.out.println("파일 저장 실패" + e);
			}
			
			vo.setUser_plantfile_org(fileorg);
			vo.setUser_plantfile_real(filereal);
		}
		int no = service.insertDiary(vo);
		
		if(no == 1) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "listDiary.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패.");
			return "common/alert";
		}
	}
	
	
	// 반려식물 관찰일지 - 두번째 
	@PostMapping("/petplantDiary/insertTwoDiary.do")
	public String insertTwo (PetplantDiaryVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		if(!file.isEmpty()) {
			String fileorg = file.getOriginalFilename();
			System.out.println("파일 이름 : " + fileorg);
			String fileext = fileorg.substring(fileorg.lastIndexOf("."));
			String filereal = new Date().getTime()+fileext;
			
			String path = req.getRealPath("/upload");
			
			try {
				System.out.println("파일저장");
				file.transferTo(new File(path+filereal));
			
			} catch (Exception e) {
				System.out.println("파일 저장 실패" + e);
			}
			
			vo.setUser_plantfile_org(fileorg);
			vo.setUser_plantfile_real(filereal);
		}
		
		int no = service.insertTwoDiary(vo);
		
		if(no == 1) {
			model.addAttribute("msg", "정상적으로 저장되었습니다.");
			model.addAttribute("url", "listDiary.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "저장 실패.");
			return "common/alert";
		}
	}
		
	// 반려 식물 관찰일지 - 수정페이지
	@GetMapping("/petplantDiary/editDiary.do")
	public String editDiary (PetplantDiaryVO vo , Model model) {
		
		model.addAttribute("diary", service.editDiary(vo.getDiary_no()));
		return "plant/petplantDiary/petplantDiaryEdit";
	}
	
	// 반려 식물 관찰일지 - 수정
	@PostMapping("/petplantDiary/updateDiary.do")
	public String updateDiary (PetplantDiaryVO vo, Model model, @RequestParam MultipartFile file, HttpServletRequest req) {
		//유저 번호 set 
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		System.out.println("vo = " + vo.getDiary_content() + vo.getDiary_title());
		System.out.println("vo = " + vo.getUser_plantfile_org());
		
		
		if(!file.isEmpty()) {
			String fileorg = file.getOriginalFilename();
			System.out.println("파일 이름 : " + fileorg);
			String fileext = fileorg.substring(fileorg.lastIndexOf("."));
			String filereal = new Date().getTime()+fileext;
			
			String path = req.getRealPath("/upload");
			
			try {
				System.out.println("파일저장");
				file.transferTo(new File(path+filereal));
			
			} catch (Exception e) {
				System.out.println("파일 저장 실패" + e);
			}
			
			vo.setUser_plantfile_org(fileorg);
			vo.setUser_plantfile_real(filereal);
		}
		
		int no = service.updateDiary(vo);
		
		if(no == 1) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "listDiary.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "수정 실패.");
			return "common/alert";
		}
	}
	
	@GetMapping("/petplantDiary/deleteDiary.do")
	public String deleteDiary(int diary_no, Model model) {
		int no = service.deleteDiary(diary_no);
		
		if(no == 1) {
			model.addAttribute("msg", "삭제되었습니다.");
			model.addAttribute("url", "listDiary.do");
			return "common/alert";
		}else {
			model.addAttribute("msg", "삭제 실패.");
			return "common/alert";
		}
	}
	
}
