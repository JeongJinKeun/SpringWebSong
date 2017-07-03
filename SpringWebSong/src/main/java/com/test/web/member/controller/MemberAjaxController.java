package com.test.web.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;
import com.test.web.member.service.MemberService;

@Controller
public class MemberAjaxController {
	
	@Autowired
	private MemberService memberService;

	/** 로그인 화면 */
	@RequestMapping("/member/loginFormAjax")
	public String loginFormAjax() {
		return "/member/loginFormAjax";
	}
	
	/** 로그인 처리 */
	@RequestMapping("/member/loginProcAjax")
	@ResponseBody
	public Map<String, Object> loginProcAjax(MemberBean bean, 
			HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		//로그인 실패
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put("mBean", bean);
		
		try {
			MemberBean memberBean = memberService.selectMember(bean);
			if( memberBean != null 
					&& memberBean.getMemberId().equals(bean.getMemberId()) ) {
				//로그인 성공 - 세션에 저장
				req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, memberBean);
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				return resMap;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	
	@RequestMapping("/member/selectMemberAjax")
	@ResponseBody
	public Map<String, Object> selectMember(MemberBean memberBean, 
			HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원정보 조회에 실패 하였습니다.");
		
		try {
			//DB로부터 데이터를 가져온다.
			MemberBean mBean = memberService.selectMember(memberBean);
			
			if(mBean != null) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원정보 조회에 성공 하였습니다.");
				resMap.put("mBean", mBean); //회원정보 저장
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	
	/** 회원가입 화면 **/
	@RequestMapping("/member/insertMemberFormAjax")
	public String insertMemberFormAjax() {
		return "/member/insertMemberFormAjax";
	}
	
	/** 회원가입 화면 **/
	@RequestMapping("/member/angInsertMemberFormAjax")
	public String angInsertMemberFormAjax() {
		return "/member/angInsertMemberFormAjax";
	}
	
	
	/** 회원가입 처리를 한다. **/
	@RequestMapping("/member/insertMemberProcAjax")
	@ResponseBody
	public Map<String, Object> insertMemberProc(MemberBean memberBean) {
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원가입에 실패 하였습니다.");
		
		//DB insert
		try {
			int res = memberService.insertMember(memberBean);
			
			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원가입에 성공 하였습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}

	
	/** 회원정보 리스트 화면 */
	@RequestMapping("/member/selectMemberListForm")
	public String selectMemberList() {
		return "/member/selectMemberList";
	}
	
	/** 회원정보 리스트 화면 */
	@RequestMapping("/member/angSelectMemberListForm")
	public String angSelectMemberListForm() {
		return "/member/angSelectMemberList";
	}
	
	/** 회원정보 리스트 AJAX **/
	@RequestMapping("/member/selectMemberListAjax")
	@ResponseBody
	public Map<String, Object> selectMemberListAjax(MemberBean bean, 
			PagingBean pagingBean, Model model) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 실패 하였습니다.");
		
		try {
			//전체 회원 리스트 갯수 조회
			int totRecord = memberService.selectMemberListTotalCount();
			//페이징 계산
			pagingBean.calcPage(totRecord);
			
			List<MemberBean> list = memberService.selectMemberList(bean, pagingBean);
		
			resMap.put("memberList", list);
			resMap.put("pagingBean", pagingBean);
			
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "회원 리스트 조회에 성공 하였습니다.");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	/** 회원가입 수정화면 **/
	@RequestMapping("/member/updateMemberFormAjax")
	public String updateMemberFormAjax(MemberBean memberBean, Model model) {
		return "/member/updateMemberFormAjax";
	}
	
	/** 회원정보 수정 처리를 한다. **/
	@RequestMapping("/member/updateMemberProcAjax")
	@ResponseBody
	public Map<String, Object> updateMemberProcAjax(MemberBean memberBean, Model model) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원정보 수정에 실패 하였습니다.");
		
		try {
			//DB update
			int res = memberService.updateMember(memberBean);
			
			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "회원정보 수정에 성공 하였습니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	/**
	 * 회원정보 삭제 (로그인한 사용자만 삭제처리)
	 * @param bean
	 * @return
	 */
	@RequestMapping("/member/memberDeleteAjax")
	@ResponseBody
	public Map<String, Object> memberDeleteAjax(MemberBean bean, 
			HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 실패 하였습니다.");
		try {
			//세션값 취득
			MemberBean sesBean = (MemberBean)req.getSession().getAttribute(Constants.MEMBER_LOGIN_BEAN);
			
			if( StringUtils.equals(sesBean.getMemberId(), bean.getMemberId()) ){
				int resVal = memberService.deleteMember(bean);
				if(resVal > 0) {
					resMap.put(Constants.RESULT, Constants.RESULT_OK);
					resMap.put(Constants.RESULT_MSG, "회원정보 삭제를 성공 하였습니다.");
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resMap;
	}
	
	
	
	
	
	
	
}
