<%--
    Document   : admin
    Created on : 23-Sept-2025, 9:11:45 pm
    Author     : DEL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Session role check
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp"); // not logged in or not admin
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - Online Exam System</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            :root {
                /* Primary Admin Colors */
                --admin-navbar-color: #2c3e50; /* Dark Blue/Gray */
                --admin-navbar-hover: #1e2b38;
                --primary-color: #007bff; /* Action Blue */
                --primary-hover: #0056b3;
                --background-color: #f4f6f9; /* Off-white background */
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
            
            /* --- Navigation Bar --- */
            .navbar {
                background-color: var(--admin-navbar-color);
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            }
            
            .navbar h2 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
            }
            
            .navbar-logout {
                color: white;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 4px;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            
            .navbar-logout:hover {
                background-color: var(--admin-navbar-hover);
            }

            /* --- Main Content & Grid --- */
            .container {
                padding: 30px;
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .dashboard-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-top: 20px;
            }

            /* --- Card Styling --- */
            .card {
                background: var(--card-background);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 5px 15px var(--shadow-color);
                transition: transform 0.3s, box-shadow 0.3s;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            }
            
            .card h3 {
                color: var(--primary-color);
                margin-top: 0;
                margin-bottom: 10px;
                font-weight: 700;
                font-size: 1.3rem;
            }
            
            .card p {
                margin-bottom: 20px;
                flex-grow: 1;
            }
            
            /* --- Action Button Styling --- */
            a.button {
                display: inline-flex;
                align-items: center;
                padding: 10px 20px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 50px; /* Pill shape */
                font-weight: 600;
                transition: background-color 0.3s, transform 0.1s;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            a.button i {
                margin-right: 8px;
            }

            a.button:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }
        </style>
    </head>
    <body>
    <div class="navbar">
        <h2><i class="fas fa-tools" style="margin-right: 10px;"></i>Admin Dashboard</h2>
        <div>
            <span style="margin-right: 20px; font-weight: 400;">Welcome, <span style="font-weight: 600;"><%= username %></span></span>
            <a href="LogoutServlet" class="navbar-logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="container">
        <h1>Management Overview</h1>
        
        <div class="dashboard-grid">
            
            <div class="card">
                <h3><i class="fas fa-users"></i> Manage Students</h3>
                <p>View, search, edit, or delete student accounts and manage user roles.</p>
                <a href="manageStudents.jsp" class="button">
                    <i class="fas fa-arrow-right"></i> Go to Students
                </a>
            </div>

            <div class="card">
                <h3><i class="fas fa-book-open"></i> Manage Exams</h3>
                <p>Create new exams, edit details, and manage the associated questions.</p>
                <a href="manageExam.jsp" class="button">
                    <i class="fas fa-arrow-right"></i> Go to Exams
                </a>
            </div>

            <div class="card">
                <h3><i class="fas fa-chart-line"></i> View Results</h3>
                <p>Monitor student performance, view detailed reports, and track trends.</p>
                <a href="viewResults.jsp" class="button">
                    <i class="fas fa-arrow-right"></i> Go to Results
                </a>
            </div>
            
<!--            <div class="card">
                <h3><i class="fas fa-cogs"></i> System Settings</h3>
                <p>Configure system parameters, backup data, or manage platform settings.</p>
                <a href="#" class="button" style="background-color: #6c757d;">
                    <i class="fas fa-arrow-right"></i> Settings (WIP)
                </a>
            </div>-->
            
        </div>
    </div>
</body>
</html>