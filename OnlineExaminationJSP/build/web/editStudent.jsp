<%-- 
    Document   : editStudent
    Created on : 23-Sept-2025, 10:35:19 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Utils.DBUtil" %>

<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("manageStudents.jsp");
        return;
    }

    int id = Integer.parseInt(idStr);
    String username = "";
    String password = "";

    try (Connection conn = DBUtil.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT username, password FROM users WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            username = rs.getString("username");
            password = rs.getString("password");
        }
        rs.close();
        ps.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <style>
        form { width: 400px; margin: 50px auto; }
        input[type=text], input[type=password] { width: 100%; padding: 8px; margin: 8px 0; }
        input[type=submit] { padding: 8px 16px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Edit Student</h2>
    <form action="EditStudentServlet" method="post">
        <input type="hidden" name="id" value="<%=id%>"/>
        <label>Username:</label>
        <input type="text" name="username" value="<%=username%>" required/>

        <label>Password:</label>
        <input type="password" name="password" value="<%=password%>" required/>

        <input type="submit" value="Update"/>
    </form>
</body>
</html>
