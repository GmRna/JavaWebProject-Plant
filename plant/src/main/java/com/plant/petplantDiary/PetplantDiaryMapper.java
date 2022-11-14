package com.plant.petplantDiary;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PetplantDiaryMapper {

	PetplantDiaryVO userplant(int user_no);

	int insertDiary(PetplantDiaryVO vo);

	// 반려 식물 관찰일지 - 리스트 ( 전체다 ) 
	List<PetplantDiaryVO> listDiary(PetplantDiaryVO vo);
	// 반려 식물 관찰일지 - 반려 식물 하나의 리스트
	List<PetplantDiaryVO> listdetDiary(PetplantDiaryVO vo);

	int gnoUpdate(int diary_no);

	int onoUpdate(PetplantDiaryVO vo);
	// 첫 작성 이후 그 펫식물 이름으로 작성하기 위해 이름 불러오기
	PetplantDiaryVO getpetname(int diary_no);

	int insertTwoDiary(PetplantDiaryVO vo);
	
	// 반려 식물 관찰일지 - 수정 폼
	PetplantDiaryVO editDiary(int diary_no);
	// 반려 식물 관찰일지 - 수정하기
	int updateDiary(PetplantDiaryVO vo);
	// 반려 식물 관찰일지 - 삭제하기
	int deleteDiary(int diary_no);
	
	

}
