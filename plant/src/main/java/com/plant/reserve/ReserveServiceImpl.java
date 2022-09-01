package com.plant.reserve;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import util.DeduplicationUtils;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	ReserveMapper mapper;

	@Override
	public List<ReserveVO> searchGd(ReserveVO vo) {
		// gd 리스트 가져오기
		List<ReserveVO> list = mapper.searchGd(vo); 
		// exist 배열 생성
		List<ReserveVO> exist = new ArrayList<ReserveVO>();
		// 해당하는 gd가 예약가능한 일정이 있는 경우만 exist 배열에 저장
		for(int i=0; i<list.size(); i++) {
			if (mapper.searchGdReservable(list.get(i)) != null && mapper.searchGdReservable(list.get(i)).isEmpty() == false) {
				exist.add(list.get(i));
			} 
		}
		return exist;
	}

	@Override
	public List<ReserveVO> searchGdReview(ReserveVO vo) {
		return mapper.searchGdReview(vo);
	}

	@Override
	public List<ReserveVO> majorList(ReserveVO vo) {

		return mapper.majorList(vo);
	}
	
	@Override
	public List<ReserveVO> searchGdReservable(ReserveVO vo) {
		return mapper.searchGdReservable(vo);
	}
	
	@Override
	public List<ReserveVO> searchGdReserved(ReserveVO vo) {
		return mapper.searchGdReserved(vo);
	}
	
	@Override
	public ReserveVO viewGd(ReserveVO vo) {
		return mapper.viewGd(vo);
	}
	
	@Override
	public ReserveVO completionCount(ReserveVO vo) {
		return mapper.completionCount(vo);
	}
	
	@Override
	public int insertReservable(ReserveVO vo) {

		return mapper.insertReservable(vo);
	}

	@Override
	public int updateReservable(ReserveVO vo) {
	
		return mapper.updateReservable(vo);
	}

	@Override
	public int changeReservable(ReserveVO vo) {
		
		return mapper.changeReservable(vo);
	}

	@Override
	public int insertReservableMajor(ReserveVO vo) {

		return mapper.insertReservableMajor(vo);
	}

	@Override
	public int changeReservableMajor(ReserveVO vo) {

		return mapper.changeReservableMajor(vo);
	}

	@Override
	public int insertReservation(ReserveVO vo) {

		return mapper.insertReservation(vo);
	}

	@Override
	public int changeReservation(ReserveVO vo) {

		return mapper.changeReservation(vo);
	}

	@Override
	public int updateReservation(ReserveVO vo) {

		return mapper.updateReservation(vo);
	}

	@Override
	public int insertCancel(ReserveVO vo) {

		return mapper.insertCancel(vo);
	}

	@Override
	public int insertReview(ReserveVO vo) {

		return mapper.insertReview(vo);
	}

	@Override
	public int answerReview(ReserveVO vo) {

		return mapper.answerReview(vo);
	}

	@Override
	public int insertInquiry(ReserveVO vo) {

		return mapper.insertInquiry(vo);
	}

	@Override
	public int answerInquiry(ReserveVO vo) {

		return mapper.answerInquiry(vo);
	}

	@Override
	public int insertPay(ReserveVO vo) {

		return mapper.insertPay(vo);
	}

	@Override
	public ReserveVO user(ReserveVO vo) {
		return mapper.user(vo);
	}
	
	@Override
	public ReserveVO selectReserveVal(int Reserve_no) {
		
		return mapper.selectReserveVal(Reserve_no);
	}

	@Override
	public ReserveVO viewReservation(ReserveVO vo) {
		
		return mapper.viewReservation(vo);
	}

	@Override
	public List<ReserveVO> userReservation(ReserveVO vo) {

		return mapper.userReservation(vo);
	}

	@Override
	public List<ReserveVO> gdReservation(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.gdReservation(vo);
	}

	@Override
	public List<ReserveVO> gdPayHistory(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.gdPayHistory(vo);
	}

	@Override
	public List<ReserveVO> userPayHistory(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.userPayHistory(vo);
	}

	@Override
	public int updateReservationCancel(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateReservationCancel(vo);
	}

	@Override
	public int updatePayCancel(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.updatePayCancel(vo);
	}

	@Override
	public List<ReserveVO> userPayHistoryDeduplication(ReserveVO vo) { 
		
		return mapper.userPayHistoryDeduplication(vo);
	}
	
	// pay 프로세스 트랜잭션 처리
	@Override
	@Transactional
	public int payProcess(ReserveVO vo) {
		mapper.insertReservation(vo);
		mapper.updateReservable(vo);
		mapper.updateReservation(vo);
		mapper.insertPay(vo);
		return 1;
	}

	@Override
	public int deleteReservable(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteReservable(vo);
	}

	@Override
	public int deleteReservableMajor(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteReservableMajor(vo);
	}

	@Override
	public int insertCompletion(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertCompletion(vo);
	}

	@Override
	public int updateCompletion(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateCompletion(vo);
	}

	@Override
	public List<ReserveVO> selectCompletionGd(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectCompletionGd(vo);
	}
	
	@Override
	public List<ReserveVO> selectCompletionUser(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectCompletionUser(vo);
	}

	@Override
	public List<ReserveVO> selectNoCompletion(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectNoCompletion(vo);
	}

	@Override
	public int updateRservationReview(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateRservationReview(vo);
	}

	@Override
	public List<ReserveVO> selectUserReview(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectUserReview(vo);
	}
	
	@Override
	public List<ReserveVO> selectGdReview(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectGdReview(vo);
	}

	@Override
	public List<ReserveVO> selectGdCancel(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectGdCancel(vo);
	}

	@Override
	public List<ReserveVO> selectGdReservationCancel(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.selectGdReservationCancel(vo);
	}


}
