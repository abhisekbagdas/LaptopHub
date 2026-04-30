-- Create and Use Database
CREATE DATABASE IF NOT EXISTS laptophub;
USE laptophub;

-- Drop existing tables for a clean install
DROP TABLE IF EXISTS users;

-- ========== NEW for Week 5 ==========
-- Users table — stores registered accounts
-- Password column stores BCrypt hash (60 chars), NOT plaintext
CREATE TABLE users (
                       id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) NOT NULL UNIQUE,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
