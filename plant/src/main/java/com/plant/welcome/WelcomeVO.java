package com.plant.welcome;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter

public class WelcomeVO {
	
	private int welcome_no;
	private String welcome_content;
	private Timestamp welcome_regdate;
	private int user_no;
	
	private int page;
	private int startIdx;
	private int pageRow;
	
	public WelcomeVO() {
//		this.page = 1;
//		this.pageRow = 10;
		this(1, 10);
	}
	public WelcomeVO(int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}
