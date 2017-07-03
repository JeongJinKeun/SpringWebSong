<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
   function check() {
      if (document.search.searchText.value == "") {
         alert("검색어를 입력하세요.");
         document.search.searchText.focus();
         return;
      }
      document.search.submit();
   }
</script>


<style>
html, body {
   font-family: 'Noto Sans KR', sans-serif, dotum, '돋움', gulim, '굴림', Arial,
      AppleGothic, verdana, helvetica;
   font-size: 14px;
   letter-spacing: -0.05em;
   line-height: 1.6;
   font-weight: 400;
   color: #333;
   margin: 0;
   overflow-x: hidden;
   !
   important;
}

a {
   color: #333333;
   text-decoration: none;
}

a:link {
   color: #333333;
   text-decoration: none;
   transition: all .3s ease
}

a:visited {
   color: #333333;
   text-decoration: none
}

a:active {
   color: #333333;
   text-decoration: none
}

a:hover {
   color: #666666;
   text-decoration: none
}

.search_festival {
   margin: 0 auto;
   width: 1200px;
}

.search_info {
   text-indent: 20px;
}

.search_form {
   width: 1200px;
   margin: 0 750px;
}

input:-ms-input-placeholder {
   color: #a8a8a8;
}

input::-webkit-input-placeholder {
   color: #a8a8a8;
}

input::-moz-placeholder {
   color: #a8a8a8;
}

h1 {
   width: 1200px;
   margin: 0 auto;
}

.form_search_info {
   height: 40px;
   width: 400px;
   border: 1px solid #1b5ac2;
   background: #ffffff;
}

.search_text {
   font-size: 16px;
   width: 325px;
   padding: 10px;
   border: 0px;
   outline: none;
   float: left;
   height: 95%;
}

.search_btn {
   width: 50px;
   height: 100%;
   border: 0px;
   background: #1b5ac2;
   outline: none;
   float: right;
   color: #ffffff;
}

.search_area {
   width: 1200px;
   margin: 0 auto;
}

.paging {
   width: 1200px;
   text-align: center;
   margin: 0 auto;
}

.search_info_info {
   margin: 0 20px;
   word-spacing: normal;
}

.search_form {
   width: 1200px;
   margin: 0 40%;
}
</style>
</head>
<body>

   <!-- 섹션 -->
   <section>

   <form action="/festival/searchView.do" method="get" class="search_form"
      name="search">
      <select name="searchType" style="display: none">
         <option value="title">제목</option>
      </select>

      <div class="form_search_info">
         <input class="search_text" type="text" name="searchText"
            value="${searchText}" placeholder="검색할 내용을 입력하세요." />
         <button type="button" class="search_btn" onClick="check()">검색</button>
      </div>
   </form>
   </hr>
   </br>
   <div>
      <h1>"${param.searchText}"&nbsp;검색 결과</h1>
   </div>
   </br>

   <div class="search_area">
      <c:forEach var="bean" items="${searchView}" varStatus="status">
      <hr/>
         <strong>
            <div class="search_info" style="font-weight: bold;">
               <a href="/festival/festival_view.do?festival_no=${bean.festival_no}">${bean.festival_name}</a>
            </div>
         </strong>
         <span class="search_info_info">${bean.festival_detail_intro}</span>
         <br/>   
      </c:forEach>
           <hr/>
   </div>

   <!-- 검색 결과 나오는 화면 -->
    
   
   				<div class="page">
   				
							<ul>
							 <c:if test="${pagingBean.groupNo > 1}">
					               <li><a href="/festival/searchView.do?pageNo=${pBean.pageStartNo - 1}" class="on">&lt;</a></li>
				            </c:if>
				            <c:forEach var="i" begin="${pagingBean.pageStartNo}" end="${pagingBean.pageEndNo}">
				            <c:choose>
				               <c:when test="${pagingBean.pageNo != i}">
				                  <li><a href="/festival/searchView.do?pageNo=${i}&searchType=${param.searchType}&searchText=${param.searchText}" class="on">${i}</a></li>
				               </c:when>
				               <c:otherwise>
				                  <li class="on">${i}</li>
				               </c:otherwise>
				            </c:choose>
				            </c:forEach>
				            <c:if test="${pagingBean.groupNo < pagingBean.totalGroupCount}">
				               <li><a href="/festival/searchView.do?pageNo=${pBean.pageEndNo + 1}" class="on">&gt;</a></li>
				            </c:if>
							
							</ul>
						</div>
						
   </section>
   <!-- 색션 끝 -->

</body>
</html>