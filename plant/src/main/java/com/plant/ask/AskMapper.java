package com.plant.ask;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AskMapper {
	
	int insert(AskVO vo);
	int count(AskVO vo);
	List<AskVO> list(AskVO vo);

	void updateViewcount(int ask_no);
	int update(AskVO vo);
	
	int delete(int ask_no);
		
	AskVO view(int ask_no);

}

