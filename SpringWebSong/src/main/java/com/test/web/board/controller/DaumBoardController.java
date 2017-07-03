package com.test.web.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.web.board.bean.BoardBean;
import com.test.web.board.service.BoardService;
import com.test.web.common.Constants;

@Controller
public class DaumBoardController {
	
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

	
	@Autowired
	BoardService boardService;
	
	//AnguarJS 게시글 쓰기
	@RequestMapping("/board/daum/angBoardInsertFormAjax")
	public String angBoardInsertFormAjax() {
		return "/board/daum/angBoardInsertFormAjax";
	}
	
	// 강사님 ver
	@RequestMapping("/board/daum/angBoardInsertProcAjax")
	@ResponseBody
	public Map<String, Object> angBoardInsertProcAjax(BoardBean boardBean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
		resMap.put(Constants.RESULT_MSG, "실패 ㅠㅠ");
		
		boolean res = boardService.insertDaumBoardProc(boardBean);
		if (res) {
			resMap.put("boardNo", boardBean.getNo());
			resMap.put(Constants.RESULT, Constants.RESULT_OK);
			resMap.put(Constants.RESULT_MSG, "성공!!");
		}
		
		return resMap;
	}
	@RequestMapping("/board/daum/angBoardDetailView")
	public String angBoardDetailView(BoardBean bean, Model model) {
		
		Map<String, Object> map = boardService.selectDaumBoardOne(bean);
		
		// 화면으로 넘어갈것이다~~~
		model.addAttribute("boardBean", map.get("boardBean"));
		model.addAttribute("baList", map.get("baList"));
		
		return "/board/daum/angBoardDetailView";
	}
	//AnguarJS 게시글 수정
	@RequestMapping("/board/daum/angBoardUpdateFormAjax")
	public String angBoardUpdateFormAjax(BoardBean bean, Model model) {
		
		// 데이터 조회
		angBoardDetailView(bean, model);
		
			
		
		return "/board/daum/angBoardUpdateFormAjax";
	}
	
	// 정진근 ver
//	@RequestMapping("/board/daum/angBoardInsertProcAjax")
//	@ResponseBody
//	public Map<String, Object> angBoardInsertProcAjax(BoardBean boardBean) {
//		Map<String, Object> resMap = new HashMap<String, Object>();
//		
//		resMap.put(Constants.RESULT, Constants.RESULT_FAIL);
//		resMap.put(Constants.RESULT_MSG, "실패 ㅠㅠ");
//		
//		// 파일을 옮겨담을 폴더 생성
//		String realPath = FILE_UPLOAD_PATH + UPLOAD_BOARD_IMG_PATH;
//		File realFolder = new File(realPath);
//		if (!realFolder.exists()) {
//			realFolder.mkdirs();
//		}
//		
//		BoardImgBean biBean = new BoardImgBean();
//		for (int i = 0; i < boardBean.getImgOriginName().length; i++) {
////			biBean.setBdNo(boardBean.getNo()); // 게시글 고유번호
//			biBean.setBdNo("1"); // 게시글 고유번호(임시로 설정)
//			biBean.setImgOriginName(boardBean.getImgOriginName()[i]); 
//			biBean.setImgPath(boardBean.getImgPath()[i]);
//			biBean.setImgSize(boardBean.getImgSize()[i]);
//			
//			String filePath = boardBean.getImgPath()[i];
//			File copyFile =  new File(FILE_UPLOAD_PATH + "/" + filePath);
//			
//			// UUID 파일명 가져오기
//			String[] fileName = filePath.split("/");
//			for (int j = 0; j < fileName.length; j++) {
//				System.out.println(fileName[j].toString());
//			}
//			File realFile = new File(realPath + "/" + fileName[fileName.length-1]);
//			
//			// 임시 폴더에서 업로드 폴더로 파일 복사하기
//			BufferedInputStream bis = null;
//			BufferedOutputStream bos = null;
//			try {
//				byte[] b = new byte[1024];
//				bis = new BufferedInputStream(new FileInputStream(copyFile));
//				bos = new BufferedOutputStream(new FileOutputStream(realFile));
//				while(true) {
//					int cnt = bis.read(b);
//					if (cnt == -1) {
//						break;
//					}
//					bos.write(b, 0, cnt);
//				}
//				System.out.println("성공!");
//			} catch (FileNotFoundException e1) {
//				e1.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			} finally{
//				try {
//					if (bis != null) {
//						bis.close();
//					}
//					if (bos != null) {
//						bos.flush();
//						bos.close();
//					}
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//			try {
//				int res = boardService.insertBoardImg(biBean);
//				
//				if (res > 0) {
//					resMap.put(Constants.RESULT, Constants.RESULT_OK);
//					resMap.put(Constants.RESULT_MSG, "성공!!!");
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		// temp 폴더 이미지 삭제하기
//		File files[] = new File(FILE_UPLOAD_PATH
//				+ UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH).listFiles();
//		for (int i = 0; i < files.length; i++) {
//			System.out.println(files[i].getName());
//			files[i].delete();
//		}
//		
//		return resMap;
//	}
} // end of class
