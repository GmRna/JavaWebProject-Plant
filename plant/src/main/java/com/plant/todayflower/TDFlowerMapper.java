package com.plant.todayflower;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TDFlowerMapper {

	TDFlowerVO select(TDFlowerVO vo);

}
