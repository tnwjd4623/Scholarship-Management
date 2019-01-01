<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>통합정보시스템</title>
</head>
<body>
<%
	String subject_professor = request.getParameter("subject");

	String student_id = request.getParameter("student_id");	
	StringTokenizer t = new StringTokenizer(subject_professor, ",");
	String number = t.nextToken();
	String subject = t.nextToken();
	String professor_id = t.nextToken();
	
	try {
				Connection conn = null;
				PreparedStatement pstmt = null;

				try{
					String jdbcUrl = "jdbc:mysql://localhost:3306/se";
					String dbId="root";
					String dbPass = "";
		
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
					
					String check = "select count(*) from registration where student_id=? and subject_number=?";
					pstmt = conn.prepareStatement(check);
					pstmt.setString(1, student_id);
					pstmt.setString(2, number);
					ResultSet rs = pstmt.executeQuery();
					rs.next();
					
					if(rs.getInt("count(*)") > 0) {
						%><script>alert("이미 신청한 과목입니다.");history.back();</script><%
					}
					else {
						String sql = "insert into registration(student_id, subject, professor, subject_number) values(?,?,?,?)";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, student_id);
						pstmt.setString(2, subject);
						pstmt.setString(3, professor_id);
						pstmt.setString(4, number);
					
						pstmt.executeUpdate();
						%><script>alert("수강신청 완료");location.href="Main_student.jsp";</script><%
					}
				}
				catch(Exception e) {
					e.printStackTrace();
				}
				finally{
					if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
					if(conn!=null) try{conn.close();}catch(SQLException sqle){}
				}
			}catch(Exception e) {
				e.printStackTrace();
		}
	%>
				
</body>
</html>