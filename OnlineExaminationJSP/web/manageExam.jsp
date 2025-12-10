<%--
    Document   : manageExam
    Created on : 24-Sept-2025, 11:13:53 am
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Exams - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            :root {
                /* Color Palette - Consistent with Admin/Primary Theme */
                --admin-navbar-color: #2c3e50; 
                --primary-color: #007bff; /* Blue for action */
                --primary-hover: #0056b3;
                --create-color: #28a745; /* Green for Create/Add action */
                --create-hover: #1e7e34;
                --edit-color: #ffc107;   /* Yellow/Orange for Edit */
                --edit-hover: #e0a800;
                --questions-color: #17a2b8; /* Cyan/Info for Questions */
                --questions-hover: #138496;
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
            
            /* --- Admin Header Bar (from admin.jsp) --- */
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

            /* --- Main Content Layout --- */
            .main-content {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }
            
            .two-column-grid {
                display: grid;
                grid-template-columns: 1fr 2fr; /* Form on left, Table on right */
                gap: 40px;
                margin-top: 30px;
            }
            
            /* --- Card Container for Sections --- */
            .card {
                background-color: var(--card-background);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 10px 30px var(--shadow-color);
            }
            
            h3 {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 1.5rem;
                margin-top: 0;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e9ecef;
            }

            /* --- Form Styling --- */
            form label {
                display: block;
                margin-bottom: 5px;
                margin-top: 15px;
                font-weight: 600;
            }
            
            form input[type=text], form input[type=number] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ced4da;
                border-radius: 6px;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
            
            form input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                outline: none;
            }
            
            /* Add Exam Button */
            form input[type=submit] {
                width: 100%;
                padding: 12px;
                margin-top: 25px;
                background-color: var(--create-color);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 1.1rem;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.1s;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            form input[type=submit]:hover {
                background-color: var(--create-hover);
                transform: translateY(-1px);
            }


            /* --- Table Styling (Exam List) --- */
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
                border-bottom: 1px solid #e9ecef; 
            }
            
            td:last-child {
                white-space: nowrap; /* Keep action buttons on one line */
            }

            th {
                background-color: #e3e6ea; 
                color: var(--text-color);
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.9rem;
            }
            
            tr:hover td {
                background-color: #f8f9fa; 
            }

            tr:last-child td {
                border-bottom: none; 
            }

            /* --- Action Buttons (Table) --- */
            .action-btn {
                text-decoration: none;
                padding: 8px 10px;
                border-radius: 5px;
                font-weight: 600;
                margin-right: 5px;
                cursor: pointer;
                border: none;
                transition: background-color 0.3s, transform 0.1s;
                font-family: 'Poppins', sans-serif;
                font-size: 0.9rem;
            }
            
            .action-btn.edit {
                background-color: var(--edit-color);
                color: var(--text-color);
            }
            .action-btn.edit:hover {
                background-color: var(--edit-hover);
                transform: translateY(-1px);
            }
            
            .action-btn.questions {
                background-color: var(--questions-color);
                color: white;
            }
            .action-btn.questions:hover {
                background-color: var(--questions-hover);
                transform: translateY(-1px);
            }

            .action-btn.delete {
                background-color: var(--danger-color);
                color: white;
            }
            .action-btn.delete:hover {
                background-color: #c82333;
                transform: translateY(-1px);
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2><i class="fas fa-book-open" style="margin-right: 8px;"></i>Manage Exams</h2>
            <div>
                <a href="admin.jsp">Dashboard</a>
                <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <div class="main-content">
            <div class="two-column-grid">
                
                <div class="card">
                    <h3><i class="fas fa-plus-circle"></i> Add New Exam</h3>
                    
                    <form action="ManageExamServlet" method="post">
                        <input type="hidden" name="action" value="create"/>
                        
                        <label for="title">Title:</label>
                        <input type="text" id="title" name="title" required/>

                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description"/>

                        <label for="total_marks">Total Marks:</label>
                        <input type="number" id="total_marks" name="total_marks" required min="1"/>

                        <label for="duration">Duration (minutes):</label>
                        <input type="number" id="duration" name="duration" required min="5"/>
                        
                        <input type="submit" value="Add Exam"/>
                    </form>
                </div>
                
                <div class="card">
                    <h3><i class="fas fa-clipboard-list"></i> Existing Exams</h3>

                    <table>
                        <thead>
                            <tr>
                                <th>ID</th><th>Title</th><th>Marks</th>
                                <th>Duration</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection con = null;
                                Statement st = null;
                                ResultSet rs = null;
                                boolean foundExams = false;
                                try {
                                    con = DBUtil.getConnection();
                                    st = con.createStatement();
                                    rs = st.executeQuery("SELECT id, title, description, total_marks, duration_minutes FROM exams ORDER BY id DESC");
                                    while (rs.next()) {
                                        foundExams = true;
                            %>
                            <tr>
                                <td><%=rs.getInt("id")%></td>
                                <td><%=rs.getString("title")%></td>
                                <td><%=rs.getInt("total_marks")%></td>
                                <td><%=rs.getInt("duration_minutes")%> min</td>
                                <td>
<!--                                    <form action="ManageExamServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
                                        <button type="submit" class="action-btn delete" onclick="return confirm('Are you sure you want to delete the exam: <%=rs.getString("title")%>?');">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </button>
                                    </form>-->
                                    
                                    <form action="editExam.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
                                        <button type="submit" class="action-btn edit">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                    </form>
                                    
                                    <form action="manageQuestions.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="exam_id" value="<%=rs.getInt("id")%>"/>
                                        <button type="submit" class="action-btn questions">
                                            <i class="fas fa-question-circle"></i> Questions
                                        </button>
                                    </form>

                                </td>
                            </tr>
                            <%
                                    }
                                    if (!foundExams) {
                                        out.println("<tr><td colspan='5' style='text-align: center; color: #6c757d; font-style: italic;'>No exams found in the database. Add one using the form.</td></tr>");
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='5' style='color: var(--danger-color); font-weight: 600; text-align: center;'>Database Error: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    // Close resources safely
                                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                    if (st != null) try { st.close(); } catch (SQLException ignore) {}
                                    if (con != null) try { con.close(); } catch (SQLException ignore) {}
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>