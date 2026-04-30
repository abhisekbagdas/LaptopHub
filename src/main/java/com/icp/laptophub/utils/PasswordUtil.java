package com.icp.laptophub.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Cost factor: 2^COST iterations. 10-12 is typical.
    // Higher = slower = more brute-force resistant, but slower login.
    private static final int COST = 10;

    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }
}
