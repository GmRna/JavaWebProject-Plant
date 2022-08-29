package com.plant.questcomment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuestCommentMapper {
	
	int insert(QuestCommentVO vo);
	List<QuestCommentVO> list(QuestCommentVO vo);
	int count(QuestCommentVO vo);
	int delete(int no);

}