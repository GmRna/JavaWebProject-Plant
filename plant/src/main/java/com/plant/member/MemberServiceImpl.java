package com.plant.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import util.SendMail;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper mapper;

	@Override
	public int insert(MemberVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public int emailDupCheck(String email) {
		return mapper.emailDupCheck(email);
	}

	@Override
	public boolean loginCheck(MemberVO vo, HttpSession sess) {
		boolean r = false;
		
		MemberVO loginInfo = mapper.loginCheck(vo);
		
		if(loginInfo != null) {
			r = true;
			
			sess.setAttribute("loginInfo", loginInfo);
		}
		return r;
	}

	@Override
	public MemberVO findEmail(MemberVO vo) {
		return null;
	}

	@Override
	public MemberVO findPwd(MemberVO vo) {
		
		MemberVO mv = mapper.findEmail(vo);
		
		if(mv != null){
			String temp = "";
			for(int i = 0; i < 2; i++) {
				temp += (char)(Math.random()*26+65);
		}
			for(int i = 0; i < 2; i++) {
				temp += (int)(Math.random()*9);
			
		}
			vo.setPwd(temp);
			mapper.updateTempPwd(vo);
			
			SendMail.sendMail("hotduc214@naver.com", vo.getEmail(), "[더조은]임시비밀번호", "임시비밀번호:"+temp);
			
			return mv;
			
	}	else {
		return null;
	}
	}
}
