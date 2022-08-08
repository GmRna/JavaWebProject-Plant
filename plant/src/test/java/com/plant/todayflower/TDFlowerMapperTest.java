package com.plant.todayflower;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class TDFlowerMapperTest {

	@Autowired
	private TDFlowerMapper mapper;
	
	
	@Test
	public void test () {
		TDFlowerVO vo = new TDFlowerVO();
		vo.setTf_month(1);
		vo.setTf_day(1);
		
		log.info(mapper.select(vo));
		
	}
}
