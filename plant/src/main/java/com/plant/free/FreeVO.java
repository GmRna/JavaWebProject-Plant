package com.plant.free;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class FreeVO {
	
	private int free_no;
	private int user_no;
	private int member_no;
	private String free_title;
	private String free_content;
	private int free_viewcount;
	private Timestamp free_regdate;
	private String free_filenameorg;
	private String free_filenamereal;
	private int comment_count;
	
	private int page;
	private String stype;
	private String sword;
	

	private int startIdx;
	private int pageRow;
		
	
	public FreeVO() {
		this(1,10);					// 1페이지당 페이지로우 10개?
		
	}


	public FreeVO(int page, int pageRow) {
		
		this.page = page;
		this.pageRow = pageRow;
	}
}

	
	