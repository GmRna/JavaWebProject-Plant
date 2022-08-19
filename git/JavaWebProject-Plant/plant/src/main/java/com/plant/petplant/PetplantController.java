package com.plant.petplant;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
public class PetplantController {

	
	@Autowired
	PetplantService service;
	
	@GetMapping("/plant/write.do")
	public String plantwrite() {
		return "plant/write";
	}
	
	
	@GetMapping("/plant/list123.do")
	public String plantwrite2() {
		return "plant/list";
	}
	
	@GetMapping("/plant/car.do")
	public String car(Model model, PetplantVO vo) {
		model.addAttribute("list", service.list(vo));
		return "plant/list4";
	}
	
	
	// 전체 리스트 
	@RequestMapping("/plant/list.do")
	public String petPlantList(Model model, PetplantVO vo) throws Exception {
		model.addAttribute("list", service.list(vo));
		return "plant/list2";
	}
	
	
	// 반려 식물 게시판 저장 (다중첨부파일)
	@PostMapping("/plant/insert.do")
	@ResponseBody
	public int plantinsert(PetplantVO vo, MultipartHttpServletRequest  mhsq , Model model, HttpServletRequest req
		) throws IllegalStateException, IOException {
		
		int no = service.insert(vo);
		vo.setFile_boardno(no);
		System.out.println("setFile_boardno : "+ no);

		List<MultipartFile> fileMap = mhsq.getFiles("file");
		
		System.out.println("사이즈 : " + fileMap.size() + "String : " + fileMap.toString());
		
		for(int i=0; i<fileMap.size(); i++) {
			
			String org = fileMap.get(i).getOriginalFilename(); 	// 본래 파일명                
			System.out.println("이름 : " + org);
			String ext = org.substring(org.lastIndexOf(".")); // 확장자  구하는거 .jpg 이런거
			String real = new Date().getTime()+ext;	
			
			//파일 저장
			String path = req.getRealPath("/upload/");
			//System.out.println(path);
			
			File file = new File(path+real);
			
			try {
				System.out.println("try");
				fileMap.get(i).transferTo(file);
				//System.out.println("@@@@@@@@   :  "+file);
			} catch (Exception e) {
				System.out.println("저장오류" + e);
			}

			vo.setFilename_org(org);
			vo.setFilename_real(real);
			service.insertfile(vo);
		}
		return no;
	}

	
	// 반려식물 게시판 상세보기 
	@GetMapping("/plant/findpetplant.do")
	@ResponseBody
	public Map findpetplant (Model model, @RequestParam(name="no") int no) {
		Map map = new HashMap();
		map.put("list", service.Detpetplant(no));
		return map; 
	}
	
	// 댓글 저장
	@PostMapping("/plant/insertReply.do")
	public String reply(PetplantVO vo , Model model, HttpServletRequest req) {
		model.addAttribute("comment", service.reply(vo));
		return "common/return";
	}
	// 댓글 답글 저장 후 리로드 
	@GetMapping("/plant/replyload.do")
	@ResponseBody
	public Map replyload (Model model, @RequestParam(name="no") int no) {
		Map map = new HashMap();
		map.put("reply", service.findpetreply(no));
		return map;
	}
		
	// 댓글 답글 저장
	@PostMapping("/plant/insertRereply.do")
	public String rereply(PetplantVO vo , Model model, HttpServletRequest req) {
		model.addAttribute("comment", service.rereply(vo));
		return "common/return";
	}
	
	
	
	
	// 좋아요 체크 후 더하거나 빼기 
	@PostMapping("/plant/checkLike.do")
	@ResponseBody
	public int checkLike(PetplantVO vo, @RequestParam(name="no") int no) {
		vo.setPet_no(no);
		
		int like = service.checkLike(vo);
		
		if (like == 0) {
			service.plustLike(vo);
			like = 1;
		} else {
			service.minusLike(vo);
			like = 2;
		}
		System.out.println("like : " + like);
		return like;
	}
	
	//댓글 좋아요 체크 후 더하거나 빼기 
	@PostMapping("/plant/checkLikeReply.do")
	@ResponseBody
	public int checkLikeReply(PetplantVO vo, @RequestParam(name="no") int no , @RequestParam(name="rno") int rno) {
		vo.setPpreply_no(rno);
		vo.setPet_no(no);
		
		int like = service.checkLike(vo);

		if (like == 0) {
			service.plustLike(vo);
			like = 1;
		} else {
			service.minusLike(vo);
			like = 2;
		}
		System.out.println("like : " + like);
		return like;
	}
	
}