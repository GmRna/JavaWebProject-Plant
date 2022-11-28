package com.plant.petplant;

import java.util.List;
import java.util.Map;


public interface PetplantService {
	// 반려식물 전체 리스트
	Map list(PetplantVO vo);
	// 반려식물 검색
	Map searchpet(PetplantVO vo);
	
	
	// 반려식물 게시물 등록
	int insert(PetplantVO vo);
	// 반려식물 파일등록
	int insertfile(PetplantVO vo);
	// 반려식물 상세보기(사진 및 댓글)
	Map findpetfile(PetplantVO vo);
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

	// 댓글 삭제
	int delreply(PetplantVO vo);
	// 답글 삭제
	int delRereply(PetplantVO vo);
	
	// 댓글 수정
	int modreply(PetplantVO vo);
	// 답글 수정
	int modRereply(PetplantVO vo);
	
	// 상세보기 하려면  필요한 vo..
	List<PetplantVO> select(PetplantVO vo);
	
	
	// 게시판 수정 - 내용 불러오기
	PetplantVO findpetcontent(int pet_no);
	// 게시판 수정 - 사진 불러오기
	Map findFile(PetplantVO vo);
	// 게시판 수정 - 내용 업데이트
	int update(PetplantVO vo);
	
	// 게시판 삭제 - 내용 삭제
	int delete(PetplantVO vo);

	// 게시판 수정 - 파일 삭제
	int deletefile(PetplantVO vo);
	// 게시판 수정 - 파일 업데이트
	int updatefile(PetplantVO vo);

	//
	int selectsavepetplant(PetplantVO vo);

	int pluspetplant(PetplantVO vo);

	int minuspetplant(PetplantVO vo);

	PetplantVO listpop(PetplantVO vo);
	
	Map list2(PetplantVO vo);
	
	Map savepetList(PetplantVO vo);

	

	




	
	
}
