package com.plant.petplant;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.plant.user.UserVO;


@Controller
public class PetplantController {

	
	@Autowired
	PetplantService service;
	
	// 반려 식물 게시판 등록폼
	@GetMapping("/plant/write.do")
	public String plantwrite() {
		return "plant/petplant/write";
	}
	 @GetMapping("/plant/in.do") 
	 public String plantwrite2() { 
		 return "plant/petplant/instagram";  
	}
	
	 @GetMapping("/plant/in2.do") 
	 public String plantwrite3() { 
		 return "plant/petplant/instagram2";  
	}
	
	
	// 반려 게시판 전체 리스트 
	@RequestMapping("/plant/list.do")
	public String petPlantList(Model model, PetplantVO vo,  HttpServletRequest req) throws Exception {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		if (user != null) {
			vo.setUser_no(user.getUser_no());
			System.out.println("@@@@@@@@@@  " + vo.getUser_no());
		}

		model.addAttribute("list", service.list(vo));

		return "plant/petplant/list";
	}
	
	// 반려식물 검색기능 
	@GetMapping("/plant/searchpet.do")
	public String searchpet (@RequestParam String sword , Model model, HttpServletRequest req , PetplantVO vo) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		if (user != null) {
			vo.setUser_no(user.getUser_no());
			System.out.println("@@@@@@@@@@  " + vo.getUser_no());
		}
		
		vo.setSword(sword);
		model.addAttribute("list", service.searchpet(vo));
		
		return "plant/petplant/list";
	}
	
	// 반려 식물 게시판 저장 (다중첨부파일)
	@PostMapping("/plant/insert.do")
	@ResponseBody
	public int plantinsert(PetplantVO vo, MultipartHttpServletRequest  mhsq , Model model, HttpServletRequest req
		) throws IllegalStateException, IOException {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());

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
	
	// 반려 식물 게시판 업데이트 (다중첨부파일)
	@PostMapping("/plant/update.do")
	@ResponseBody
	public int plantupdate(PetplantVO vo, MultipartHttpServletRequest  mhsq , Model model, HttpServletRequest req
		) throws IllegalStateException, IOException {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());

		int no = service.update(vo);
		
		vo.setFile_boardno(vo.getPet_no());
		System.out.println("setFile_boardno : "+ vo.getPet_no());
		
		List<MultipartFile> fileMap = mhsq.getFiles("file");
		
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
	
	
	// 반려식물 게시판 사진 삭제 
	@PostMapping("/plant/deletefile.do")
	@ResponseBody
	public int deletefile (Model model, PetplantVO vo, @RequestParam("file_no") int file_no,  @RequestParam("filename_real") String filename_real ) {
		vo.setFile_no(file_no);
		vo.setFilename_real(filename_real);
		System.out.println("@@@@@@@@@@@@@@@  : " + vo.getFile_no() + " : " + vo.getFilename_real());
		
		int no = service.deletefile(vo);
		
		return no;
	}
	
	
	// 반려식물 게시판 수정 - 글 불러오기
	@GetMapping("/plant/editpet.do")
	public String editpetplant(Model model, PetplantVO vo ) {
		PetplantVO plist = service.findpetcontent(vo.getPet_no());
		
		model.addAttribute("flist", service.findFile(vo));
		model.addAttribute("plist", plist);
		
		return "plant/petplant/edit";
	}
	
	
	// 반려식물 게시판 수정 - 파일 불러오기 
	@RequestMapping("/plant/findFile.do")
	@ResponseBody
	public Map findFile (Model model, PetplantVO vo, HttpServletRequest req) {
		Map map = new HashMap();
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		System.out.println("pet_no 이랑 넘어오니? : " + vo.getPet_no());
		
		if(user != null) {
			vo.setUser_no(user.getUser_no());
		}
		
		map.put("flist", service.findFile(vo));
		
		return map;	
	}
	
	
	
	// 반려식물 게시판 상세보기 
	@GetMapping("/plant/findpetplant.do")
	public String findpetfile (Model model, PetplantVO vo,  HttpServletRequest req) {
		// 유저번호 set 해주면 user_no 똑같아 져서 새로 vo 추가해서 set해줌
		
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		if(user != null) {
			vo.setUser_no(user.getUser_no());
		}
		model.addAttribute("petboard", service.listpop(vo));
		model.addAttribute("pppcheck", service.selectsavepetplant(vo));
		model.addAttribute("list",service.findpetfile(vo));
	
		//Map map = new HashMap();
		//map.put("list", service.findpetfile(vo));
		
		return "plant/petplant/petplantpopup";
	}
	
	// 댓글 저장
	@PostMapping("/plant/insertReply.do")
	public String reply(PetplantVO vo , Model model, HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
				
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
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		model.addAttribute("comment", service.rereply(vo));
		return "common/return";
	}
	
	
	
	
	// 좋아요 체크 후 더하거나 빼기 
	@PostMapping("/plant/checkLike.do")
	@ResponseBody
	public int checkLike(PetplantVO vo, @RequestParam(name="no") int no, HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		
		vo.setUser_no(user.getUser_no());
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
	public int checkLikeReply(PetplantVO vo
			,HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		int like = service.checkLikeReply(vo);
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
	
	// 댓글, 답글 삭제
	@PostMapping("/plant/delreply.do")
	public String delreply (Model model, PetplantVO vo) {
		model.addAttribute("rlist", service.delreply(vo));
		return "common/return";
	}
	// 댓글, 답글 수정
	@PostMapping("/plant/modreply.do")
	public String modreply (Model model, PetplantVO vo) {
		model.addAttribute("rlist", service.modreply(vo));
		return "common/return";
	}
	
	
	// 반려식물 게시물 저장 (담기)
	@PostMapping("/plant/savepetplant.do")
	@ResponseBody
	public int savepetplant (Model model, PetplantVO vo ,HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		vo.setUser_no(user.getUser_no());
		
		int no = service.selectsavepetplant(vo);
		
		if(no == 0) {
			service.pluspetplant(vo);
			no = 1;
		} else {
			service.minuspetplant(vo);
			no = 2;
		}
		System.out.println("no : " + no);
		return no;
	}
	
}
