<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title> <decorator:title default="Spring 테스트웹"/> </title>
	
	<c:import url="/WEB-INF/view/layout/header.jsp"></c:import>
		
	<decorator:head />
</head>
<body>

	<div>공통 헤더</div>
	<hr />

	<div>
		<decorator:body />
	</div>

	<hr />
	<div>공통 푸터</div>
</body>
</html>
