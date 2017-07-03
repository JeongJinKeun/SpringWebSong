<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>

	<table style="width: 900px; text-align: center;" border="1" cellspacing="0px">
		<tr>
			<th width="7%">번호</th>
			<th width="15%">ID</th>
			<th width="50%">제목</th>
			<th width="10%">날짜</th>
			<th width="5%">삭제</th>
		</tr>
		<c:forEach var="bean" items="${boardList}" varStatus="status">
			<tr>
				<td>${bean.no}</td>
				<td>${bean.memberId}</td>
				<td>${bean.title}</td>
				<td><span style="font-size: 11px;">${bean.regDate}</span></td>
				<td><button type="button" onclick="">삭제</button></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7">
				<!--  
				 &lt;&lt;처음&nbsp;&nbsp;&nbsp;
				 &lt;이전 [1] [2] [3] [4] 다음&gt; 
				 &nbsp;&nbsp;&nbsp;마지막&gt;&gt;
				 -->
		
				 <c:if test="${pBean.groupNo > 1}">
				 	<a href="/board/boardList.do?pageNo=${pBean.pageStartNo - 1}">&lt;이전</a>
				 </c:if>
				 
				 <c:forEach var="i" begin="${pBean.pageStartNo}" end="${pBean.pageEndNo}" >
				 	<c:choose>
				 		<c:when test="${pBean.pageNo != i}">
				 			<a href="/board/boardList.do?pageNo=${i}&searchType=${param.searchType}&searchText=${param.searchText}">[${i}]</a>
				 		</c:when>
				 		<c:otherwise>
				 			[${i}]
				 		</c:otherwise>
				 	</c:choose>
				 	
				 </c:forEach>
				 
				 <c:if test="${pBean.groupNo < pBean.totalGroupCount}">
				 	<a href="/board/boardList.do?pageNo=${pBean.pageEndNo + 1}">다음&gt;</a>
				 </c:if>
				 
			 </td>
		</tr>
		<tr>
			<td colspan="7">
				<form action="/board/boardList.do" method="get">
					검색: 
					<select name="searchType">
						<option value="titleContent">제목+내용</option>
						<option value="id">ID</option>
						<option value="title">제목</option>
					</select>
					<input type="text" name="searchText" /> 
					<input type="submit" value="검색" />
				</form>
			</td>
		</tr>
	</table>

</body>
</html>