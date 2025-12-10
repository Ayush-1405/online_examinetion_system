/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.exam.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import java.util.*;
import Utils.DBUtil;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int examId = Integer.parseInt(request.getParameter("examId"));
        int userId = 1; // 🔹 Replace with logged-in student ID from session

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int score = 0;
        int totalMarks = 0;

        try {
            con = DBUtil.getConnection();

            // Get all questions for this exam
            String query = "SELECT id, correct_option FROM questions WHERE exam_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, examId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int qId = rs.getInt("id");
                int correct = rs.getInt("correct_option");

                // Fetch student's answer
                String answerStr = request.getParameter("q_" + qId);
                if (answerStr != null) {
                    int selected = Integer.parseInt(answerStr);
                    if (selected == correct) {
                        score++; // each question = 1 mark (you can change logic if needed)
                    }
                }
                totalMarks++;
            }

            // Save result into DB
            String insertQuery = "INSERT INTO results (user_id, exam_id, score, total_marks) VALUES (?, ?, ?, ?)";
            PreparedStatement insertPs = con.prepareStatement(insertQuery);
            insertPs.setInt(1, userId);
            insertPs.setInt(2, examId);
            insertPs.setInt(3, score);
            insertPs.setInt(4, totalMarks);
            insertPs.executeUpdate();

            request.setAttribute("score", score);
            request.setAttribute("totalMarks", totalMarks);

            RequestDispatcher rd = request.getRequestDispatcher("examResult.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
            try { if (con != null) con.close(); } catch (Exception ex) {}
        }
    }
}
