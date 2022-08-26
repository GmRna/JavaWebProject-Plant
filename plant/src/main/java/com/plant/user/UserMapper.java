package com.plant.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	int insert(UserVO vo);
	int emailDupCheck(String id);
	int nickDupCheck(String id);
	
	List<UserVO> list(UserVO vo);
	
	UserVO view(int user_no);
	UserVO loginCheck(UserVO vo);
	UserVO findEmail(UserVO vo);
	UserVO findPwd(UserVO vo);
	void updateTempPwd(UserVO vo);
	
	int delete(int user_no);
	int count(UserVO vo);
	UserVO detail(int user_no);
	UserVO myInfo(String user_id);
	int edit(UserVO vo);

}
