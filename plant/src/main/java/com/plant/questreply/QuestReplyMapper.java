package com.plant.questreply;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuestReplyMapper {
	
	int reply(QuestReplyVO vo);
	int insert(QuestReplyVO vo);
	List<QuestReplyVO> list(QuestReplyVO vo);
	int count(QuestReplyVO vo);
	QuestReplyVO view(int no);
	void updateViewcount(int no);
	
	int update(QuestReplyVO vo);
	int gnoUpdate(int gno);
	int delete(int no);
	void onoUpdate(QuestReplyVO vo);
}