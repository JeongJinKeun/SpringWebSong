<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<title>Insert title here</title>
	<script type="text/javascript" src="/js/common/jquery/jquery-3.2.1.js"></script>
	
	<script type="text/javascript">
		
		$(document).ready(function() {
			
			$("#btnLogin").click(function() {
				
				$.ajax({
					type: "post",
					url: "/member/loginProcAjax.do",
					data: {
						memberId: $("#memberId").val(),
						memberPw: $("#memberPw").val()
					},
					dataType: "json",
					success: function(data) {
						console.log(data);
						
						if(data.result == "ok") {
							
							//android 호출
							try {
								var memId = $("#memberId").val();
								window.JSInterface.updateAndToken(memId);
							} catch(e) {
								console.log(e);
							}
							
							//로그인 성공
							location.replace("/index.do");
							return;
						} else {
							alert("로그인을 실패하였습니다.");
							$("#memberPw").focus();
						}
						
					},
					error: function(xhr, status, error) {
						console.log(xhr);
						alert("error\nxhr : " + xhr + ", status : " 
								+ status + ", error : " + error);      
					}
				});
				
			});
			
		});
		
		$(function() {
			
		});
	
	</script>
	
</head>
<body>
	<div style="width: 100%; height: 100%">
		<input type="text" id="memberId" /> <br/>
		<input type="password" id="memberPw" /> <br/>
		<button type="button" id="btnLogin">로그인</button>
	</div>
</body>
</html>