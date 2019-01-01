<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = "";
	String name = request.getParameter("name");
	String plan = request.getParameter("plan");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		id = (String)session.getAttribute("id");

		 String jdbcUrl = "jdbc:mysql://localhost:3306/se";
	     String dbId = "root";
	     String dbPass = "";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select name from subject where name=? and professor=?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1,name);
	      pstmt.setString(2, id);
	      rs = pstmt.executeQuery();
    	  
	      if(rs.next()){
	    	  String rName = rs.getString("name");
	    	 
	    	  if(name.equals(rName)){
	    		  sql = "update subject set plan= ? where name= ? and professor=?";
	    		  //sql = "insert into subject(plan) values(?)";
	    		  pstmt = conn.prepareStatement(sql);
	    		  
	    	      pstmt.setString(1,plan);
	    	      pstmt.setString(2,name);
	    	      pstmt.setString(3, id);
	    	      pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>강의계획서 등록</title>
</head>
<script>
	alert("강의계획서 등록 완료");
	location.href="Main_professor.jsp";
</script>
</html>

<%
    	  }
	    }
	      else{
	    	out.println("교수 ID가 틀렸습니다");
	      }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	    if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>    		  



</body>
</html>