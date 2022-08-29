package com.plant.questreply;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface QuestReplyService {
	
	//목록
	
	Map index(QuestReplyVO vo);
	
	QuestReplyVO view(int no);
	QuestReplyVO edit(int no);
	
	boolean update(QuestReplyVO vo);
	boolean insert(QuestReplyVO vo);
	boolean reply(QuestReplyVO vo);
	boolean delete(int no);

	
}