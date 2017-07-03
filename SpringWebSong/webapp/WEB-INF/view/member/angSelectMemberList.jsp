<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript" src="/js/member/memberApp.js"></script>
	<script type="text/javascript" src="/js/member/memberController.js"></script>
	
</head>
<body>
	<div ng-app="memberApp" ng-controller="MemberController" 
				ng-init="selectMemberList('${param.pageNo == null ? 1 : param.pageNo}')">
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
			<tr ng-repeat="member in memberList">
				<td>{{member.no}}</td>
				<td>{{member.memberId}}</td>
				<td>{{member.memberName}}</td>
				<td>{{member.memberAge}}</td>
				<td>{{member.memberArea}}</td>
				<td>{{member.hp}}</td>
				<td>{{member.memberSex == 'M' ? '남자' : '여자'}}</td>
				<td>삭제</td>
			</tr>
		</table>
		
		<table>
			<tr>
				<td colspan="7">
					검색: 
					<form>
						<select name="searchType">
							<option value="id">ID</option>
							<option value="title">제목</option>
						</select>
						<input type="text" name="searchText" ng-model="pBean.searchText" /> 
						<button type="button" onclick="alert('메롱');">검색</button>
					</form>
				</td>
			</tr>
		</table>
		
		<br/>
		<div> 
			<span 
			ng-if="pBean.groupNo > 1"
			ng-click="selectMemberList(pBean.pageStartNo-1)">&lt이전</span>
		
		 		<span ng-repeat="p in getArr(pBean.totalPageCount) track by $index">
		 			<span ng-click="selectMemberList($index+1)">[ {{$index+1}} ]</span>&nbsp; 
		 		</span>
		 
		 	<span 
		 	ng-click="selectMemberList(pBean.pageEndNo+1)">다음&gt</span>
		 </div>
		
	</div>
</body>
</html>