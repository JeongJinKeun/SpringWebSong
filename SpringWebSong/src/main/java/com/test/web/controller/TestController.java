package com.test.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.common.Constants;
import com.test.web.common.FCMSender;
import com.test.web.common.bean.PushMsgBean;
import com.test.web.member.bean.MemberBean;
import com.test.web.member.service.MemberService;

@Controller
public class TestController {

	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping("/test/sendPush")
	@ResponseBody
	public Map<String, Object> sendPushTest(MemberBean mBean) {
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "푸시 발송 실패");
		
		try {
			if( StringUtils.isEmpty(mBean.getMemberId()) ) {
				resMap.put(Constants.RESULT_MSG, "MemberID가 누락 되었습니다.");
				return resMap;
			}
			
			MemberBean dbMemBean = memberService.selectMember(mBean);
			
			//메세지를 작성
			PushMsgBean msgBean = new PushMsgBean();
			msgBean.setTo( dbMemBean.getToken() );
			PushMsgBean.Data data = new PushMsgBean.Data();
			data.setTitle("테스트 이다. 받아라");
			data.setMessage("메시지이다. 받아라");
			msgBean.setData(data);
			
			//푸시발송
			boolean resBool = FCMSender.sendPushMsg(msgBean);
			
			if(resBool) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "푸시발송 성공: " 
													+ mBean.getMemberId());
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return resMap;
	}
	
	
	
}
