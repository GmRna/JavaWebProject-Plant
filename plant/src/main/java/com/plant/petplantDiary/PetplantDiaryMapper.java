package com.plant.petplantDiary;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PetplantDiaryMapper {

	PetplantDiaryVO userplant(int user_no);

	int insertDiary(PetplantDiaryVO vo);

}
