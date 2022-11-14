package com.plant.plantType;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PlantTypeMapper {

	List<PlantTypeVO> plantStypeF(String stype);

	List<PlantTypeVO> plantStypeS(String stype);
	
	
}
