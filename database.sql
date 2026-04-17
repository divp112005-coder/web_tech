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

-- ===================== STARTERS (15 items) =====================
('Crispy Samosa', 'Deep-fried pastry filled with spiced potatoes and peas', 30.00, 'Starters', '', 1),
('Chicken Tikka', 'Tender chicken marinated in yogurt and spices, roasted in tandoor', 220.00, 'Starters', '', 1),
('Paneer Tikka', 'Spiced cottage cheese chunks roasted with bell peppers and onions', 200.00, 'Starters', '', 1),
('Onion Bhaji', 'Crispy fried onion fritters spiced with cumin and coriander', 80.00, 'Starters', '', 1),
('Aloo Tikki', 'Crispy shallow-fried potato patties served with mint chutney', 60.00, 'Starters', '', 1),
('Papdi Chaat', 'Crispy discs topped with chickpeas, yogurt, tamarind & mint chutney', 90.00, 'Starters', '', 1),
('Pani Puri', '6 crispy puris filled with spicy tamarind water, chickpeas and potato', 70.00, 'Starters', '', 1),
('Hara Bhara Kabab', 'Green spinach and pea patties with a crunchy exterior', 130.00, 'Starters', '', 1),
('Seekh Kabab', 'Minced mutton skewers spiced with ginger, garlic and garam masala', 250.00, 'Starters', '', 1),
('Fish Amritsari', 'Crispy batter-fried fish marinated in carom seeds and chili', 280.00, 'Starters', '', 1),
('Dahi Puri', 'Hollow puris filled with potato, yogurt and sweet tamarind chutney', 80.00, 'Starters', '', 1),
('Sev Puri', 'Flat crispy crackers topped with potatoes, onions and chutneys', 70.00, 'Starters', '', 1),
('Vada Pav', 'Mumbai street food: spiced potato fritter in a soft bun with chutneys', 50.00, 'Starters', '', 1),
('Bhel Puri', 'Puffed rice tossed with vegetables, chutneys and sev', 60.00, 'Starters', '', 1),
('Chicken Malai Tikka', 'Tender chicken in creamy malai and mild spice marinade, charcoal grilled', 240.00, 'Starters', '', 1),

-- ===================== MAIN COURSE (25 items) =====================
('Butter Chicken', 'Tender chicken simmered in a creamy, spiced tomato-butter gravy', 320.00, 'Main Course', '', 1),
('Chicken Tikka Masala', 'Roasted chicken in a robust spiced curry sauce with cream', 300.00, 'Main Course', '', 1),
('Palak Paneer', 'Soft cottage cheese in vibrant spinach puree with ginger and garlic', 250.00, 'Main Course', '', 1),
('Dal Makhani', 'Slow-cooked black lentils and kidney beans with butter and cream', 220.00, 'Main Course', '', 1),
('Rogan Josh', 'Aromatic Kashmiri lamb curry with fiery spice blend', 350.00, 'Main Course', '', 1),
('Shahi Paneer', 'Paneer in a rich, royal cashew and cream based gravy', 260.00, 'Main Course', '', 1),
('Chicken Korma', 'Mild, fragrant chicken curry with coconut, yogurt and nuts', 310.00, 'Main Course', '', 1),
('Kadai Chicken', 'Chicken cooked with bell peppers in a spicy kadai masala', 290.00, 'Main Course', '', 1),
('Mutton Curry', 'Slow-in-bone mutton pieces in a thick, aromatic onion-tomato gravy', 380.00, 'Main Course', '', 1),
('Aloo Gobi', 'Dry stir-fried potato and cauliflower with turmeric and spices', 180.00, 'Main Course', '', 1),
('Matar Paneer', 'Green peas and paneer in a tomato-onion based curry', 230.00, 'Main Course', '', 1),
('Chole Bhature', 'Spicy chickpea curry served with deep-fried fluffy bread', 150.00, 'Main Course', '', 1),
('Rajma Chawal', 'Red kidney bean curry served over steamed basmati rice', 160.00, 'Main Course', '', 1),
('Bhindi Masala', 'Okra stir-fried with onions, tomatoes and aromatic spices', 170.00, 'Main Course', '', 1),
('Saag Chicken', 'Chicken cooked in mustard greens and spinach with a rustic flavour', 300.00, 'Main Course', '', 1),
('Fish Curry', 'Coastal-style fish in a tangy, coconut-based curry sauce', 340.00, 'Main Course', '', 1),
('Prawn Masala', 'Juicy prawns cooked in a spicy onion-tomato gravy', 380.00, 'Main Course', '', 1),
('Egg Curry', 'Hard-boiled eggs simmered in a spiced onion and tomato base', 180.00, 'Main Course', '', 1),
('Dal Tadka', 'Yellow lentils tempered with ghee, cumin, dried chili and garlic', 160.00, 'Main Course', '', 1),
('Vegetable Jalfrezi', 'Mixed vegetables stir-fried with bell peppers and spicy sauce', 200.00, 'Main Course', '', 1),
('Lamb Keema', 'Minced mutton cooked with peas in a fragrant masala', 320.00, 'Main Course', '', 1),
('Chicken Chettinad', 'South Indian pepper-spiced chicken curry with fresh coconut', 310.00, 'Main Course', '', 1),
('Paneer Butter Masala', 'Paneer cubes in a rich, buttery tomato gravy', 260.00, 'Main Course', '', 1),
('Goan Fish Curry', 'Tangy and fiery Goan-style fish curry with kokum', 350.00, 'Main Course', '', 1),
('Daal Baati Churma', 'Rajasthani baked wheat balls with lentil curry and sweet churma', 220.00, 'Main Course', '', 1),

-- ===================== RICE & BIRYANI (12 items) =====================
('Chicken Dum Biryani', 'Aromatic basmati layered with marinated chicken and dum-cooked to perfection', 300.00, 'Rice & Biryani', '', 1),
('Hyderabadi Mutton Biryani', 'Slow-cooked mutton with long-grain basmati in the iconic Hyderabadi style', 380.00, 'Rice & Biryani', '', 1),
('Vegetable Biryani', 'Fragrant basmati rice with mixed vegetables, whole spices and saffron', 220.00, 'Rice & Biryani', '', 1),
('Prawn Biryani', 'Succulent prawns layered in spiced basmati rice', 360.00, 'Rice & Biryani', '', 1),
('Egg Biryani', 'Spiced basmati rice with boiled eggs and caramelized onions', 230.00, 'Rice & Biryani', '', 1),
('Panner Biryani', 'Fragrant rice with marinated paneer and saffron strands', 250.00, 'Rice & Biryani', '', 1),
('Jeera Rice', 'Basmati rice tempered with ghee and cumin seeds', 100.00, 'Rice & Biryani', '', 1),
('Lemon Rice', 'South Indian tangy rice with mustard, curry leaves and peanuts', 120.00, 'Rice & Biryani', '', 1),
('Curd Rice', 'Cooling rice mixed with yogurt, tempering and pomegranate', 110.00, 'Rice & Biryani', '', 1),
('Tamarind Rice', 'Puli sadam: tangy South Indian rice with tamarind paste and spices', 120.00, 'Rice & Biryani', '', 1),
('Chicken Pulao', 'One-pot aromatic rice cooked with chicken and whole garam masala', 260.00, 'Rice & Biryani', '', 1),
('Kashmiri Dum Biryani', 'Kashmiri style biryani with dry fruits, whole spices and slow-dum cooking', 340.00, 'Rice & Biryani', '', 1),

-- ===================== BREADS (10 items) =====================
('Garlic Naan', 'Oven-baked flatbread topped with minced garlic and fresh cilantro', 40.00, 'Breads', '', 1),
('Butter Naan', 'Soft tandoor-baked flatbread brushed with butter', 35.00, 'Breads', '', 1),
('Peshwari Naan', 'Sweet naan stuffed with almond, coconut and sultana filling', 60.00, 'Breads', '', 1),
('Stuffed Paratha', 'Whole wheat flatbread stuffed with spiced potato or paneer', 70.00, 'Breads', '', 1),
('Missi Roti', 'Gram flour flatbread spiced with fenugreek and ajwain', 45.00, 'Breads', '', 1),
('Tandoori Roti', 'Whole wheat bread baked in a traditional clay oven', 30.00, 'Breads', '', 1),
('Bhatura', 'Deep-fried fluffy leavened bread, classic with chole', 35.00, 'Breads', '', 1),
('Lachha Paratha', 'Multi-layered flaky flatbread with visible crispy layers', 50.00, 'Breads', '', 1),
('Puri', 'Deep-fried whole wheat puffed bread, served with aloo sabzi', 25.00, 'Breads', '', 1),
('Kulcha', 'Soft leavened bread baked in tandoor, great with butter', 40.00, 'Breads', '', 1),

-- ===================== SOUTH INDIAN (10 items) =====================
('Masala Dosa', 'Crispy fermented crepe filled with spiced potato filling, served with sambar & chutney', 120.00, 'South Indian', '', 1),
('Idli Sambar', '3 soft steamed rice cakes served with lentil sambar and coconut chutney', 90.00, 'South Indian', '', 1),
('Medu Vada', 'Crispy lentil doughnuts served with coconut chutney and sambar', 80.00, 'South Indian', '', 1),
('Uttapam', 'Thick rice pancake topped with onions, tomatoes and green chilies', 110.00, 'South Indian', '', 1),
('Pongal', 'Comforting rice and lentil porridge with black pepper, cashews and ghee', 100.00, 'South Indian', '', 1),
('Rava Idli', 'Soft semolina cakes with mustard and cashews, served with chutneys', 95.00, 'South Indian', '', 1),
('Mini Idli Sambar', '12 mini idlis dunked in a flavourful sambar bowl', 110.00, 'South Indian', '', 1),
('Ghee Roast Dosa', 'Paper-thin crispy dosa smeared generously with ghee', 130.00, 'South Indian', '', 1),
('Pesarattu', 'Green moong dal crepe, a specialty from Andhra Pradesh', 100.00, 'South Indian', '', 1),
('Appam with Stew', 'Lacy coconut rice pancakes served with a mild vegetable stew', 150.00, 'South Indian', '', 1),

-- ===================== DESSERTS (13 items) =====================
('Gulab Jamun', 'Deep-fried milk dumplings soaked in rose and cardamom syrup', 60.00, 'Desserts', '', 1),
('Rasmalai', 'Soft paneer discs soaked in saffron and pistachio flavoured milk', 80.00, 'Desserts', '', 1),
('Gajar Ka Halwa', 'Slow-cooked carrot pudding with ghee, milk, nuts and cardamom', 90.00, 'Desserts', '', 1),
('Kheer', 'Creamy rice pudding simmered with milk, sugar and cardamom', 80.00, 'Desserts', '', 1),
('Jalebi', 'Crispy deep-fried pretzel-shaped sweets soaked in saffron syrup', 60.00, 'Desserts', '', 1),
('Kulfi', 'Dense and creamy Indian ice cream with pistachio and cardamom', 70.00, 'Desserts', '', 1),
('Rabri', 'Thickened sweetened milk with saffron, cardamom and rose water', 90.00, 'Desserts', '', 1),
('Shahi Tukda', 'Fried bread soaked in condensed milk and topped with rabri and nuts', 100.00, 'Desserts', '', 1),
('Besan Ladoo', 'Traditional gram flour balls sweetened with sugar and ghee', 50.00, 'Desserts', '', 1),
('Mysore Pak', 'Rich South Indian fudge made from gram flour, ghee and sugar', 60.00, 'Desserts', '', 1),
('Modak', 'Sweet steamed dumplings stuffed with coconut and jaggery', 70.00, 'Desserts', '', 1),
('Imarti', 'Pretzel-shaped lentil-batter sweets soaked in sugar syrup', 65.00, 'Desserts', '', 1),
('Phirni', 'Ground rice pudding set in clay pots with saffron and cardamom', 85.00, 'Desserts', '', 1),

-- ===================== BEVERAGES (15 items) =====================
('Mango Lassi', 'Thick yogurt-based drink blended with sweet Alphonso mango pulp', 80.00, 'Beverages', '', 1),
('Rose Lassi', 'Refreshing sweet yogurt drink with rose syrup and rose petals', 70.00, 'Beverages', '', 1),
('Salted Lassi', 'Classic Punjabi salted yogurt drink with cumin and coriander', 60.00, 'Beverages', '', 1),
('Masala Chai', 'Freshly brewed spiced tea with ginger, cardamom, cloves and milk', 40.00, 'Beverages', '', 1),
('Filter Coffee', 'South Indian style strong decoction coffee with frothy hot milk', 50.00, 'Beverages', '', 1),
('Cold Coffee', 'Chilled blended coffee with ice cream and milk', 90.00, 'Beverages', '', 1),
('Fresh Lime Soda', 'Sparkling water with fresh lime, salt or sugar (your choice)', 50.00, 'Beverages', '', 1),
('Jal Jeera', 'Tangy and refreshing spiced water with cumin, mint and tamarind', 40.00, 'Beverages', '', 1),
('Thandai', 'A festive milk drink blended with nuts, seeds, rose and spices', 90.00, 'Beverages', '', 1),
('Aam Panna', 'Raw mango drink with mint, cumin and black salt — the summer cooler', 60.00, 'Beverages', '', 1),
('Coconut Water', 'Fresh chilled coconut water straight from the tender coconut', 70.00, 'Beverages', '', 1),
('Buttermilk (Chaas)', 'Thin salted yogurt drink with green chili, ginger and curry leaves', 40.00, 'Beverages', '', 1),
('Shikanji', 'Traditional Indian lemonade with black salt, cumin and black pepper', 50.00, 'Beverages', '', 1),
('Rooh Afza Milk', 'Chilled milk sweetened with floral rose concentrate', 60.00, 'Beverages', '', 1),
('Badam Milk', 'Warm or cold sweetened milk with almond paste and cardamom', 80.00, 'Beverages', '', 1);

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
