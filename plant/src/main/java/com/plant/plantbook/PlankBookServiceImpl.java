package com.plant.plantbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.notice.NoticeVO;

@Service
public class PlankBookServiceImpl implements PlantBookService{

	@Autowired
	PlantBookMapper mapper;
	
	@Override
	public Map searchWord(PlantBookVO vo) {
		int totalCount = mapper.count(vo);
		int totalPage = totalCount / vo.getPageRow();
		
		if(totalCount % vo.getPageRow() > 0) totalPage++;

		//시작 인덱스 / boardMapper.xml 쿼리문과 비교해가면서 메소드를 완성시켜야한다.
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		// 이후 set으로 호춯	
		vo.setStartIdx(startIdx);
		List<PlantBookVO> list = mapper.searchWord(vo);
		
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
	public int checkbook(int no) {
		return mapper.checkbook(no);
	}

	@Override
	public int insertbook(int no) {
		return mapper.insertbook(no);
	}

	@Override
	public int deletebook(int no) {
		return mapper.deletebook(no);
	}

	@Override
	public PlantBookVO viewbook(int no) {
		return mapper.viewbook(no);
	}

}
