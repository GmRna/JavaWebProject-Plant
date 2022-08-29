package com.plant.notice;

import java.util.Map;

public interface NoticeService {
	
	Map index(NoticeVO vo);
	
	NoticeVO view(int notice_no);
	NoticeVO edit(int notice_no);
	// 등록처리
	boolean insert(NoticeVO vo);
	// 수정처리
	boolean update(NoticeVO vo);
	// 삭제처리
	boolean delete(int no);
	

}
