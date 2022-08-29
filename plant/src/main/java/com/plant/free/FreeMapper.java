package com.plant.free;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

// FreeService와 연관?


@Mapper
public interface FreeMapper {
	
	int insert(FreeVO vo);
	int count(FreeVO vo);
	List<FreeVO> list(FreeVO vo);
	FreeVO view(int free_no);
	void updateViewcount(int free_no);
	int update(FreeVO vo);
	int delete(int free_no);
	
	

}
