package com.plant.report;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportMapper {

	int insert(ReportVO vo);

	List<ReportVO> reportList(ReportVO vo);

}
