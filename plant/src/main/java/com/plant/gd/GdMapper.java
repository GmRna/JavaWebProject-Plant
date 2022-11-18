 package com.plant.gd;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.plant.user.UserVO;

@Mapper
public interface GdMapper {
	int insert(GdVO vo);
	int insertcar(GdVO vo);
	int insertcer(GdVO vo);
	int emailDupCheck(String id);
	GdVO loginCheck(GdVO vo);
	GdVO findEmail(GdVO vo);
	GdVO findPwd(GdVO vo);
	int updateTempPwd(GdVO vo);
	
	List<GdVO> list(GdVO vo);
	GdVO view(int gd_no);
	
	GdVO detail(int gd_no);
	int count(GdVO vo);
	int delete(int gd_no);
	GdVO myInfo(int gd_no);
	int access(GdVO vo);
	int edit(GdVO vo);
	
	int insert2(GdVO vo);
	int insertcar2(GdVO vo);
	int insertcer2(GdVO vo);
	GdVO status(String gd_id);
}
