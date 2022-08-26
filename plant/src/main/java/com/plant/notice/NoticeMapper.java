package com.plant.notice;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
	
	int insert(NoticeVO vo);
	int count(NoticeVO vo);
	List<NoticeVO> list(NoticeVO vo);
	
	NoticeVO view(int notice_no);
	void updateViewcount(int notice_no);
	int update(NoticeVO vo);
	int delete(int notice_no);
}
