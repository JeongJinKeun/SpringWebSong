<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
	<link rel="stylesheet" type="text/css"
	 	href="/js/common/daumEditor/css/editor.css"></link>
	<script src="/js/common/daumEditor/js/editor_loader.js?environment=production" 
		type="text/javascript" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(function() {
			$.ajax({
			    type:"POST", 
				url : "/js/common/daumEditor/editor_template.html",
		        success : function(data){
		            $("#editor_frame").html(data);
		            // 에디터UI load
		            var config = {
		                /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
		                txHost: '',
		                /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
		                txPath: '',
		                /* 수정필요없음. */
		                txService: 'sample',
		                /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
		                txProject: 'sample',
		                /* 대부분의 경우에 빈문자열 */
		                initializedId: "",
		                /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
		                wrapper: "tx_trex_container",
		                /* 등록하기 위한 Form 이름 */
		                form: "tx_editor_form",
		                /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
		                txIconPath: "/js/common/daumEditor/images/icon/editor/",
		                /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
		                txDecoPath: "/js/common/daumEditor/images/deco/contents/",
		                canvas: {
		                    minHeight: 100,
		                    maxHeight:  500,
		                    autoSize: true,
		                    exitEditor:{
		                        /*
		                        desc:'빠져 나오시려면 shift+b를 누르세요.',
		                        hotKey: {
		                            shiftKey:true,
		                            keyCode:66
		                        },
		                        nextElement: document.getElementsByTagName('button')[0]
		                        */
		                    },
		                    styles: {
		                        color: "#123456", /* 기본 글자색 */
		                        fontFamily: "굴림", /* 기본 글자체 */
		                        fontSize: "10pt", /* 기본 글자크기 */
		                        backgroundColor: "#fff", /*기본 배경색 */
		                        lineHeight: "1.5", /*기본 줄간격 */
		                        padding: "8px" /* 위지윅 영역의 여백 */
		                    },
		                    showGuideArea: false
		                },
		                events: {
		                    preventUnload: false
		                },
		                sidebar: {
		                    attachbox: {
		                        show: true,
		                        confirmForDeleteAll: true
		                    },
		                    attacher: {
		                        file: {
		                           boxonly: true
		                        }
		                     }
		                },
		                size: {
		                    contentWidth: 850 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
		                }
		            };
		            
		            
		            EditorJSLoader.ready(function(Editor) { 
		            	//에디터내에 환경설정 적용하기
// 		            	var editor = new Editor(config); 
		            	
		            	 //에디터내에 환경설정 적용하기
	 		            new Editor(config);
			            Editor.modify({
			                content: '${boardBean.content}',
			                attachments:[
			                  <c:forEach items="${baList}" var="imgList" varStatus="status" >
			                 	 <c:if test="${imgList.attachType == '2'}"> /* 이미지 일때 */
				                 	 {
				                         attacher: 'image', 
				                          data: {
					                          thumburl: "${imgList.fileName}",
					                           imageurl: "${imgList.fileName}",
					                          originalurl: "${imgList.fileName}",
					                           exifurl: "${imgList.fileName}",
					                           attachurl: "${imgList.fileName}",
					                          filename: "${imgList.fileName}",
					                          filesize: "743"
				                          }
				                      },
			                      </c:if>
			                  </c:forEach>
			                  <c:forEach items="${baList}" var="fileList" varStatus="status" >
				                  <c:if test="${fileList.attachType == '1'}"> /* 이미지 일때 */
					               	  {
					                        attacher: 'file', 
					                         data: {
						                         thumburl: "${fileList.fileName}",
						                          imageurl: "${fileList.fileName}",
						                         originalurl: "${fileList.fileName}",
						                          exifurl: "${fileList.fileName}",
						                          attachurl: "${fileList.fileName}",
						                         filename: "${fileList.fileName}",
						                         filesize: "743"
					                         }
					                  },
					              </c:if>
			               	  </c:forEach>
			                  {}
			        		]
			       		 }); // end of Editor.modify
		            });
		        }
		    });//end Ajax
		}); // end of ready
		
		/**
		 * Editor.save()를 호출한 경우 데이터가 유효한지 검사하기 위해 부르는 콜백함수로
		 * 상황에 맞게 수정하여 사용한다.
		 * 모든 데이터가 유효할 경우에 true를 리턴한다.
		 * @function
		 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
		 * @returns {Boolean} 모든 데이터가 유효할 경우에 true
		 */
		function validForm(editor) {
			// Place your validation logic here

			// sample : validate that content exists
			var validator = new Trex.Validator();
			var content = editor.getContent();
			if (!validator.exists(content)) {
				alert('내용을 입력하세요');
				return false;
			}

			return true;
		}

		 /**
		 * Editor.save()를 호출한 경우 validForm callback 이 수행된 이후
		 * 실제 form submit을 위해 form 필드를 생성, 변경하기 위해 부르는 콜백함수로
		 * 각자 상황에 맞게 적절히 응용하여 사용한다.
		 * @function
		 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
		 * @returns {Boolean} 정상적인 경우에 true
		 */
		function setForm(editor) {
	        var i, input;
	        var form = editor.getForm();
	        var content = editor.getContent();

	        // 본문 내용을 필드를 생성하여 값을 할당하는 부분
	        var textarea = document.createElement('textarea');
	        textarea.name = 'content';
	        textarea.style='"display: none;"';
	        textarea.value = content;
	        form.createField(textarea);

	        /* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
	         첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */
	        var images = editor.getAttachments('image',true);
	        for (i = 0; i < images.length; i++) {
	            // existStage는 현재 본문에 존재하는지 여부
	            if (images[i].existStage) {
	                // data는 팝업에서 execAttach 등을 통해 넘긴 데이터
	                //alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
	                input = document.createElement('input');
	                input.type = 'hidden';
	                input.name = 'imgPath';
	                input.value = images[i].data.imageurl;  // 이미지 경로
	                form.createField(input);
	                input = document.createElement('input');
	                input.type = 'hidden';
	                input.name = 'imgOriginName';
	                input.value = images[i].data.filename  // 이미지 원본 이름
	                form.createField(input);
	                input = document.createElement('input');
	                input.type = 'hidden';
	                input.name = 'imgSize';
	                input.value = images[i].data.filesize;  // 이미지 크기
	                form.createField(input);
	            }
	        }

	        var files = editor.getAttachments('file',true);
	        for (i = 0; i < files.length; i++) {
	            input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'filePath';
	            input.value = files[i].data.attachurl;
	            form.createField(input);
	            input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'fileOriginName';
	            input.value = files[i].data.filename  // 파일 원본 이름
	            form.createField(input);
	            input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'fileSize';
	            input.value = files[i].data.filesize;  // 파일 크기
	            form.createField(input);
	        }
	        return true;
		};//end setForm
		 
		//게시글 저장
		function updateBoard() {
			if( confirm("수정 하시겠습니까?") ) {
// 				Editor.save();
				
				// refresh 안하기 위해서 임시방편
				validForm(Editor);
				setForm(Editor);
				
				
				var param = $("#tx_editor_form").serialize();
				
				console.log(param);
				
				$.ajax({
					url : "/board/daum/angBoardUpdateProcAjax.do",
					method : "post",
					data : param,
					dataType : "json",
					success : function(data) {
						alert("글 수정 성공");
						
						location.reload(); // 재로딩
					}
				});
				
				return false;
			}
		};
	</script>
	
</head>
<body>
	
	<div>게시판 글수정</div>
	<div>
		
		<form name="tx_editor_form" id="tx_editor_form" method="post"  accept-charset="utf-8">
			<table width="100%">
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td id="editor_frame"></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" id="save" value="수정" onclick="updateBoard()">수정</button>
						<input type="button" value="취소"/>
					</td>
				</tr>
			</table>
		</form>

	</div>
	
</body>
</html>