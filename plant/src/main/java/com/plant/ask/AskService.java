package com.plant.ask;

import java.util.Map;

public interface AskService {
	
	Map index(AskVO vo);
	
	AskVO view(int ask_no);
	AskVO edit(int ask_no);
	
		
	boolean insert(AskVO vo);
	boolean update(AskVO vo);
	boolean delete(int ask_no);
	

}
