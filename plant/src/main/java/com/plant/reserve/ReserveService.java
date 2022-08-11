package com.plant.reserve;

import java.util.List;

public interface ReserveService {
	
	// 가드너 조회
	List<ReserveVO> searchGd(ReserveVO vo); // 가드너 리스트 검색
	List<ReserveVO> searchGdReview(ReserveVO vo); // 검색된 가드너 리뷰목록 조회
	List<ReserveVO> majorList(ReserveVO vo); // 케어종목 리스트
	ReserveVO viewGd(ReserveVO vo); // 가드너 상세보기
	List<ReserveVO> searchGdReservable(ReserveVO vo); // 가드너 예약 가능 시간 조회
	
	// 예약가능 스케줄
	int insertReservable(ReserveVO vo); // 예약일정 insert
	int updateReservable(ReserveVO vo); // 예약 확정시 update
	int changeReservable(ReserveVO vo); // 예약일정 변경(시간)

	// 예약가능 스케줄 케어종목
	int insertReservableMajor(ReserveVO vo); // 예약가능 스케줄의 케어종목 insert
	int changeReservableMajor(ReserveVO vo); // 예약가능 스케줄의 케어종목 변경
	
	// 예약
	int insertReservation(ReserveVO vo); // 예약 insert
	int changeReservation(ReserveVO vo); // 예약 변경
	int payReservation(ReserveVO vo); // 결제시 결제 컬럼값 변경
	
	// 취소
	int insertCancel(ReserveVO vo); // 취소 insert
	
	// 리뷰
	int insertReview(ReserveVO vo); // 리뷰 insert
	int answerReview(ReserveVO vo); // 리뷰 답변 update
	
	// 1:1문의
	int insertInquiry(ReserveVO vo); // 1:1문의 insert
	int answerInquiry(ReserveVO vo); // 1:1문의 답변 update
	
	// 결제
	int insertPay(ReserveVO vo); // 결제 insert
}
