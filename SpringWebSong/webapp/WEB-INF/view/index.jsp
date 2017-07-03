<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	 <meta charset="UTF-8" name="viewport" 
	 content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<title>Insert title here</title>
</head>
<body>
	<div style="width: 100%;">
	Hello Spring 
	<br/>
	
	환영합니다. ${sessionScope.memberLoginBean.memberId} 님
	
	<br/><br/>
	<a href="/board/boardList.do">JSTL게시판 바로가기</a>
	<br/>
	<a href="/board/boardDetailViewForm.do?no=1">AJAX게시판 바로가기</a>
	</div>
	
</body>
</html>