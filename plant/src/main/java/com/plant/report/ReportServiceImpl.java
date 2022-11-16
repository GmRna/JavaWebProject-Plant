package com.plant.report;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	ReportMapper mapper;
	
	
	// 게시판 신고하기 - 저장
	@Override
	public int insert(ReportVO vo) {
		return mapper.insert(vo);
	}

	// 신고 된 게시판 리스트
	@Override
	public List<ReportVO> reportList(ReportVO vo) {
		return mapper.reportList(vo);
	}
}
