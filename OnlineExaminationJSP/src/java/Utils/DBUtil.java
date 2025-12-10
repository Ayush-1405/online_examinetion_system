/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.sql.*;

/**
 *
 * @author DEL
 */
public class DBUtil {
    
    private static final String url = "jdbc:mysql://localhost:3306/online_exam?useSSL=false&serverTimezone=UTC";
    private static final String user = "root";
    private static final String pass = "devansh04";
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException{
        return DriverManager.getConnection(url,user,pass);
    }
}
