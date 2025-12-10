<%--
    Document   : editExam
    Created on : 24-Sept-2025, 11:20:33 am
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Utils.DBUtil" %>
<%
    // Admin Role Check
    String roleCheck = (String) session.getAttribute("role");
    if (roleCheck == null || !"admin".equalsIgnoreCase(roleCheck)) {
        response.sendRedirect("index.jsp"); 
        return;
    }

    // --- Database Fetch Logic ---
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int examId = 0;
    
    // Check for ID parameter
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            examId = Integer.parseInt(idParam);
            con = DBUtil.getConnection();
            ps = con.prepareStatement("SELECT * FROM exams WHERE id=?");
            ps.setInt(1, examId);
            rs = ps.executeQuery();
            
            // Check if record exists
            if (!rs.next()) {
                // Exam not found, redirect back
                response.sendRedirect("manageExam.jsp?message=ExamNotFound");
                return;
            }
        } catch (NumberFormatException | SQLException e) {
            // Log error and redirect
            System.err.println("Error fetching exam data: " + e.getMessage());
            response.sendRedirect("manageExam.jsp?message=ErrorFetching");
            return;
        } 
    } else {
        // ID parameter missing, redirect back
        response.sendRedirect("manageExam.jsp?message=IDMissing");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Exam - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        :root {
            /* Color Palette - Consistent with Admin/Primary Theme */
            --admin-navbar-color: #2c3e50; 
            --primary-color: #007bff; /* Blue */
            --update-color: #ffc107; /* Yellow/Orange for Update/Warning */
            --update-hover: #e0a800;
            --background-color: #f4f6f9; 
            --card-background: #ffffff; 
            --text-color: #343a40; 
            --shadow-color: rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            color: var(--text-color);
        }

        /* --- Admin Header Bar --- */
        .navbar {
            background-color: var(--admin-navbar-color);
            color: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 600;
            transition: color 0.3s;
        }
        .navbar h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* --- Form Container --- */
        .form-container {
            max-width: 550px;
            margin: 50px auto;
            padding: 30px;
            background-color: var(--card-background);
            border-radius: 10px;
            box-shadow: 0 10px 30px var(--shadow-color);
            text-align: left;
        }

        h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 30px;
            text-align: center;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            margin-top: 15px;
            font-weight: 600;
            color: var(--text-color);
        }

        input[type=text], input[type=number] {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 10px;
            display: inline-block;
            border: 1px solid #ced4da;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
        }
        
        input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            outline: none;
        }

        /* --- Submit Button --- */
        input[type=submit] {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background-color: var(--update-color);
            color: var(--text-color);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 700;
            transition: background-color 0.3s, transform 0.1s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        input[type=submit]:hover {
            background-color: var(--update-hover);
            transform: translateY(-1px);
        }
        
        .back-link {
            display: block;
            margin-top: 25px;
            text-align: center;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2><i class="fas fa-edit" style="margin-right: 8px;"></i>Edit Exam Details</h2>
        <div>
            <a href="admin.jsp">Dashboard</a>
            <a href="manageExam.jsp">Manage Exams</a>
        </div>
    </div>

    <div class="form-container">
        <h2>Editing Exam #<%= examId %></h2>
        
        <form action="ManageExamServlet" method="post">
            <input type="hidden" name="action" value="update"/>
            <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
            
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%=rs.getString("title")%>" required/>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="<%=rs.getString("description")%>"/>

            <label for="total_marks">Total Marks:</label>
            <input type="number" id="total_marks" name="total_marks" value="<%=rs.getInt("total_marks")%>" required min="1"/>

            <label for="duration">Duration (minutes):</label>
            <input type="number" id="duration" name="duration" value="<%=rs.getInt("duration_minutes")%>" required min="5"/>
            
            <input type="submit" value="Update Exam"/>
        </form>
        
        <a href="manageExam.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Cancel and Go Back
        </a>
    </div>
</body>
</html>
<%
    // --- Safe Resource Closing ---
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException ignore) {
        // Ignore closing errors
    }
%>