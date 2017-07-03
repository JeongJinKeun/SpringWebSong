package com.test.web.board.dao;

import java.util.List;

import com.test.web.board.bean.BoardAttachBean;

public interface BoardAttachDao {

	public int insertBoardAttach(BoardAttachBean bean);
	
	public List<BoardAttachBean> selectAttachList(BoardAttachBean bean);
}
