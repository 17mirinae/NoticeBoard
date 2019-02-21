package com.Ex.dao;

import java.util.List;

import com.Ex.dto.MemberVO;
import com.Ex.dto.UserVO;
 
public interface MemberDAO {
    
    List<MemberVO> selectAll() throws Exception;

	List<MemberVO> selectSearch(String value) throws Exception;

    List<MemberVO> selectView(int code) throws Exception;
    
    List<UserVO> selectUser() throws Exception;
    
    void insertBoard(MemberVO memberVO) throws Exception;

	void deleteBoard(int code) throws Exception;
	
	void updateBoard(MemberVO memberVO) throws Exception;
	
	void updateNum(int code) throws Exception;

}
