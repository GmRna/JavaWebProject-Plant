package com.plant.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	ReserveMapper mapper;

	@Override
	public List<ReserveVO> searchGd(ReserveVO vo) {
		return mapper.searchGd(vo);
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
	public ReserveVO viewGd(ReserveVO vo) {
		return mapper.viewGd(vo);
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
	public int payReservation(ReserveVO vo) {

		return mapper.payReservation(vo);
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


	
	
}
