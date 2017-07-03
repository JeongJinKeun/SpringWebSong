package com.test.web.board.bean;

public class BoardBean {

	private String no;
	private String memberId;
	private String memberName;
	private String title;
	private String content;
	private String replyTotCount;
	private String regDate;
	
	// 다음에디터 이미지
	private String imgPath[];
	private String imgOriginName[];
	private String imgSize[];
	// 다음에디터 파일
	private String filePath[];
	private String fileOriginName[];
	private String fileSize[];
	
	public BoardBean() {
		
	}
	public BoardBean(String no, String memberId) {
		this.no = no;
		this.memberId = memberId;
	}
	
	
	public String getReplyTotCount() {
		return replyTotCount;
	}
	public void setReplyTotCount(String replyTotCount) {
		this.replyTotCount = replyTotCount;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getNo() {
		return no;
	}
	public String getMemberId() {
		return memberId;
	}
	public String getTitle() {
		return title;
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
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String[] getImgPath() {
		return imgPath;
	}
	public void setImgPath(String[] imgPath) {
		this.imgPath = imgPath;
	}
	public String[] getImgOriginName() {
		return imgOriginName;
	}
	public void setImgOriginName(String[] imgOriginName) {
		this.imgOriginName = imgOriginName;
	}
	public String[] getImgSize() {
		return imgSize;
	}
	public void setImgSize(String[] imgSize) {
		this.imgSize = imgSize;
	}
	public String[] getFilePath() {
		return filePath;
	}
	public void setFilePath(String[] filePath) {
		this.filePath = filePath;
	}
	public String[] getFileOriginName() {
		return fileOriginName;
	}
	public void setFileOriginName(String[] fileOriginName) {
		this.fileOriginName = fileOriginName;
	}
	public String[] getFileSize() {
		return fileSize;
	}
	public void setFileSize(String[] fileSize) {
		this.fileSize = fileSize;
	}
}
