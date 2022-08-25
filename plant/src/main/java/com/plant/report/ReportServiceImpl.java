package com.plant.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	ReportMapper mapper;

	@Override
	public int insert(ReportVO vo) {
		return mapper.insert(vo);
	}
}
