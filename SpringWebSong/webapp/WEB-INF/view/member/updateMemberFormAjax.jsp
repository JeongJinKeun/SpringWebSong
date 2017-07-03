<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
	<script type="text/javascript">
		
		$(function() {
			
			HoldOn.open({
				  theme:"sk-cube-grid"
				});
			
			//회원정보를 취득한다.
			$.ajax({
				type: "post",
				url: "/member/selectMemberAjax.do?memberId=${param.memberId}",
				dataType: "json",
				success: function(data) {
					printLog( data );
					
					HoldOn.close();
					
					if(data.result == "ok") {
						
						var mBean = data.mBean;
						
						$("#dispMemberId").text(mBean.memberId);
						$("input[name='memberName']").val( mBean.memberName );
						$("select[name='memberAge']").val( mBean.memberAge );
						$("select[name='memberArea']").val( mBean.memberArea );
						$("select[name='hp1']").val( mBean.hp1 );
						$("input[name='hp2']").val( mBean.hp2 );
						$("input[name='hp3']").val( mBean.hp3 );
						$('input:radio[name="memberSex"][value="' 
							+ mBean.memberSex  + '"]').prop('checked', true);
						
					} else {
						alert(data.resultMsg);
					}
					
				},
				error: function(xhr, status, error) {
					console.log(xhr);
					HoldOn.close();
					alert("error\nxhr : " + xhr + ", status : " 
							+ status + ", error : " + error);      
				}
			});
			
		});
	
		
		//회원정보 수정
		function updateMember() {
			
			
		};
		
	</script>
</head>
<body>

	<div>회원가입</div>

	<form id="memberForm" method="post">
		id: <span id="dispMemberId"></span>
		<input type="hidden" name="memberId" value="" />
		<br/>
		pw: <input type="password" name="memberPw" maxlength="20" required /><br/>
		이름: <input type="text" name="memberName" maxlength="20" value="" /><br/>
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
			<option value="서울">서울</option>
			<option value="부산">부산</option>
		</select>
		<br/>
		<select id="hp1" name="hp1">
			<option value="010">010</option>
			<option value="070">070</option>
		</select>
		- <input type="number" id="hp2" name="hp2" maxlength="5" value="" placeholder="핸드폰 가운데 자리">
		- <input type="number" id="hp3" name="hp3" maxlength="5" value="" placeholder="핸드폰 뒷자리">
		<input type="hidden" id="hp" name="hp" />
		<br/>
		<input type="radio" name="memberSex" value="F">여자 
		<input type="radio" name="memberSex" value="M">남자 
		<br/><br/>
		<button type="button" onclick="updateMember(); return false;">회원가입하기</button> &nbsp;&nbsp; 
		<button type="button" onclick="javascript:history.back();">취소</button>
	</form>

</body>
</html>