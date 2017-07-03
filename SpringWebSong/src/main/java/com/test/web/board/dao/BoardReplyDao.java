package com.test.web.board.dao;

import java.util.List;

import com.test.web.board.bean.BoardReplyBean;
import com.test.web.common.bean.PagingBean;

public interface BoardReplyDao {
	
	//댓글 리스트 조회
	public List<BoardReplyBean> selectReplyList(PagingBean bean);
	
}
