package com.plant.todayflower;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TDFlowerVO {
	
	// 오늘의 꽃
	private int tf_no; // 오늘의 꽃 번호
	private String tf_name; // 오늘의 꽃 이름(국문)
	private String tf_ename; // 오늘의 꽃 이름(영문)
	private int tf_month; // 오늘의 꽃 (월)
	private int tf_day; // 오늘의 꽃 (일)
	private String tf_content; // 오늘의 꽃 내용 
	private String tf_lang; // 오늘의 꽃 꽃말
	private String tf_img; // 오늘의 꽃 사진이름
	private String tf_url; // 오늘의 꽃 사진URL
	private String tf_org; // 오늘의 꽃 출처
	private String tf_use; // 오늘의 꽃 쓰임새
	private String tf_grow; // 오늘의 꽃 기르기
	private String tf_type; // 오늘의 꽃 타입

}
