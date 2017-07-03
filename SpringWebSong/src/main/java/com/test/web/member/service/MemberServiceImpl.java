package com.test.web.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;
import com.test.web.member.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public MemberBean selectMember(MemberBean bean) throws Exception {
		return memberDao.selectMember(bean);
	}

	@Override
	public List<MemberBean> selectMemberList(MemberBean bean, PagingBean pBean) throws Exception  {
		return memberDao.selectMemberList(bean, pBean);
	}

	/** 회원정보 전체 리스트 갯수를 가져온다. **/
	@Override
	public int selectMemberListTotalCount() {
		return memberDao.selectMemberListTotalCount();
	}
	
	@Override
	public int insertMember(MemberBean bean) throws Exception {
		int res = memberDao.insertMember(bean);
		System.out.println(res);
		return res;
	}

	@Override
	public int updateMember(MemberBean bean) throws Exception {
		return memberDao.updateMember(bean);
	}
	
	@Override
	public int deleteMember(MemberBean bean) throws Exception {
		return memberDao.deleteMember(bean);
	}
}
