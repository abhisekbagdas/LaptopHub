-- ============================================================
-- LaptopHub — Complete Database Setup
-- Includes: users, products, carts, orders, order_items
-- Run this file once to create and seed the full database.
-- ============================================================

CREATE DATABASE IF NOT EXISTS laptophub;
USE laptophub;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
/*!40101 SET NAMES utf8mb4 */;

-- ============================================================
-- DROP existing tables (safe clean install)
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- TABLE: users
-- ============================================================
CREATE TABLE `users` (
                         `user_id`       int(11)      NOT NULL AUTO_INCREMENT,
                         `username`      varchar(255) NOT NULL,
                         `email`         varchar(255) NOT NULL,
                         `password`      varchar(255) NOT NULL,
                         `profile_image` varchar(500) DEFAULT NULL,
                         `created_at`    timestamp    NOT NULL DEFAULT current_timestamp(),
                         `updated_at`    timestamp    NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                         PRIMARY KEY (`user_id`),
                         UNIQUE KEY `username` (`username`),
                         UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Seed users
-- All passwords are BCrypt hash of "password123"
INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `profile_image`, `created_at`, `updated_at`) VALUES
                                                                                                                  (1, 'admin',    'admin@example.com',   '$2a$10$yUK8SPXB.NwRSviTxcIVHOxtfvwjGEe600j9g2H5xi3Y4l54A5jLa', NULL, '2026-05-18 06:49:16', '2026-05-18 06:49:16'),
                                                                                                                  (2, 'testuser', 'test@example.com',   '$2a$10$yUK8SPXB.NwRSviTxcIVHOxtfvwjGEe600j9g2H5xi3Y4l54A5jLa', NULL, '2026-05-18 06:49:16', '2026-05-18 06:49:16'),
                                                                                                                  (3, 'demouser', 'demo@example.com',   '$2a$10$yUK8SPXB.NwRSviTxcIVHOxtfvwjGEe600j9g2H5xi3Y4l54A5jLa', NULL, '2026-05-18 06:49:16', '2026-05-18 06:49:16');

ALTER TABLE `users` MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- ============================================================
-- TABLE: products
-- ============================================================
CREATE TABLE `products` (
                            `product_id`  int(11)       NOT NULL AUTO_INCREMENT,
                            `user_id`     int(11)       NOT NULL,
                            `name`        varchar(255)  NOT NULL,
                            `description` text          NOT NULL,
                            `price`       decimal(10,2) NOT NULL,
                            `stock`       int(11)       NOT NULL,
                            `image`       varchar(500)  DEFAULT NULL,
                            `created_at`  timestamp     NOT NULL DEFAULT current_timestamp(),
                            `updated_at`  timestamp     NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                            PRIMARY KEY (`product_id`),
                            KEY `fk_products_user` (`user_id`),
                            CONSTRAINT `fk_products_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Seed products
INSERT INTO `products` (`product_id`, `user_id`, `name`, `description`, `price`, `stock`, `image`, `created_at`, `updated_at`) VALUES
                                                                                                                                   (28, 1, 'Lenovo Thinkbook Plus', 'The Lenovo ThinkBook Plus IRU Gen 4 is a unique dual screen laptop designed for professionals, creators, and multitaskers who want a more efficient and flexible workspace. Powered by the Intel Core i5-1335U processor with 16GB RAM and 512GB SSD.', 135000.00, 15, 'static/images/productImage/1779091107597_Lenovo Thinkbook Plus.png', '2026-05-18 07:58:27', '2026-05-18 07:58:27'),
                                                                                                                                   (29, 1, 'Lenovo Thinkpad X13 Gen 6', 'The Lenovo ThinkPad X13 Gen 6 is a premium ultra-portable business laptop powered by Intel Core Ultra 7 255H. Features 32GB DDR5 RAM, 512GB PCIe Gen4 NVMe SSD, and 13.3-inch WUXGA display.', 312000.00, 20, 'static/images/productImage/1779091243596_Lenovo Thinkpad X13 Gen 6.png', '2026-05-18 08:00:43', '2026-05-18 08:00:43'),
                                                                                                                                   (30, 1, 'Apple MacBook Pro 14-inch M4 Pro', 'Apple MacBook Pro 14-inch M4 Pro (2024) with 24GB unified memory and 512GB SSD. 12-Core CPU, 16-Core GPU. Designed for professionals and creators.', 335000.00, 20, 'static/images/productImage/1779091345410_Apple MacBook Pro 14-inch M4 Pro.png', '2026-05-18 08:02:25', '2026-05-18 08:02:25'),
                                                                                                                                   (31, 1, 'Asus Zenbook 14 UM3406KA', 'Asus Zenbook 14 powered by AMD Ryzen AI 7 350, 16GB RAM, 1TB SSD, 14-inch 3K OLED display. Slim and lightweight premium design.', 210000.00, 20, 'static/images/productImage/1779091611039_Asus Zenbook 14 UM3406KA.png', '2026-05-18 08:06:51', '2026-05-18 08:06:51'),
                                                                                                                                   (32, 1, 'ASUS Zenbook Duo UX8406CA', 'Dual 14-inch 3K OLED 120Hz touchscreen displays. 15th Gen Intel Core Ultra 9 285H, 32GB RAM, 2TB Gen4 SSD. With stylus support.', 379000.00, 20, 'static/images/productImage/1779091699976_ASUS Zenbook Duo UX8406CA.png', '2026-05-18 08:08:19', '2026-05-18 08:08:19'),
                                                                                                                                   (33, 1, 'Lenovo Legion Pro 7i Gaming Laptop 2025', 'Intel Core Ultra 9 275HX, NVIDIA GeForce RTX 5090. Ultimate flagship gaming laptop with extreme performance.', 860000.00, 20, 'static/images/productImage/1779091795690_Lenovo Legion Pro 7i Gaming Laptop 2025.png', '2026-05-18 08:09:55', '2026-05-18 08:09:55'),
                                                                                                                                   (34, 1, 'Acer Predator Helios 18 AI', 'Intel Core Ultra 9 275HX, RTX 5090 24GB GDDR7, 96GB DDR5 RAM, 2TB PCIe Gen4 SSD, 18-inch WQUXGA display. Desktop replacement powerhouse.', 940000.00, 20, 'static/images/productImage/1779091952850_Acer Predator Helios 18 AI Intel Core Ultra 9 275HX.png', '2026-05-18 08:12:32', '2026-05-18 08:12:32'),
                                                                                                                                   (35, 1, 'Asus TUF A15 2024 FA506NFR', 'AMD Ryzen 7 7435HS, NVIDIA GeForce RTX 2050 4GB, 8GB DDR5 RAM, 512GB SSD, 15.6-inch 144Hz display. Includes free gaming backpack and mouse.', 130000.00, 15, 'static/images/productImage/1779092312782_Screenshot 2026-05-18 140314.png', '2026-05-18 08:18:32', '2026-05-18 08:18:32'),
                                                                                                                                   (36, 1, 'Acer Predator Triton 500 2020', 'Intel Core i7-10875H, RTX 2070 8GB, 15.6" Full-HD 144Hz display, 16GB RAM, 512GB SSD.', 130000.00, 12, 'static/images/productImage/1779092424879_Screenshot 2026-05-18 140459.png', '2026-05-18 08:20:24', '2026-05-18 08:20:24'),
                                                                                                                                   (37, 1, 'Acer Predator Triton 300 2020', 'Intel Core i7-10750H, RTX 2060, 15.6" Full-HD 144Hz display, 16GB RAM, 512GB SSD.', 109000.00, 12, 'static/images/productImage/1779092520591_Screenshot 2026-05-18 140638.png', '2026-05-18 08:22:00', '2026-05-18 08:22:00'),
                                                                                                                                   (38, 1, 'Lenovo Legion 5 Pro 2021', 'AMD Ryzen 7 5800H, RTX 3060 6GB, 16GB DDR4 RAM, 1TB PCIe NVMe SSD, 16-inch WQXGA 165Hz 16:10 display. Legion ColdFront cooling.', 135000.00, 20, 'static/images/productImage/1779092663847_Screenshot 2026-05-18 140910.png', '2026-05-18 08:24:23', '2026-05-18 08:24:23'),
                                                                                                                                   (39, 1, 'Dell G5 G5510 2021', 'Intel Core i7-10870H, NVIDIA RTX 3060 6GB, 16GB DDR4 RAM, 512GB SSD, 15.6-inch IPS 165Hz display.', 108000.00, 19, 'static/images/productImage/1779092750492_Screenshot 2026-05-18 141036.png', '2026-05-18 08:25:50', '2026-05-18 08:25:50'),
                                                                                                                                   (40, 1, 'HP Victus 16 2021', 'Intel Core i7-11800H, NVIDIA RTX 3060 6GB, 512GB SSD, 16GB DDR4 RAM, 16.1-inch IPS 144Hz display. Bang & Olufsen speakers.', 125000.00, 18, 'static/images/productImage/1779092849399_Screenshot 2026-05-18 141212.png', '2026-05-18 08:27:29', '2026-05-18 08:27:29'),
                                                                                                                                   (41, 1, 'Dell XPS 15 9500 2020', 'Intel Core i7-10750H, NVIDIA GeForce GTX 1650Ti 4GB, 16GB DDR4 RAM, 1TB PCIe SSD, 15.6-inch InfinityEdge Non-touch display. 500 nits brightness.', 245000.00, 17, 'static/images/productImage/1779093008760_Screenshot 2026-05-18 141406.png', '2026-05-18 08:29:18', '2026-05-18 08:30:08'),
                                                                                                                                   (42, 1, 'Acer Spin 3 2021', 'Intel Core i7-1165G7, 8GB LPDDR4x RAM, 512GB NVMe SSD, 14-inch WQXGA touchscreen, 360-degree hinge. Includes rechargeable stylus.', 105000.00, 16, 'static/images/productImage/1779093088450_Screenshot 2026-05-18 141617.png', '2026-05-18 08:31:28', '2026-05-18 08:31:28'),
                                                                                                                                   (43, 1, 'Asus VivoBook 15 K513EQ-BQ074T', 'Intel Core i5-1135G7, Intel Iris Xe Graphics, 8GB DDR4 RAM, 512GB SSD, 15.6-inch Full HD display. Backlit keyboard and fingerprint scanner.', 85000.00, 18, 'static/images/productImage/1779093191599_Screenshot 2026-05-18 141759.png', '2026-05-18 08:33:11', '2026-05-18 08:33:11'),
                                                                                                                                   (44, 1, 'Apple M1 MacBook Air 2020', 'Apple M1 chip, 13.3-inch Retina display. Fanless design for silent operation. Exceptional performance and long battery life.', 104000.00, 19, 'static/images/productImage/1779093277693_Screenshot 2026-05-18 141926.png', '2026-05-18 08:34:37', '2026-05-18 08:34:37'),
                                                                                                                                   (45, 1, 'HP Omen 16 2024', 'Intel Core i7-14650HX 16-core, NVIDIA RTX 4060 8GB, 16GB DDR5 RAM, 512GB SSD, 16.1-inch FHD 144Hz display. Bang & Olufsen speakers.', 199000.00, 14, 'static/images/productImage/1779093378807_Screenshot 2026-05-18 142107.png', '2026-05-18 08:36:18', '2026-05-18 08:36:18'),
                                                                                                                                   (46, 1, 'Dell XPS 14 9440 2024', "Dell's New XPS Lineup with futuristic design and built-in AI. Premium ultrabook for professionals.", 425000.00, 19, 'static/images/productImage/1779093532559_Screenshot 2026-05-18 142339.png', '2026-05-18 08:38:52', '2026-05-18 08:38:52'),
                                                                                                                                   (47, 1, 'Asus ROG Strix G16 2026', 'Intel Core Ultra 9 275HX, NVIDIA GeForce RTX 5070 Ti, 16GB DDR5 RAM, 1TB NVMe SSD, 16-inch WQXGA 240Hz display. Advanced ROG cooling.', 420000.00, 9, 'static/images/productImage/1779093684521_Screenshot 2026-05-18 142602.png', '2026-05-18 08:41:24', '2026-05-18 08:41:24'),
                                                                                                                                   (48, 1, 'Lenovo Legion Pro 7i (RTX 5080)', 'Intel Core Ultra 9 275HX, RTX 5080 16GB GDDR7, 32GB DDR5 RAM, 1TB SSD, 16-inch WQXGA OLED 240Hz display. Wi-Fi 7 connectivity.', 545000.00, 17, 'static/images/productImage/1779093769403_Screenshot 2026-05-18 142735.png', '2026-05-18 08:42:49', '2026-05-18 08:42:49'),
                                                                                                                                   (49, 1, 'Dell Alienware Aurora 16X', 'Intel Core Ultra 9 275HX, NVIDIA RTX 5070 8GB, 32GB RAM, 2TB SSD, 16-inch 2560x1600 240Hz display. Blue Backlit Keyboard.', 375000.00, 12, 'static/images/productImage/1779093837675_Screenshot 2026-05-18 142843.png', '2026-05-18 08:43:57', '2026-05-18 08:43:57'),
                                                                                                                                   (50, 1, 'Asus Zenbook Duo (Intel Core Ultra 9)', 'Dual 14-inch OLED touchscreen, Intel Core Ultra 9 285H, premium portable design. Two stunning screens for ultimate productivity.', 379000.00, 13, 'static/images/productImage/1779093925439_Screenshot 2026-05-18 143011.png', '2026-05-18 08:45:25', '2026-05-18 08:45:25'),
                                                                                                                                   (51, 1, 'Dell XPS 13 9350 (Core Ultra 7)', 'Intel Core Ultra Series 2, Copilot+ PC. Create and work anywhere with the thinnest XPS. More powerful AI capabilities.', 361500.00, 16, 'static/images/productImage/1779093999578_Screenshot 2026-05-18 143127.png', '2026-05-18 08:46:39', '2026-05-18 08:46:39'),
                                                                                                                                   (52, 1, 'Asus ROG Strix G18 2023 G614JIR', 'Intel Core i9-14900HX, NVIDIA GeForce RTX 4070, 16GB DDR5 RAM, 512GB NVMe SSD, 18-inch WQXGA 240Hz display. ROG advanced cooling.', 360000.00, 19, 'static/images/productImage/1779094068722_Screenshot 2026-05-18 143238.png', '2026-05-18 08:47:48', '2026-05-18 08:47:48'),
                                                                                                                                   (53, 1, 'Asus ROG Strix Scar G16 G614PM', 'AMD Ryzen 9 8940HX, NVIDIA GeForce RTX 5060, 16GB DDR5 RAM, 1TB NVMe SSD, 16-inch WQXGA 240Hz display.', 357000.00, 11, 'static/images/productImage/1779094143286_Screenshot 2026-05-18 143351.png', '2026-05-18 08:49:03', '2026-05-18 08:49:03'),
                                                                                                                                   (54, 1, 'MSI Vector GP68 HX 13VG 2023', 'Intel Core i9-13950HX 24-core, NVIDIA RTX 4070 8GB, 32GB DDR5 RAM, 2TB Gen4 SSD, 16-inch QHD 240Hz display. WiFi 6E, BT 5.3.', 347700.00, 10, 'static/images/productImage/1779094228806_Screenshot 2026-05-18 143518.png', '2026-05-18 08:50:28', '2026-05-18 08:50:28'),
                                                                                                                                   (55, 1, 'MSI Vector 16 HX AI A2XWHG', 'Intel Core Ultra 9 275HX, NVIDIA GeForce RTX 5070 Ti, 16GB DDR5 RAM, 1TB NVMe SSD, 16-inch QHD 240Hz display.', 345000.00, 13, 'static/images/productImage/1779094336943_Screenshot 2026-05-18 143704.png', '2026-05-18 08:52:16', '2026-05-18 08:52:16'),
                                                                                                                                   (56, 1, 'Dell XPS 13 9350 2025', 'Intel Core Ultra 7 256V, 16GB RAM, 512GB SSD, 13.4-inch FHD+ 120Hz 100% sRGB Infinity Edge display. Intel Arc Graphics. 2 Year Warranty.', 334000.00, 14, 'static/images/productImage/1779094459601_Screenshot 2026-05-18 143908.png', '2026-05-18 08:54:19', '2026-05-18 08:54:19'),
                                                                                                                                   (57, 1, 'Acer Predator Helios Neo 16S AI 2025 (RTX 5070 Ti)', 'Intel Core Ultra 9 275HX, RTX 5070 Ti, 16GB DDR5 RAM, 1TB PCIe Gen4 SSD, 16-inch OLED WQXGA 240Hz display. AeroBlade cooling. 3-year warranty.', 330000.00, 17, 'static/images/productImage/1779094526188_Screenshot 2026-05-18 144016.png', '2026-05-18 08:55:26', '2026-05-18 08:55:26'),
                                                                                                                                   (58, 1, 'Lenovo Legion 5 2025 (Ryzen 7 260)', 'AMD Ryzen 7 260, RTX 5050 8GB GDDR7, 16GB DDR5 RAM, 512GB PCIe Gen4 SSD, 15.1-inch WQXGA OLED 165Hz 100% DCI-P3 display.', 330000.00, 13, 'static/images/productImage/1779094610881_Screenshot 2026-05-18 144136.png', '2026-05-18 08:56:50', '2026-05-18 08:56:50'),
                                                                                                                                   (59, 1, 'Acer Predator Helios Neo 16S AI 2025 (RTX 5070)', 'Intel Core Ultra 9 275HX, RTX 5070, 32GB DDR5 6500MHz RAM, 1TB PCIe Gen4 SSD, 16-inch OLED WQXGA 240Hz display. DLSS 4 support.', 320000.00, 15, 'static/images/productImage/1779094707954_Screenshot 2026-05-18 144316.png', '2026-05-18 08:58:27', '2026-05-18 08:58:27'),
                                                                                                                                   (60, 1, 'Asus ROG Zephyrus G14 2024 GA403UV', 'AMD Ryzen 9 8945HS, NVIDIA RTX 4060 8GB, 16GB DDR5 RAM, 1TB NVMe SSD, 14-inch 3K OLED 120Hz display. 1.5KG. Includes sleeve and mouse.', 318900.00, 14, 'static/images/productImage/1779094764853_Screenshot 2026-05-18 144412.png', '2026-05-18 08:59:24', '2026-05-18 08:59:37'),
                                                                                                                                   (61, 1, 'MSI Crosshair 16 HX AI D2XWGKG', 'Intel Core Ultra 9 275HX, NVIDIA GeForce RTX 5070, 16GB DDR5 RAM, 1TB NVMe Gen4 SSD, 16-inch QHD 240Hz display.', 295000.00, 11, 'static/images/productImage/1779094882527_Screenshot 2026-05-18 144610.png', '2026-05-18 09:01:22', '2026-05-18 09:01:22'),
                                                                                                                                   (62, 1, 'Asus Zenbook S16 OLED 2024 UM5606WA', 'AMD Ryzen AI 9 HX 370, 32GB RAM, 1TB SSD, stunning 3K OLED display. Premium design for professionals and creators.', 285000.00, 16, 'static/images/productImage/1779094998214_Screenshot 2026-05-18 144807.png', '2026-05-18 09:03:18', '2026-05-18 09:03:18');

ALTER TABLE `products` MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

-- ============================================================
-- TABLE: carts
-- ============================================================
CREATE TABLE `carts` (
                         `cart_id`    int(11)   NOT NULL AUTO_INCREMENT,
                         `user_id`    int(11)   NOT NULL,
                         `product_id` int(11)   NOT NULL,
                         `quantity`   int(11)   NOT NULL DEFAULT 1,
                         `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
                         `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                         PRIMARY KEY (`cart_id`),
                         UNIQUE KEY `unique_user_product` (`user_id`, `product_id`),
                         KEY `fk_carts_product` (`product_id`),
                         CONSTRAINT `fk_carts_user`    FOREIGN KEY (`user_id`)    REFERENCES `users`    (`user_id`)    ON DELETE CASCADE ON UPDATE CASCADE,
                         CONSTRAINT `fk_carts_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Seed: testuser has 2 items in cart
INSERT INTO `carts` (`cart_id`, `user_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
                                                                                                     (10, 2, 62, 1, '2026-05-18 10:05:18', '2026-05-18 10:05:18'),
                                                                                                     (11, 2, 61, 1, '2026-05-18 10:05:22', '2026-05-18 10:05:22');

ALTER TABLE `carts` MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

-- ============================================================
-- TABLE: orders
-- ============================================================
CREATE TABLE `orders` (
                          `order_id`       int(11)       NOT NULL AUTO_INCREMENT,
                          `user_id`        int(11)       NOT NULL,
                          `full_name`      varchar(255)  NOT NULL,
                          `phone`          varchar(20)   NOT NULL,
                          `address`        text          NOT NULL,
                          `city`           varchar(100)  NOT NULL,
                          `payment_method` varchar(50)   NOT NULL DEFAULT 'COD',
                          `subtotal`       decimal(10,2) NOT NULL,
                          `discount`       decimal(10,2) NOT NULL DEFAULT 0.00,
                          `total`          decimal(10,2) NOT NULL,
                          `status`         varchar(50)   NOT NULL DEFAULT 'Pending',
                          `created_at`     timestamp     NOT NULL DEFAULT current_timestamp(),
                          PRIMARY KEY (`order_id`),
                          KEY `fk_orders_user` (`user_id`),
                          CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- TABLE: order_items
-- ============================================================
CREATE TABLE `order_items` (
                               `item_id`      int(11)       NOT NULL AUTO_INCREMENT,
                               `order_id`     int(11)       NOT NULL,
                               `product_id`   int(11)       NOT NULL,
                               `product_name` varchar(255)  NOT NULL,
                               `image`        varchar(500)  DEFAULT NULL,
                               `unit_price`   decimal(10,2) NOT NULL,
                               `quantity`     int(11)       NOT NULL,
                               `total_price`  decimal(10,2) NOT NULL,
                               PRIMARY KEY (`item_id`),
                               KEY `fk_order_items_order` (`order_id`),
                               CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Done! Database is ready.
-- Test credentials (all passwords: "password123"):
--   admin    / admin@example.com     (admin account)
--   testuser / test@example.com      (regular user with cart items)
--   demouser / demo@example.com      (regular user)
-- ============================================================