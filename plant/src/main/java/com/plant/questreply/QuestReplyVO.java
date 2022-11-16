package com.plant.questreply;


import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class QuestReplyVO {
	
	private int questreply_no;
	private int user_no;
	private String user_nick;
	private String questreply_title;
	private String questreply_content;
	private int questreply_viewcount;
	private Timestamp questreply_regdate;
	private String filename_org;
	private String filename_real;
	private int quest_level;
	private int comment_count;
	private int questreply_gno;
	private int questreply_ono;
	private int questreply_nested;
	
	private int page;
	private String stype;
	private String sword;
	private int startIdx;
	private int pageRow;
		
	public QuestReplyVO() {
		this(1,10);					// 1페이지당 페이지로우 10개?
		
	}

	public QuestReplyVO(int page, int pageRow) {
		
		this.page = page;
		this.pageRow = pageRow;
	}
}

	
	