<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
	<c:choose>
		<c:when test="${result eq 'ok'}">
			<script type="text/javascript">
				alert("회원정보 수정에 성공 하였습니다.");
				location.href = "/member/selectMember.do?memberId=${memberBean.memberId}";
			</script>
		</c:when>
		<c:when test="${result eq 'fail'}">
			<script type="text/javascript">
				alert("회원정보 수정에 실패 하였습니다.");
			</script>
		</c:when>
	</c:choose>
	
	
	<script type="text/javascript">
		
		//회원정보 수정
		function updateMember() {
			
			var memberForm = document.getElementById("memberForm");
			memberForm.action = "/member/updateMemberProc.do";
			console.log(memberForm.method);
			memberForm.method = "post";
			console.log(memberForm.method);
			
			//핸드폰번호를 문자열 결합한다.
			var hp1 = document.getElementById("hp1");
			var hp2 = document.getElementById("hp2");
			var hp3 = document.getElementById("hp3");
			//통합
			var hp = hp1.value + "-" + hp2.value + "-" + hp3.value;

			document.getElementById("hp").value = hp;
			
			memberForm.submit();
		};
		
	</script>
</head>
<body>

	<div>회원가입</div>

	<form id="memberForm" method="post">
		id: ${memberBean.memberId} 
		<input type="hidden" name="memberId" value="${memberBean.memberId}" />
		<br/>
		pw: <input type="password" name="memberPw" maxlength="20" required /><br/>
		이름: <input type="text" name="memberName" maxlength="20" value="${memberBean.memberName}" /><br/>
		나이: 
		<select name="memberAge">
			<c:forEach var="i" begin="1" end="100" varStatus="status">
				<option value="${i}" 
					${i == memberBean.memberAge ? 'selected=selected' : '' }
				>${i}</option>
			</c:forEach>
		</select>
		<br/>
		지역: 
		<select name="memberArea">
			<option value="서울"
			 	<c:if test="${memberBean.memberArea eq '서울'}">selected="selected"</c:if>  >서울</option>
			<option value="부산"
				<c:if test="${memberBean.memberArea eq '부산'}">selected="selected"</c:if>
			>부산</option>
		</select>
		<br/>
		<select id="hp1" name="hp1">
			<option value="010" <c:if test="${memberBean.hp1 eq '010'}">selected="selected"</c:if>>010</option>
			<option value="070" <c:if test="${memberBean.hp1 eq '070'}">selected="selected"</c:if>>070</option>
		</select>
		- <input type="number" id="hp2" name="hp2" maxlength="5" value="${memberBean.hp2}" placeholder="핸드폰 가운데 자리">
		- <input type="number" id="hp3" name="hp3" maxlength="5" value="${memberBean.hp3}" placeholder="핸드폰 뒷자리">
		<input type="hidden" id="hp" name="hp" />
		<br/>
		<input type="radio" name="memberSex" value="F" <c:if test="${fn:toUpperCase(memberBean.memberSex) eq 'F'}">checked</c:if> >여자 
		<input type="radio" name="memberSex" value="M" <c:if test="${fn:toUpperCase(memberBean.memberSex) eq 'M'}">checked</c:if> >남자 
		<br/><br/>
		<button type="button" onclick="updateMember(); return false;">회원가입하기</button> &nbsp;&nbsp; 
		<button type="button" onclick="javascript:history.back();">취소</button>
	</form>

</body>
</html>