package com.test.web.board.service;

import java.util.List;
import java.util.Map;

import com.test.web.board.bean.BoardAttachBean;
import com.test.web.board.bean.BoardBean;
import com.test.web.board.bean.BoardImgBean;
import com.test.web.board.bean.BoardReplyBean;
import com.test.web.common.bean.PagingBean;

public interface BoardService {

	//게시글 1건 조회
	public BoardBean selectBoard(BoardBean bean);
	
	//댓글 목록 조회
	public List<BoardReplyBean> selectBoardReplyList(PagingBean bean);
	
	//게시글과 댓글목록을 한꺼번에 조회하는 처리
	public Map<String, Object> selectBoardReplyInfo(PagingBean pBean);
	
	//게시글과 파일의 정보를 한꺼번에 insert 처리
	public int insertBoardAttach(BoardBean bBean, BoardAttachBean baBean, String upPath);
	
	//게시글 이미지등록
	public int insertBoardImg(BoardImgBean boardImgBean) throws Exception;
	
	/** 다음 게시판의 모든 글쓰기 처리를 실행한다 */
	public boolean insertDaumBoardProc(BoardBean bean);
	/** 다음 게시판 한개의 글 + attache 리스트 가져오기 */
	public Map<String, Object> selectDaumBoardOne(BoardBean bean);
}
