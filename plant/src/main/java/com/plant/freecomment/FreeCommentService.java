package com.plant.freecomment;
import java.util.Map;


public interface FreeCommentService {
	Map index(FreeCommentVO vo);
	int insert(FreeCommentVO vo);
	int delete(FreeCommentVO vo);
}
