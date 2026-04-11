-- phpMyAdmin SQL Dump
-- Database: `food_db`
CREATE DATABASE IF NOT EXISTS `food_db`;
USE `food_db`;

-- Table structure for table `users`
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL UNIQUE,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `menu_items`
CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT 'placeholder.jpg',
  `is_available` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `menu_items`
INSERT INTO `menu_items` (`name`, `description`, `price`, `category`, `image_url`, `is_available`) VALUES
-- Starters
('Crispy Samosa', 'Deep-fried pastry filled with spiced potatoes and peas', 30.00, 'Starters', '', 1),
('Chicken Tikka', 'Tender pieces of chicken marinated in yogurt and spices, roasted in a tandoor', 220.00, 'Starters', '', 1),
('Paneer Tikka', 'Spiced cottage cheese chunks roasted with bell peppers and onions', 200.00, 'Starters', '', 1),
('Onion Bhaji', 'Crispy fried onion fritters spiced with cumin and coriander', 80.00, 'Starters', '', 1),
('Chicken Caesar Salad', 'Crisp romaine, parmesan, homemade croutons, and grilled chicken breast', 180.00, 'Starters', '', 1),
('Garlic Bread with Cheese', 'Toasted baguette slices topped with garlic butter and melted mozzarella', 100.00, 'Starters', '', 1),

-- Main Course
('Butter Chicken', 'Tender chicken simmered in a creamy, spiced tomato gravy with rich butter', 320.00, 'Main Course', '', 1),
('Chicken Tikka Masala', 'Roasted marinated chicken chunks in a robust spiced curry sauce', 300.00, 'Main Course', '', 1),
('Palak Paneer', 'Soft cottage cheese cubes cooked in a vibrant spinach puree with ginger and garlic', 250.00, 'Main Course', '', 1),
('Dal Makhani', 'Slow-cooked black lentils and kidney beans enriched with butter and cream', 220.00, 'Main Course', '', 1),
('Rogan Josh', 'Aromatic lamb curry slow-cooked with a fiery blend of Kashmiri spices', 350.00, 'Main Course', '', 1),
('Hyderabadi Dum Biryani', 'Aromatic basmati rice layered with marinated chicken, saffron, and rich spices', 300.00, 'Main Course', '', 1),
('Garlic Naan', 'Oven-baked flatbread topped with minced garlic and fresh cilantro (served as main side)', 40.00, 'Main Course', '', 1),
('Classic Cheeseburger', 'Angus beef patty with cheddar cheese, lettuce, and tomato on a brioche bun', 150.00, 'Main Course', '', 1),
('Margherita Pizza', 'Wood-fired crust, San Marzano tomato sauce, fresh mozzarella, and basil', 250.00, 'Main Course', '', 1),
('Spaghetti Bolognese', 'Traditional slow-cooked meaty tomato sauce over spaghetti', 280.00, 'Main Course', '', 1),

-- Desserts
('Gulab Jamun', 'Deep-fried milk dumplings soaked in a warm, fragrant rose and cardamom syrup', 60.00, 'Desserts', '', 1),
('Rasmalai', 'Soft paneer discs soaked in thickened, sweetened milk flavored with saffron and pistachios', 80.00, 'Desserts', '', 1),
('Chocolate Lava Cake', 'Warm chocolate cake with a molten center, served with vanilla ice cream', 120.00, 'Desserts', '', 1),
('Mango Lassi', 'A classic Indian yogurt-based drink blended with sweet ripe mangoes', 70.00, 'Desserts', '', 1),
('Classic Pancakes', 'Fluffy buttermilk pancakes served with premium maple syrup and butter', 100.00, 'Desserts', '', 1);

-- Table structure for table `orders`
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('Pending','Preparing','Ready','Delivered','Cancelled') DEFAULT 'Pending',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `order_items`
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_at_order` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
