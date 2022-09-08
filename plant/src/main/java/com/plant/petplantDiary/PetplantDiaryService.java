package com.plant.petplantDiary;

import java.util.List;
import java.util.Map;

public interface PetplantDiaryService {

	PetplantDiaryVO userplant(int user_no);

	int insertDiary(PetplantDiaryVO vo);
	
	// 관찰일지 리스트 - 전체 리스트
	List<PetplantDiaryVO> listDiary(PetplantDiaryVO vo);
	
	// 두번째 등록
	int insertTwoDiary(PetplantDiaryVO vo);

	// 디테일
	Map listdetDiary(PetplantDiaryVO vo);

	PetplantDiaryVO editDiary(int diary_no);

	int updateDiary(PetplantDiaryVO vo);

	
	
	Map plantStypeF(String stype);

	Map plantStypeS(String stype);


}
