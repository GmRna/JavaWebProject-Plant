package com.plant.reserve;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.plant.gd.GdVO;
import com.plant.user.UserVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import util.GetToken;

@Controller
public class ReserveController {
	
	//결제 내용 검증 api
	private IamportClient api;
	
	public ReserveController() {
		this.api = new IamportClient("4167546717646634","G1hwWUFVOBmW5o5Ki4ZI0UfAlpZcNvWXLU3lIPg6CV0Ggs2hKK8dILtEJ9k4TwnVnG777wWSh2swl7dP");
	}
	
	@Autowired
	ReserveService service;
	 
	
	// 초기화면
	@GetMapping("/reserve/reserve.do")
	public String reserve(Model model, ReserveVO vo, HttpServletRequest req) {
		// 가드너 번호 set
		HttpSession sess = req.getSession();
		GdVO gd = new GdVO();
		gd = (GdVO) sess.getAttribute("loginGdInfo");
		if(gd == null) {
			model.addAttribute("msg", "가드너로 로그인 해주십시오.");
			model.addAttribute("url", "/plant/gd/login.do");
			return "common/alert";
		} else {
		vo.setGd_no(2);
			model.addAttribute("loginGdInfo", vo); // gd세션값
			return "plant/reserve/reserve";
		}
	}
	
	// 예약서비스 설명
	@GetMapping("/reserve/explainReserve.do")
	public String explainReserve(Model model, ReserveVO vo) {
		return "plant/reserve/explainReserve";
	}
	
	// 가드너 검색 사이트
	@GetMapping("/reserve/searchGardener.do")
	public String searchGdGet(Model model, ReserveVO vo) {
		model.addAttribute("major", service.majorList(vo)); // 케어종목 리스트 조회
		return "plant/reserve/searchGardener";
	}
	
	// 프로필 카드
	@GetMapping("/reserve/profileCard.do")
	public String profileCard(Model model, ReserveVO vo) {
		model.addAttribute("profile", service.searchGd(vo));  // 가드너 검색
		return "plant/reserve/profileCard";
	}
	
	// 대표후기 및 예약시간 가져오기
	@GetMapping("/reserve/riviewAndReservable.do")
	public String riviewAndReservable(Model model, ReserveVO vo) {
		model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
		model.addAttribute("reservable", service.searchGdReservable(vo)); // 가드너 예약시간 조회
		return "plant/reserve/riviewAndReservable";
	}
	
	// 가드너 상세보기
	@GetMapping("/reserve/profileView.do")
	public String profileView(Model model, ReserveVO vo) {
		if(vo.getGd_no() == 0 ) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "common/alert";
		} else {
			model.addAttribute("data", service.viewGd(vo)); // 가드너 상세 정보 조회
			model.addAttribute("certificate", service.selectGdCertificate(vo)); // 가드너 상세 정보 조회
			model.addAttribute("career", service.selectGdCareer(vo)); // 가드너 상세 정보 조회
			model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
			model.addAttribute("reservable", service.searchGdReservable(vo)); // 가드너 예약시간 조회
			model.addAttribute("reserved", service.searchGdReserved(vo)); // 가드너 예약된 내역 조회
			return "plant/reserve/profileView";
		}
	}
	
	// 예약하기
	@GetMapping("/reserve/reservation.do")
	public String reservation(Model model, ReserveVO vo, HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		if(user == null) {
			model.addAttribute("msg", "로그인하셔야 예약 가능합니다. 유저로 로그인 해주세요");
			model.addAttribute("url", "/plant/user/login.do");
			return "common/alert";
		} else if(vo.getGd_no() == 0 ) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "common/alert";
		} else {
			model.addAttribute("data", service.viewGd(vo)); // 가드너 상세 정보 조회
			model.addAttribute("certificate", service.selectGdCertificate(vo)); // 가드너 상세 정보 조회
			model.addAttribute("career", service.selectGdCareer(vo)); // 가드너 상세 정보 조회
			model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
			model.addAttribute("reservable", service.searchGdReservable(vo)); // 가드너 예약시간 조회
			model.addAttribute("reserved", service.searchGdReserved(vo)); // 가드너 예약된 내역 조회
			model.addAttribute("completion", service.completionCount(vo)); // 예약 완료 내역 조회
			model.addAttribute("major", service.majorList(vo)); // 케어종목 리스트 조회
			return "plant/reserve/reservation";
		}
	}
	
	// 결제 하기
	@PostMapping("/reserve/pay.do")
	public String pay(Model model, ReserveVO vo) {
		// 선택한 예약가능한 번호
		String selectReserve = vo.getSelectReserve();
		// 구분자로 분리
		String[] reservable_no = selectReserve.split(",");
		// 예약가능번호 리스트
		List<ReserveVO> list = new ArrayList<ReserveVO>();
		for(int i=0; i<reservable_no.length; i++) {
			// 예약가능번호 리스트에 담기
			list.add(service.selectReserveVal(Integer.parseInt(reservable_no[i])));
		}
		model.addAttribute("total", vo.getSelectReserveSubTotal()); // 소계 금액
		model.addAttribute("user", service.user(vo)); // 유저정보 조회
		model.addAttribute("gd", service.viewGd(vo)); // 가드너 상세 정보 조회
		model.addAttribute("review", service.searchGdReview(vo)); // 가드너 리뷰 조회
		model.addAttribute("selectReserve", list); // 선택된 예약내용
		model.addAttribute("reserved", service.searchGdReserved(vo)); // 가드너 예약된 내역 가져오기
		model.addAttribute("completion", service.completionCount(vo)); // 예약 완료 내역 조회
		model.addAttribute("major", service.majorList(vo)); // 케어종목 리스트 조회
		return "plant/reserve/pay";
	}
	
	// 결제내용 검증
	@ResponseBody
	@PostMapping("/reserve/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(
			Model model
			, Locale locale
			, HttpSession session
			, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException
	{	
			return api.paymentByImpUid(imp_uid);
	}
	
	//결제 확인
	@PostMapping("/reserve/payConfirm.do")
	public String payConfirm(Model model, ReserveVO vo) {
		// 예약가능번호 가져오기
		String selectReserve = vo.getSelectReserve();
		// 구분자 제외하고 리스트로 저장
		String[] reservable_no = selectReserve.split(",");
		// 예약가능 일자 리스트
		List<ReserveVO> list = new ArrayList<ReserveVO>();
		// 예약 리스트
		List<ReserveVO> reservationList = new ArrayList<ReserveVO>();
		for(int i=1; i<reservable_no.length; i++) {
			list.add(service.selectReserveVal(Integer.parseInt(reservable_no[i])));
			vo.setReservable_do(1);
			vo.setReservable_no(Integer.parseInt(reservable_no[i]));
			vo.setReserve_pay(1);
			service.payProcess(vo);
			reservationList.add(service.viewReservation(vo));
		}
		model.addAttribute("vo", vo); // 결제정보 리턴
		model.addAttribute("reservation", reservationList); // 결제정보 리턴
		model.addAttribute("user", service.user(vo)); // 유저정보 조회
		model.addAttribute("gd", service.viewGd(vo)); // 가드너 상세 정보 조회		
		model.addAttribute("selectReserve", list); // 선택된 예약내용
		return "plant/reserve/payConfirm";
	}
	
	// 유저 예약화면
	@GetMapping("/reserve/userReservationView.do")
	public String userReservationView(Model model, ReserveVO vo, HttpServletRequest req) {
		// 유저 번호 set
		HttpSession sess = req.getSession();
		UserVO user = new UserVO();
		user = (UserVO) sess.getAttribute("loginUserInfo");
		if(user == null) {
			model.addAttribute("msg", "먼저 로그인을 해주세요");
			model.addAttribute("url", "/plant/user/login.do");
			return "common/alert";
		} else {
			vo.setUser_no(user.getUser_no());
			// 예약정보 리스트
			List<ReserveVO> reservationList = service.userReservation(vo);
			// 가드너 정보 리스트
			List<ReserveVO> gdList = new ArrayList<ReserveVO>();	
				
			for(int i=0; i<reservationList.size(); i++) {
				vo.setGd_no(reservationList.get(i).getGd_no());
				gdList.add(service.viewGd(vo));
			}
				
			model.addAttribute("userPayHistory", service.userPayHistory(vo)); // 유저 결제정보
			model.addAttribute("reservationList", reservationList); // 유저 예약정보
			model.addAttribute("gdList", gdList); // 가드너 정보
			model.addAttribute("user", service.user(vo)); // 유저정보 조회
			model.addAttribute("userPayHistoryDeduplication", service.userPayHistoryDeduplication(vo));
			model.addAttribute("completion", service.selectCompletionUser(vo));
			model.addAttribute("reviewList", service.selectUserReview(vo));
			return "plant/reserve/userReservationView";
		}
	}
	
	// 예약취소
	@PostMapping("/reserve/cancel.do")
	public ResponseEntity<String> cancel(Model model
			, ReserveVO vo
			, HttpServletRequest request
			, HttpServletResponse response) throws Exception {
		// api 인증키
		String imp_key = URLEncoder.encode("4167546717646634", "UTF-8");
			
		String imp_secret = URLEncoder.encode("G1hwWUFVOBmW5o5Ki4ZI0UfAlpZcNvWXLU3lIPg6CV0Ggs2hKK8dILtEJ9k4TwnVnG777wWSh2swl7dP", "UTF-8");
			
		JSONObject json = new JSONObject();
			
//		json.put("imp_key", imp_key);
			
		json.put("imp_secret", imp_secret);
		
		// 토큰발급
		String token = GetToken.getToken(request, response, json, "https://api.iamport.kr/users/getToken");
		
		// 환불 프로세스 
		RestTemplate template = new RestTemplate(new HttpComponentsClientHttpRequestFactory());
		
		String url = "https://api.iamport.kr/payments/cancel";
		
		HttpHeaders headers = new HttpHeaders();
		
		headers.set("Content-Type", "application/json");
		headers.set("Authorization", token);
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("reason", vo.getCancel_comment());
		params.add("merchant_uid", vo.getMerchant_uid());
		params.add("checksum", vo.getPay_size()+"");
		params.add("cancel_request_amount", vo.getPay_size()+"");
		
		HttpEntity<MultiValueMap<String, String>> req = new HttpEntity<>(params, headers);
		
		ResponseEntity<String> res = template.postForEntity(url, req, String.class);
		
		// api 송신성공
		if(res.getStatusCode() == HttpStatus.OK) {
			System.out.println(res.getBody());
			System.out.println(res.getStatusCodeValue());
			
			// 예약가능번호 가져오기
			String selectReserve = vo.getSelectReserve();
			// 구분자 제외하고 리스트로 저장
			String[] reserve_no = selectReserve.split(",");
			// 예약번호 리스트
			List<Integer> reserveNoList = new ArrayList<Integer>();
			// 예약번호 리스트에 넣기
			for(int i=1; i<reserve_no.length; i++) {
				reserveNoList.add(Integer.parseInt(reserve_no[i]));
			}
			// 취소타입 유저 = 2
			vo.setCancel_type(2);
			// 해당예약 예약가능하도록 변경
			vo.setReservable_do(0);
			// 예약 및 취소 캔슬 변수 1로 변경
			vo.setReserve_cancel(1);
			for(int i=0; i<reserveNoList.size(); i++) {
				vo.setReserve_no(reserveNoList.get(i));
				service.insertCancel(vo);
				service.updateReservable(vo);
				service.updatePayCancel(vo);
				service.updateReservationCancel(vo);
			}
		}
		return res;
	}
	
	// 가드너 예약관리
	@GetMapping("/reserve/gdReservationView.do")
	public String gdReservationView(Model model, ReserveVO vo, HttpServletRequest req) {
		// 가드너 번호 set
		HttpSession sess = req.getSession();
		GdVO gd = new GdVO();
		gd = (GdVO) sess.getAttribute("loginGdInfo");
		if(gd == null) {
			model.addAttribute("msg", "가드너만 접근 가능합니다. 가드너로 로그인해주세요.");
			model.addAttribute("url", "/plant/gd/login.do");
			return "common/alert";
		} else {
			vo.setGd_no(gd.getGd_no());
			model.addAttribute("reservableList", service.searchGdReservable(vo)); // 예약 가능한 내역
			model.addAttribute("reservedList", service.searchGdReserved(vo)); // 예약된 내역
			model.addAttribute("reservationList", service.gdReservation(vo)); // 예약정보
			model.addAttribute("reservationCancelList", service.selectGdReservationCancel(vo)); // 예약정보
			model.addAttribute("gdPayHistoryList", service.gdPayHistory(vo)); // 결제정보
			model.addAttribute("gd", service.viewGd(vo)); // 가드너 정보 조회
			model.addAttribute("majorList", service.majorList(vo)); // 케어종목 내역
			model.addAttribute("cancelList", service.selectGdCancel(vo)); // 취소 내역 
			return "plant/reserve/gdReservationView";
		}
	}
	
	// 가드너 예약가능일정 삭제
	@PostMapping("/reserve/reservableChooseDelete.do")
	public String reservableChooseDelete(Model model, ReserveVO vo) {
		// 예약가능번호 가져오기
		String selectReserve = vo.getSelectReserve();
		// 구분자 제외하고 리스트로 저장
		String [] reservable_no = selectReserve.split(",");
		for(int i=0; i<reservable_no.length; i++) {
			vo.setReservable_no(Integer.parseInt(reservable_no[i]));
			service.deleteReservableMajor(vo);
			service.deleteReservable(vo);
		}
		return "plant/reserve/gdReservationView";
	}
	
	// 가드너 예약가능일정 변경
	@RequestMapping("/reserve/reservableChooseUpdate.do")
	public String reservableChooseUpdate(Model model, @RequestBody Map<String, Object> obj, ReserveVO vo) {
		// 예약가능번호
		String reserveNoArrange = (String) obj.get("reserveNoArrange");
		// 구분자 제외하고 리스트로 저장
		String [] reservable_no = reserveNoArrange.split(",");
		// 변경한 시간
		String hourArrange = (String) obj.get("hourArrange");
		// 구분자 제외하고 리스트로 저장
		String [] reservable_hour = hourArrange.split(",");
		// 변경한 종목
		String majorArrange = (String) obj.get("majorArrange");
		// 구분자 제외하고 리스트로 저장
		String [] reservable_major = majorArrange.split(",");
		
		for(int i=0; i<reservable_no.length; i++) {
			vo.setReservable_no(Integer.parseInt(reservable_no[i]));
			vo.setReservable_hour(Integer.parseInt(reservable_hour[i]));
			vo.setReservable_major(reservable_major[i]);
			service.changeReservable(vo);
			service.changeReservableMajor(vo);
		}
		return "plant/reserve/gdReservationView";
	}
	
	// 가드너 예약가능일정 추가
	@PostMapping("/reserve/addReservableSchedule.do")
	public String addReservableSchedule(Model model, ReserveVO vo) {
		service.insertReservable(vo);
		service.insertReservableMajor(vo);
		return "plant/reserve/gdReservationView";
	}
	
	// 케어진행완료페이지
	@GetMapping("/reserve/completion.do")
	public String completion(Model model, ReserveVO vo, HttpServletRequest req) {
		// 가드너 번호 set
		HttpSession sess = req.getSession();
		GdVO gd = new GdVO();
		gd = (GdVO) sess.getAttribute("loginGdInfo");
		if(gd == null) {
			model.addAttribute("msg", "가드너만 접근 가능합니다. 가드너로 로그인해주세요.");
			model.addAttribute("url", "/plant/gd/login.do");
			return "common/alert";
		} else {
			model.addAttribute("completionList", service.selectCompletionGd(vo)); // 케어진행완료 리스트
			model.addAttribute("noCompletionList", service.selectNoCompletion(vo)); // 케어미진행 리스트 
			model.addAttribute("gd", service.viewGd(vo)); // 가드너 정보 조회
			model.addAttribute("gdPayHistoryList", service.gdPayHistory(vo)); // 결제정보
			model.addAttribute("reviewList", service.selectGdReview(vo)); // 가드너 리뷰리스트
			return "plant/reserve/completion";
		}
	}
	
	// 케어진행완료페이지
	@PostMapping("/reserve/completion.do")
	@ResponseBody
	public int InsertCompletion(Model model
			, ReserveVO vo
			, MultipartHttpServletRequest mhsq
			, HttpServletRequest req) throws IllegalStateException, IOException {

		List<MultipartFile> fileMap = mhsq.getFiles("file");
		
		System.out.println("사이즈 : " + fileMap.size() + "String : " + fileMap.toString());
		
		for(int i=0; i<fileMap.size(); i++) {
			
			String org = fileMap.get(i).getOriginalFilename(); 	// 본래 파일명               
			String ext = org.substring(org.lastIndexOf(".")); // 확장자 구하기
			String real = new Date().getTime()+ext;	
			
			//파일 저장
			String path = req.getRealPath("/upload/");
			
			File file = new File(path+real);
			
			try {
				fileMap.get(i).transferTo(file);
			} catch (Exception e) {
				System.out.println("저장오류" + e);
			}
			
			if(i == 0) {
				vo.setCompletion_picorg1(org);
				vo.setCompletion_picreal1(real);
			} else if(i == 1) {
				vo.setCompletion_picorg2(org);
				vo.setCompletion_picreal2(real);
			} else {
				vo.setCompletion_picorg3(org);
				vo.setCompletion_picreal3(real);
			}
		}
		service.insertCompletion(vo);
		int no = service.updateCompletion(vo);
		return no;
	}
	
	//리뷰 입력
	@PostMapping("/reserve/insertReview.do")
	@ResponseBody
	public int InsertCompletion(Model model, ReserveVO vo) {
		int no =service.insertReview(vo);
		service.updateRservationReview(vo);
		return no;
	}
	
	//답변 입력
	@PostMapping("/reserve/updateAnswer.do")
	@ResponseBody
	public int updateAnswer(Model model, ReserveVO vo) {
		int no =service.answerReview(vo);
		return no;
	}
	
}
