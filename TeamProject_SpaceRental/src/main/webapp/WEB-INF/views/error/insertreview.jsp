<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>Error 리뷰작성 :Ubiquitous</title>
</head>
<body>
	<div class="container">
		<h3>Review Insert Exception</h3>
		<p class="alert alert-info">
			${info }
			<a href="${pageContext.request.contextPath}/">인덱스로</a>
		</p>
	</div>
</body>
</html>