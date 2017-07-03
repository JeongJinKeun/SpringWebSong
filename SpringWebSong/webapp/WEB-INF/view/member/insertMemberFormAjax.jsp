<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>회원가입 화면</title>
	
	<script type="text/javascript">
	
		function insertMember() {
			
			//핸드폰번호를 문자열 결합한다.
			var hp = $("#hp1").val() + "-" + $("#hp2").val()
					 + "-" + $("#hp3").val();
			$("#hp").val(hp);
			
			console.log( $("#memberForm").serialize() );
			
			$.ajax({
				type: "post",
				url: "/member/insertMemberProcAjax.do",
				data: $("#memberForm").serialize(),
				dataType: "json",
				success: function(data) {
					console.log(data);
					
					if(data.result == "ok") {
						alert(data.resultMsg);
						location.replace("/member/loginFormAjax.do");
						return;
					} else {
						alert(data.resultMsg);
					}
					
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					alert("error\nxhr : " + xhr + ", status : " 
							+ status + ", error : " + error);      
				}
			});
			
		};
		
	</script>
</head>
<body>

	<div>회원가입</div>

	<form id="memberForm">
		id: <input type="text" name="memberId" maxlength="13" required /><br/>
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
		<button type="button" onclick="insertMember(); return false;">회원가입하기</button> &nbsp;&nbsp; 
		<button type="button" onclick="javascript:history.back();">취소</button>
	</form>

</body>
</html>