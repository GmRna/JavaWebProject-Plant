package com.plant.plantbook;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlantBookVO {
	
	private String sword;
	
	private int plantbook_no;
	private String atchFileLink;
	private String cntntsSj;
	private String imgFileLink;
	private String imgFileLinkOriginal;
	private String mainChartrInfo;
	private String orginlFileNm;
	private String prdlstCtgCode;
	private String svcCodeNm;
	private String upperSvcCode;
	
	
	private int user_no;
	private Timestamp pb_regdate;
	private int count;
	
	
	private int page;
	
	//
	private int startIdx;
	private int pageRow;
	
	// 페이지
	
	public PlantBookVO(){
		this.page = 1;
		this.pageRow = 10;
	}
	
	public PlantBookVO(int page, int pageRow){
		this.page = page;
		this.pageRow = pageRow;
	}
	
}
