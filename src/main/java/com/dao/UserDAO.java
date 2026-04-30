package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dto.User;

public class UserDAO {
    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    // ========== Register User ==========
    public boolean register(User u) {
        boolean f = false;
        try {
            String sql = "INSERT INTO user(name, qualification, email, password, role) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setString(2, u.getQualification());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, "user"); // default role

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // ========== Login User ==========
    public User login(String em, String psw) {
        User u = null;
        try {
            String sql = "SELECT * FROM user WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, em);
            ps.setString(2, psw);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setQualification(rs.getString("qualification"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

 // ========== Update User ==========
    public boolean updateUser(User u) {
        boolean updated = false;
        String sql = "UPDATE user SET name=?, email=?, password=?, qualification=? WHERE id=?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            // The order must match the SQL query
            ps.setString(1, u.getName());        // name
            ps.setString(2, u.getEmail());       // email
            ps.setString(3, u.getPassword());    // password
            ps.setString(4, u.getQualification());// qualification
            ps.setInt(5, u.getId());             // id

            int rows = ps.executeUpdate();
            updated = (rows > 0);

            System.out.println(updated ? "User updated successfully!" : "No user updated. Check ID.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }

}
