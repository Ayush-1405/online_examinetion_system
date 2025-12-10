<%--
    Document   : manageQuestions
    Created on : 24-Sept-2025, 11:33:04 am
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
    
    // Get Exam ID
    String examIdParam = request.getParameter("exam_id");
    int examId = 0;
    try {
        examId = Integer.parseInt(examIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("manageExam.jsp?message=InvalidExamID");
        return;
    }
    
    // Placeholder to fetch exam title for display (Optional but nice)
    String examTitle = "Loading...";
    Connection conTitle = null;
    PreparedStatement psTitle = null;
    ResultSet rsTitle = null;
    try {
        conTitle = DBUtil.getConnection();
        psTitle = conTitle.prepareStatement("SELECT title FROM exams WHERE id=?");
        psTitle.setInt(1, examId);
        rsTitle = psTitle.executeQuery();
        if (rsTitle.next()) {
            examTitle = rsTitle.getString("title");
        }
    } catch (Exception e) {
        // Ignore, just use default title
    } finally {
        if (rsTitle != null) try { rsTitle.close(); } catch (SQLException ignore) {}
        if (psTitle != null) try { psTitle.close(); } catch (SQLException ignore) {}
        if (conTitle != null) try { conTitle.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Questions - Exam: <%= examTitle %></title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            :root {
                /* Color Palette - Consistent with Admin Theme */
                --admin-navbar-color: #2c3e50; 
                --primary-color: #007bff; 
                --create-color: #28a745; /* Green for Add */
                --create-hover: #1e7e34;
                --edit-color: #ffc107;   /* Yellow/Orange for Edit */
                --edit-hover: #e0a800;
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
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .navbar a {
                color: white;
                text-decoration: none;
                margin-left: 20px;
                font-weight: 600;
            }
            .navbar h2 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
            }

            /* --- Main Content Layout --- */
            .main-content {
                max-width: 1400px;
                margin: 40px auto;
                padding: 0 20px;
            }
            
            .card-header {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 20px;
            }
            
            .two-column-grid {
                display: grid;
                grid-template-columns: 350px 1fr; /* Form on left (fixed width), Table on right */
                gap: 30px;
            }
            
            /* --- Card Container for Sections --- */
            .card {
                background-color: var(--card-background);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 10px 30px var(--shadow-color);
                height: fit-content; /* Ensure the add form card isn't too tall */
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
            
            /* Add Question Button */
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


            /* --- Table Styling (Question List) --- */
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

            /* Question/Options specific styling */
            td:nth-child(2) { /* Question column */
                font-weight: 600;
            }
            td:nth-child(3) { /* Options column */
                font-size: 0.9rem;
                line-height: 1.4;
            }
            td:nth-child(4) { /* Correct option column */
                font-weight: 700;
                color: var(--create-color);
                text-align: center;
            }
            td:last-child {
                white-space: nowrap;
                text-align: center;
            }

            /* --- Action Buttons (Table) --- */
            .action-btn {
                text-decoration: none;
                padding: 8px 10px;
                border-radius: 5px;
                font-weight: 600;
                margin-left: 5px;
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
            .action-btn.delete {
                background-color: var(--danger-color);
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <h2><i class="fas fa-question-circle" style="margin-right: 8px;"></i>Manage Questions</h2>
            <div>
                <a href="admin.jsp">Dashboard</a>
                <a href="manageExam.jsp"><i class="fas fa-arrow-left"></i> Back to Exams</a>
            </div>
        </div>

        <div class="main-content">
            <div class="card-header">Questions for Exam: **<%= examTitle %>** (ID: <%= examId %>)</div>
            
            <div class="two-column-grid">
                
                <div class="card">
                    <h3><i class="fas fa-plus-square"></i> Add New Question</h3>
                    
                    <form action="QuestionServlet" method="post">
                        <input type="hidden" name="action" value="create"/>
                        <input type="hidden" name="exam_id" value="<%=examId%>"/>
                        
                        <label for="question">Question Text:</label>
                        <input type="text" id="question" name="question" required/>

                        <label for="option1">Option 1:</label>
                        <input type="text" id="option1" name="option1" required/>

                        <label for="option2">Option 2:</label>
                        <input type="text" id="option2" name="option2" required/>

                        <label for="option3">Option 3:</label>
                        <input type="text" id="option3" name="option3" required/>

                        <label for="option4">Option 4:</label>
                        <input type="text" id="option4" name="option4" required/>

                        <label for="correct_option">Correct Option (1-4):</label>
                        <input type="number" id="correct_option" name="correct_option" min="1" max="4" required/>
                        
                        <input type="submit" value="Add Question"/>
                    </form>
                </div>
                
                <div class="card">
                    <h3><i class="fas fa-list-alt"></i> Question List</h3>

                    <table>
                        <thead>
                            <tr>
                                <th>ID</th><th>Question</th><th>Options</th><th>Correct</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                boolean foundQuestions = false;
                                try (Connection con = DBUtil.getConnection();
                                     PreparedStatement ps = con.prepareStatement("SELECT * FROM questions WHERE exam_id=? ORDER BY id ASC")) {
                                    ps.setInt(1, examId);
                                    ResultSet rs = ps.executeQuery();
                                    while(rs.next()){
                                        foundQuestions = true;
                            %>
                            <tr>
                                <td><%=rs.getInt("id")%></td>
                                <td><%=rs.getString("question")%></td>
                                <td>
                                    **1)** <%=rs.getString("option1")%><br>
                                    **2)** <%=rs.getString("option2")%><br>
                                    **3)** <%=rs.getString("option3")%><br>
                                    **4)** <%=rs.getString("option4")%>
                                </td>
                                <td><%=rs.getInt("correct_option")%></td>
                                <td>
                                    <form action="QuestionServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
                                        <input type="hidden" name="exam_id" value="<%=examId%>"/>
                                        <button type="submit" class="action-btn delete" onclick="return confirm('Delete this question?');">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                    
                                    <form action="editQuestion.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
                                        <input type="hidden" name="exam_id" value="<%=examId%>"/>
                                        <button type="submit" class="action-btn edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                    if (!foundQuestions) {
                                        out.println("<tr><td colspan='5' style='text-align: center; color: #6c757d; font-style: italic;'>No questions yet! Add the first one using the form.</td></tr>");
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='5' style='color: var(--danger-color); font-weight: 600; text-align: center;'>Database Error: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>