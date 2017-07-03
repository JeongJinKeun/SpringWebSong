package com.test.web.common;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.web.multipart.MultipartFile;

public class Util {
	
	public static String uploadFileMng(MultipartFile file, String upPath) throws Exception {
		
		if(file == null) return null;
		
		//파일을 저장하는 처리를 시작한다.
		File saveDir = new File(upPath);
		
		if(!saveDir.exists()) {
			saveDir.mkdirs();
		}
		
		//파일이름 생성
		String fileName = System.nanoTime() + "";
		String fileExt = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf(".") 
				);
		System.out.println( fileName + fileExt );
		
		String fullFilePath = saveDir.getPath() 
						+ File.separator + fileName + fileExt;
		
		//파일저장
		byte[] bytes = file.getBytes();
		BufferedOutputStream buffStream = 
			new BufferedOutputStream(new FileOutputStream(fullFilePath));
		buffStream.write(bytes);
		buffStream.close();
			
		return fileName + fileExt;
	}
	
	
}
