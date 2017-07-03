package com.test.web.board.bean;

public class BoardReplyBean extends BoardBean {

	private String no;
	private String boardNo;
	private String memberId;
	private String content;
	private String regDate;
	
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getNo() {
		return no;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public String getContent() {
		return content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
