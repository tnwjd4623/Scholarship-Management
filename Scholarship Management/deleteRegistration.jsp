<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%		
			String subject_number = request.getParameter("subject_number");
			String student_id = request.getParameter("student_id");
			try {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String jdbcUrl = "jdbc:mysql://localhost:3306/se";
				String dbId="root";
				String dbPass = "";
	
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
					
				
				String sql = "delete from registration where student_id=? and subject_number=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, student_id);
				pstmt.setString(2, subject_number);
				pstmt.executeUpdate();
				
				%><script>alert("delete success");
							location.href="./Main_student.jsp";
					</script><%
			}catch(Exception e) {
				e.printStackTrace();
			}
		%>
</body>
</html>