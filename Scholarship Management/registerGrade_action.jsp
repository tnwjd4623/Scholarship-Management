<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="./grade.css">

<title>통합정보시스템</title>
</head>
<body>
	<%
		String id = "";
		String student_id = request.getParameter("student_id");
		String subject_number = request.getParameter("subject");
		String grade = request.getParameter("grade");
		
		try {
			id = (String)session.getAttribute("id");
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try{
				String jdbcUrl = "jdbc:mysql://localhost:3306/se";
				String dbId="root";
				String dbPass = "";
	
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
				String sql = "select student_id, subject, professor, subject_number from registration where subject_number=? and student_id=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, subject_number);
				pstmt.setString(2, student_id);
				rs = pstmt.executeQuery();
				
				String check = "select count(*) from score where student_id=? and subject_number=?";
				pstmt = conn.prepareStatement(check);
				pstmt.setString(1, student_id);
				pstmt.setString(2, subject_number);
				
				ResultSet rs2 = pstmt.executeQuery();	
				rs2.next();
				
				if(rs.next()) {
					
					if(rs2.getInt("count(*)") > 0) {
						String update = "update score set score=? where student_id=? and subject_number=?" ;
						pstmt = conn.prepareStatement(update);
						pstmt.setString(1, grade);
						pstmt.setString(2, student_id);
						pstmt.setString(3, subject_number);
						
						pstmt.executeUpdate();
						%><script>alert("update success"); history.back(); </script><%
					}
					else {
						String insert = "insert into score(student_id, subject, score, subject_number) values(?,?,?,?)";
						pstmt = conn.prepareStatement(insert);
						pstmt.setString(1, rs.getString("student_id"));
						pstmt.setString(2, rs.getString("subject"));
						pstmt.setString(3, grade);
						pstmt.setString(4, rs.getString("subject_number"));
					
						pstmt.executeUpdate();
						%><script>alert("insert success"); history.back(); </script><%
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
				
		}catch(Exception e) {
			e.printStackTrace();
		}
	
%>

</body>
</html>