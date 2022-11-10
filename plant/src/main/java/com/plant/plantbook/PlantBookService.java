package com.plant.plantbook;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


public interface PlantBookService {

	Map searchWord(PlantBookVO vo);

	int checkbook(int no);

	int insertbook(int no);

	int deletebook(int no);

	PlantBookVO viewbook(int no);

}
