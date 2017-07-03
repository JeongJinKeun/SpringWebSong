<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
	<script type="text/javascript">
		function writeBoard() {
			
			var formData = new FormData();
			
			formData.append("title", $("#title").val() );
			formData.append("content", $("#content").val() );
			
			formData.append("upFile", 
					$("input[name=upFile]")[0].files[0]);
			formData.append("upFile", 
					$("input[name=upFile]")[1].files[0]);
			
			$.ajax({
	                url: '/board/boardInsertProcAjax.do',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(data){
	                    
	                	alert(data.resultMsg);
	                	
	                	if(data.result == "ok") {
	                		//화면이동 처리
	                	}
	                	
	                }
	            });

		};//end function
	</script>
	
</head>
<body>
	
	<div>게시판 글쓰기</div>
	<div> 
		제목: <input type="text" id="title" />
	</div>
	<div>
		내용: <textarea id="content" rows="10" cols="30"></textarea>
	</div>
	<div>
		파일1: <input type="file" name="upFile" /><br/>
		파일2: <input type="file" name="upFile" /><br/>
	</div>
	<div>
		<button type="button" onclick="writeBoard()">글쓰기</button>
	</div>
	
</body>
</html>