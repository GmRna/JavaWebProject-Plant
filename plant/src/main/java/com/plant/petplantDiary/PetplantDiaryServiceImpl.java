package com.plant.petplantDiary;

import java.util.HashMap;
import java.util.List;
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

	
	// 반려 식물 관찰일지 - 등록 첫 등록
	@Override
	public int insertDiary(PetplantDiaryVO vo) {
		int no = mapper.insertDiary(vo);
		if(no > 0) mapper.gnoUpdate(vo.getDiary_no());
		return no;
	}
	// 두번째 등록
	@Override
	public int insertTwoDiary(PetplantDiaryVO vo) {
		mapper.onoUpdate(vo);
		vo.setDiary_ono(vo.getDiary_ono()+1);
		return mapper.insertTwoDiary(vo);
	}

	// 반려 식물 관찰일지 - 리스트 ( 전체 - 유저번호, 식물 이름 )
	@Override
	public List<PetplantDiaryVO> listDiary(PetplantDiaryVO vo) {
		return mapper.listDiary(vo);
	}

	// 반려 식물 관찰일지 - 상세보기
	@Override
	public Map listdetDiary(PetplantDiaryVO vo) {
		Map map = new HashMap();
		List<PetplantDiaryVO> diarylist = mapper.listdetDiary(vo);
		PetplantDiaryVO diaryVO =  mapper.getpetname(vo.getDiary_no());
		
		map.put("diarylist", diarylist);
		map.put("diaryVO", diaryVO);
		
		return map;
	}

	// 반려 식물 관찰일지 - 수정 폼
	@Override
	public PetplantDiaryVO editDiary(int diary_no) {
		return mapper.editDiary(diary_no);
	}

	// 반려 식물 관찰일지 - 수정하기
	@Override
	public int updateDiary(PetplantDiaryVO vo) {
		return mapper.updateDiary(vo);

	}


	@Override
	public Map plantStypeF(String stype) {
		List<PetplantDiaryVO> list = mapper.plantStypeF(stype);
		Map map = new HashMap();  
		map.put("stype", list);
		return map;
	}

	@Override
	public Map plantStypeS(String stype) {
		List<PetplantDiaryVO> list = mapper.plantStypeS(stype);
		Map map = new HashMap();  
		map.put(stype, list);
		return map;
	}

	
}
