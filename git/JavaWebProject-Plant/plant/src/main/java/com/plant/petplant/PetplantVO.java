package com.plant.petplant;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class PetplantVO {

	
	private int pet_no;
	private int user_no;
	private Timestamp pet_regdate;
	private String pet_content;
	
	// 파일 저장
	private int file_no;
	private String filename_org;
	private String filename_real;
	private int file_boardno;
	private String file_tablename;
	private Timestamp file_regdate;
	
	
	//댓글
	private int ppr_no;
	private String ppr_content;
	private Timestamp ppr_regdate;
	private int ppr_gno;
	private int ppr_order;
	private int ppr_nested;
	private String ppr_secretCheck;
	
	
	// 좋아요 수
	private int countLike;
	private int ppreply_no;
}
