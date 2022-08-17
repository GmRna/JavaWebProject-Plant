package com.plant.petplant;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface PetplantMapper {
	// 반려식물 게시판 목록
	List<PetplantVO> list(PetplantVO vo);
	
	int insert(PetplantVO vo);
	int insertfile(PetplantVO vo);

	List<PetplantVO> findpetplant(int no);
	List<PetplantVO> findpetreply(int no);

	// 반려식물 상세보기-댓글 등록
	boolean reply(PetplantVO vo);
	int gnoUpdate(int gno);
	
	// 반려식물 상세보기-대댓글 등록 
	int rereply(PetplantVO vo);
	void onoUpdate(PetplantVO vo);
	
	// 처음에 게시판 리스트 좋아요 개수 불러오기
	List<PetplantVO> countLike (PetplantVO vo);
	// 상세보기 게시판 좋아요 수
	int DecountLike (int no);
	// 좋아요 했는지 안했는지 체크
	int checkLike(PetplantVO vo);
	// 좋아요 플러스
	int plusLike(PetplantVO vo);
	// 좋아요 마이너스
	int minusLike(PetplantVO vo);
	// 댓글 좋아요 개수 불러오기
	int countLikeReply(int no);
	// 댓글 좋아요 했는지 안했는지 체크
	int checkLikeReply(PetplantVO vo);

	
	
	
	
}
