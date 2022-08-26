package com.plant.ask;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AskServiceImpl implements AskService {
	
	@Autowired
	AskMapper mapper;

	@Override
	public Map index(AskVO vo) {
		int totalCount = mapper.count(vo); // 총게시물수
		// 총페이지수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		// 시작인덱스
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<AskVO> list = mapper.list(vo);
		
		// 페이징처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage-9;
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("list", list);
		
		return map;
	}
	

	@Override
	public AskVO view(int ask_no) {
		mapper.updateViewcount(ask_no); // 상세페이지를 보면 viewcount +1?
		return mapper.view(ask_no);
	}

	@Override
	public AskVO edit(int ask_no) {
		return mapper.view(ask_no);
	}

	@Override
	public boolean insert(AskVO vo) {
		return  mapper.insert(vo) > 0 ? true : false;
	}

	@Override
	public boolean update(AskVO vo) {						// 언제 AskVO vo / int ask_no를 써야하는지
		return mapper.update(vo) > 0 ? true : false;
	}

	@Override
	public boolean delete(int ask_no) {
		return mapper.delete(ask_no) > 0 ? true : false;
	}

	

}
