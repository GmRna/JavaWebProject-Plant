package com.plant.user;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {
	private int user_no;
	private String user_nick;
	private String user_id;	
	private String user_pwd;
	private String user_email;
	private String user_name;
	private String user_regnum;
	private String user_postcode;
	private String user_addr1;
	private String user_addr2;
	private String user_hp;
	private String user_plantname;
	private String user_planttype;
	private String user_plantfile_org;
	private String user_plantfile_real;
	private Timestamp user_regdate;
	private String user_favrplant;
	private int user_open;
	private int user_group;
	
	private int page;
	private String stype;
	private String sword;
	
	//
	private int startIdx;
	private int pageRow;
	
	// 페이지
	
	public UserVO(){
		this.page = 1;
		this.pageRow = 10;
	}
	
	public UserVO(int page, int pageRow){

		this.page = page;
		this.pageRow = pageRow;
	}
	
}
