<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>

	<table style="width: 600px;">
		<tr>
			<td>타이틀: </td>
			<td>${boardBean.title}</td>
		</tr>
		<tr>
			<td>내용 : </td>
			<td>${boardBean.content}</td>
		</tr>
		<tr>
			<td>파일</td>
			<td>
				<c:forEach items="${baList}" var="item" varStatus="status">
					<a href="${item.fileName}">${item.fileName}</a> <br/>
				</c:forEach>
			</td>
		</tr>
	</table>
	
</body>
</html>