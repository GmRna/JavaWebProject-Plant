package com.plant.free;

import java.util.Map;

public interface FreeService {

	//목록
	Map index(FreeVO vo);
	
	//상세
	FreeVO view(int free_no);
	//수정
	FreeVO edit(int free_no);
	//수정처리
	boolean update(FreeVO vo);
	//등록처리
	boolean insert(FreeVO vo);
	//삭제처리
	boolean delete(int free_no);
	
}
