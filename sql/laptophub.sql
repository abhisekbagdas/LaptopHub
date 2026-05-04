-- ======================================================
-- Database: LaptopHub - Fully Normalized Schema (3NF)
-- ======================================================

-- Create and use database
CREATE DATABASE IF NOT EXISTS laptophub;
USE laptophub;

-- Drop tables in reverse order of dependencies (child first)
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS CartItem;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS LaptopCategory;
DROP TABLE IF EXISTS Laptop;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS User;

-- ======================================================
-- 1. User table (customers and admins)
-- ======================================================
CREATE TABLE User (
                      user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      username VARCHAR(255) NOT NULL UNIQUE,
                      email VARCHAR(255) NOT NULL UNIQUE,
                      password VARCHAR(255) NOT NULL,          -- BCrypt hash
                      phone VARCHAR(20),
                      address TEXT,
                      role ENUM('customer', 'admin') NOT NULL DEFAULT 'customer',
                      registration_date DATE NOT NULL,
                      last_login DATETIME,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ======================================================
-- 2. Brand table
-- ======================================================
CREATE TABLE Brand (
                       brand_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       brand_name VARCHAR(100) NOT NULL UNIQUE,
                       brand_logo_url VARCHAR(500)
);

-- ======================================================
-- 3. Category table
-- ======================================================
CREATE TABLE Category (
                          category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          category_name VARCHAR(100) NOT NULL UNIQUE
);

-- ======================================================
-- 4. Laptop table (product details)
-- ======================================================
CREATE TABLE Laptop (
                        laptop_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        brand_id INT NOT NULL,
                        model VARCHAR(100) NOT NULL,
                        processor VARCHAR(100),
                        ram VARCHAR(50),
                        storage VARCHAR(50),
                        price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
                        stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
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
-- 5. LaptopCategory (many-to-many between Laptop and Category)
-- ======================================================
CREATE TABLE LaptopCategory (
                                laptop_id INT NOT NULL,
                                category_id INT NOT NULL,
                                PRIMARY KEY (laptop_id, category_id),
                                FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE,
                                FOREIGN KEY (category_id) REFERENCES Category(category_id)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);

-- ======================================================
-- 6. Cart table (shopping cart per user)
-- ======================================================
CREATE TABLE Cart (
                      cart_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      user_id INT NOT NULL,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                      FOREIGN KEY (user_id) REFERENCES User(user_id)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE
);

-- ======================================================
-- 7. CartItem table (items inside a cart)
-- ======================================================
CREATE TABLE CartItem (
                          cart_item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          cart_id INT NOT NULL,
                          laptop_id INT NOT NULL,
                          quantity INT NOT NULL CHECK (quantity > 0),
                          added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (cart_id) REFERENCES Cart(cart_id)
                              ON DELETE CASCADE
                              ON UPDATE CASCADE,
                          FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
                              ON DELETE RESTRICT
                              ON UPDATE CASCADE
);

-- ======================================================
-- 8. Order table (customer orders)
-- ======================================================
CREATE TABLE `Order` (
                         order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         user_id INT NOT NULL,
                         order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
                         shipping_address TEXT NOT NULL,
                         order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES User(user_id)
                             ON DELETE RESTRICT
                             ON UPDATE CASCADE
);

-- ======================================================
-- 9. OrderItem table (line items within an order)
-- ======================================================
CREATE TABLE OrderItem (
                           order_item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           order_id INT NOT NULL,
                           laptop_id INT NOT NULL,
                           quantity INT NOT NULL CHECK (quantity > 0),
                           unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0), -- snapshot at purchase time
                           FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
                               ON DELETE CASCADE
                               ON UPDATE CASCADE,
                           FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
                               ON DELETE RESTRICT
                               ON UPDATE CASCADE
);

-- ======================================================
-- 10. Payment table (track payments for orders)
-- ======================================================
CREATE TABLE Payment (
                         payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         order_id INT NOT NULL,
                         payment_method VARCHAR(50) NOT NULL,
                         payment_status ENUM('Pending', 'Completed', 'Failed') NOT NULL DEFAULT 'Pending',
                         transaction_id VARCHAR(100) UNIQUE,
                         payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
                             ON DELETE CASCADE
                             ON UPDATE CASCADE
);

-- ======================================================
-- 11. Review table (customer reviews for laptops)
-- ======================================================
CREATE TABLE Review (
                        review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        laptop_id INT NOT NULL,
                        user_id INT NOT NULL,
                        rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
                        comment TEXT,
                        review_date DATE NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (laptop_id) REFERENCES Laptop(laptop_id)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE,
                        FOREIGN KEY (user_id) REFERENCES User(user_id)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE,
    -- Ensure one review per user per laptop
                        UNIQUE KEY unique_user_laptop_review (user_id, laptop_id)
);

-- ======================================================
-- Optional: Insert sample data (for testing)
-- ======================================================
-- Insert sample brands
INSERT INTO Brand (brand_name, brand_logo_url) VALUES
                                                   ('Dell', 'dell_logo.png'),
                                                   ('Lenovo', 'lenovo_logo.png'),
                                                   ('Apple', 'apple_logo.png');

-- Insert sample categories
INSERT INTO Category (category_name) VALUES
                                         ('Gaming'),
                                         ('Business'),
                                         ('Ultrabook');

-- Insert sample users (password = 'password123' hashed would go here, but plain for demo)
INSERT INTO User (username, email, password, phone, address, role, registration_date) VALUES
                                                                                          ('alice', 'alice@example.com', 'hashed_pw1', '123-456-7890', '123 Main St', 'customer', CURDATE()),
                                                                                          ('bob', 'bob@example.com', 'hashed_pw2', '098-765-4321', '456 Oak Ave', 'customer', CURDATE()),
                                                                                          ('admin1', 'admin@laptophub.com', 'admin_hash', NULL, NULL, 'admin', CURDATE());

-- Insert sample laptops
INSERT INTO Laptop (brand_id, model, processor, ram, storage, price, stock_quantity, description, added_date) VALUES
                                                                                                                  (1, 'XPS 13', 'Intel i7-12700H', '16GB', '512GB SSD', 1200.00, 10, 'Premium ultrabook', CURDATE()),
                                                                                                                  (2, 'Legion 5', 'AMD Ryzen 7 5800H', '32GB', '1TB SSD', 1500.00, 5, 'Gaming laptop', CURDATE()),
                                                                                                                  (3, 'MacBook Air', 'Apple M2', '8GB', '256GB SSD', 999.00, 8, 'Lightweight and powerful', CURDATE());

-- Assign categories to laptops
INSERT INTO LaptopCategory (laptop_id, category_id) VALUES
                                                        (1, 3), -- XPS 13 -> Ultrabook
                                                        (2, 1), -- Legion 5 -> Gaming
                                                        (3, 3); -- MacBook Air -> Ultrabook

-- Create carts for users
INSERT INTO Cart (user_id) VALUES (1), (2);

-- Sample cart items
INSERT INTO CartItem (cart_id, laptop_id, quantity) VALUES
                                                        (1, 1, 2),
                                                        (2, 2, 1);

-- Sample orders
INSERT INTO `Order` (user_id, order_date, total_amount, shipping_address, order_status) VALUES
                                                                                            (1, NOW(), 2400.00, '123 Main St', 'Delivered'),
                                                                                            (2, NOW(), 1500.00, '456 Oak Ave', 'Shipped');

-- Sample order items
INSERT INTO OrderItem (order_id, laptop_id, quantity, unit_price) VALUES
                                                                      (1, 1, 2, 1200.00),
                                                                      (2, 2, 1, 1500.00);

-- Sample payments
INSERT INTO Payment (order_id, payment_method, payment_status, transaction_id, payment_date) VALUES
                                                                                                 (1, 'Credit Card', 'Completed', 'TXN123456', NOW()),
                                                                                                 (2, 'PayPal', 'Pending', 'TXN789012', NOW());

-- Sample reviews
INSERT INTO Review (laptop_id, user_id, rating, comment, review_date) VALUES
                                                                          (1, 1, 5, 'Excellent laptop!', CURDATE()),
                                                                          (2, 2, 4, 'Great for gaming, but a bit heavy.', CURDATE());