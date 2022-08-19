package com.plant.user;

import javax.servlet.http.HttpSession;

public interface UserService {
	int insert(UserVO vo);
	int emailDupCheck(String id);
	boolean loginCheck(UserVO vo, HttpSession sess);
	UserVO findEmail(UserVO vo);
	//UserVO findPwd(UserVO vo);
}	