package com.plant.gd;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GdVO {
	private int gd_no;
	private String gd_id;	
	private String gd_pwd;
	private String gd_email;
	private String gd_name;
	private String gd_regnum;
	private String gd_postcode;
	private String gd_addr1;
	private String gd_addr2;
	private String gd_hp;
	private String gd_ableaddr;
	private String gd_career;
	private String gd_picorg;
	private String gd_picreal;
	private String gd_certificate;
	private int gd_acc;
	private String gd_major1;
	private String gd_major2;
	private String gd_major3;
	private String gd_major4;
	private String gd_major5;
	private String gd_major6;
	private String gd_major7;
	private Timestamp gd_regdate;
	
	private int page;
	private String stype;
	private String sword;
	
	//
	private int startIdx;
	private int pageRow;
	
	// 페이지
	
	public GdVO(){
		this.page = 1;
		this.pageRow = 10;
	}
	
	public GdVO(int page, int pageRow){

		this.page = page;
		this.pageRow = pageRow;
	}
}
