<%--
    Document   : examResult
    Created on : 24-Sept-2025, 4:39:34 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Result - Online Exam System</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        
        <style>
            :root {
                /* Color Palette - MATCHING the other pages */
                --primary-color: #007bff; /* Blue */
                --primary-hover: #0056b3;
                --success-color: #28a745; /* Green for pass/good score */
                --fail-color: #dc3545;    /* Red for fail/low score */
                --background-color: #e9ecef; 
                --card-background: #ffffff; 
                --text-color: #343a40; 
                --shadow-color: rgba(0, 0, 0, 0.1);
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: var(--background-color);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }

            .result-container {
                background-color: var(--card-background);
                padding: 40px 60px;
                border-radius: 12px;
                box-shadow: 0 10px 30px var(--shadow-color);
                width: 100%;
                max-width: 500px;
                text-align: center;
            }

            h2 {
                color: var(--primary-color);
                margin-bottom: 30px;
                font-weight: 700;
                font-size: 2rem;
            }

            /* Score Card Styling */
            .score-card {
                padding: 30px;
                margin-top: 20px;
                border-radius: 10px;
                border: 3px solid; /* Defined by the result color */
                font-size: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                transition: border-color 0.5s;
            }

            .score-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 10px;
            }
            
            .final-score {
                font-size: 3rem; /* Large score display */
                font-weight: 800;
                line-height: 1.1;
            }
            
            .score-out-of {
                font-size: 1.2rem;
                font-weight: 400;
                color: #6c757d;
                margin-top: -5px;
            }

            /* Dynamic Result Messages */
            .result-message {
                margin-top: 20px;
                padding: 10px;
                border-radius: 5px;
                font-weight: 600;
                font-size: 1.1rem;
            }
            
            /* Action Buttons */
            .actions {
                margin-top: 40px;
            }
            
            .actions a {
                display: inline-block;
                padding: 10px 20px;
                margin: 0 10px;
                text-decoration: none;
                border-radius: 50px;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.1s;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            
            .btn-home {
                background-color: var(--primary-color);
                color: white;
            }
            
            .btn-home:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }
            
            .btn-review {
                background-color: #6c757d; /* Neutral gray */
                color: white;
            }
            
            .btn-review:hover {
                background-color: #5a6268;
                transform: translateY(-1px);
            }
        </style>
    </head>
    <body>
        <div class="result-container">
            <h2>Exam Completed!</h2>

            <%
                // Safely retrieve attributes and handle nulls/parsing
                Integer scoreObj = (Integer) request.getAttribute("score");
                Integer totalMarksObj = (Integer) request.getAttribute("totalMarks");
                
                int score = (scoreObj != null) ? scoreObj.intValue() : 0;
                int totalMarks = (totalMarksObj != null) ? totalMarksObj.intValue() : 1; // Prevent division by zero
                
                // Calculate percentage (handle totalMarks=0 gracefully)
                double percentage = (totalMarks > 0) ? ((double) score / totalMarks) * 100 : 0;
                
                // Determine result (Example: 60% is passing)
                boolean passed = percentage >= 60;
                String resultClass = passed ? "success-color" : "fail-color";
                String message = passed ? "Congratulations! You passed the exam." : "Unfortunately, you did not pass this time.";
                String icon = passed ? "fas fa-trophy" : "fas fa-times-circle";
            %>
            
            <div class="score-card" style="border-color: var(--<%= resultClass %>);">
                <p class="score-title">Your Final Score</p>
                <p class="final-score" style="color: var(--<%= resultClass %>);">
                    <%= score %>
                </p>
                <p class="score-out-of">out of <%= totalMarks %> Marks</p>
            </div>
            
            <div class="result-message" style="background-color: var(--<%= resultClass %>); color: white;">
                <i class="<%= icon %>" style="margin-right: 8px;"></i>
                <%= message %>
            </div>

            <div class="actions">
                <a href="home.jsp" class="btn-home">
                    <i class="fas fa-home"></i> Go to Dashboard
                </a>
                
                <a href="ReviewExamServlet?examId=<%= request.getAttribute("examId") %>" class="btn-review">
                    <i class="fas fa-search"></i> Review Answers
                </a>
            </div>
            
        </div>
    </body>
</html>