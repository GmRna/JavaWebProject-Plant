package com.plant.reserve;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class ReserveMapperTest {

	@Autowired
	private ReserveMapper mapper;
	
	
//	@Test
	public void insertReservableTest () {
		ReserveVO vo = new ReserveVO();
		vo.setGd_no(2);
		vo.setReservable_date(20220802);
		vo.setReservable_hour(13);
		
		log.info(mapper.insertReservable(vo));
		
	}
	
//	@Test
	public void updateReservableTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReservable_do(1);
		vo.setReservable_no(12);
		
		log.info(mapper.updateReservable(vo));
		
	}
	
//	@Test
	public void changeReservableTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReservable_no(12);
		vo.setReservable_date(20220731);
		vo.setReservable_hour(16);
		
		log.info(mapper.changeReservable(vo));
		
	}
	
//	@Test
	public void insertReservableMajorTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReservable_no(15);
		vo.setReservable_major("분재갈이");
		
		log.info(mapper.insertReservableMajor(vo));
		
	}
	
//	@Test
	public void changeReservableMajorTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReservable_major_no(6);
		vo.setReservable_major("가지치기");
		
		log.info(mapper.changeReservableMajor(vo));
		
	}
	
//	@Test
	public void insertReservationTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReservable_no(15);
		vo.setGd_no(2);
		vo.setUser_no(1);
		vo.setReserve_date(20220822);
		vo.setReserve_hour(13);
		vo.setReserve_etc("없습니다.");
		vo.setMajor_no(1);
		
		log.info(mapper.insertReservation(vo));
		
	}
	
//	@Test
	public void changeReservationTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(1);
		vo.setReserve_date(20220731);
		vo.setReserve_hour(16);
		vo.setMajor_no(5);
		
		log.info(mapper.changeReservation(vo));
		
	}
	
//	@Test
	public void payReservationTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(5);
		vo.setReserve_pay(1);
		
		log.info(mapper.payReservation(vo));
		
	}
	
//	@Test
	public void insertCancelTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(1);
		vo.setGd_no(1);
		vo.setUser_no(2);
		vo.setCancel_comment("개인 스케줄로 인해 취소합니다");
		vo.setCancel_type(2);
		
		log.info(mapper.insertCancel(vo));
		
	}
	
//	@Test
	public void insertReviewTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(5);
		vo.setGd_no(2);
		vo.setUser_no(1);
		vo.setReview("깔끔하게 일 처리해주셨습니다.");
		vo.setStar(4.5);
		
		log.info(mapper.insertReview(vo));
		
	}
	
//	@Test
	public void answerReviewTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReview_no(2);
		vo.setReview_answer("따뜻한 리뷰 감사합니다.");
		
		log.info(mapper.answerReview(vo));
		
	}
	
//	@Test
	public void insertInquiryTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(5);
		vo.setGd_no(2);
		vo.setUser_no(1);
		vo.setInquiry("분재갈이는 1개만 진행가능한가요?");
		
		log.info(mapper.insertInquiry(vo));
		
	}
	
//	@Test
	public void answerInquiryTest () {
		ReserveVO vo = new ReserveVO();
		vo.setInquiry_no(1);
		vo.setInquiry_answer("아뇨 정해진 시간 내에서는 여러개도 가능합니다만, 개당 30분이라고 치면 2개까지 가능합니다.");
		
		log.info(mapper.answerInquiry(vo));
		
	}
	
//	@Test
	public void insertPayTest () {
		ReserveVO vo = new ReserveVO();
		vo.setReserve_no(1);
		vo.setPay_size(30000);
		
		log.info(mapper.insertPay(vo));
		
	}
	
	@Test
	public void searchGdTest() {
		ReserveVO vo = new ReserveVO();
//		vo.setGd_no(2);
//		vo.setDateStart(20220802);
//		vo.setDateEnd(20220801);
//		vo.setSearchMajor("분재갈이"); 
		vo.setCategory("littleReview");
		List<ReserveVO> list = mapper.searchGd(vo);
		list.forEach(ReserveVO -> log.info(list));
	}
	
//	@Test
	public void searchGdReview() {
		ReserveVO vo = new ReserveVO();
		vo.setGd_no(2);
		List<ReserveVO> list = mapper.searchGdReview(vo);
		list.forEach(ReserveVO -> log.info(list));
	}
}
