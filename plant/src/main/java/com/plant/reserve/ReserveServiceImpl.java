package com.plant.reserve;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	ReserveMapper mapper;
	
	@Override
	public ReserveVO select(ReserveVO vo) {
		return vo;
	}

}
