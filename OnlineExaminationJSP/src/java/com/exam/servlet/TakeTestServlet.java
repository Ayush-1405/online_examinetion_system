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

@WebServlet("/TakeTestServlet")
public class TakeTestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Map<String, Object>> exams = new ArrayList<>();

        try {
            con = DBUtil.getConnection();
            String query = "SELECT id, title, description, total_marks, duration_minutes FROM exams";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> exam = new HashMap<>();
                exam.put("id", rs.getInt("id"));
                exam.put("title", rs.getString("title"));
                exam.put("description", rs.getString("description"));
                exam.put("total_marks", rs.getInt("total_marks"));
                exam.put("duration_minutes", rs.getInt("duration_minutes"));
                exams.add(exam);
            }

            request.setAttribute("exams", exams);
            RequestDispatcher rd = request.getRequestDispatcher("takeTest.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ex) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
            }
        }
    }
}


