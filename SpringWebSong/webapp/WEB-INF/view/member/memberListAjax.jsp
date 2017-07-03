<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
		<tr>
			<th>번호</th>
			<th>ID</th>
			<th>이름</th>
			<th>나이</th>
			<th>지역</th>
			<th>휴대폰</th>
			<th>성별</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="bean" items="${memberList}" varStatus="status">
			<tr>
				<td>${bean.no}</td>
				<td>${bean.memberId}</td>
				<td>${bean.memberName}</td>
				<td>${bean.memberAge}</td>
				<td>${bean.memberArea}</td>
				<td>${bean.hp }</td>
				<td>${bean.memberSex}</td>
				<td><button type="button" onclick="">삭제</button></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7">
				검색: 
				<form>
					<select name="searchType">
						<option value="id">ID</option>
						<option value="title">제목</option>
					</select>
					<input type="text" name="searchText" /> 
					<button type="button" onclick="alert('메롱');">검색</button>
				</form>
			</td>
		</tr>
	</table>

</body>
</html>