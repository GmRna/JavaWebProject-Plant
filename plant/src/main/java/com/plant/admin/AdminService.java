package com.plant.admin;

import javax.servlet.http.HttpSession;

public interface AdminService {
	
	boolean loginCheck(AdminVO vo, HttpSession sess);

}	