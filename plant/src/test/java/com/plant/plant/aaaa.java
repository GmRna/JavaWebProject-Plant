package com.plant.plant;

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
public class aaaa {

	@Autowired
	private testmapper mapper;
	
	
	@Test
	public void test () {
		testVO vo = new testVO();
		
		List<testVO> list = mapper.select(vo);
		
		list.forEach(list1-> log.info(list1));
		
	}
}
