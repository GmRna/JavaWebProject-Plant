package com.plant.admin;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

	AdminVO loginCheck(AdminVO vo);
}
