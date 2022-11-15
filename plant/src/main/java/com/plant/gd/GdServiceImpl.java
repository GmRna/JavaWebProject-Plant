package com.plant.gd;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.plant.gd.GdVO;
import com.plant.user.UserVO;
import util.SendMail;

@Service
public class GdServiceImpl implements GdService {

	@Autowired
	GdMapper mapper;
	
	@Override
	public Map index(GdVO vo) {
		int totalCount = mapper.count(vo);
		int totalPage = totalCount / vo.getPageRow();
		
		if(totalCount % vo.getPageRow() > 0) totalPage++;

		//시작 인덱스 / boardMapper.xml 쿼리문과 비교해가면서 메소드를 완성시켜야한다.
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		// 이후 set으로 호춯	
		vo.setStartIdx(startIdx);
		List<GdVO> list = mapper.list(vo);
		
		// 페이징처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage-9;
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;

		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("list", list);
		
		return map;
	}
	
	@Override
	public int insert(GdVO vo) {
		int no = mapper.insert(vo);
		no = vo.getGd_no();
		return no;
	}
	
	@Override
	public int insertcar(GdVO vo) {		
		return mapper.insertcar(vo);
	}

	@Override
	public int insertcer(GdVO vo) {
		
		return mapper.insertcer(vo);
	}
	
	@Override
	public int edit(GdVO vo) {
		int no = mapper.edit(vo);
		return no;
	}

	@Override
	public int emailDupCheck(String id) {
		return mapper.emailDupCheck(id);
	}

	@Override
	public boolean loginCheck(GdVO vo, HttpSession sess) {
		boolean r = false;
		GdVO loginGdInfo = mapper.loginCheck(vo);
		if (loginGdInfo != null) {
			r = true;
			// 로그인 성공시 세션에 저장
			sess.setAttribute("loginGdInfo", loginGdInfo);
		}
		return r;
	}
	
	@Override
	public GdVO findEmail(GdVO vo) {
		return mapper.findEmail(vo);
	}
	
	@Override
	public GdVO findPwd(GdVO vo) {
		// update
		GdVO mv = mapper.findPwd(vo);
		if (mv != null) {
			// 임시 비밀번호 생성
			// 영문 세 자리, 숫자 세 자리
			String temp = "";
			for (int i=0; i<3; i++) {
				temp += (char)(Math.random() * 26 + 65);
			}
			for (int i=0; i<3; i++) {
				temp += (int)(Math.random() * 9);
			}
			
			// 임시 비밀번호 update
			vo.setGd_pwd(temp);
			mapper.updateTempPwd(vo);
			
			// email 발송
			SendMail.sendMail("carmania4567@naver.com", vo.getGd_email(), "[식물통합정보사이트]임시비밀번호", "임시비밀번호:"+temp);
			
			return mv;
		} else {
			return null;
		}
	}
	
	@Override
	public GdVO view(int gd_no) {
		return mapper.view(gd_no);
	}
	
	@Override
	public boolean delete(int gd_no) {
		return mapper.delete(gd_no) > 0 ? true : false;
	}
	
	@Override
	public GdVO detail(int gd_no) {
		return mapper.detail(gd_no);
	}
	
	@Override
	public GdVO myInfo(String gd_id) {
		return mapper.myInfo(gd_id);
	}

	@Override
	public GdVO getInfo(String gd_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int access(GdVO vo) {
		return mapper.access(vo);
	}

	@Override
	public int insert2(GdVO vo) {
		int no = mapper.insert(vo);
		no = vo.getGd_no();
		return no;
	}
	
	@Override
	public int insertcar2(GdVO vo) {		
		return mapper.insertcar(vo);
	}

	@Override
	public int insertcer2(GdVO vo) {		
		return mapper.insertcer(vo);
	}

	@Override
	public GdVO status(String gd_id) {
		return mapper.status(gd_id);
	}




}
