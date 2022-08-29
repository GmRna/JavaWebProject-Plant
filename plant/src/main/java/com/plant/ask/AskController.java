package com.plant.ask;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.plant.member.MemberVO;

@Controller
public class AskController {
	
	@Autowired
	AskService service;
	
	@GetMapping("/ask/index.do")
	public String index(Model model, AskVO vo) {							//index는 service.index(vo) / view는 getAsk_no
		model.addAttribute("data", service.index(vo));
		
		return "/plant/ask/index";
	}
	
	@GetMapping("/ask/view.do")
	public String view(Model model, AskVO vo) {
		
		AskVO data = service.view(vo.getAsk_no());
		model.addAttribute("data", data);
		
		return "/plant/ask/view";
	}
	
	@GetMapping("/ask/write.do")
	public String write() {
		return "/plant/ask/write";
	}
	
	@PostMapping("/ask/insert.do")
	public String insert(AskVO vo, Model model,
			@RequestParam MultipartFile filename,
			HttpServletRequest req) {
		
		// 첨부파일 처리
				if (!filename.isEmpty()) {
					// 파일명 구하기
					String org = filename.getOriginalFilename();
					String ext = org.substring(org.lastIndexOf(".")); // 확장자
					String real = new Date().getTime()+ext;
					
					// 파일저장
					String path = req.getRealPath("/upload/");
					try {
					filename.transferTo(new File(path+real));
					} catch (Exception e) {}
					
					vo.setFilename_org(org);
					vo.setFilename_real(real);
				}
				HttpSession sess = req.getSession();
				MemberVO mv = (MemberVO)sess.getAttribute("loginInfo");
				
				vo.setUser_no(mv.getNo());
				
				if(service.insert(vo)) {
					model.addAttribute("msg", "저장되었습니다.");
					model.addAttribute("url", "index.do");

					return "common/alert";

				} else {
					
					model.addAttribute("msg", "저장에 실패하였습니다.");
					return "common/alert";
					
				}
			}
		@GetMapping("/ask/edit.do")
		public String edit(AskVO vo, Model model) {
			AskVO data = service.edit(vo.getAsk_no());
			
			model.addAttribute("data", data);
			return "/plant/ask/edit";
			
		}
		
		@PostMapping("/ask/update.do")
		public String update(AskVO vo, Model model) {
			
			if(service.update(vo)) {												// service.update(vo) 의미 service.update에 vo 내용이 들어있으면?
				model.addAttribute("msg", "수정완료");
				model.addAttribute("url", "view.do?ask_no="+vo.getAsk_no());
				
				return "common/alert";
			} else {
				model.addAttribute("msg", "수정실패");
				return "common/alert";
				
			}
			
		}
		@GetMapping("/ask/delete.do")
		public String delete(AskVO vo, Model model) {
			
			if(service.delete(vo.getAsk_no())){
				model.addAttribute("msg", "정상적으로 삭제되었습니다.");
				model.addAttribute("url", "index.do");
				return "common/alert";
			} else {
				model.addAttribute("msg", "삭제실패");
				return "common/alert";
			}
		}
	}
	