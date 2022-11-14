package com.plant.plantType;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

public interface PlantTypeService {
	
	List<PlantTypeVO> plantStypeF(String stype);

	List<PlantTypeVO> plantStypeS(String stype);
}
