<%--
    Document   : takeTest
    Created on : 24-Sept-2025, 4:00:54 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // Security check: Redirect if no exam data is present (likely means the servlet hasn't run)
    if (request.getAttribute("exams") == null) {
        response.sendRedirect("TakeTestServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Available Exams - Online Exam System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        :root {
            /* Color Palette - MATCHING the other pages */
            --primary-color: #007bff; /* Blue for action/focus */
            --primary-hover: #0056b3;
            --background-color: #e9ecef; /* Light gray background */
            --card-background: #ffffff; /* White card */
            --text-color: #343a40; /* Dark gray for text */
            --shadow-color: rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 50px 20px;
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .main-container {
            background-color: var(--card-background);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px var(--shadow-color);
            width: 100%;
            max-width: 1000px;
        }

        h2 {
            color: var(--primary-color);
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2rem;
            text-align: center;
        }

        /* --- Table Styling --- */
        table {
            border-collapse: separate; /* Use separate to allow border-radius on cells */
            border-spacing: 0;
            width: 100%;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px; /* Rounded corners for the entire table */
            overflow: hidden; /* Ensures cells respect the table's border-radius */
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e9ecef; /* Light separator */
        }

        th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
        }
        
        /* Apply rounded corners to the first and last th */
        table tr:first-child th:first-child { border-top-left-radius: 8px; }
        table tr:first-child th:last-child { border-top-right-radius: 8px; }

        tr:last-child td {
            border-bottom: none; /* Remove bottom border from the last row */
        }
        
        tr:hover td {
            background-color: #f8f9fa; /* Subtle hover effect on rows */
        }

        /* --- Button Styling --- */
        a.button {
            display: inline-flex;
            align-items: center;
            padding: 8px 15px;
            background-color: var(--primary-color);
            color: #fff;
            text-decoration: none;
            border-radius: 50px; /* Pill shape */
            font-weight: 600;
            transition: background-color 0.3s, transform 0.1s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        a.button i {
            margin-right: 5px;
        }

        a.button:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        /* --- No Exams Message --- */
        .no-exams {
            text-align: center;
            padding: 50px;
            border: 2px dashed #ccc;
            border-radius: 10px;
            margin-top: 50px;
            color: var(--text-color);
        }
        .no-exams p {
             font-size: 1.1rem;
             font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <h2><i class="fas fa-list-alt" style="margin-right: 10px;"></i>Available Exams</h2>

        <%
            List<Map<String, Object>> exams = (List<Map<String, Object>>) request.getAttribute("exams");
            if (exams == null || exams.isEmpty()) {
        %>
        <div class="no-exams">
            <p>There are currently no exams available for you to take.</p>
            <p>Please check back later or contact your instructor.</p>
        </div>
        <%
        } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Marks</th>
                    <th>Duration</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map<String, Object> exam : exams) {
                %>
                <tr>
                    <td><%= exam.get("title")%></td>
                    <td><%= exam.get("description")%></td>
                    <td><%= exam.get("total_marks")%></td>
                    <td><%= exam.get("duration_minutes")%> min</td>
                    <td>
                        <a href="StartExamServlet?examId=<%= exam.get("id")%>" class="button">
                            <i class="fas fa-play-circle"></i>
                            Start Exam
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            }
        %>
    </div>
</body>
</html>