package com.test.web.board.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.board.bean.BoardAttachBean;
import com.test.web.board.bean.BoardBean;
import com.test.web.board.bean.BoardImgBean;
import com.test.web.board.bean.BoardReplyBean;
import com.test.web.board.dao.BoardAttachDao;
import com.test.web.board.dao.BoardDao;
import com.test.web.board.dao.BoardReplyDao;
import com.test.web.common.Constants;
import com.test.web.common.Util;
import com.test.web.common.bean.PagingBean;

@Service
public class BoardServiceImpl implements BoardService {
	
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
	private BoardDao boardDao;
	@Autowired
	private BoardReplyDao boardReplyDao;
	@Autowired
	private BoardAttachDao boardAttachDao;
	
	
	@Override
	public BoardBean selectBoard(BoardBean bean) {
		return boardDao.selectBoard(bean);
	}

	@Override
	public List<BoardReplyBean> selectBoardReplyList(PagingBean bean) 
	{
		return boardReplyDao.selectReplyList(bean);
	}

	public Map<String, Object> selectBoardReplyInfo(PagingBean pBean) 
	{
		BoardBean bb = new BoardBean( pBean.getNo(), null );
		
		BoardBean boardBean = selectBoard(bb);
		List<BoardReplyBean> list = selectBoardReplyList(pBean);
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("boardBean", boardBean);
		resMap.put("boardReplyList", list);
		
		return resMap;
	}
	
	@Override
	public int insertBoardAttach(BoardBean bBean, BoardAttachBean baBean, String upPath) {
		
		//TODO 테스트 데이터
		bBean.setMemberId("kyg");
		int resVal1 = boardDao.insertBoard(bBean);
		
		if(resVal1 <= 0) return 0; //insert실패
		
		
		for(int i=0; i<baBean.getUpFile().length; i++) {
			
			MultipartFile file = baBean.getUpFile()[i];
			String fileName = "";
			try {
				fileName = Util.uploadFileMng(file, upPath);
			} catch(Exception e) {
				e.printStackTrace();
			}
			//insert
			BoardAttachBean inBean = new BoardAttachBean();
			inBean.setBoardNo( bBean.getNo() );
			inBean.setAttachType( Constants.FILE_TYPE_BOARD );
			inBean.setFileName( fileName );
			//DB
			boardAttachDao.insertBoardAttach(inBean);
		}
		
		return resVal1;
	}

	/** 다음 게시판의 모든 글쓰기 처리를 실행한다 */
	@Override
	public boolean insertDaumBoardProc(BoardBean bean) {
		bean.setMemberId("kyg"); //TODO : test용 id 강제삽입
		
		// 경로변경 처리
		String content = bean.getContent().replaceAll(UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH, UPLOAD_BOARD_IMG_PATH);
		String content2 = content.replaceAll(UPLOAD_DAUM_EDITOR_FILE_TEMP_PATH, UPLOAD_BOARD_FILE_PATH);
		
		bean.setContent(content2);
		
		int resVal1 = boardDao.insertBoard(bean);
		if (resVal1 <= 0) { // insert 실패
			return false;
		}
		
		// 파일삭제 리스트 저장
		List<File> deleteFileList = new ArrayList<File>();
		
		// 이미지 처리
		if (bean.getImgPath() != null && bean.getImgPath().length > 0) {
			for (int i = 0; i < bean.getImgPath().length; i++) {
				
				String tmpImgPathName = bean.getImgPath()[i];
				// Path의 경로를 바꾼다. (temp -> upload)
				String orgImgPathName = tmpImgPathName.replace(UPLOAD_DAUM_EDITOR_IMAGE_TEMP_PATH, UPLOAD_BOARD_IMG_PATH);
				
				// insert
				BoardAttachBean attachBean = new BoardAttachBean();
				attachBean.setBoardNo( bean.getNo() );
				attachBean.setAttachType( Constants.IMG_TYPE_BOARD );
				attachBean.setFileName( orgImgPathName );
				//DB
				boardAttachDao.insertBoardAttach(attachBean);
				
				// 파일 복사작업 (temp -> 원본)
				File boardImgTempFile = new File(FILE_UPLOAD_PATH + tmpImgPathName);
				// 나중 삭제할 목록에 추가
				deleteFileList.add(boardImgTempFile);

				String boardImgPath = UPLOAD_BOARD_IMG_PATH + "/" + boardImgTempFile.getName();

				File boardImgFile = new File(FILE_UPLOAD_PATH + "/" + boardImgPath);

				// 정상적인 프로세스상 파일 이동이 이동되어야 하지만,
				// 파일 복사로 변경
				try {
					FileUtils.copyFile(boardImgTempFile, boardImgFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 파일 처리
		if (bean.getFilePath() != null && bean.getFilePath().length > 0) {
			for (int i = 0; i < bean.getFilePath().length; i++) {
				
				String tmpFilePathName = bean.getFilePath()[i];
				// Path의 경로를 바꾼다. (temp -> upload)
				String orgFilePathName = tmpFilePathName.replace(UPLOAD_DAUM_EDITOR_FILE_TEMP_PATH, UPLOAD_BOARD_FILE_PATH);
				
				// insert
				BoardAttachBean attachBean = new BoardAttachBean();
				attachBean.setBoardNo( bean.getNo() );
				attachBean.setAttachType( Constants.FILE_TYPE_BOARD );
				attachBean.setFileName( orgFilePathName );
				//DB
				boardAttachDao.insertBoardAttach(attachBean);
				
				// 파일 복사작업 (temp -> 원본)
				File boardFileTempFile = new File(FILE_UPLOAD_PATH + tmpFilePathName);
				// 나중 삭제할 목록에 추가
				deleteFileList.add(boardFileTempFile);

				String boardFilePath = UPLOAD_BOARD_FILE_PATH + "/" + boardFileTempFile.getName();

				File boardFileFile = new File(FILE_UPLOAD_PATH + "/" + boardFilePath);

				// 정상적인 프로세스상 파일 이동이 이동되어야 하지만,
				// 파일 복사로 변경
				try {
					FileUtils.copyFile(boardFileTempFile, boardFileFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 게시글 이미지 등록(진근)
	@Override
	public int insertBoardImg(BoardImgBean boardImgBean) throws Exception {
		return boardDao.insertBoardImg(boardImgBean);
	}

	/** 다음 게시판의 한개의 글 + attache 리스트 가져오기 */
	@Override
	public Map<String, Object> selectDaumBoardOne(BoardBean bean) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		BoardBean bBean = selectBoard(bean);
		
		resMap.put("boardBean", bBean);
		
		BoardAttachBean baBean = new BoardAttachBean();
		baBean.setNo(bBean.getNo());
		List<BoardAttachBean> baList = boardAttachDao.selectAttachList(baBean);
		
		resMap.put("baList", baList);
		
		return resMap;
	}
} // end of class
