package com.test.web.member.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.test.web.common.Constants;
import com.test.web.common.bean.PagingBean;
import com.test.web.member.bean.MemberBean;
import com.test.web.member.dao.MemberDao;

@Controller
public class MemberController {

	@Value("#{config['admin.id']}")
	private String ADMIN_ID;
	@Value("#{config['admin.pw']}")
	private String ADMIN_PW;
	//파일 업로드 저장경로
	@Value("#{config['file.upload.path']}")
	private String FILE_UPLOAD_PATH;
	
	@Autowired
	private MemberDao memberDao;

	
	/** 로그인 화면 */
	@RequestMapping("/member/loginForm")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	/** 로그인 처리 */
	@RequestMapping("/member/loginProc")
	public String loginProc(MemberBean bean, Model model, 
			HttpServletRequest req) 
	{
		MemberBean memberBean = memberDao.selectMember(bean);
		if( memberBean != null 
				&& memberBean.getMemberId().equals(bean.getMemberId()) ) {
			//로그인 성공 - 세션에 저장
			req.getSession().setAttribute(Constants.MEMBER_LOGIN_BEAN, memberBean);
			model.addAttribute("result", "success");
			return "redirect:/index.do";
		}
		else {
			//로그인 실패
			model.addAttribute("result", "fail");
			model.addAttribute("mBean", bean);
			return "/member/loginForm";
		}
	}
	
	
	@RequestMapping("/member/selectMember")
	public String selectMember(MemberBean memberBean, Model model) 
	{
		//DB로부터 데이터를 가져온다.
		MemberBean mBean = memberDao.selectMember(memberBean);
		//JSP로 보내기 위해서 데이터를 적재한다.
		model.addAttribute("memberBean", mBean);
		
		return "/member/member";
	}
	
	/** 회원가입 화면 **/
	@RequestMapping("/member/insertMemberForm")
	public String insertMemberForm() {
		return "/member/insertMemberForm";
	}

	/** 회원가입 처리를 한다. **/
	@RequestMapping("/member/insertMemberProc")
	public String insertMemberProc(
			MemberBean memberBean,
			@RequestParam("file1") MultipartFile file1
	) 
	{
		if(file1 != null) {
			try {
				
				//파일을 저장하는 처리를 시작한다.
				File saveDir = new File(FILE_UPLOAD_PATH + "/upfile");
				
				if(!saveDir.exists()) {
					saveDir.mkdirs();
				}
				
				//파일이름 생성
				String fileName = System.nanoTime() + "";
				String fileExt = file1.getOriginalFilename().substring(
						file1.getOriginalFilename().lastIndexOf(".") 
						);
				System.out.println( fileName + fileExt );
				
				String fullFilePath = saveDir.getPath() 
								+ File.separator + fileName + fileExt;
				
				//파일저장
				byte[] bytes = file1.getBytes();
				BufferedOutputStream buffStream = 
					new BufferedOutputStream(new FileOutputStream(fullFilePath));
				buffStream.write(bytes);
				buffStream.close();
				
				
				//DB insert
				int res = memberDao.insertMember(memberBean);
				
				System.out.println(res);
				
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}//end if
		
		
		return "redirect:/member/loginForm.do";
	}
	
	/** 회원가입 수정화면 **/
	@RequestMapping("/member/updateMemberForm")
	public String updateMemberForm(MemberBean memberBean, Model model) {
		
		MemberBean resBean = memberDao.selectMember(memberBean);
		
		model.addAttribute("memberBean", resBean);
		
		return "/member/updateMemberForm";
	}
	
	/** 회원정보 수정 처리를 한다. **/
	@RequestMapping("/member/updateMemberProc")
	public String updateMemberProc(MemberBean memberBean, Model model) {
		
		model.addAttribute(Constants.RESULT, Constants.RESULT_FAIL);
		model.addAttribute("memberBean", memberBean);
		
		//DB update
		int res = memberDao.updateMember(memberBean);
		
		System.out.println(res);
		
		System.out.println(ADMIN_ID);
		System.out.println(ADMIN_PW);
		
		if(res > 0) {
			model.addAttribute(Constants.RESULT, Constants.RESULT_OK);
		}
		
		return "/member/updateMemberForm";
	}
	
	
	/** 회원정보 리스트 표시 **/
	@RequestMapping("/member/selectMemberList")
	public String selectMemberList(MemberBean bean, 
			PagingBean pagingBean, Model model) 
	{
		List<MemberBean> list = memberDao.selectMemberList(bean, pagingBean);
		
		model.addAttribute("memberList", list);
		
		return "/member/memberList";
	}
	
	
	
	
	
	
}
