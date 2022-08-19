package com.plant.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	int insert(UserVO vo);
	int emailDupCheck(String id);
	UserVO loginCheck(UserVO vo);
	UserVO findEmail(UserVO vo);
	UserVO findPwd(UserVO vo);
	void updateTempPwd(UserVO vo);
}
