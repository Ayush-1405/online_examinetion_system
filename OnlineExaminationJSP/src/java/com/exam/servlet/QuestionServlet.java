/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.exam.servlet;

/**
 *
 * @author DEL
 */
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import Utils.DBUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/QuestionServlet")
public class QuestionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        int examId = Integer.parseInt(request.getParameter("exam_id"));

        try (Connection con = DBUtil.getConnection()) {
            if ("create".equals(action)) {
                String question = request.getParameter("question");
                String option1 = request.getParameter("option1");
                String option2 = request.getParameter("option2");
                String option3 = request.getParameter("option3");
                String option4 = request.getParameter("option4");
                int correctOption = Integer.parseInt(request.getParameter("correct_option"));

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO questions (exam_id, question, option1, option2, option3, option4, correct_option) VALUES (?,?,?,?,?,?,?)"
                );
                ps.setInt(1, examId);
                ps.setString(2, question);
                ps.setString(3, option1);
                ps.setString(4, option2);
                ps.setString(5, option3);
                ps.setString(6, option4);
                ps.setInt(7, correctOption);
                ps.executeUpdate();

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String question = request.getParameter("question");
                String option1 = request.getParameter("option1");
                String option2 = request.getParameter("option2");
                String option3 = request.getParameter("option3");
                String option4 = request.getParameter("option4");
                int correctOption = Integer.parseInt(request.getParameter("correct_option"));

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE questions SET question=?, option1=?, option2=?, option3=?, option4=?, correct_option=? WHERE id=?"
                );
                ps.setString(1, question);
                ps.setString(2, option1);
                ps.setString(3, option2);
                ps.setString(4, option3);
                ps.setString(5, option4);
                ps.setInt(6, correctOption);
                ps.setInt(7, id);
                ps.executeUpdate();

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM questions WHERE id=?");
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("manageQuestions.jsp?exam_id=" + examId);
    }
}
