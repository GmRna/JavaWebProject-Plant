package com.plant.ask;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class AskVO {
	
	private int ask_no;
	private int user_no;
	private String ask_title;
	private String ask_content;
	private Timestamp ask_regdate;
	private int ask_viewcount;
	private int secretcheck;
	private int level;
	private int status;
	private int admin;
	private String filename_org;
	private String filename_real;
	
	
	private int page;
	private String stype;
	private String sword;
	
	private int startIdx;
	private int pageRow;
	

	public AskVO() {
		this(1, 10);
	}
	
	public AskVO(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}
