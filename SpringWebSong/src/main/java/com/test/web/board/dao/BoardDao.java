package com.test.web.board.dao;

import java.util.List;

import com.test.web.board.bean.BoardBean;
import com.test.web.board.bean.BoardImgBean;
import com.test.web.common.bean.PagingBean;

public interface BoardDao {

	/** 게시판를 조회해서 가져온다. **/
	public BoardBean selectBoard(BoardBean bean);
	
	/** 게시판를 조회해서 리스트로 가져온다. **/
	public List<BoardBean> selectBoardList(PagingBean bean);
	
	/** 전체 레코드 갯수를 가져온다. **/
	public int selectBoardListTotalCount(PagingBean bean);
	
	/** 게시판 게시글 저장 **/
	public int insertBoard(BoardBean bean);
	
	// 게시글 이미지 등록
	public int insertBoardImg(BoardImgBean boardImgBean);
	
}
