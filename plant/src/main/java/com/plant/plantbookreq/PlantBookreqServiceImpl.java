package com.plant.plantbookreq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlantBookreqServiceImpl implements PlantBookreqService {

	
	@Autowired
	PlantBookreqMapper mapper;
	
	
	// 총 리스트 
	@Override
	public Map listBookreq(PlantBookreqVO vo) {
		// 총 게시물 수 
		int totalcount = mapper.count(vo);
		
		// 총 페이지수
		int totalPage = totalcount / vo.getPageRow();
		if (totalcount % vo.getPageRow() > 0 ) totalPage++;
		
		// 시작 인덱스
		int startIdx = (vo.getPage() -1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		
		// 게시판 목록
		List<PlantBookreqVO> reqlist = mapper.listBookreq(vo);
		
		// 페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*vo.getPageRow());
		int startPage = endPage - 9;
		if ( endPage > totalPage ) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		
		Map map = new HashMap();
		
		// 총 게시물수 
		map.put("totalcount", totalcount);
		// 총 페이지수
		map.put("totalPage", totalPage);
		
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		
		map.put("reqlist", reqlist);

		System.out.println("totalCount : "+totalcount+" totalPage : "+totalPage+": startPage :"+startPage+" endPage : "+ endPage+ "page: "+ vo.getPage());

		return map;
	}
	
	
	
	@Override
	public int insertBookreq(PlantBookreqVO vo) {
		return mapper.insertBookreq(vo);
	}

	

	@Override
	public PlantBookreqVO viewBookreq(PlantBookreqVO vo) {
		return mapper.viewBookreq(vo);
	}



	@Override
	public int insertadmin(PlantBookreqVO vo) {
		return mapper.insertadmin(vo);
	}

}
