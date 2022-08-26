package com.plant.quest;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuestMapper {		//interface
	
	int insert(QuestVO vo);
	int count(QuestVO vo);
	List<QuestVO> list (QuestVO vo);
	
	QuestVO view(int quest_no);
	void updateViewcount(int quest_no);
	int update(QuestVO vo);
	int delete(int quest_no);

}
