package com.plant.quest;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class QuestVO {
	
	private int quest_no;
	private int user_no;
	private int member_no;
	private String quest_title;
	private String quest_content;
	private int quest_viewcount;
	private Timestamp quest_regdate;
	private String quest_filenameorg;
	private String quest_filenamereal;
	private int comment_count;
	private int quest_level;
	
	private int page;
	private String stype;
	private String sword;
	

	private int startIdx;

	private int pageRow;
		
	public QuestVO() {
		this(1,10);					// 1페이지당 페이지로우 10개?
		
	}


	public QuestVO(int page, int pageRow) {
		
		this.page = page;
		this.pageRow = pageRow;
	}
}

	
	