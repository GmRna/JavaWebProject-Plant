package com.plant.quest;

import java.util.Map;

public interface QuestService {

	Map index(QuestVO vo);
	
	QuestVO edit(int quest_no);
	QuestVO view(int quest_no);
	boolean update(QuestVO vo);
	boolean insert(QuestVO vo);
	boolean delete(int quest_no);
	
	
}
