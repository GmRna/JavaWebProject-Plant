package com.plant.quest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class QuestServiceImpl implements QuestService {
	
	@Autowired
	QuestMapper mapper;
	
	
	@Override
	public Map index(QuestVO vo) {
		int totalCount = mapper.count(vo); // 총게시물수
		// 총페이지수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		// 시작인덱스
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<QuestVO> list = mapper.list(vo);
		
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
	public QuestVO edit(int quest_no) {
		return mapper.view(quest_no);
	}

	@Override
	public QuestVO view(int quest_no) {
		
		mapper.updateViewcount(quest_no);
		return mapper.view(quest_no);
	}

	@Override
	public boolean update(QuestVO vo) {
		return mapper.update(vo) > 0 ? true : false;
	}

	@Override
	public boolean insert(QuestVO vo) {
		return mapper.insert(vo) > 0 ? true : false;
	}

	@Override
	public boolean delete(int quest_no) {
		return mapper.delete(quest_no) > 0 ? true : false;
	}
	

	
}