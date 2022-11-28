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
	public Map list(PetplantVO vo) {
		int totalCount = mapper.listCount(vo);
		
		// 총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() -1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<PetplantVO> list = mapper.list(vo);

		// 페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/ 10.0)* vo.getPageRow());
		int startPage = endPage-9;
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startIdx > 1 ? true : false;
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
	public Map findpetfile(PetplantVO vo) {
		List<PetplantVO> flist = mapper.findpetfile(vo);
		List<PetplantVO> rlist = mapper.findpetreply(vo);
		
		int checkLike = mapper.checkLike(vo);
		
		
		//List<PetplantVO> likecount = mapper.countLike(vo); 
		
		Map map = new HashMap();
		
		map.put("flist", flist);
		map.put("rlist", rlist);
		map.put("checkLike", checkLike);
		
		// 댓글 수 불러오기
		
		int no = vo.getPet_no();
		int count_reply = mapper.countreply(no);
		map.put("countreply", count_reply);
		
		//map.put("likecount", likecount);
		
		return map;
	}
	
	// 첫 댓글 등록
	@Override
	public boolean reply(PetplantVO vo) {
		
		if(vo.getPpr_secretCheck() == null) {
			vo.setPpr_secretCheck("0");
		}
		
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
		
		// 댓글 수 불러오기
		int countreply = mapper.countreply(no);
		map.put("countreply", countreply);
				
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

	// 댓글 삭제
	@Override
	public int delreply(PetplantVO vo) {
		return mapper.delreply(vo);
	}
	// 답글 삭제
	@Override
	public int delRereply(PetplantVO vo) {
		return mapper.delRereply(vo);
	}
	
	// 댓글 수정
	@Override
	public int modreply(PetplantVO vo) {
		return mapper.modreply(vo);
	}
	// 답글 수정
	@Override
	public int modRereply(PetplantVO vo) {
		return mapper.modRereply(vo);
	}

	@Override
	public List<PetplantVO> select(PetplantVO vo) {
		return mapper.select(vo);
	}

	// 반려 식물 게시판 - 수정 내용 불러오기
	@Override
	public PetplantVO findpetcontent(int pet_no) {
		return mapper.findpetcontent(pet_no);
	}

	@Override
	public Map findFile(PetplantVO vo) {
		List<PetplantVO> flist = mapper.findpetfile(vo);
		
		Map map = new HashMap();
		map.put("flist", flist);
		
		return map;
	}
	
	// 반려 게시판 수정 - 내용
	@Override
	public int update(PetplantVO vo) {
		return mapper.update(vo);
	}
	// 반려 게시판 수정 - 사진
	@Override
	public int updatefile(PetplantVO vo) {
		vo.setFile_tablename("petplant");
		return mapper.updatefile(vo);
	}

	@Override
	public int deletefile(PetplantVO vo) {
		return mapper.deletefile(vo);
	}

	@Override
	public int selectsavepetplant(PetplantVO vo) {
		return mapper.selectsavepetplant(vo);
	}

	@Override
	public int pluspetplant(PetplantVO vo) {
		return mapper.pluspetplant(vo);
	}

	@Override
	public int minuspetplant(PetplantVO vo) {
		return mapper.minuspetplant(vo);
	}

	@Override
	public PetplantVO listpop(PetplantVO vo) {
		return mapper.listpop(vo);
	}
	
	
	// 검색기능
	@Override
	public Map searchpet(PetplantVO vo) {
		Map map = new HashMap();
		List<PetplantVO> list = mapper.searchpet(vo);
		
		map.put("list", list);
		
		
		return map;
	}
	// 게시판 삭제
	@Override
	public int delete(PetplantVO vo) {
		return mapper.delete(vo);
	}

	@Override
	public Map list2(PetplantVO vo) {
		int totalCount = mapper.listCount(vo);
		
		// 총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() -1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<PetplantVO> list = mapper.list(vo);

		// 페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/ 10.0)* vo.getPageRow());
		int startPage = endPage-9;
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startIdx > 1 ? true : false;
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

	// 반려식물 게시물 리스트
	@Override
	public Map savepetList(PetplantVO vo) {
		int totalCount = mapper.savelistCount(vo);
		
		// 총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if (totalCount % vo.getPageRow() > 0) totalPage++;
		
		int startIdx = (vo.getPage() -1) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<PetplantVO> list = mapper.savepetList(vo);

		// 페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/ 10.0)* vo.getPageRow());
		int startPage = endPage-9;
		
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startIdx > 1 ? true : false;
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
	
}

