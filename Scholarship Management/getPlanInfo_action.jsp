<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="./main.css">
<title>Insert title here</title>
</head>
<body>
		<header>
				<a class="logout" href='./Logout.jsp'">Logout</a><br/><br/>
		</header>
				
		<nav></nav>
	
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String name = request.getParameter("name");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/se";
	     String dbId = "root";
	     String dbPass = "";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select * from subject where name=? ";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1,name);
	      rs = pstmt.executeQuery();
 %>
	<%    
		int count = 1;  
		if(rs.next()) {
			%><table class="type09">
				<thead>
 					<tr>
 					<th>과목명</th>
 					<th>강의계획서</th>
  					</tr>
  				</thead>
	    	 	<tbody>
	    	 	 <tr>
	    	 	 <td><%=rs.getString("name")%></td>
	    		 <td><%=rs.getString("plan")%></td> 
	    		 </td>
	    		 </tr>
	    	 <%count++;
		}
	      while(rs.next()){
	    	  if(count%2==0) {
	    		  %>
	  	    	  <tr>
	  	    	  <td class="even"><%=rs.getString("name")%></td>
	  	    	  <td class="even"><%=rs.getString("plan")%></td> 
	  	    	  </td>
	  	    	  </tr>

	  	    	 <%
	    	  
	    	  }
	    	  else {
	    		  %>
	  	    	<tr>
	  	    	  <td><%=rs.getString("name")%></td>
	  	    	  <td><%=rs.getString("plan")%></td> 
	  	    	  </td>
	  	    	  </tr>

	  	    	 <%
	    	  }
	    	  count++;
	  
	    } // end while
	    	 %>
	    	 
	    	 </tbody>
	    	 </table>
	    	  

   <button class="type01" onClick="location.href='./Main_student.jsp'">메인으로</button>
    <button class="type01" onClick="location.href='./getPlanInfo.jsp'">이전으로</button>
    
	    	  <%
	    	    rs.close();        // ResultSet exit
	    	    pstmt.close();     // Statement exit
	    	    conn.close();    // Connection exit
	    	 }
	    	  catch (SQLException e) {
	    	        out.println("err:"+e.toString());
	    	  } 
	    	 %>	      
</body>
</html>