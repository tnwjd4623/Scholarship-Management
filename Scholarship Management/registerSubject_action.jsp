<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>과목 등록</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %> 
<%!
	public boolean check_time(String start_time, String end_time) {
		StringTokenizer t = new StringTokenizer(start_time, ":");
		int s_hour = Integer.parseInt(t.nextToken());
		int s_minute = Integer.parseInt(t.nextToken());
	
		t = new StringTokenizer(end_time, ":");
		int e_hour = Integer.parseInt(t.nextToken());
		int e_minute = Integer.parseInt(t.nextToken());
	
		if(s_hour > e_hour) {
			return false;
	 	}
	
		else if(s_hour == e_hour) {
			if(s_minute > e_minute) {
			
				return false;
			}
		}
	return true;
	}
%>
<%
	String name = request.getParameter("name");
	String classroom ="";
	
	String day = request.getParameter("day");
	String start_time = request.getParameter("start_time");
	String end_time = request.getParameter("end_time");
	int subject_number = 0;
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/se";
		String dbId = "root";
		String dbPass = "";
		Class.forName("com.mysql.jdbc.Driver");
      	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	   	
	   	String count = "select count(*) from (select distinct number from subject) s";
	   	pstmt = conn.prepareStatement(count);
		ResultSet rs = pstmt.executeQuery();
	  	rs.next();
	  	int number = Integer.parseInt(rs.getString("count(*)"));
	  	subject_number = number+1;
	  	
	}catch(Exception e) {
		e.printStackTrace();
	}
	finally {
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
      	if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
	
	
   		if(check_time(start_time, end_time)){
   			String time = start_time +"-"+ end_time;
   			String professor = request.getParameter("professor_id");
   	
   			conn = null;
   			pstmt = null;
	 		String str = "";
   
   		try{
      		String jdbcUrl = "jdbc:mysql://localhost:3306/se";
      		String dbId = "root";
      		String dbPass = "";
      
      		Class.forName("com.mysql.jdbc.Driver");
	      	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
   	   	
   	   		String count = "select count(*) from subject";
   	   		pstmt = conn.prepareStatement(count);
   		   	ResultSet rs = pstmt.executeQuery();
   	  	 	rs.next();
      	
      		int classroom_total = Integer.parseInt(rs.getString("count(*)"));
      		classroom = (classroom_total+100+1)+"";
      		
      		String check = "insert into subject(name, classroom, time, professor,plan, number, day) values(?,?,?,?,?,?,?)";
  			pstmt = conn.prepareStatement(check);
  			pstmt.setString(1, name);
  			pstmt.setString(2, classroom);
  			pstmt.setString(3, time);
  			pstmt.setString(4, professor);
  			pstmt.setString(5, "Plan is not registered.");
  			pstmt.setString(6, subject_number+"");
  			pstmt.setString(7, day);
  			pstmt.executeUpdate();

  			%><script>
  				alert("과목 등록 완료");
  				location.href="./Main_professor.jsp";	
  			</script>
  			<%	
   		}catch(Exception e) {
      		e.printStackTrace();
%>		  	<script>
			alert("fail");
			location.href="./registerSubject.jsp";
			  </script>
<%		    str = "과목등록에 실패했습니다.";
   		}finally {
      		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
      		if(conn != null) try{conn.close();}catch(SQLException sqle){}
   			}
   		}
   		
   		else {
   			%>
   			<script>
			alert("시간을 정확히 입력해주세요");
			history.back();
			</script>
			<%
   		}
   	
%>
</html>