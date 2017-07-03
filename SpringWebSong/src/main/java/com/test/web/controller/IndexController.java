package com.test.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.member.bean.MemberBean;
import com.test.web.member.service.MemberService;

@Controller
public class IndexController {

	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping("/index")
	public String index() {
		return "index";		
	}
	
	/**
	 * 사용자의 토큰값을 받아서 정보를 업데이트 해준다.
	 * @return
	 */
	@RequestMapping("/updatePushToken")
	@ResponseBody
	public Map<String, Object> updatePushToken(MemberBean mBean) {
		
		//받아야 되는 정보?
		//안드로이드 정보전송 --> token, id ===> member테이블 (70%)
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "토큰정보 업데이트 실패");
		
		try {
			
			int resVal = memberService.updateMember(mBean);
			if(resVal > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "토큰정보 업데이트 성공");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
	
	
}
