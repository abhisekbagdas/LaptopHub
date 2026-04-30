package com.icp.laptophub.dao;

import com.icp.laptophub.entity.User;

public interface UserDao {

    boolean insertUser(User user);
    User findByUsername(String username);
    User findByEmail(String email);
}
