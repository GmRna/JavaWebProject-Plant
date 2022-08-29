package com.plant.freecomment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FreeCommentMapper{
	
	int insert(FreeCommentVO vo);
	int count(FreeCommentVO vo);
	List<FreeCommentVO> list(FreeCommentVO vo);
	int delete(int no);
}
