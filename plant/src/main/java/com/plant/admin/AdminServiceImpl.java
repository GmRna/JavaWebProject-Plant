package com.plant.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import util.SendMail;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper mapper;	

	@Override
	public boolean loginCheck(AdminVO vo, HttpSession sess) {
		boolean r = false;
		AdminVO loginAdminInfo = mapper.loginCheck(vo);
		if (loginAdminInfo != null) {
			r = true;
			// 로그인 성공시 세션에 저장
			sess.setAttribute("loginAdminInfo", loginAdminInfo);
		}
		return r;
	}

}
