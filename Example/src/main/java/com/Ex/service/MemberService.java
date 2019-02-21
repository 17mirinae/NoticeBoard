package com.Ex.service;

import java.util.List;

import com.Ex.dto.MemberVO;
import com.Ex.dto.UserVO;

public interface MemberService {

	public List<MemberVO> selectAll() throws Exception;
	
	public List<MemberVO> selectSearch(String value) throws Exception;

	public List<UserVO> selectUser() throws Exception;
	
	public List<MemberVO> selectView(int code) throws Exception;

	public void insertBoard(MemberVO memberVO) throws Exception;

	public void deleteBoard(int code) throws Exception;

	public void updateBoard(MemberVO memberVO) throws Exception;

}
