package com.exam.servlet;

import Utils.DBUtil; // use your DBUtil class
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection con = DBUtil.getConnection()) {
            // Check if username already exists
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE username=?");
            check.setString(1, username);
            ResultSet rs = check.executeQuery();

            if(rs.next()) {
                // username exists
                response.sendRedirect("register_failed.jsp");
            } else {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users (username, password, role) VALUES (?, ?, ?)"
                );
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, role);

                int row = ps.executeUpdate();
                if(row > 0) {
                    response.sendRedirect("index.jsp"); // go to login
                } else {
                    response.sendRedirect("register_failed.jsp");
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("register_failed.jsp");
        }
    }
}
