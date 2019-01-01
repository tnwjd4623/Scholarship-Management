<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>Register</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>
    
<%
	String permit = request.getParameter("permit");
	String name = request.getParameter("name");
   	String idStr = request.getParameter("id");
   	int id = Integer.parseInt(idStr);
   	String address = request.getParameter("address");
   	String pw = request.getParameter("pw");
   	
   Connection conn = null;
   PreparedStatement pstmt = null;
   String str = "";
   
   try{
      	String jdbcUrl = "jdbc:mysql://localhost:3306/se";
      	String dbId = "root";
      	String dbPass = "";
      
      	Class.forName("com.mysql.jdbc.Driver");
      	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
      	
      	String check = "select * from student where student_id=?";
  		pstmt = conn.prepareStatement(check);
  		pstmt.setInt(1, id);
  		ResultSet rs = pstmt.executeQuery();
    	if(rs.next()) {
%>			<script>
				alert("�̹� �����ϴ� ��ȣ�Դϴ�.");
				location.href="./Register.jsp";
			</script>
<%
    	}
    	
    	check = "select * from professor where professor_id=?";
  		pstmt = conn.prepareStatement(check);
  		pstmt.setInt(1, id);
  		rs = pstmt.executeQuery();
    	if(rs.next()) {
%>			<script>
				alert("�̹� �����ϴ� ��ȣ�Դϴ�.");
				location.href="./Register.jsp";
			</script>
<%
    	}
    	 	
      if(permit.equals("1")) {
      	String sql = "insert into student values(?,?,?,?)";
      	pstmt = conn.prepareStatement(sql);
      	pstmt.setString(1,name);
      	pstmt.setInt(2,id);
      	pstmt.setString(3,address);
      	pstmt.setString(4,pw);
      	pstmt.executeUpdate();
      
      	sql = "insert into member values(?,?,?)";
      	pstmt = conn.prepareStatement(sql);
      	pstmt.setString(1, idStr);
      	pstmt.setString(2, pw);
      	pstmt.setString(3, permit);
      	pstmt.executeUpdate();
      	str = "�л� ������ �߰��߽��ϴ�.";
      }
      
      else if(permit.equals("2")) {
    	String sql = "insert into professor values(?,?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1,id);
        pstmt.setString(2,name);
        pstmt.setString(3,address);
        pstmt.setString(4,pw);
        pstmt.executeUpdate();
        
        sql = "insert into member values(?,?,?)";
      	pstmt = conn.prepareStatement(sql);
      	pstmt.setString(1, idStr);
      	pstmt.setString(2, pw);
      	pstmt.setString(3, permit);
      	pstmt.executeUpdate();
        str="���� ������ �߰��߽��ϴ�.";
      }
   }catch(Exception e) {
      e.printStackTrace();
%>	  <script>
		alert("fail");
		location.href="./Register.jsp";
	  </script>
<%    str = "�����߰��� �����߽��ϴ�.";
   }finally {
      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
      if(conn != null) try{conn.close();}catch(SQLException sqle){}
   }
%>

	<script>
	alert("���� ���� �Ϸ�");
	</script>
	<h2><%=str %></h2>
	<h2>��ȣ: <%=id %></h2>
	<h2>�̸�: <%=name %></h2>
	<h2>��й�ȣ: <%=pw %></h2>
	<h2>�ּ�: <%=address %></h2>
	<button onClick="location.href='./Main_admin.jsp'">��������</button>
	
</body>
</html>