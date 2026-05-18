package com.icp.laptophub.dao;

import com.icp.laptophub.model.User;

public interface UserDao {

    boolean insertUser(User user);
    User findByUsername(String username);
    User findByEmail(String email);
    boolean updateUser(int userId, String username, String email);
    boolean updatePassword(int userId, String hashedPassword);
    boolean updateProfileImage(int userId, String imagePath);
}
