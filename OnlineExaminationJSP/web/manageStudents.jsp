<%--
    Document   : manageStudents
    Created on : 23-Sept-2025, 10:25:32 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Utils.DBUtil" %>
<%
    // Admin Role Check (Good practice, even if usually done on the calling page)
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
        <title>Manage Students - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            :root {
                /* Color Palette - Consistent with Admin/Primary Theme */
                --admin-navbar-color: #2c3e50; 
                --primary-color: #007bff; /* Blue for action */
                --primary-hover: #0056b3;
                --success-color: #28a745; /* Edit/Save action */
                --danger-color: #dc3545; /* Delete action */
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
            }
            
            .navbar a {
                color: white;
                text-decoration: none;
                margin-right: 20px;
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
                display: inline-block;
            }

            /* --- Main Content Container --- */
            .main-content {
                max-width: 1000px;
                margin: 40px auto;
                padding: 30px;
                background-color: var(--card-background);
                border-radius: 10px;
                box-shadow: 0 10px 30px var(--shadow-color);
            }
            
            h2 {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 25px;
            }
            
            /* --- Top Action Button --- */
            .top-actions {
                margin-bottom: 30px;
                text-align: right;
            }
            
            .btn-primary {
                display: inline-flex;
                align-items: center;
                padding: 10px 20px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 50px;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.1s;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            .btn-primary:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }
            
            .btn-primary i {
                margin-right: 8px;
            }

            /* --- Table Styling --- */
            table {
                width: 100%;
                border-collapse: separate; 
                border-spacing: 0;
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #e9ecef; /* Only bottom separator */
            }

            th {
                background-color: #e3e6ea; /* Light gray header */
                color: var(--text-color);
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.9rem;
            }
            
            tr:hover td {
                background-color: #f8f9fa; /* Subtle row hover */
            }

            tr:last-child td {
                border-bottom: none; 
            }
            
            td:last-child {
                text-align: center; /* Center actions column */
            }

            /* --- Action Links (Buttons) --- */
            .action-link {
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 50px;
                font-weight: 600;
                margin: 0 5px;
                transition: background-color 0.3s;
            }
            
            .action-link.edit {
                background-color: var(--success-color);
                color: white;
            }
            
            .action-link.edit:hover {
                background-color: #1e7e34;
            }

            .action-link.delete {
                background-color: var(--danger-color);
                color: white;
            }
            
            .action-link.delete:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2><i class="fas fa-users"></i> Manage Students</h2>
            <div>
                <a href="admin.jsp">Dashboard</a>
                <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <div class="main-content">
            <div class="top-actions">
                <a href="addStudent.jsp" class="btn-primary">
                    <i class="fas fa-plus"></i> Add New Student
                </a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBUtil.getConnection()) {
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT id, username, role FROM users WHERE role='student' ORDER BY id ASC");
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String username = rs.getString("username");
                                String studentRole = rs.getString("role");
                    %>
                    <tr>
                        <td><%= id%></td>
                        <td><%= username%></td>
                        <td><span style="text-transform: capitalize;"><%= studentRole%></span></td>
                        <td>
                            <a href="editStudent.jsp?id=<%= id%>" class="action-link edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="ManageStudentServlet?action=delete&id=<%= id%>" class="action-link delete" 
                               onclick="return confirm('Are you sure you want to delete the student <%= username %>?');">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                            rs.close();
                            stmt.close();
                        } catch (Exception e) {
                            // Display error message directly on the page for debugging/admin visibility
                            out.println("<tr><td colspan='4' style='color: var(--danger-color); font-weight: 600;'>Database Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>