package com.test.web.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;

public interface MemberDao {

	/** 회원정보를 조회해서 가져온다. **/
	public MemberBean selectMember(MemberBean bean);
	
	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectMemberListTotalCount();
	
	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<MemberBean> selectMemberList(
			@Param("memberBean") MemberBean bean,
			@Param("pagingBean") PagingBean pBean
	);
	
	/** 회원정보를 삽입한다. **/
	public int insertMember(MemberBean bean);
	
	/** 회원정보를 수정한다. **/
	public int updateMember(MemberBean bean);
	
	public int deleteMember(MemberBean bean) throws Exception;
}
