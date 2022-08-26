package com.plant.petplantDiary;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PetplantDiaryVO {
	
	
	private int diary_no;
	private int user_no;
	private Timestamp pet_regdate;
	private String user_plantname;
	private String user_planttype;
	private String filename_org;
	private String filename_real;
	private String diary_title;
	private int diary_weather;
	private String diary_content;
	
}
