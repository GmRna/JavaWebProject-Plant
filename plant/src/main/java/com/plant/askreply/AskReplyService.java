package com.plant.askreply;

import java.util.Map;

public interface AskReplyService {
	
	Map index(AskReplyVO vo);
	
	AskReplyVO view(int no);
	AskReplyVO edit(int no);
	
	boolean insert(AskReplyVO vo);
	boolean update(AskReplyVO vo);
	boolean reply(AskReplyVO vo);
	boolean delete(int no);

}
