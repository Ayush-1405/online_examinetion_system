<%--
    Document   : index
    Created on : 20-Sept-2025, 11:16:46 am
    Author     : DEL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Examination - Login</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            :root {
                /* Color Palette */
                --primary-color: #007bff; /* Blue for action */
                --primary-hover: #0056b3;
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
                height: 100vh;
                margin: 0;
            }
            
            .login-box {
                background: var(--card-background);
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 10px 25px var(--shadow-color);
                width: 100%;
                max-width: 380px;
                text-align: center;
            }

            h2 {
                color: var(--primary-color);
                margin-bottom: 30px;
                font-weight: 600;
                font-size: 1.8rem;
            }

            input[type=text], input[type=password] {
                width: 100%;
                padding: 12px 15px;
                margin: 10px 0;
                display: inline-block;
                border: 1px solid #ced4da;
                border-radius: 6px;
                box-sizing: border-box; /* Important for padding/width */
                transition: border-color 0.3s, box-shadow 0.3s;
                font-size: 1rem;
            }
            
            input[type=text]:focus, input[type=password]:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Focus ring effect */
                outline: none;
            }

            button[type=submit] {
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background-color: var(--primary-color);
                border: none;
                color: white;
                font-size: 1.1rem;
                font-weight: 600;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.1s;
                letter-spacing: 0.5px;
            }
            
            button[type=submit]:hover {
                background-color: var(--primary-hover);
                transform: translateY(-1px);
            }
            
            button[type=submit]:active {
                transform: translateY(0);
            }

            p {
                margin-top: 25px;
                font-size: 0.95rem;
                color: var(--text-color);
            }

            a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
            }

            a:hover {
                color: var(--primary-hover);
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="login-box">
            <h2><span style="margin-right: 5px;">&#9999;</span>Online Exam Login</h2>
            <form action="LoginServlet" method="post">
                <input type="text" name ="username" placeholder="Enter Username" required>
                <input type="password" name ="password" placeholder="Enter Password" required>
                <button type="submit"> Login </button>
            </form>
            <p>Don’t have an account? 
                <a href="register.jsp">Register here</a>
            </p>
        </div>
    </body>
</html>