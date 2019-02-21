package com.Ex.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.Ex.dto.MemberVO;
import com.Ex.dto.UserVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.Ex.mapper.memberMapper";

	@Override
	public List<MemberVO> selectAll() throws Exception {

		return sqlSession.selectList(Namespace + ".selectAll");
	}
	
	@Override
	public List<MemberVO> selectSearch(String value) throws Exception {

		return sqlSession.selectList(Namespace + ".selectSearch",value);
	}
	
	@Override
	public List<MemberVO> selectView(int code) throws Exception {

		return sqlSession.selectList(Namespace + ".selectView", code);
	}
	
	@Override
	public List<UserVO> selectUser() throws Exception {

		return sqlSession.selectList(Namespace + ".selectUser");
	}
	
	@Override
	public void deleteBoard(int code) throws Exception {
		sqlSession.delete(Namespace + ".deleteBoard", code);
	}
	
	@Override
	public void updateBoard(MemberVO memberVO) throws Exception {
		sqlSession.update(Namespace + ".updateBoard", memberVO);
	}
	
	@Override
	public void insertBoard(MemberVO memberVO) throws Exception {
		sqlSession.insert(Namespace + ".insertBoard", memberVO);
	}
	
	@Override
	public void updateNum(int code) throws Exception {
		sqlSession.update(Namespace + ".updateNum", code);
	}
	
}