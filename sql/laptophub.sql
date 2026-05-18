-- Create and Use Database
CREATE DATABASE IF NOT EXISTS laptophub;
USE laptophub;

-- Drop existing tables for a clean install
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

-- ========== NEW for Week 5 ==========
-- Users table — stores registered accounts
-- Password column stores BCrypt hash (60 chars), NOT plaintext
CREATE TABLE users (
                       user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(255) NOT NULL UNIQUE,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       profile_image VARCHAR(500) DEFAULT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE products (
                          product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          user_id INT NOT NULL,
                          name VARCHAR(255) NOT NULL,
                          description TEXT NOT NULL,
                          price DECIMAL(10, 2) NOT NULL,
                          stock INT NOT NULL,
                          image VARCHAR(500),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          CONSTRAINT fk_products_user
                              FOREIGN KEY (user_id)
                                  REFERENCES users(user_id)
                                  ON DELETE CASCADE
                                  ON UPDATE CASCADE
);

-- Corrected Carts Table
CREATE TABLE carts (
                       cart_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       user_id INT NOT NULL,
                       product_id INT NOT NULL,
                       quantity INT NOT NULL DEFAULT 1,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Ensure a user cannot have the same product twice in the cart
                       CONSTRAINT unique_user_product UNIQUE (user_id, product_id),

    -- Foreign Keys
                       CONSTRAINT fk_carts_user
                           FOREIGN KEY (user_id)
                               REFERENCES users(user_id)
                               ON DELETE CASCADE
                               ON UPDATE CASCADE,

                       CONSTRAINT fk_carts_product
                           FOREIGN KEY (product_id)
                               REFERENCES products(product_id)
                               ON DELETE CASCADE
                               ON UPDATE CASCADE
);