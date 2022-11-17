package com.plant.plantbookreq;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlantBookreqVO {
	
	private int pbreq_no; 
	private String pbreq_title;
	private int user_no;
	private String user_nick;
	private String pbreq_content;
	private int pbreq_status;
	private String pbreq_type;
	private int pbreq_gno;
	private int pbreq_ono;
	private int pbreq_admin;
	private Timestamp pbreq_regdate;
	private String filename_org;
	private String filename_real;
	
	
	private int page;
	private String stype;
	private String sword;
	private int startIdx;
	private int pageRow;
	
	
	public PlantBookreqVO () {
		this(1, 10);
	}
	public PlantBookreqVO (int page, int pageRow) {
		this.page = page;
		this.pageRow = pageRow;
	}
}
