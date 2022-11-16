package com.plant.report;

import java.util.List;
import java.util.Map;

public interface ReportService {

	int insert(ReportVO vo);

	List<ReportVO> reportList(ReportVO vo);

}
