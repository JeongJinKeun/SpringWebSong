package com.test.web.board.bean;

import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.bean.CommonBean;

public class BoardAttachBean extends CommonBean {

	private MultipartFile upFile[];
	
	private String attachType;
	private String fileName;
	
	
	public MultipartFile[] getUpFile() {
		return upFile;
	}
	public void setUpFile(MultipartFile[] upFile) {
		this.upFile = upFile;
	}
	public String getAttachType() {
		return attachType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
