package com.plant.notice;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class NoticeVO {
	
	private int notice_no;
	private int admin_no;
	private String notice_title;
	private String notice_content;
	private int notice_viewcount;
	private Timestamp notice_regdate;
	private String filename_org;
	private String filename_real;
	private int notice_level;
	
	//NoticeService에서 목록을 불러오는 용도
	
	private int page;
	private String stype;
	private String sword;
	
	//
	private int startIdx;
	private int pageRow;
	
	// 페이지
	
	public NoticeVO(){
		this.page = 1;
		this.pageRow = 10;
	}
	
	public NoticeVO(int page, int pageRow){

		this.page = page;
		this.pageRow = pageRow;
	}
	
	
		
}
	
	