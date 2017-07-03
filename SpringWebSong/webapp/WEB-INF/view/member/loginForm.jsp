<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result ne null && result eq 'fail'}">
		<script type="text/javascript">
			alert("로그인에 실패 하였습니다.");
		</script>
	</c:if>

	<form action="/member/loginProc.do" method="post">
		<input type="text" name="memberId" value="${mBean.memberId}"/> <br/>
		<input type="password" name="memberPw" value="${mBean.memberPw}"/> <br/>
		<input type="submit" value="로그인">
	</form>
	

</body>
</html>