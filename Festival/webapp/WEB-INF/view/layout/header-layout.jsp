<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
@media screen and (max-width: 767px) {
			footer {
				display: none;
			}
			.gallery {
				width: 100%;
				margin: 50px auto;
			}
			.search_form {
    	width: 100%;
	}
	
		}
		
</style>
	<!-- 헤더 -->
    <header>
        <div class="head">
            <h1 class="logo">
                <a href="/index.do">
                    <img src="/images/title_subject.png" alt="로고">
                </a>
            </h1>
            
				
            <div class="menu_box">
                <ul class="menu_member">
                
                	<!-- 로그인이 안되어 있을 때 화면 -->
	                <c:if test="${empty memberBean}">
<!-- 					<li><a href="/member/joinMain.do?bdCategoryCd=02">JOIN</a></li> -->
<!-- 					<li><a href="/member/loginForm.do?bdCategoryCd=01">LOGIN</a></li> -->
 						<li><a href="/member/loginForm.do">로그인</a></li>
 						<li><a href="/join.do">회원가입</a></li>
 						
					</c:if>
					
                	<!-- 로그인이 되어 있을 때 화면 -->
					<c:if test="${!empty memberBean}">
						<!-- 관리자 일때 화면 -->
						<c:if test="${!empty sessionScope.memberBean.memberAdmin}">
							<li><a href="/member/memberList.do">회원관리</a></li>
							<li><a href="/festival/master_managerFestival.do">축제관리</a></li>
						</c:if>
						<li><a href="/member/myList.do?memberId=${sessionScope.memberBean.memberId}">마이페이지</a></li>
						<li><a href="#" onclick="logoutAjax(); return false;">로그아웃</a></li>
					</c:if>
					
					<!--  관리자의 화면 -->
<%-- 					<c:if test="${memberBean.mbTypeCd eq 01 }"> --%>
<!-- 						<li><a href="/board/memberList.do?bdCategoryCd=04&mbTypeCd=04" class="orange">회원목록</a></li> -->
<%-- 					</c:if> --%>
                </ul>
            </div>
        </div>
        <div class="head2">
            <div class="menu_box2">
                <ul class="menu_title">
                    <li>
                        <a href="/about/about.do">소개</a>
                        <ul class="menu_list">
                            <li><a href="/about/about.do">인사말</a></li>
                            <li><a href="/about/pageguide.do">페이지 가이드</a></li>
                        </ul>
                    </li>
                     <li>
                        <a href="/festival/festival_main.do">축제</a>
                    </li>
                     <li>
                        <a href="/board/noticeList.do?pageNo=1">커뮤니티</a>
                        <ul class="menu_list">
                            <li><a href="/board/noticeList.do?pageNo=1">자유게시판</a></li>
                            <li><a href="/qna.do">QnA</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        
<!--         모바일용 header -->
        <div class="m_head">
            <h1 class="logo">
                <a href="#"><img src="/images/title_subject.PNG" alt="로고" /></a>
            </h1>
        </div>
        
        <!----------------------------------------------------------->
    </header>
    
