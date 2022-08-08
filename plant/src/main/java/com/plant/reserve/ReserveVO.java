package com.plant.reserve;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReserveVO {
	
	// gd
	private int gd_no; // 가드너 no
	private String gd_major; // 가드너 주요 종목
	private String gd_ableaddr; // 가드너 출장가능지역
	private String gd_name; // 가드너 이름
	
	// user 
	private int user_no; // 유저 no
	
	// 리뷰
	private int review_no; // 리뷰 no
	private Timestamp review_date; // 리뷰 남긴 시간
	private String review; // 리뷰 내용
	private double star; // 별점
	private String review_answer; // 리뷰 답글
	
	// 예약
	private int reserve_no; // 예약번호
	private int reserve_date; // 예약년월일
	private int reserve_hour; // 예약 시간
	private String reserve_etc; // 예약 특이사항
	private Timestamp reserve_time; // 예약한 시간
	private int reserve_pay;
	
	//케어종목가격
	private int major_no; // 케어종목 번호
	private String major; // 케어종목
	private int major_price; // 케어종목 가격
	
	// 1:1 문의
	private int inquiry_no; // 문의 번호
	private Timestamp inquiry_date; // 문의한 시간
	private String inquiry; // 문의 내용
	private String inquiry_answer; // 문의 답변
	
	// 결제
	private int pay_no; // 결제번호
	private Timestamp pay_date; // 결제 시간
	private int pay_size; // 결제액
	
	// 취소
	private int cancel_no; // 취소 번호
	private Timestamp cancel_date; // 취소한 시간
	private String cancel_comment; // 취소 사유
	private int cancel_type; // 취소 타입 0 이면 유저가 취소 1이면 가드너가 취소
	
	// 가드너 예약가능시간
	private int reservable_no; // 예약가능시간 번호
	private int reservable_date; // 예약가능 년월일
	private int reservable_hour; // 예약가능 시간
	private int reservable_do; // 예약여부 0이면 예약가능 1이면 예약 불가
	private Timestamp reservable_time; // 예약가능시간 등록일
	
	// 예약가능한 케어종목
	private int reservable_major_no; // 예약가능한 케어종목 번호
	private String reservable_major; // 예약가능한 종목
	
	// 검색
	private String stype; // 검색타입
	private String sword; // 검색어
	
	// 체크박스
	private String reserveSaerch1; // 검색조건 : 케어종목
	private String reserveSaerch2; // 검색조건 : 출장가능주소
	private String reserveSaerch3; // 검색조건 : 가드너 이름
	
	// 정렬 카테고리
	private String category;
	
	// 
	private int dateStart;
	private int dateEnd;

}
