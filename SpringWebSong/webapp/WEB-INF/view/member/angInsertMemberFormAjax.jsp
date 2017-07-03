<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html >
<head>
	<title>회원가입 화면</title>
	
	<script type="text/javascript" src="/js/member/memberApp.js"></script>
	<script type="text/javascript" src="/js/member/memberController.js"></script>
	
</head>
<body>

	<div ng-app="memberApp" ng-controller="MemberController">
	
		<div>회원가입</div>
	
		<form id="memberForm">
			id: <input type="text" name="memberId" maxlength="13" ng-model="memberBean.memberId" required /><br/>
			pw: <input type="password" name="memberPw" maxlength="20" required /><br/>
			이름: <input type="text" name="memberName" maxlength="20" /><br/>
			나이: 
			<select name="memberAge">
				<c:forEach var="i" begin="1" end="100" varStatus="status">
					<option value="${i}" 
						${i == 20 ? 'selected=selected' : '' }
					>${i}</option>
				</c:forEach>
			</select>
			<br/>
			지역: 
			<select name="memberArea">
				<option value="서울">서울</option>
				<option value="부산">부산</option>
			</select>
			<br/>
			<select id="hp1" name="hp1">
				<option value="010">010</option>
				<option value="070">070</option>
			</select>
			- <input type="number" id="hp2" name="hp2" maxlength="5" placeholder="핸드폰 가운데 자리">
			- <input type="number" id="hp3" name="hp3" maxlength="5" placeholder="핸드폰 뒷자리">
			<input type="hidden" id="hp" name="hp" />
			<br/>
			<input type="radio" name="memberSex" value="F" >여자 
			<input type="radio" name="memberSex" value="M" >남자 
			<br/><br/>
			<button type="button" ng-click="insertMemberClick()">회원가입하기</button> &nbsp;&nbsp; 
			<button type="button" onclick="javascript:history.back();">취소</button>
		</form>

	</div>
	
</body>
</html>