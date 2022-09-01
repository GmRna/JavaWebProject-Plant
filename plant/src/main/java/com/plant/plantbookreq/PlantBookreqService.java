package com.plant.plantbookreq;

import java.util.Map;

public interface PlantBookreqService {

	// 게시물 저장
	int insertBookreq(PlantBookreqVO vo);

	Map listBookreq(PlantBookreqVO vo);

	PlantBookreqVO viewBookreq(PlantBookreqVO vo);

	int insertadmin(PlantBookreqVO vo);

}
