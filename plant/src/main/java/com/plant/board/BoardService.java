package com.plant.board;

import java.util.Map;

public interface BoardService {

	// 목록
	Map index(BoardVO vo);
	// 상세
	BoardVO view(int no);
	// 수정 폼
	BoardVO edit(int no);
	// 수정 처리
	boolean update(BoardVO vo);
	// 등록 처리
	boolean insert(BoardVO vo);
	
	boolean delete(int no);
	
}
