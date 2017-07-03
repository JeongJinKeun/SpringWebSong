<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
	
		//전체 댓글의 갯수
		var replyListTotCount = 0;
		//현재 startRow 값
		var replyStartRow = 0;
		var isReplayLoading = false;
		
		
		$(function() {
			
			//윈도우 스크롤의 마지막을 감지하는 이벤트
			$(window).scroll(function() { 
				
				var scrollTop = $(window).scrollTop();
				var docHeight = $(document).height();
				var winHeight = $(window).height();
				
				printLog("scrollTop: " + scrollTop 
						+ ", docHeight: " + docHeight
						+ ", winHeight: " + winHeight);
				
				if ($(window).scrollTop() >= $(document).height() - $(window).height() - 20)
				{ 
					showNextReplyList();
				}
			});
			
			
			$.ajax({
				type: "post",
				url: "/board/boardDetailViewAjax.do",
				data: {
					no: "${param.no}"
				},
				dataType: "json",
				success: function(data) {
					printLog(data);
					
					if(data.result == "ok") {
						
						var board = data.boardBean;
						
						$("#boardNo").text( board.no );
						$("#regDate").text( board.regDate );
						$("#memberId").text( board.memberId );
						$("#memberName").text( board.memberName );
						$("#title").text( board.title );
						$("#content").text( board.content );
						
						//댓글 리스트 출력
						$.each(data.boardReplyList, function(i, mBean) {
							var str = "";
							str += "<tr>";
							str += "<td width='5%'>" + mBean.no + "</td>";
							str += "<td width='20%'>" + mBean.regDate + "</td>";
							str += "<td width='10%'>" + mBean.memberId + "</td>";
							str += "<td width='10%'>" + mBean.memberName + "</td>";
							str += "<td><pre>" + mBean.content + "</pre></td>";
							str += "</tr>";
							
							$("#boardReplyInfo").append(str);
						});
						
						//더보기 버튼에 대한 처리
						replyListTotCount = board.replyTotCount;
						replyStartRow =  data.boardReplyList.length;
						
						if( board.replyTotCount > data.boardReplyList.length ) {
							//댓글 더보기 버튼 화면에 표시
							$("#moreReplyList").show();
						} else{
							$("#moreReplyList").hide();
						}
						
						
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
			
			
		});//end ready
		
		
		//다음 댓글 리스트를 표시한다.
		function showNextReplyList() {
			
			if( replyListTotCount <= replyStartRow && isReplayLoading) {
				return;
			}
			
			//알고 있어야 되는 정보
			//전체 댓글의 갯수
			//현재 startRow 를 알고 있어야 한다.
			
			isReplayLoading = true;
			
			$.ajax({
				type: "post",
				url: "/board/boardDetailViewAjax.do",
				data: {
					no: "${param.no}",
					startRow : replyStartRow
				},
				dataType: "json",
				success: function(data) {
					printLog(data);
					
					if(data.result == "ok") {
						
						//댓글 리스트 출력
						$.each(data.boardReplyList, function(i, mBean) {
							var str = "";
							str += "<tr>";
							str += "<td width='5%'>" + mBean.no + "</td>";
							str += "<td width='20%'>" + mBean.regDate + "</td>";
							str += "<td width='10%'>" + mBean.memberId + "</td>";
							str += "<td width='10%'>" + mBean.memberName + "</td>";
							str += "<td><pre>" + mBean.content + "</pre></td>";
							str += "</tr>";
							
							$("#boardReplyInfo").append(str);
						});
						
						//더보기 버튼에 대한 처리
						replyStartRow += data.boardReplyList.length*1;
						
						if( replyListTotCount > replyStartRow ) {
							//댓글 더보기 버튼 화면에 표시
							$("#moreReplyList").show();
						} else{
							$("#moreReplyList").hide();
						}
						
					} else {
						alert(data.resultMsg);
					}
					
					isReplayLoading = false;
				},
				error: function(xhr, status, error) {
					isReplayLoading = false;
					console.log(xhr);
					alert("error\nxhr : " + xhr + ", status : " 
							+ status + ", error : " + error);      
				}
			});
			
			
			
		};
		
	</script>
</head>
<body>
	
	<div style="width: 700px;">
		<div>게시글 번호: <span id="boardNo"></span> </div>
		<div>게시글 날짜: <span id="regDate"></span> </div>
		<div>글쓴이 ID: <span id="memberId"></span> </div>
		<div>글쓴이 이름: <span id="memberName"></span> </div>
		<div>게시글 제목: <span id="title"></span> </div>
		<div>게시글 내용: <pre id="content"></pre> </div>
	</div>
	
	<br/><br/>
	댓글목록 <br/>
	<table style="width: 700px;">
		<tbody id="boardReplyInfo"></tbody>
	</table>
	
	<br/>
	<table style="width: 700px;">
		<tr>
			<td>
				<button type="button" id="moreReplyList"
				 onclick="showNextReplyList()">댓글 더보기</button>	
			</td>
		</tr>
	</table>
</body>
</html>