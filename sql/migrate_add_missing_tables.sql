-- ======================================================
-- Migration: Add missing tables to laptophub database
-- Run this in phpMyAdmin (Import tab) to fix admin dashboard errors
-- This preserves existing 'users' and 'products' tables
-- ======================================================

USE laptophub;

-- Add 'role' and 'registration_date' columns to existing 'users' table if not present
ALTER TABLE users ADD COLUMN IF NOT EXISTS role ENUM('customer', 'admin') NOT NULL DEFAULT 'customer';
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone VARCHAR(20) DEFAULT NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS address TEXT DEFAULT NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS registration_date DATE DEFAULT NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_login DATETIME DEFAULT NULL;

-- Update registration_date for existing users that have NULL
UPDATE users SET registration_date = DATE(created_at) WHERE registration_date IS NULL;

-- ======================================================
-- Create Brand table
-- ======================================================
CREATE TABLE IF NOT EXISTS Brand (
    brand_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    brand_logo_url VARCHAR(500)
);

-- ======================================================
-- Create Category table
-- ======================================================
CREATE TABLE IF NOT EXISTS Category (
    category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- ======================================================
-- Create Laptop table
-- ======================================================
CREATE TABLE IF NOT EXISTS Laptop (
    laptop_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    brand_id INT NOT NULL,
    model VARCHAR(100) NOT NULL,
    processor VARCHAR(100),
    ram VARCHAR(50),
    storage VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    description TEXT,
    image_url VARCHAR(500),
    added_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ======================================================
-- Create LaptopCategory table
-- ======================================================
CREATE TABLE IF NOT EXISTS LaptopCategory (
    laptop_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (laptop_id, category_id),
    FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- Create Cart table
-- ======================================================
CREATE TABLE IF NOT EXISTS Cart (
    cart_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- Create CartItem table
-- ======================================================
CREATE TABLE IF NOT EXISTS CartItem (
    cart_item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    laptop_id INT NOT NULL,
    quantity INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ======================================================
-- Create Order table
-- ======================================================
CREATE TABLE IF NOT EXISTS `Order` (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ======================================================
-- Create OrderItem table
-- ======================================================
CREATE TABLE IF NOT EXISTS OrderItem (
    order_item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    laptop_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ======================================================
-- Create Payment table
-- ======================================================
CREATE TABLE IF NOT EXISTS Payment (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed') NOT NULL DEFAULT 'Pending',
    transaction_id VARCHAR(100) UNIQUE,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ======================================================
-- Create Review table
-- ======================================================
CREATE TABLE IF NOT EXISTS Review (
    review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    laptop_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    review_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY unique_user_laptop_review (user_id, laptop_id)
);

-- ======================================================
-- Insert sample data
-- ======================================================
INSERT IGNORE INTO Brand (brand_name, brand_logo_url) VALUES
    ('Dell', 'dell_logo.png'),
    ('Lenovo', 'lenovo_logo.png'),
    ('Apple', 'apple_logo.png'),
    ('HP', 'hp_logo.png'),
    ('Asus', 'asus_logo.png'),
    ('Acer', 'acer_logo.png'),
    ('MSI', 'msi_logo.png'),
    ('Samsung', 'samsung_logo.png');

INSERT IGNORE INTO Category (category_name) VALUES
    ('Gaming'),
    ('Business'),
    ('Ultrabook');

INSERT IGNORE INTO Laptop (brand_id, model, processor, ram, storage, price, stock_quantity, description, added_date) VALUES
    (1, 'XPS 13', 'Intel i7-12700H', '16GB', '512GB SSD', 120000.00, 10, 'Premium ultrabook', CURDATE()),
    (2, 'Legion 5', 'AMD Ryzen 7 5800H', '32GB', '1TB SSD', 150000.00, 5, 'Gaming laptop', CURDATE()),
    (3, 'MacBook Air', 'Apple M2', '8GB', '256GB SSD', 130000.00, 8, 'Lightweight and powerful', CURDATE());

INSERT IGNORE INTO LaptopCategory (laptop_id, category_id) VALUES
    (1, 3),
    (2, 1),
    (3, 3);

-- Make admin user an admin (update existing user if username matches)
UPDATE users SET role = 'admin' WHERE username = 'admin1' OR email = 'admin@laptophub.com';
