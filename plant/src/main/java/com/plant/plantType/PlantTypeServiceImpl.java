package com.plant.plantType;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.plantbookreq.PlantBookreqService;
import com.plant.plantbookreq.PlantBookreqVO;

@Service
public class PlantTypeServiceImpl implements PlantTypeService {

	
	@Autowired
	PlantTypeMapper mapper;
	
	@Override
	public List<PlantTypeVO> plantStypeF(String stype) {
		return mapper.plantStypeF(stype);
	}

	@Override
	public List<PlantTypeVO> plantStypeS(String stype) {
		return mapper.plantStypeS(stype);
	}

	

}
