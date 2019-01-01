<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%	request.setCharacterEncoding("euc-kr"); %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String address = request.getParameter("address");
	String session_id = "";
	int student_id = Integer.parseInt(id);
	
	try {
		session_id = (String)session.getAttribute("id");
		student_id = Integer.parseInt(session_id);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if(session_id==null || session_id.equals("")) {
%>			<script>
				alert("로그인이 필요한 서비스입니다.");
				location.replace("Login.jsp");
			</script>
<%
		}
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3306/se";
			String dbId="root";
			String dbPass = "";
	
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			String sql = "select student_id from student where student_id=?";
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1,student_id);
		    rs = pstmt.executeQuery();
			
		    if(rs.next()) {
		    	if(!pw.equals("")) {
		    		sql = "update student set address=?, pw=? where student_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, address);
					pstmt.setString(2, pw);
					pstmt.setInt(3, student_id);
					pstmt.executeUpdate();
					
					sql = "update member set pw=? where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pw);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
		    	}
		    	else {
		    		sql = "update student set address=? where student_id=?";
		    		pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, address);
					pstmt.setInt(2, student_id);
					pstmt.executeUpdate();
		    	}
		    	
		    	%>
		    	<script>
		    		alert("수정 완료");
		    		location.href="./getStudentInfo.jsp";
		    	</script>
		    	<%
		    }
		    
		    else {
		    %>
		    <script>
		    	alert("fail");
		    	location.href="./getStudentInfo.jsp";
		    </script>
		    <%
		    }
		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally{
			if(rs != null) try{rs.close();}catch(SQLException sqle){}
			if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
			if(conn!=null) try{conn.close();}catch(SQLException sqle){}
		}
	}catch(Exception e) {
		e.printStackTrace();
	}
	
%>
</body>
</html>