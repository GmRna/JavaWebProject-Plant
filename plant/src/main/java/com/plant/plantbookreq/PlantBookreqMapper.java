package com.plant.plantbookreq;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlantBookreqMapper {

	int insertBookreq(PlantBookreqVO vo);

	List<PlantBookreqVO> listBookreq(PlantBookreqVO vo);

	PlantBookreqVO viewBookreq(PlantBookreqVO vo);

	int count(PlantBookreqVO vo);

}
