package com.plant.petplantDiary;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PetplantDiaryVO {
	
	
	private int diary_no;
	private int user_no;
	private String pet_regdate;
	private String user_plantname;
	private String user_planttype;
	private String user_plantfile_org;
	private String user_plantfile_real;
	private String diary_title;
	private int diary_weather;
	private String diary_content;
	private int diary_gno;
	private int diary_ono;
	private int diary_day;
	private Timestamp diary_regdate;
	
	
	private String svcCodeNm;
	
}
