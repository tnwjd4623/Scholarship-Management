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
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		java.util.Date s_date = new SimpleDateFormat("yyyy-MM-dd").parse(start_date);
		java.util.Date e_date = new SimpleDateFormat("yyyy-MM-dd").parse(end_date);
		
		if(s_date!=null && e_date!=null) {
			if(s_date.getTime() > e_date.getTime()) {
				%><script>alert("시간을 정확히 입력해 주세요");history.back();</script><%
			}
		
		
		else {
			try {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try{
					String jdbcUrl = "jdbc:mysql://localhost:3306/se";
					String dbId="root";
					String dbPass = "";
		
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
					String sql = "select count(*) from class_date";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					rs.next();
					int total = Integer.parseInt(rs.getString("count(*)"));
					
					if(total==0) {
						sql = "insert into class_date(start_date, end_date) values(DATE(?), DATE(?))";
						pstmt = conn.prepareStatement(sql);
				  		pstmt.setString(1,start_date);
				  		pstmt.setString(2,end_date);
				  
				  		pstmt.executeUpdate();
				  		%><script>alert("날짜를 등록하였습니다.");location.href="Main_admin.jsp";</script><%
					}
					else {
						sql = "update class_date set start_date=?, end_date=?" ;
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, start_date);
						pstmt.setString(2, end_date);
						
						pstmt.executeUpdate();
						%><script>alert("날짜를 수정하였습니다."); location.href="Main_admin.jsp";</script><%
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
		}}
	%>
</body>
</html>