package com.plant.gd;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface GdService {
	
	Map index(GdVO vo);
	
	int insert(GdVO vo);
	int insertcar(GdVO vo);
	int insertcer(GdVO vo);
	
	int emailDupCheck(String email);
	boolean loginCheck(GdVO vo, HttpSession sess);
	
	GdVO findEmail(GdVO vo);
	GdVO findPwd(GdVO vo);
	GdVO view(int gd_no);
	
	GdVO detail(int gd_no);
	
	boolean delete(int gd_no);

	GdVO getInfo(String gd_id);

	GdVO myInfo(String gd_id);
	
	int access(GdVO vo);

	int edit(GdVO vo);

	int insert2(GdVO vo);
	int insertcar2(GdVO vo);
	int insertcer2(GdVO vo);

	GdVO status(String gd_id);


}	
