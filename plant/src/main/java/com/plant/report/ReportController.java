package com.plant.report;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.plant.user.UserVO;

@Controller
public class ReportController {
	
	@Autowired
	ReportService service;
	
	@GetMapping("/plant/report.do")
	public String report (Model model, ReportVO vo , HttpServletRequest req
			, @RequestParam(name="report_tablename") String report_tablename
			, @RequestParam(name="board_no") int board_no
			) {
		
		// 신고 한 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginInfo");
		
		if(user == null) {
			model.addAttribute("msg", "로그인 후 이용해 주십시오 reportcontroller");
			model.addAttribute("url", "/plant/user/login.do");
			return "common/alert";
		}	
		
		vo.setUser_no(user.getUser_no());
		vo.setReport_tablename(report_tablename);
		vo.setBoard_no(board_no);
		
		model.addAttribute("reportList" , vo);
		
		return "common/report";
	}
	
	@PostMapping("/plant/report.do")
	public String addreport (Model model, ReportVO vo) {
		
		
		
		
		if (service.insert(vo) > 0) {
			model.addAttribute("msg", "신고 완료 되었습니다.");
			return "common/alert";
		} else {
			model.addAttribute("msg", "신고 오류");
			return "common/alert";
		}
	}
	
}
