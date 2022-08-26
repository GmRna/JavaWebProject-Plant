package com.plant.freecomment;
import java.sql.Timestamp;
 
 import lombok.Getter; import lombok.Setter; import lombok.ToString;
  
  
  @Getter
  @Setter
  @ToString 
  
  public class FreeCommentVO {
  
  private int no; 
  private String content; 
  private int user_no; 
  private int free_no; 
  private Timestamp regdate; 
  private String tablename;
  
  //NoticeService에서 목록을 불러오는 용도
  
	private int startIdx;
	private int pageRow;
	private int page;
	
	public FreeCommentVO() {
		this.pageRow = 10;
		this.page = 1;
	}
}
