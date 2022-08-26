package com.plant.petplantDiary;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class PetplantDiaryServiceImpl implements PetplantDiaryService {

	
	@Autowired
	PetplantDiaryMapper mapper;

	@Override
	public PetplantDiaryVO userplant(int user_no) {
		return mapper.userplant(user_no);
	}
	
}
