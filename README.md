# Eats Direct - Online Food Ordering MVP

This is an academic mini-project for a white-label Online Food Ordering System. It is built strictly using the following technology stack:
- **Frontend**: HTML5, CSS3 (Vanilla), Vanilla JS, and AngularJS (1.x).
- **Backend**: Pure PHP.
- **Database**: MySQL.

## Features
1. **User Authentication**: Register and Login functionality built with AngularJS logic and PHP backend (passwords hashed using `PASSWORD_BCRYPT`).
2. **Vanilla JS Validations**: `alert()` boxes for missing fields or errors, and a `prompt()` box for confirming the checkout process.
3. **Interactive Menu & Cart**: The menu items are fetched dynamically from MySQL. The cart is managed by an AngularJS Service (using localStorage to persist).
4. **Order Placement**: Selecting "Checkout" prompts for confirmation and submits the order details into the MySQL database mapping `orders` and `order_items`.

## Setup Instructions (for XAMPP/WAMP)

### 1. Database Configuration
1. Open phpMyAdmin (`http://localhost/phpmyadmin/`).
2. Import the `database.sql` file provided in this project's root. This will automatically create the `food_order_db` database, structure the tables, and insert dummy menu data.

### 2. Server Deployment
1. Move the entire project folder (e.g., `web_tech`) into your local server's public directory:
   - For XAMPP: Copy to `C:\xampp\htdocs\web_tech`
   - For WAMP: Copy to `C:\wamp64\www\web_tech`

### 3. Application Access
1. Start the **Apache** and **MySQL** modules using the XAMPP/WAMP Control Panel.
2. Open your web browser and navigate to:
   `http://localhost/web_tech/`

## Project Structure
- `index.html`: Main shell, loads AngularJS application and Vanilla CSS.
- `js/app.js`: AngularJS 1.x module configurations, controllers, and Vanilla JS custom validations.
- `css/style.css`: Premium layout using vanilla CSS declarations.
- `views/`: Contains individual AngularJS views (`menu.html`, `cart.html`, `login.html`, `register.html`).
- `api/`: Contains pure PHP connection and CRUD operations, functioning as a JSON API (`db_connect.php`, `menu.php`, `login.php`, `register.php`, `place_order.php`).
- `database.sql`: MySQL Dump containing schemas and mock data.
