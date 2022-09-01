package com.plant.reserve;

import java.util.List;

public interface ReserveService {
	
	// 가드너 조회
	List<ReserveVO> searchGd(ReserveVO vo); // 가드너 리스트 검색
	List<ReserveVO> searchGdReview(ReserveVO vo); // 검색된 가드너 리뷰목록 조회
	List<ReserveVO> majorList(ReserveVO vo); // 케어종목 리스트
	ReserveVO viewGd(ReserveVO vo); // 가드너 상세보기
	List<ReserveVO> searchGdReservable(ReserveVO vo); // 가드너 예약 가능 시간 조회
	List<ReserveVO> searchGdReserved(ReserveVO vo); // 가드너 예약된 내역 조회
	ReserveVO completionCount(ReserveVO vo); // 가드너 케어완료 수 조회
	List<ReserveVO> selectGdCertificate(ReserveVO vo); // 가드너 자격증 조회
	List<ReserveVO> selectGdCareer(ReserveVO vo); // 가드너 이력 조회
	
	// 유저 조회
	ReserveVO user(ReserveVO vo); // 유저정보 조회
	
	// 예약가능 스케줄
	int insertReservable(ReserveVO vo); // 예약일정 insert
	int updateReservable(ReserveVO vo); // 예약 확정시 update
	int changeReservable(ReserveVO vo); // 예약일정 변경(시간)
	ReserveVO selectReserveVal(int Reserve_no); // 선택학 예약번호로 예약정보 조회
	int deleteReservable(ReserveVO vo); // 예약가능 스케줄의 삭제

	// 예약가능 스케줄 케어종목
	int insertReservableMajor(ReserveVO vo); // 예약가능 스케줄의 케어종목 insert
	int changeReservableMajor(ReserveVO vo); // 예약가능 스케줄의 케어종목 변경
	int deleteReservableMajor(ReserveVO vo); // 예약가능 종목의 삭제
	
	// 예약
	ReserveVO viewReservation(ReserveVO vo); // 예약내역 조회
	List<ReserveVO> userReservation(ReserveVO vo); // 유저예약 내역 확인
	List<ReserveVO> gdReservation(ReserveVO vo); // 가드너 내역 확인
	List<ReserveVO> selectGdReservationCancel(ReserveVO vo); // 가드너 예약 취소 내역 확인
	int insertReservation(ReserveVO vo); // 예약 insert
	int changeReservation(ReserveVO vo); // 예약 변경
	int updateReservation(ReserveVO vo); // 결제시 결제 컬럼값 변경
	int updateReservationCancel(ReserveVO vo); // 예약 취소 여부 업데이트
	int updateRservationReview(ReserveVO vo); // 리뷰 등록 여부 업데이트
	
	// 취소
	int insertCancel(ReserveVO vo); // 취소 insert
	List<ReserveVO> selectGdCancel(ReserveVO vo); // 가드너 취소내역 조회
	
	// 리뷰
	int insertReview(ReserveVO vo); // 리뷰 insert
	int answerReview(ReserveVO vo); // 리뷰 답변 update
	List<ReserveVO> selectUserReview(ReserveVO vo); // 유저 리뷰 내역
	List<ReserveVO> selectGdReview(ReserveVO vo); // 가드너 리뷰 내역
	
	// 1:1문의
	int insertInquiry(ReserveVO vo); // 1:1문의 insert
	int answerInquiry(ReserveVO vo); // 1:1문의 답변 update
	
	// 결제
	int insertPay(ReserveVO vo); // 결제 insert
	int updatePayCancel(ReserveVO vo); // 결제 취소 여부 업데이트
	List<ReserveVO> gdPayHistory(ReserveVO vo); // 유저결제 내역 확인
	List<ReserveVO> userPayHistory(ReserveVO vo); // 가드너결제 내역 확인
	List<ReserveVO> userPayHistoryDeduplication(ReserveVO vo); // 유저 결제 내역 중복내역 제거
	
	//트랜잭션
	int payProcess(ReserveVO vo); // 페이 트랜잭션
	
	// 케어진행
	int insertCompletion(ReserveVO vo); // 케어진행내용 입력
	int updateCompletion(ReserveVO vo); // 케어진행완료 여부 입력
	List<ReserveVO> selectCompletionGd(ReserveVO vo); // 가드너 케어진행된 내역 불러오기
	List<ReserveVO> selectCompletionUser(ReserveVO vo); // 유저 케어진행된 내역 불러오기
	List<ReserveVO> selectNoCompletion(ReserveVO vo); // 케어진행되지 않은 내역 불러오기 
}
