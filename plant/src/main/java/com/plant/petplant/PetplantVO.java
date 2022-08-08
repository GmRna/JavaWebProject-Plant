package com.plant.petplant;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PetplantVO {

	
	private int pet_no;
	private int user_no;
	private Timestamp pet_regdate;
	private String pet_content;
	
	// 파일 저장
	private String filename_org;
	private String filename_real;
	
}
