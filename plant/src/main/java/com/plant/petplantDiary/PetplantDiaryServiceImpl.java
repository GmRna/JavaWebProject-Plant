package com.plant.petplantDiary;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class PetplantDiaryServiceImpl implements PetplantDiaryService {

	
	@Autowired
	PetplantDiaryMapper mapper;
	
	
	// 반려 식물 관찰일지 - 등록된 데이터 불러오기
	@Override
	public PetplantDiaryVO userplant(int user_no) {
		return mapper.userplant(user_no);
	}

	
	// 반려 식물 관찰일지 - 등록 
	@Override
	public int insertDiary(PetplantDiaryVO vo) {
		return mapper.insertDiary(vo);
	}
	
}
