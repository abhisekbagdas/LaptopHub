package com.icp.laptophub.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/laptophub";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Temporary migration to add profile_image column
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                java.sql.DatabaseMetaData md = conn.getMetaData();
                java.sql.ResultSet rs = md.getColumns(null, null, "users", "profile_image");
                if (!rs.next()) {
                    try (java.sql.Statement stmt = conn.createStatement()) {
                        stmt.execute("ALTER TABLE users ADD COLUMN profile_image VARCHAR(500) DEFAULT NULL");
                        System.out.println("Migration successful: added profile_image column.");
                    }
                }
            } catch (Exception e) {
                System.out.println("Migration skipped or failed: " + e.getMessage());
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
}
