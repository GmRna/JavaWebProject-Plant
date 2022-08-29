package com.plant.questcomment;
import java.sql.Timestamp;
 
 import lombok.Getter; import lombok.Setter; import lombok.ToString;
  
  
  @Getter
  @Setter
  @ToString 
  
  public class QuestCommentVO {
  
  private int no; 
  private String content; 
  private int user_no; 
  private int quest_no; 
  private Timestamp regdate; 
  private String tablename;
  
  //NoticeService에서 목록을 불러오는 용도
  
	private int startIdx;
	private int pageRow;
	private int page;
	
	public QuestCommentVO() {
		this.pageRow = 10;
		this.page = 1;
	}
}
