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

}
