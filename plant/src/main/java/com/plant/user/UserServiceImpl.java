package com.plant.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper mapper;
	
	@Override
	public int insert(UserVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public int emailDupCheck(String id) {
		return mapper.emailDupCheck(id);
	}

	@Override
	public boolean loginCheck(UserVO vo, HttpSession sess) {
		boolean r = false;
		UserVO loginInfo = mapper.loginCheck(vo);
		if (loginInfo != null) {
			r = true;
			// 로그인 성공시 세션에 저장
			sess.setAttribute("loginInfo", loginInfo);
		}
		return r;
	}
	
	@Override
	public UserVO findEmail(UserVO vo) {
		return mapper.findEmail(vo);
	}
	
	/*
	 * @Override public UserVO findPwd(UserVO vo) { // update UserVO mv =
	 * mapper.findPwd(vo); if (mv != null) { // 임시 비밀번호 생성 // 영문 두 자리, 숫자 두 자리
	 * String temp = ""; for (int i=0; i<3; i++) { temp += (char)(Math.random() * 26
	 * + 65); } for (int i=0; i<3; i++) { temp += (int)(Math.random() * 9); }
	 * 
	 * // 임시 비밀번호 update vo.setUser_pwd(temp); mapper.updateTempPwd(vo);
	 * 
	 * // email 발송 SendMail.sendMail("carmania4567@naver.com", vo.getUser_email(),
	 * "[식물통합정보사이트]임시비밀번호", "임시비밀번호:"+temp);
	 * 
	 * return mv; } else { return null; } }
	 */

}
