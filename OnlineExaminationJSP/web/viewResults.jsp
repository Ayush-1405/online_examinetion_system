<%-- 
    Document   : viewResult
    Created on : 28-Sept-2025, 6:27:39 pm
    Author     : DEL
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>My Results</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #f2f2f2; }
        h2 { text-align: center; }
    </style>
</head>
<body>
    <h2>Your Exam Results</h2>

    <%
        List<Map<String, Object>> results = (List<Map<String, Object>>) request.getAttribute("results");
        if (results == null || results.isEmpty()) {
    %>
        <p style="text-align:center;">No results found.</p>
    <%
        } else {
    %>
    <table>
        <tr>
            <th>Result ID</th>
            <th>Exam Title</th>
            <th>Score</th>
            <th>Total Marks</th>
            <th>Exam Date</th>
        </tr>
        <%
            for (Map<String, Object> row : results) {
        %>
        <tr>
            <td><%= row.get("id") %></td>
            <td><%= row.get("title") %></td>
            <td><%= row.get("score") %></td>
            <td><%= row.get("total_marks") %></td>
            <td><%= row.get("exam_date") %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</body>
</html>

