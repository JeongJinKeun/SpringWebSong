package com.test.web.member.service;

import java.util.List;

import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;

public interface MemberService {

	/** 회원정보를 조회해서 가져온다. **/
	public MemberBean selectMember(MemberBean bean) throws Exception;
	
	/** 회원정보를 조회해서 리스트로 가져온다. **/
	public List<MemberBean> selectMemberList(MemberBean bean, PagingBean pBean) throws Exception;

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	public int selectMemberListTotalCount();
	
	/** 회원정보를 삽입한다. **/
	public int insertMember(MemberBean bean) throws Exception;
	
	/** 회원정보를 수정한다. **/
	public int updateMember(MemberBean bean) throws Exception;
	
	public int deleteMember(MemberBean bean) throws Exception;
}
