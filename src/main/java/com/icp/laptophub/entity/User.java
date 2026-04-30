package com.icp.laptophub.entity;

import java.sql.Timestamp;


public class User {

    private int id;
    private String username;
    private String email;
    private String password;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor for creating a new user (registration)
    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // Constructor for reading from database
    public User(int id, String username, String email, String password,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }

    public void setId(int id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }

    @Override
    public String toString() {
        return "[" + id + "] " + username + " (" + email + ")";
    }
}
