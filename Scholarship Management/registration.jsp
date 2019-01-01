<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="./main.css">
<title>Insert title here</title>
</head>
<body>


<%		
		String id="";
		String name="";
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
		
				String sql = "select name from student where student_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					name = rs.getString("name");
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
			
			if(id==null || name.equals("")) {
	%>			<script>
					alert("로그인이 필요한 서비스입니다.");
					location.replace("Login.jsp");
				</script>
	<%
			}else {
	%>			<header>
					<a class="logout" href='./Logout.jsp'">Logout</a><br/><br/>
				</header>
				
				<nav></nav>
				<label for="login__username"><svg class="icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use></svg>
				<span><%=name %></span></label>		
<%	
				try {
					conn = null;
					pstmt = null;
					rs = null;	

					try{
						String jdbcUrl = "jdbc:mysql://localhost:3306/se";
						String dbId="root";
						String dbPass = "tnwjd6557";
		
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
						String sql = "select start_date, end_date from class_date";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						rs.next();
					
						java.util.Date s_date = new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("start_date"));
						java.util.Date e_date = new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("end_date"));
						java.util.Date today = new java.util.Date();
					
						if(today.getTime() < s_date.getTime() || today.getTime() > e_date.getTime()) {
							%><script>alert("수강신청 기간이 아닙니다."); history.back();</script><%
						}
						else {
							sql = "select number, name, classroom, time, professor from subject";
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							%> <form method="post" action="registration_action.jsp">
							개설과목<br/>
								<table class="type09">
								<thead>
									<tr>
										<th></th>
										<th>과목번호</th>
										<th>과목</th>
										<th>교수님</th>
										<th>시간</th>
										<th>강의실</th>
									</tr>
								</thead>
								<tbody>
							<%				
							int count = 1;
							while(rs.next()) {
								name = rs.getString("name");
								String professor = rs.getString("professor");
								String sql2 = "select name from professor where professor_id=?";
								
								pstmt = conn.prepareStatement(sql2);
								pstmt.setString(1, professor);
								
								
								ResultSet rs2 = pstmt.executeQuery();
								rs2.next();
								professor = rs2.getString("name");
								
								String number = rs.getString("number");
								String time = rs.getString("time");
								String classroom = rs.getString("classroom");
								
								if(count%2==0) {
								%><tr>
									<td class="even"><input type="radio" name="subject" value="<%=number%>,<%=name%>,<%=professor%>"></td>
									<td class="even"><%=number %></td>
									<td class="even"><%=name%></td>
									<td class="even"><%=professor %></td>
									<td class="even"><%=time %></td>
									<td class="even"><%=classroom %></td>
								</tr>
								<%
								}
								else {
									%><tr>
									<td><input type="radio" name="subject" value="<%=number%>,<%=name%>,<%=professor%>"></td>
									<td><%=number %></td>
									<td><%=name%></td>
										<td><%=professor %></td>
									<td><%=time %></td>
									<td><%=classroom %></td>
								</tr>
								<%
								}
								count++;
							}
							
							%>
								</tbody>
								</table>
								<input type="hidden" value="<%=id %>" name="student_id">
								<input class="type01" type="submit" value="신청">
								</form><%
								
							String sql3 = "select subject_number, subject, professor from registration where student_id=?";
							pstmt = conn.prepareStatement(sql3);
							pstmt.setString(1, id);
							ResultSet rs3 = pstmt.executeQuery();
								
							%><br/><br/>수강 신청 내역:  <br/>
								<table class="type09">
								<thead>
									<tr>
										<th>과목번호</th>
										<th>과목</th>
										<th>교수님</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								<%
							count = 1;	
							while(rs3.next()) {	
								String subject = rs3.getString("subject");
								String professor = rs3.getString("professor");
								String subject_number = rs3.getString("subject_number");
								
								if(count%2==0) {
								%> <tr>
										<td class="even"><%=subject_number %></td>
										<td class="even"><%=subject %></td>
										<td class="even"><%=professor %></td>
										<td class="even"><form method="get" action="./deleteRegistration.jsp">
												<input type="hidden" name="subject_number" value="<%=subject_number%>">
												<input type="hidden" name="student_id" value="<%=id %>">
												<input type="submit" value="삭제">
											</form>
										</td>
								   </tr>
								<%
								}
								else {
									%> <tr>
									<td><%=subject_number %></td>
									<td><%=subject %></td>
									<td><%=professor %></td>
									<td><form method="get" action="./deleteRegistration.jsp">
											<input type="hidden" name="subject_number" value="<%=subject_number%>">
											<input type="hidden" name="student_id" value="<%=id %>">
											<input type="submit" value="삭제">
										</form>
									</td>
							   </tr>
							<%
								}
								count++;
							}
								%>
								</tbody>
								</table><%
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
			}
		}catch(Exception e) {
			
		}
			%>
			<button class="type01" onClick="location.href='./Main_student.jsp'">메인으로</button>
							<svg xmlns="http://www.w3.org/2000/svg" class="icons"><symbol id="arrow-right" viewBox="0 0 1792 1792"><path d="M1600 960q0 54-37 91l-651 651q-39 37-91 37-51 0-90-37l-75-75q-38-38-38-91t38-91l293-293H245q-52 0-84.5-37.5T128 1024V896q0-53 32.5-90.5T245 768h704L656 474q-38-36-38-90t38-90l75-75q38-38 90-38 53 0 91 38l651 651q37 35 37 90z"/></symbol><symbol id="lock" viewBox="0 0 1792 1792"><path d="M640 768h512V576q0-106-75-181t-181-75-181 75-75 181v192zm832 96v576q0 40-28 68t-68 28H416q-40 0-68-28t-28-68V864q0-40 28-68t68-28h32V576q0-184 132-316t316-132 316 132 132 316v192h32q40 0 68 28t28 68z"/></symbol><symbol id="user" viewBox="0 0 1792 1792"><path d="M1600 1405q0 120-73 189.5t-194 69.5H459q-121 0-194-69.5T192 1405q0-53 3.5-103.5t14-109T236 1084t43-97.5 62-81 85.5-53.5T538 832q9 0 42 21.5t74.5 48 108 48T896 971t133.5-21.5 108-48 74.5-48 42-21.5q61 0 111.5 20t85.5 53.5 62 81 43 97.5 26.5 108.5 14 109 3.5 103.5zm-320-893q0 159-112.5 271.5T896 896 624.5 783.5 512 512t112.5-271.5T896 128t271.5 112.5T1280 512z"/></symbol></svg>
			
</body>
</html>