<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript">
	
		//회원정보 삭제
		function delMember(memberId) {
			
			if( confirm("회원정보를 삭제 하시겠습니까?") ) {
				
				HoldOn.open({theme:"sk-cube-grid"});
				
				$.ajax({
					type: "post",
					url: "/member/memberDeleteAjax.do",
					data: { 
						memberId: memberId
					},
					dataType: "json",
					success: function(data) {
						console.log(data);
						
						HoldOn.close();
						
						if(data.result == "ok") {
							location.reload(); //새로고침
						} else {
							alert(data.resultMsg);
						}
						
					},
					error: function(xhr, status, error) {
						HoldOn.close();
						console.log(xhr);
						alert("error\nxhr : " + xhr + ", status : " 
								+ status + ", error : " + error);      
					}
				});
			}
			
		};
		
		$(function() {
			
			HoldOn.open({
				  theme:"sk-cube-grid"
				});
			
			$.ajax({
				type: "post",
				url: "/member/selectMemberListAjax.do",
				dataType: "json",
				success: function(data) {
					console.log(data);
					
					HoldOn.close();
					
					if(data.result == "ok") {
						
						//리스트 출력
						$.each(data.memberList, function(i, mBean) {
							var str = "";
							str += "<tr>";
							str += "<td>" + mBean.no + "</td>";
							str += "<td><a href='/member/updateMemberFormAjax.do?memberId=" + mBean.memberId + "'>" + mBean.memberId + "</a></td>";
							str += "<td>" + mBean.memberName + "</td>";
							str += "<td>" + mBean.memberAge + "</td>";
							str += "<td>" + mBean.memberArea + "</td>";
							str += "<td>" + mBean.hp + "</td>";
							str += "<td>" + mBean.memberSex + "</td>";
							str += "<td><button type='button' onclick=delMember('" 
									+ mBean.memberId + "')>삭제</button></td>";
							str += "</tr>";
							
							$("#memberListBody").append(str);
						});
						
						
					} else {
						alert(data.resultMsg);
					}
					
				},
				error: function(xhr, status, error) {
					HoldOn.close();
					console.log(xhr);
					alert("error\nxhr : " + xhr + ", status : " 
							+ status + ", error : " + error);      
				}
			});
			
		});
	
	</script>
	
</head>
<body>

	<table>
		<thead>
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
		</thead>
		<tbody id="memberListBody">
			
		</tbody>
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
					<input type="text" name="searchText" /> 
					<button type="button" onclick="alert('메롱');">검색</button>
				</form>
			</td>
		</tr>
	</table>

</body>
</html>