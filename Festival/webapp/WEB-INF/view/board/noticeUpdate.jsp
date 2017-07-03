<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
		function updateBoard() {
			var formData = new FormData();
			
			formData.append("boardTitle", $("#boardTitle").val() );
			formData.append("boardContent", $("#boardContent").val() );
			formData.append("boardNo", $("#boardNo").val());
			if($("input[name=upFile]")[0].files[0] != null){
				
			formData.append("upFile", $("input[name=upFile]")[0].files[0]);
			
			}
			
			$.ajax({
                type: 'POST',
                url: "/board/noticeUpdateAjax.do",
                processData: false,
                contentType: false,
                data: formData,
                	
                success: function(data){
                	
                	alert(data.resultMsg);
                	
                	if(data.result == "ok") {
                		//화면이동 처리
                		location.href="noticeList.do?pageNo=1";
                	}
                }
            }); // end of ajax
		}
		
		$(function(){
			$("#imgFile").click(function(){
				if(confirm("삭제 하시겠습니까?")) {
					$.ajax({
		    			type: 'POST',
		    			url: "/board/deleteBoardFileAjax.do",
		                data: {
		                	boardNo : "${boardList.boardNo}",
		                },
		                success: function(data){
		                	alert(data.resultMsg);
		                	if(data.result == "ok") {
		                		//화면이동 처리
		                		location.reload();
		                	}
		                }
		            }); // end of ajax
				}
			});
		});
	</script>
</head>
<body>
		<!--메인 -->
		<section>
			<div class="sub_wrap">
				<div class="sub_bg">
					<h1>커뮤니티 Community</h1>
					<img src="/images/community.jpg" alt="서브배경" />	
				</div>
				<!-- 서브 네비 -->
				<div class="sub_nav">
					<div class="sub_menu">
						<h3>커뮤니티</h3>
						<ul>
							<li><a href="noticeList.do?pageNo=1" class="on">자유게시판</a></li>
							<li><a href="qna_list.html"> Q&amp;A </a></li>
						</ul>
					</div>
					<div class="sub_title">
						<div class="rout">
							<ul>
								<li>홈</li> > 
								<li>커뮤니티</li> > 
								<li>자유게시판</li>
							</ul>
						</div>
						<h2>자유게시판 글수정</h2>
					</div>

					<!-- 서브 내용 -->
					<div class="sub_content">
						<div class="write_table">
							<table>
								<tr>
									<th>번호</th>
									<td><input type="text" class="input" id="boardNo" value="${boardList.boardNo}" readonly></td>
								</tr>
								<tr>
									<th>제목</th>
									<td><input type="text" class="input" id="boardTitle" value="${boardList.boardTitle}"></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td><input type="file" name="upFile"> 
									<c:forEach var="bean" items="${fileList}" varStatus="status">
									<c:if test="${fileList ne null}"> <input type=text style="cursor:pointer" id="imgFile" value="${bean.fileOriginName}"></c:if>
									</c:forEach></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><textarea id="boardContent">${boardList.boardContent}</textarea></td>
								</tr>
							</table>
							<button type="submit" class="btn_submit" onclick="updateBoard()">수정하기</button>
						</div>
					</div>
				</div>
			</div>
			
			
		</section>
		<!--메인끝 -->
</body>
</html>