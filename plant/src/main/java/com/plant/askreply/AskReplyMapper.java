package com.plant.askreply;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AskReplyMapper {
	
	int insert(AskReplyVO vo);
	int update(AskReplyVO vo);
	
	int edit(int no);
	void updateViewcount(int no); // 얘는 왜 void?
	
	int count(AskReplyVO vo);
	
	List<AskReplyVO> list(AskReplyVO vo);
	
	int gnoUpdate(int gno);
	int onoUpdate(AskReplyVO vo);
	int reply(AskReplyVO vo);
	
	AskReplyVO view(int no);	// 얘는 
	
	
	int delete(int no);
	

}
