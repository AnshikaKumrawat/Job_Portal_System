//package com.util;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//
//public class DBUtil {
//	private static String URL = "jdbc:mysql://localhost:3306/job_portal";
//	private static String USERNAME = "root";
//	private static String PASSWORD = "root";
//	private static  String DRIVER = "com.mysql.cj.jdbc.Driver";
//
//	private static Connection connection;
//	public static Connection getConnection() throws ClassNotFoundException, SQLException {
//		try {
//			if(connection == null) {
//				Class.forName(DRIVER);
//				connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
//
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return connection;
//	}
//
//	public void getClose(Connection connection, PreparedStatement pstmt) throws SQLException {
//		if (pstmt != null)
//			pstmt.close();
//		if (connection != null) {
//			connection.close();
//		}
//	}
//}



















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
