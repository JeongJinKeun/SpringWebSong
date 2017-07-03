package com.test.web.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.board.bean.BoardAttachBean;
import com.test.web.board.bean.BoardBean;
import com.test.web.board.service.BoardService;
import com.test.web.common.Constants;
import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;

@Controller
public class BoardControllerAjax {
	
	//파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping("/board/boardDetailViewForm")
	public String boardDetailViewForm() {
		return "/board/boardDetailViewForm";
	}
	
	//게시글 상세보기 AJAX
	@RequestMapping("/board/boardDetailViewAjax")
	@ResponseBody
	public Map<String, Object> boardDetailViewAjax(PagingBean pBean) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 실패");

		try {
			//게시글 통합조회(댓글 목록까지 조회)
			resMap = boardService.selectBoardReplyInfo(pBean);

			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "게시글 상세보기 조회 성공");
		} catch(Exception e) {
			e.printStackTrace();
		}

		return resMap;
	}


	@RequestMapping("/board/boardInsertFormAjax")
	public String boardInsertFormAjax() {
		return "/board/boardInsertFormAjax";
	}
	

	@RequestMapping("/board/boardInsertProcAjax")
	@ResponseBody
	public Map<String, Object> boardInsertProcAjax(
			BoardBean bBean, BoardAttachBean baBean, HttpServletRequest req) 
	{
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "게시글 작성 실패");

		try {
			//로그인 정보 가져오기
			MemberBean ssBean = 
				(MemberBean)req.getSession()
				.getAttribute(Constants.MEMBER_LOGIN_BEAN);
			if(ssBean != null) {
				bBean.setMemberId( ssBean.getMemberId() );
			}
			
			int res = boardService.insertBoardAttach(bBean, 
					baBean, FILE_UPLOAD_PATH + "/upFile");
			if(res > 0) {
				resMap.put(Constants.RESULT, Constants.RESULT_OK);
				resMap.put(Constants.RESULT_MSG, "게시글 작성 성공");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}

	

}
