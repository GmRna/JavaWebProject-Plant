package com.plant.petplantDiary;

import java.util.List;
import java.util.Map;

public interface PetplantDiaryService {
	// 저장된 반려식물 데이터 가져오기
	PetplantDiaryVO userplant(int user_no);
	// 관찰일지 작성하기
	int insertDiary(PetplantDiaryVO vo);
	
	// 관찰일지 리스트 - 전체 리스트
	List<PetplantDiaryVO> listDiary(PetplantDiaryVO vo);
	
	// 두번째 등록
	int insertTwoDiary(PetplantDiaryVO vo);

	// 디테일
	Map listdetDiary(PetplantDiaryVO vo);
	
	// 수정 페이지
	PetplantDiaryVO editDiary(int diary_no);
	// 수정 하기
	int updateDiary(PetplantDiaryVO vo);
	// 삭제 하기
	int deleteDiary(int diary_no);


}
