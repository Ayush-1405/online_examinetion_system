<%--
    Document   : takeTest
    Created on : 20-Sept-2025, 2:07:57 pm
    Author     : DEL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Take Exam - Online Exam System</title>
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
                padding-top: 80px; /* Space for the fixed header */
                color: var(--text-color);
                min-height: 100vh;
            }

            /* --- Fixed Header Bar --- */
            .header-bar {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 60px;
                background-color: var(--card-background);
                box-shadow: 0 4px 10px var(--shadow-color);
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 30px;
            }

            .header-bar h2 {
                color: var(--primary-color);
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
            }

            .timer-box {
                background-color: var(--primary-color);
                color: white;
                padding: 5px 15px;
                border-radius: 6px;
                font-weight: 600;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            /* --- Main Content Area --- */
            .exam-content {
                max-width: 900px;
                margin: 30px auto; /* Center the content */
                padding: 0 20px;
            }

            /* --- Question Cards --- */
            .question {
                background-color: var(--card-background);
                margin-bottom: 25px;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                border-left: 5px solid var(--primary-color); /* Highlight strip */
            }

            .question p b {
                font-size: 1.15rem;
                color: var(--text-color);
            }
            
            /* --- Options Styling --- */
            .options {
                margin-top: 15px;
                display: flex;
                flex-direction: column;
            }
            
            .options label {
                padding: 10px;
                margin-bottom: 8px;
                border-radius: 5px;
                border: 1px solid #dee2e6;
                cursor: pointer;
                transition: background-color 0.2s, border-color 0.2s;
                display: flex;
                align-items: center;
            }

            .options label:hover {
                background-color: #f8f9fa;
                border-color: var(--primary-color);
            }
            
            /* Customizing Radio Buttons */
            .options input[type=radio] {
                /* Resetting default styles for customization */
                appearance: none; 
                width: 18px;
                height: 18px;
                border: 2px solid #ccc;
                border-radius: 50%;
                margin-right: 15px;
                transition: border-color 0.2s;
                position: relative;
                flex-shrink: 0; /* Prevents radio button from shrinking */
            }
            
            .options input[type=radio]:checked {
                border-color: var(--primary-color);
                background-color: var(--primary-color);
            }
            
            .options input[type=radio]:checked::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background-color: white;
            }
            
            .options input[type=radio]:focus {
                outline: none;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
            }

            /* --- Submit Button --- */
            #examForm input[type=submit] {
                width: 100%;
                background-color: var(--primary-color);
                color: white;
                padding: 15px 20px;
                border: none;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.1s;
                margin-top: 30px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            
            #examForm input[type=submit]:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
            }
            
            /* --- No Questions Message --- */
            .no-questions {
                text-align: center;
                padding: 50px;
                border: 2px dashed #ccc;
                border-radius: 10px;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        
        <div class="header-bar">
            <h2><i class="fas fa-flask" style="margin-right: 8px;"></i>Online Exam</h2>
            <div class="timer-box">
                <i class="far fa-clock" style="margin-right: 5px;"></i>
                Time Remaining: <span id="timer">Loading...</span>
            </div>
        </div>

        <div class="exam-content">
            <form id="examForm" action="SubmitExamServlet" method="post">
                <input type="hidden" name="examId" value="<%= request.getAttribute("examId")%>">

                <%
                    List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
                    int duration = (request.getAttribute("duration") != null) ? (Integer) request.getAttribute("duration") : 0;

                    if (questions == null || questions.isEmpty()) {
                %>
                <div class="no-questions">
                    <p style="font-size: 1.2rem; font-weight: 600;">No questions available for this exam.</p>
                    <p>Please contact your administrator.</p>
                </div>
                <%
                    } else {
                        int qNo = 1;
                        for (Map<String, Object> q : questions) {
                %>
                <div class="question">
                    <p><b>Q<%= qNo++%>:</b> <%= q.get("question")%></p>
                    <div class="options">
                        <label><input type="radio" name="q_<%= q.get("id")%>" value="1"> <%= q.get("option1")%></label>
                        <label><input type="radio" name="q_<%= q.get("id")%>" value="2"> <%= q.get("option2")%></label>
                        <label><input type="radio" name="q_<%= q.get("id")%>" value="3"> <%= q.get("option3")%></label>
                        <label><input type="radio" name="q_<%= q.get("id")%>" value="4"> <%= q.get("option4")%></label>
                    </div>
                </div>
                <%
                        }
                %>
                <input type="submit" value="Submit Exam and Finish">
                <%
                    }
                %>
            </form>
        </div>

        <script>
            // Ensure duration is handled correctly for the initial load
            let initialDuration = <%= duration%>;
            let timeLeft = initialDuration > 0 ? initialDuration * 60 : 0; 
            let timer = document.getElementById("timer");
            let examForm = document.getElementById("examForm");

            function updateTimer() {
                if (timeLeft < 0) timeLeft = 0; // Prevent negative time

                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;
                
                let displayTime = minutes + "m " + (seconds < 10 ? "0" : "") + seconds + "s";
                timer.innerHTML = displayTime;

                // Highlight timer when low on time
                if (timeLeft <= 60 && timeLeft > 0) { // 60 seconds remaining
                    timer.parentElement.style.backgroundColor = '#ffc107'; /* Yellow */
                    timer.parentElement.style.color = '#343a40'; 
                } else if (timeLeft <= 10) {
                     timer.parentElement.style.backgroundColor = '#dc3545'; /* Red */
                     timer.parentElement.style.color = 'white';
                }

                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    alert("Time is up! Submitting your exam automatically.");
                    examForm.submit(); // auto-submit
                    return; // Stop countdown
                }
                
                timeLeft--;
            }

            // Check if there are questions to start the timer
            if (initialDuration > 0 && examForm) {
                let timerInterval = setInterval(updateTimer, 1000);
                updateTimer(); // Initial call to show time immediately
            } else if (timer) {
                 timer.innerHTML = "Not Timed";
            }
        </script>
    </body>
</html>