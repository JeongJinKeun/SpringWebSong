package com.test.web.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * DaumEditor 업로드 Controller
 * 
 * @author CSG
 * @since 2017-03-29
 */
@Controller
public class DaumEditorUploadDownloadController {

	// 레파지토리 경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;
	// 보드 이미지 폴더 경로
	@Value("#{config['upload.board.img.path']}")
	private String UPLOAD_BOARD_IMG_PATH;
	// 보드 파일 폴더 경로
	@Value("#{config['upload.board.file.path']}")
	private String UPLOAD_BOARD_FILE_PATH;
	// 다음 에디터 이미지 임시 폴더 경로
	@Value("#{config['upload.daum.editor.image.temp.path']}")
	private String UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH;
	// 다음 에디터 파일 임시 폴더 경로
	@Value("#{config['upload.daum.editor.file.temp.path']}")
	private String UPLOAD_DAUM_EDITOR_FILE_TEMP_PATH;

	
	/**
	 * 다음 에디터 이미지 파일 업로드 - 사용자 이미지 업로드 즉시 temp 폴더로 업로드됨 - 등록요청시 temp 이미지 파일을
	 * 이동시킴
	 * */
	@RequestMapping(value = "/common/uploadDaumEditorImg", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadDaumEditorImg(
			@RequestParam("file") MultipartFile file) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String fileName = null;
		if (!file.isEmpty()) {
			try {

				// 첨부이미지 임시 폴더 확인 및 생성
				String tempPath = FILE_UPLOAD_PATH + UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH;
				System.out.println(tempPath);
				File tempFolder = new File(tempPath);
				if (!tempFolder.exists()) {
					tempFolder.mkdirs();
				}

				// 사용자 업로드 파일 네임
				// 임시 폴더 이므로 파일명을 UUID로 생성
				String fileExt = file.getOriginalFilename().substring(
						file.getOriginalFilename().lastIndexOf(".") + 1);
				fileName = UUID.randomUUID().toString() + "." + fileExt;

				byte[] bytes = file.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(
						new FileOutputStream(
								new File(tempPath + "/" + fileName)));
				buffStream.write(bytes);
				buffStream.close();
				File copyFile =  new File(tempPath + "/" + fileName);
				BufferedImage bi = ImageIO.read(copyFile);
				System.out.println("hei--"+bi.getHeight()+"______wid--"+bi.getWidth());
				
				resultMap.put("filename", file.getOriginalFilename());
				resultMap.put("filesize", bytes.length);
				resultMap.put("imagealign", "C");
				resultMap.put("uploadedPath", "/");
				resultMap.put("imageurl", UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH + "/" + fileName);
				resultMap.put("imgWidth", bi.getWidth());
				resultMap.put("imgHeight", bi.getHeight());
				System.out.println(resultMap.get("imageurl"));
			} catch (Exception e) {

			}
		} else {
		}
		return resultMap;
	}

	/**
	 * 다음 에디터 파일 업로드 - 사용자 파일 업로드 즉시 temp 폴더로 업로드됨 - 등록요청시 temp 파일을 이동시킴
	 * */
	@RequestMapping(value = "/common/uploadDaumEditorFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadDaumEditorFile(
			@RequestParam("file") MultipartFile file) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String fileName = null;
		if (!file.isEmpty()) {
			try {
				// 첨부이미지 임시 폴더 확인 및 생성
				String tempPath = FILE_UPLOAD_PATH+UPLOAD_DAUM_EDITOR_FILE_TEMP_PATH;
				System.out.println(tempPath);
				File tempFolder = new File(tempPath);
				if (!tempFolder.exists()) {
					tempFolder.mkdirs();
				}
				// 사용자 업로드 파일 네임
				// 임시 폴더 이므로 파일명을 UUID로 생성
				String fileExt = file.getOriginalFilename().substring(
						file.getOriginalFilename().lastIndexOf(".") + 1);
				fileName = UUID.randomUUID().toString() + "." + fileExt;

				byte[] bytes = file.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(
						new FileOutputStream(
								new File(tempPath + "/" + fileName)));
				buffStream.write(bytes);
				buffStream.close();


				resultMap.put("filename", file.getOriginalFilename());
				resultMap.put("filesize", bytes.length);

				resultMap.put("fileurl", UPLOAD_DAUM_EDITOR_FILE_TEMP_PATH
						+"/" + fileName);
				resultMap.put("filemime", file.getContentType());

				System.out.println(resultMap.get("fileurl"));
			} catch (Exception e) {

			}
		} else {
		}
		return resultMap;
	}
}