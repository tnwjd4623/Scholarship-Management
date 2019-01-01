<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.Date,
java.text.SimpleDateFormat, java.text.ParseException" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>장학생 등록</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>
    
<%
	String idStr = request.getParameter("student_id");
    int id = Integer.parseInt(idStr);
	String moneyStr = request.getParameter("money");
	int money = Integer.parseInt(moneyStr);
   	
   	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
   
   	java.util.Date today = new java.util.Date();
   	String sql_StartDate = format.format(today);
  
   	
   Connection conn = null;
   PreparedStatement pstmt = null;
   String str = "";
   
   try{
      	String jdbcUrl = "jdbc:mysql://localhost:3306/se";
      	String dbId = "root";
      	String dbPass = "";
      
      	Class.forName("com.mysql.jdbc.Driver");
      	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
      	
      	String check = "insert into scholarship values(?,DATE(?), ?)";
  		pstmt = conn.prepareStatement(check);
  		pstmt.setInt(3, id);
  		pstmt.setInt(1, money);
  		pstmt.setString(2, sql_StartDate);
  		pstmt.executeUpdate();

   }catch(Exception e) {
      e.printStackTrace();
%>	  <script>
		alert("fail");
		location.href="./RegisterScholarship.jsp";
	  </script>
<%    
   }finally {
      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
      if(conn != null) try{conn.close();}catch(SQLException sqle){}
   }
%>
<script>
	alert("장학생 등록 완료");
	location.href="RegisterScholarship.jsp";
</script>
</html>