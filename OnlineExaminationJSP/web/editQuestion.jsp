<%-- 
    Document   : editQuestion
    Created on : 24-Sept-2025, 11:40:15 am
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Utils.DBUtil" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int examId = Integer.parseInt(request.getParameter("exam_id"));
    Connection con = DBUtil.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM questions WHERE id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Question</title>
    </head>
    <body>
<h2>Edit Question</h2>
<form action="QuestionServlet" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
    <input type="hidden" name="exam_id" value="<%=examId%>"/>
    Question: <input type="text" name="question" value="<%=rs.getString("question")%>" required/><br>
    Option1: <input type="text" name="option1" value="<%=rs.getString("option1")%>" required/><br>
    Option2: <input type="text" name="option2" value="<%=rs.getString("option2")%>" required/><br>
    Option3: <input type="text" name="option3" value="<%=rs.getString("option3")%>" required/><br>
    Option4: <input type="text" name="option4" value="<%=rs.getString("option4")%>" required/><br>
    Correct Option: <input type="number" name="correct_option" min="1" max="4" value="<%=rs.getInt("correct_option")%>" required/><br>
    <input type="submit" value="Update"/>
</form>
</body>
</html>
