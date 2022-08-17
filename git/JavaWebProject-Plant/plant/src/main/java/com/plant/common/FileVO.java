package com.plant.common;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;



@Getter
@Setter
public class FileVO {

	
	// 파일 저장
		private int file_no;
		private String filename_org;
		private String filename_real;
		private int file_boardno;
		private String file_tablename;
		private Timestamp file_regdate;
		
}
