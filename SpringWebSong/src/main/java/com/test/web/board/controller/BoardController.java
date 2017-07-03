package com.test.web.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.web.board.bean.BoardBean;
import com.test.web.board.dao.BoardDao;
import com.test.web.common.bean.PagingBean;

@Controller
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	
	
	@RequestMapping("/board/boardList")
	public String boardList(Model model, PagingBean pBean) {
		
		//전체 레코드 갯수 취득
		int totRecord = boardDao.selectBoardListTotalCount(pBean);
		//페이징 계산
		pBean.calcPage(totRecord);
		
		List<BoardBean> list = boardDao.selectBoardList(pBean);
		model.addAttribute("boardList", list);
		model.addAttribute("pBean", pBean);
		
		return "/board/boardList";
	}
	
}
