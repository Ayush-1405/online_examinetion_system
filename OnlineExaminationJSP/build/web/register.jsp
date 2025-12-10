<%--
    Document   : register
    Created on : 20-Sept-2025, 12:32:23 pm
    Author     : DEL
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Exam - Register</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            :root {
                /* Color Palette - MATCHING the Login page */
                --primary-color: #007bff; /* Blue for action/focus */
                --primary-hover: #0056b3;
                --background-color: #e9ecef; /* Light gray background */
                --card-background: #ffffff; /* White card */
                --text-color: #343a40; /* Dark gray for text */
                --shadow-color: rgba(0, 0, 0, 0.15);
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

            .register-box {
                background: var(--card-background);
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 10px 25px var(--shadow-color);
                width: 100%;
                max-width: 400px; 
                text-align: center;
            }

            h2 {
                color: var(--primary-color);
                margin-bottom: 30px;
                font-weight: 600;
                font-size: 1.8rem;
            }

            input, select {
                width: 100%;
                padding: 12px 15px;
                margin: 10px 0;
                display: inline-block;
                border: 1px solid #ced4da;
                border-radius: 6px;
                box-sizing: border-box;
                transition: border-color 0.3s, box-shadow 0.3s;
                font-size: 1rem;
                color: var(--text-color);
            }
            
            input:focus, select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Blue focus ring */
                outline: none;
            }
            
            /* Style for the select dropdown */
            select {
                appearance: none; 
                background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="%236c757d" viewBox="0 0 16 16"><path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592c.859 0 1.319 1.013.753 1.658l-4.796 5.482a1 1 0 0 1-1.506 0z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 15px center;
                padding-right: 40px; 
            }


            button[type=submit] {
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background-color: var(--primary-color); /* Blue button */
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
        <div class="register-box">
            <h2><span style="margin-right: 5px;">&#9999;</span>Create Account</h2> 
            <form action="RegisterServlet" method="post">
                <input type="text" name="full_name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="text" name="username" placeholder="Choose Username" required>
                <input type="password" name="password" placeholder="Enter Password" required>
                <input type="password" name="confirm_password" placeholder="Confirm Password" required>
                
                <select name="role" required>
                    <option value="" disabled selected>-- Select Your Role --</option>
                    <option value="student">Student</option>
                </select>
                
                <button type="submit">Register</button>
            </form>
            <p>Already have an account? 
                <a href="index.jsp">Login here</a>
            </p>
        </div>
    </body>
</html>