package com.plant.petplant;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PetplantServiceImpl implements PetplantService {

	
	@Autowired
	PetplantMapper mapper;
	
	// 반려식물 전체 리스트 (첫화면)
	@Override
	public List<PetplantVO> list(PetplantVO vo) {
		return mapper.list(vo);
	}

	// 반려식물 게시물 등록
	@Override
	public int insert(PetplantVO vo) {
		int no = mapper.insert(vo);
		no = vo.getPet_no();
		System.out.println("serviceimpl 에서의 no" + no);
		return no;
	}
	// 반려식물 파일 등록
	@Override
	public int insertfile(PetplantVO vo) {
		vo.setFile_tablename("petplant");
		return mapper.insertfile(vo);
	}

	// 반려식물 상세보기-파일 및 댓글
	@Override
	public Map Detpetplant(int no) {
		List<PetplantVO> list = mapper.findpetplant(no);
		List<PetplantVO> rlist = mapper.findpetreply(no);
		//PetplantVO vo = new PetplantVO();
		
		//List<PetplantVO> likecount = mapper.countLike(vo); 
		
		Map map = new HashMap();
		
		map.put("list", list);
		map.put("rlist", rlist);
		//map.put("likecount", likecount);
		
		return map;
	}
	
	// 첫 댓글 등록
	@Override
	public boolean reply(PetplantVO vo) {
		boolean in = mapper.reply(vo);
		if(in) mapper.gnoUpdate(vo.getPpr_no());	// 댓글의 pk를 가져와야 하니까
		return in;
	}
	
	// 반려식물 대댓글 달기
	@Override
	public boolean rereply(PetplantVO vo) {
		mapper.onoUpdate(vo);
		vo.setPpr_order(vo.getPpr_order()+1);
		vo.setPpr_nested(vo.getPpr_nested()+1);
		return mapper.rereply(vo) > 0 ? true : false;
	}
	// 반려식물 댓글 저장 후 불러오기
	@Override
	public Map findpetreply(int no) {
		List<PetplantVO> list = mapper.findpetreply(no);
		Map map = new HashMap();
		map.put("list", list);
		return map;
	}
	
	
	// 좋아요 체크
	@Override
	public int checkLike(PetplantVO vo) {
		return mapper.checkLike(vo);
	}
	
	// 좋아요, 댓글좋아요 플러스
	@Override
	public int plustLike(PetplantVO vo) {
		return mapper.plusLike(vo);
	}
	
	// 좋아요 마이너스 
	@Override
	public int minusLike(PetplantVO vo) {
		return mapper.minusLike(vo);
	}
	
	// 댓글 좋아요 카운트
	@Override
	public int countLikeReply(int no) {
		return mapper.countLikeReply(no);
	}
	
	// 댓글 좋아요 체크 
	@Override
	public int checkLikeReply(PetplantVO vo) {
		return mapper.checkLikeReply(vo);
	}

	
	
	
}
