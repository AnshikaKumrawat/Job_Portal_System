package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/job_portal";
    private static final String USERNAME = "YOUR_DB_USERNAME";
    private static final String PASSWORD = "YOUR_DB_PASSWORD";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // Load driver once
    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found");
            e.printStackTrace();
        }
    }

    // Get connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Close resources
    public static void close(Connection connection, PreparedStatement pstmt) {
        try {

            if (pstmt != null) {
                pstmt.close();
            }

            if (connection != null) {
                connection.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
