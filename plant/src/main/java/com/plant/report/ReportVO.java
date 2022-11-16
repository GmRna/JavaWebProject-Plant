package com.plant.report;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportVO {
	
	private int report_no;
	private int board_no;
	private String report_tablename;
	private int reply_no;
	
	private int user_no;
	private String user_nick;

	private int report_check;
	private String report_etc;
	
	private Timestamp report_regdate;
	
}	
