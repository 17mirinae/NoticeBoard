package com.Ex.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Ex.dao.MemberDAO;
import com.Ex.dto.MemberVO;
import com.Ex.dto.UserVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;

	@Autowired
	private MemberDAO memberDAOService;

	@Override
	public List<MemberVO> selectAll() throws Exception {

		return dao.selectAll();
	}
	
	@Override
	public List<MemberVO> selectSearch(String value) throws Exception {

		return dao.selectSearch(value);
	}

	@Override
	public List<MemberVO> selectView(int code) throws Exception {

		return dao.selectView(code);
	}

	@Override
	public List<UserVO> selectUser() throws Exception {

		return dao.selectUser();
	}
	
	@Override
	public void deleteBoard(int code) throws Exception {
		memberDAOService.deleteBoard(code);
	}
	
	@Override
	public void insertBoard(MemberVO memberVO) throws Exception {
		memberDAOService.insertBoard(memberVO);
	}
	
	@Override
	public void updateBoard(MemberVO memberVO) throws Exception{
		memberDAOService.updateBoard(memberVO);
	}


}
