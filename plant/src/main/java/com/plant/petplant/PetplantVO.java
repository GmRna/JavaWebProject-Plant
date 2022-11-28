package com.plant.petplant;

import java.sql.Timestamp;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PetplantVO {

	
	private int pet_no;
	private int user_no;
	private Timestamp pet_regdate;
	private String pet_content;
	private String user_nick;
	private int user_writeNo;
	private String user_plantfile_real;
	
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
	private int count_reply;	// 댓글 수 
	
	
	// 좋아요 수 및 좋아요 
	private int ppreply_no;	// 좋아요 테이블의 댓글번호
	private int countLike;	// 게시판 좋아요 수 
	private int countreplyLike; // 댓글 좋아요 수
	private int like_check;	// 게시판 좋아요 했는지 안했는지 체크
	private int like_replycheck;	// 댓글 좋아요 했는지 안했는지 체크

	// 저장
	private int ppp_check;
	private int plantput_no;
	private Timestamp regdate;
	
	private String sword;
	
	// 페이징 처리
	private int page;
	private int startIdx;
	private int pageRow;
	
	// 페이지
	public PetplantVO(){
		this.page = 1;
		this.pageRow = 10;
	}
	public PetplantVO(int page, int pageRow){
		this.page = page;
		this.pageRow = pageRow;
	}
}
