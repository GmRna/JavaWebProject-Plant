package com.plant.todayflower;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TDFlowerServiceImpl implements TDFlowerService {

	@Autowired
	TDFlowerMapper mapper;
	
	@Override
	public TDFlowerVO select(TDFlowerVO vo) {
		return mapper.select(vo);
	}

}
