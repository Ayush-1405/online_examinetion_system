package com.exam.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import Utils.DBUtil;

@WebServlet("/ViewResultServlet")
public class ViewResultsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); 
        // assuming you store logged-in student's ID in session at login time

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();
            String sql = "SELECT r.id, r.exam_id, r.score, r.total_marks, r.exam_date, e.title " +
                         "FROM results r " +
                         "JOIN exams e ON r.exam_id = e.id " +
                         "WHERE r.user_id = ? ORDER BY r.exam_date DESC";
            pst = con.prepareStatement(sql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();

            request.setAttribute("results", rsToList(rs));
            RequestDispatcher rd = request.getRequestDispatcher("viewResult.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }

    private java.util.List<java.util.Map<String, Object>> rsToList(ResultSet rs) throws SQLException {
        java.util.List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();
        java.sql.ResultSetMetaData md = rs.getMetaData();
        int columns = md.getColumnCount();
        while (rs.next()) {
            java.util.Map<String, Object> row = new java.util.HashMap<>(columns);
            for (int i = 1; i <= columns; ++i) {
                row.put(md.getColumnLabel(i), rs.getObject(i));
            }
            list.add(row);
        }
        return list;
    }
}
