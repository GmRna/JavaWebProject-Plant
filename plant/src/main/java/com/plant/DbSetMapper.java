package com.plant;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DbSetMapper {

	int apiInsert(DataVO vo);
}
