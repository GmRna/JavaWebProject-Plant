package com.plant;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class MapperTest {

	@Autowired
	private DbSetMapper dbMapper;
	
	
	@Test
	public void test () {
		DataVO vo = new DataVO();
		
		log.info(dbMapper.apiInsert(vo));
		
	}
}
