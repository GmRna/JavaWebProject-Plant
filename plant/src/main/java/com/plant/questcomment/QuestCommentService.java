package com.plant.questcomment;
import java.util.Map;


public interface QuestCommentService {
	Map index(QuestCommentVO vo);
	int insert(QuestCommentVO vo);
	int delete(QuestCommentVO vo);
}
