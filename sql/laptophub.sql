-- Create and Use Database
CREATE DATABASE IF NOT EXISTS laptophub;
USE laptophub;

-- Drop existing tables for a clean install
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;

-- ========== NEW for Week 5 ==========
-- Users table — stores registered accounts
-- Password column stores BCrypt hash (60 chars), NOT plaintext
CREATE TABLE users (
                       user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) NOT NULL UNIQUE,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE products (
                          product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          user_id INT NOT NULL, -- Foreign Key column
                          name VARCHAR(255) NOT NULL,
                          description TEXT NOT NULL,
                          price DECIMAL(10, 2) NOT NULL,
                          image VARCHAR(500),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          CONSTRAINT fk_products_user
                              FOREIGN KEY (user_id)
                                  REFERENCES users(user_id)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);