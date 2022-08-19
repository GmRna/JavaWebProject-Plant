package com.plant.petplant;

import java.util.List;
import java.util.Map;


public interface PetplantService {
	// 반려식물 전체 리스트
	List<PetplantVO> list(PetplantVO vo);
	
	// 반려식물 게시물 등록
	int insert(PetplantVO vo);
	// 반려식물 파일등록
	int insertfile(PetplantVO vo);
	// 반려식물 상세보기(사진 및 댓글)
	Map findpetplant(PetplantVO vo);
	// 반려식물 댓글 저장 후 불러오기
	Map findpetreply(int no);
	//반려식물 상세보기-댓글달기
	boolean reply(PetplantVO vo);
	// 반려식물 상세보기-대댓글달기
	boolean rereply(PetplantVO vo);
	
	// 좋아요 했는지 안했는지 체크
	int checkLike(PetplantVO vo);
	// 좋아요 플러스
	int plustLike(PetplantVO vo);
	// 좋아요 마이너스
	int minusLike(PetplantVO vo);
	
	// 댓글 좋아요 카운트
	int countLikeReply(int no);
	// 댓글 좋아요 체크
	int checkLikeReply(PetplantVO vo);


	
	
}
