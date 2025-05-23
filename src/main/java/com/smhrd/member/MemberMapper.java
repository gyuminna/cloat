package com.smhrd.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	public MemberVO login(MemberVO vo);
	public void join(MemberVO vo);	
	public int IdCheck(String id);
	public int update(MemberVO vo);
}