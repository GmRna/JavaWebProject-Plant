package com.plant.report;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportMapper {

	int insert(ReportVO vo); 

}
