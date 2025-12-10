package com.exam.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import java.util.*;
import Utils.DBUtil;

@WebServlet("/StartExamServlet")
public class StartExamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String examIdStr = request.getParameter("examId");
        if (examIdStr == null) {
            response.getWriter().println("No exam selected.");
            return;
        }

        int examId = Integer.parseInt(examIdStr);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Map<String, Object>> questions = new ArrayList<>();
        int durationMinutes = 0; // default duration

        try {
            con = DBUtil.getConnection();

            // Fetch questions
            String query = "SELECT id, question, option1, option2, option3, option4 FROM questions WHERE exam_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, examId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> q = new HashMap<>();
                q.put("id", rs.getInt("id"));
                q.put("question", rs.getString("question"));
                q.put("option1", rs.getString("option1"));
                q.put("option2", rs.getString("option2"));
                q.put("option3", rs.getString("option3"));
                q.put("option4", rs.getString("option4"));
                questions.add(q);
            }
            rs.close();
            ps.close();

            // Fetch exam duration
            ps = con.prepareStatement("SELECT duration_minutes FROM exams WHERE id=?");
            ps.setInt(1, examId);
            rs = ps.executeQuery();
            if (rs.next()) {
                durationMinutes = rs.getInt("duration_minutes");
            }

            request.setAttribute("examId", examId);
            request.setAttribute("questions", questions);
            request.setAttribute("duration", durationMinutes); // pass to JSP

            RequestDispatcher rd = request.getRequestDispatcher("takeExam.jsp");
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
