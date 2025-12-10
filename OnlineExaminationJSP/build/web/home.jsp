<%-- 
    Document   : home
    Created on : 20-Sept-2025, 2:07:57 pm
    Author     : DEL
--%>
<!--
<%--<%@page language= "java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Utils.DBUtil" %>
<%
    HttpSession session1 = request.getSession(false);
    if(session1 == null || session1.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    }
%>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Home - Online Exam System</title>
         <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            align-items:center;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
            display: inline-block;
        }
        h1 {
            color: #333;
        }
        a {
            display: block;
            margin: 15px 0;
            padding: 12px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            width: 200px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
    </head>
   <body>
    <div class="container">
        <h1>Welcome to Online Examination System</h1>
        <a href="takeTest.jsp">Take Test</a>
        <a href="viewResults.jsp">View Results</a>
        <a href="profile.jsp">Profile</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</body>
</html>-->
<%--
    Document   : home
    Created on : 20-Sept-2025, 2:07:57 pm
    Author     : DEL
--%>

<%@page language= "java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Utils.DBUtil" %>
<%
    // Session check for authentication
    HttpSession session1 = request.getSession(false);
    if(session1 == null || session1.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return; // Add return to stop further execution
    }
    
    // Retrieve username and role (assuming role is stored in session)
    String username = (String) session1.getAttribute("username");
    String role = (String) session1.getAttribute("role"); 
    // If role is not set, default to student for display purposes
    if (role == null) {
        role = "Student"; 
    } else {
        // Capitalize the first letter for display
        role = role.substring(0, 1).toUpperCase() + role.substring(1).toLowerCase();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Online Exam System</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                /* Color Palette - MATCHING the Login/Register pages */
                --primary-color: #007bff; /* Blue for action/focus */
                --primary-hover: #0056b3;
                --danger-color: #dc3545; /* Red for logout/danger */
                --danger-hover: #c82333;
                --background-color: #e9ecef; /* Light gray background */
                --card-background: #ffffff; /* White card */
                --text-color: #343a40; /* Dark gray for text */
                --shadow-color: rgba(0, 0, 0, 0.1);
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: var(--background-color);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }
            
            .dashboard-container {
                background-color: var(--card-background);
                padding: 50px;
                border-radius: 12px;
                box-shadow: 0 10px 30px var(--shadow-color);
                width: 100%;
                max-width: 600px;
                text-align: center;
            }

            h1 {
                color: var(--primary-color);
                margin-bottom: 5px;
                font-weight: 700;
                font-size: 2rem;
            }
            
            .welcome-message {
                color: var(--text-color);
                font-size: 1.1rem;
                margin-bottom: 30px;
                font-weight: 400;
            }
            
            .username-highlight {
                font-weight: 600;
                color: var(--primary-hover);
            }
            
            .actions-grid {
                display: grid;
                grid-template-columns: 1fr 1fr; /* Two columns for the buttons */
                gap: 20px;
                margin-top: 40px;
            }

            .action-link {
                display: flex; /* Use flex for icon and text alignment */
                justify-content: center;
                align-items: center;
                padding: 15px 20px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-size: 1.05rem;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.1s, box-shadow 0.3s;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            
            .action-link i {
                margin-right: 10px;
                font-size: 1.2rem;
            }

            .action-link:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }
            
            .logout-link {
                grid-column: 1 / -1; /* Make logout button span both columns */
                background-color: var(--danger-color); 
                margin-top: 20px;
            }
            
            .logout-link:hover {
                background-color: var(--danger-hover);
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    </head>
    <body>
        <div class="dashboard-container">
            <h1>Online Exam System</h1>
            <p class="welcome-message">Hello, <span class="username-highlight"><%= username %></span>! (<%= role %>)</p>
            
            <div class="actions-grid">
                <a href="takeTest.jsp" class="action-link">
                    <i class="fas fa-edit"></i> Take Test
                </a>
                
                <a href="viewResults.jsp" class="action-link">
                    <i class="fas fa-chart-bar"></i> View Results
                </a>
                
<!--                <a href="profile.jsp" class="action-link">
                    <i class="fas fa-user-circle"></i> Profile
                </a>-->
                
<!--                <a href="#" class="action-link" style="background-color: #6c757d; border: 2px solid #6c757d;">
                    <i class="fas fa-cog"></i> 
                    Settings
                </a>-->
                
                <a href="LogoutServlet" class="action-link logout-link">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </body>
</html>