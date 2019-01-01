<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/se";
		String dbId="root";
		String dbPass = "";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select * from member where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			String rId = rs.getString("id");
			String rPasswd = rs.getString("pw");
			String rPermit = rs.getString("permit");
			
			if(id.equals(rId)&&pw.equals(rPasswd)) {
				session.setAttribute("id", id);
				session.setAttribute("pw", pw);
				
				if(rPermit.equals("0")){ 
%>					<script>
					location.replace("./Main_admin.jsp");
					</script>
<%				}
				else if(rPermit.equals("1")){
%>					<script>
					location.replace("./Main_student.jsp");
					</script>
<%				}
				else {
%>					<script>
					location.replace("./Main_professor.jsp");
					</script>
<%				}
			}
			else {
				%>
				<script>
				alert("wrong password");
				location.replace("./Login.jsp");
				</script>
				<%
			}	
		}
		else {
			%>
			<script>
			alert("wrong id");
			location.replace("./Login.jsp");
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
%>

</body>
</html>
