/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.exam.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import Utils.DBUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ManageExamServlet")
public class ManageExamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection con = DBUtil.getConnection()) {
            if ("create".equals(action)) {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                int totalMarks = Integer.parseInt(request.getParameter("total_marks"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO exams (title, description, total_marks, duration_minutes) VALUES (?,?,?,?)"
                );
                ps.setString(1, title);
                ps.setString(2, description);
                ps.setInt(3, totalMarks);
                ps.setInt(4, duration);
                ps.executeUpdate();

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                int totalMarks = Integer.parseInt(request.getParameter("total_marks"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE exams SET title=?, description=?, total_marks=?, duration_minutes=? WHERE id=?"
                );
                ps.setString(1, title);
                ps.setString(2, description);
                ps.setInt(3, totalMarks);
                ps.setInt(4, duration);
                ps.setInt(5, id);
                ps.executeUpdate();

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = con.prepareStatement("UPDATE exams SET is_active = FALSE WHERE id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("manageExam.jsp");
    }
}
