<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>장학 현황 확인</title>
</head>
<body>
	<form method="post" action="./getScholarship_action.jsp">
		학번 : <input type="text" name="student_id" maxlength="10"><br/>		
		<input type="submit" value="검색">
		<input type = "button" value="메인으로" onclick="location.href='./Main_student.jsp'"/>
	</form>
</body>
</html>