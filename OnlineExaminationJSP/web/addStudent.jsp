<%--
    Document   : addStudent
    Created on : 23-Sept-2025, 10:41:16 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Admin Role Check (Good practice)
    String roleCheck = (String) session.getAttribute("role");
    if (roleCheck == null || !"admin".equalsIgnoreCase(roleCheck)) {
        response.sendRedirect("index.jsp"); 
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add New Student - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <style>
        :root {
            /* Color Palette - Consistent with Admin/Primary Theme */
            --admin-navbar-color: #2c3e50; 
            --primary-color: #007bff; /* Blue */
            --primary-hover: #0056b3;
            --success-color: #28a745; /* Green for Add/Save action */
            --success-hover: #1e7e34;
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
        .navbar a:hover {
            color: #ced4da;
        }
        .navbar h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* --- Form Container --- */
        .form-container {
            max-width: 450px;
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

        input[type=text], input[type=password] {
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
        
        input[type=text]:focus, input[type=password]:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            outline: none;
        }

        /* --- Submit Button --- */
        input[type=submit] {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background-color: var(--success-color); /* Green for 'Add' */
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.1s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        input[type=submit]:hover {
            background-color: var(--success-hover);
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
        <h2><i class="fas fa-user-plus" style="margin-right: 8px;"></i>Add New Student</h2>
        <div>
            <a href="admin.jsp">Dashboard</a>
            <a href="manageStudents.jsp">Manage Students</a>
        </div>
    </div>

    <div class="form-container">
        <h2>Register Student Account</h2>
        <form action="AddStudentServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter desired username" required/>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Set initial password" required/>

            <input type="submit" value="Add Student"/>
        </form>
        <a href="manageStudents.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Student List
        </a>
    </div>
</body>
</html>