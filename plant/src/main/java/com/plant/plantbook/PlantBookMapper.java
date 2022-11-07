package com.plant.plantbook;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlantBookMapper {

	List<PlantBookVO> searchWord(PlantBookVO vo);

	int count(PlantBookVO vo);

	int checkbook(int no);

	int insertbook(int no);

	int deletebook(int no);

	PlantBookVO viewbook(int no);

	
	
}
